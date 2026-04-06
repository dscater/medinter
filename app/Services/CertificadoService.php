<?php

namespace App\Services;

use App\Models\Certificado;
use App\Models\CertificadoEmitido;
use App\Services\HistorialAccionService;
use App\Models\User;
use Carbon\Carbon;
use Illuminate\Http\UploadedFile;
use Exception;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Illuminate\Validation\ValidationException;

class CertificadoService
{
    private $modulo = "CERTIFICADOS";

    public function __construct(private  CargarArchivoService $cargarArchivoService, private HistorialAccionService $historialAccionService, private CertificadoEmitidoService $certificado_emitido_service) {}

    public function listado(): Collection
    {
        $certificados = Certificado::select("certificados.*")->where("status", 1)->get();
        return $certificados;
    }
    /**
     * Lista de certificados paginado con filtros
     *
     * @param integer $length
     * @param integer $page
     * @param string $search
     * @param array $columnsSerachLike
     * @param array $columnsFilter
     * @return LengthAwarePaginator
     */
    public function listadoPaginado(int $length, int $page, string $search, array $columnsSerachLike = [], array $columnsFilter = [], array $columnsBetweenFilter = [], array $orderBy = []): LengthAwarePaginator
    {
        $certificados = Certificado::select("certificados.*")
            ->with(["cliente:id,nombre,paterno,materno,ci,ci_exp,complemento", "tipo_certificado:id,nombre", "sucursal:id,nombre", "user:id,nombre,paterno,materno"])->where("status", 1);

        if (Auth::user()->tipo == 'MÉDICO') {
            $certificados->where("user_id", Auth::user()->id);
        }

        // Filtros exactos
        foreach ($columnsFilter as $key => $value) {
            if (!is_null($value)) {
                $certificados->where("certificados.$key", $value);
            }
        }

        // Filtros por rango
        foreach ($columnsBetweenFilter as $key => $value) {
            if (isset($value[0], $value[1])) {
                $certificados->whereBetween("certificados.$key", $value);
            }
        }

        // Búsqueda en múltiples columnas con LIKE
        if (!empty($search) && !empty($columnsSerachLike)) {
            $certificados->where(function ($query) use ($search, $columnsSerachLike) {
                foreach ($columnsSerachLike as $col) {
                    $query->orWhere("$col", "LIKE", "%$search%");
                }
            });
        }

        // Ordenamiento
        foreach ($orderBy as $value) {
            if (isset($value[0], $value[1])) {
                $certificados->orderBy($value[0], $value[1]);
            }
        }


        $certificados = $certificados->paginate($length, ['*'], 'page', $page);
        return $certificados;
    }

    /**
     * Crear certificado
     *
     * @param array $datos
     * @return Certificado
     */
    public function crear(array $datos): Certificado
    {
        $fecha_actual = Carbon::now("America/La_Paz")->format("Y-m-d");
        $hora_actual = Carbon::now("America/La_Paz")->format("H:i:s");

        $certificado = Certificado::create([
            "cliente_id" => $datos["cliente_id"],
            "precio" => $datos["precio"],
            "tipo_certificado_id" => $datos["tipo_certificado_id"],
            "tipo_pago" => $datos["tipo_pago"],
            "user_id" => Auth::user()->id,
            "sucursal_id" => $datos["sucursal_id"],
            "fecha_registro" => $fecha_actual,
            "hora_registro" => $hora_actual,
        ]);


        // cargar archivo1
        if ($datos["archivo1"] && !is_string($datos["archivo1"])) {
            $this->cargarArchivo($certificado, $datos["archivo1"], "archivo1");
        }

        // cargar archivo2
        if ($datos["archivo2"] && !is_string($datos["archivo2"])) {
            $this->cargarArchivo($certificado, $datos["archivo2"], "archivo2");
        }

        $this->certificado_emitido_service->actualizarCertificadoEmitido($datos["tipo_certificado_id"], $fecha_actual, Auth::user()->id);

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REGISTRO UN CERTIFICADO", $certificado);

        return $certificado;
    }

    /**
     * Actualizar certificado
     *
     * @param array $datos
     * @param Certificado $certificado
     * @return Certificado
     */
    public function actualizar(array $datos, Certificado $certificado): Certificado
    {
        $old_certificado = clone $certificado;

        $certificado->update([
            "cliente_id" => $datos["cliente_id"],
            "precio" => $datos["precio"],
            "tipo_certificado_id" => $datos["tipo_certificado_id"],
            "tipo_pago" => $datos["tipo_pago"],
            // "user_id" => Auth::user()->id,
            "sucursal_id" => $datos["sucursal_id"],
        ]);

        // cargar archivo1
        if ($datos["archivo1"] && !is_string($datos["archivo1"])) {
            $this->cargarArchivo($certificado, $datos["archivo1"], "archivo1");
        }

        // cargar archivo2
        if ($datos["archivo2"] && !is_string($datos["archivo2"])) {
            $this->cargarArchivo($certificado, $datos["archivo2"], "archivo2");
        }


        $user_id = $certificado->user_id;
        $this->certificado_emitido_service->actualizarCertificadoEmitido($datos["tipo_certificado_id"], $old_certificado->fecha_registro, $user_id, $old_certificado->tipo_certificado_id);

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "MODIFICACIÓN", "ACTUALIZÓ UN CERTIFICADO", $old_certificado, $certificado->withoutRelations());

        return $certificado;
    }

    /**
     * Eliminar certificado
     *
     * @param Certificado $certificado
     * @return boolean
     */
    public function eliminar(Certificado $certificado): bool|Exception
    {
        $old_certificado = clone $certificado;
        $certificado->status = 0;
        $certificado->save();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ UN CERTIFICADO", $old_certificado, $certificado);

        return true;
    }

    /**
     * Cargar archivo
     *
     * @param Certificado $certificado
     * @param UploadedFile $archivo
     * @return void
     */
    public function cargarArchivo(Certificado $certificado, UploadedFile $archivo, String $col): void
    {
        if ($certificado[$col]) {
            \File::delete(public_path("files/certificados/" . $certificado[$col]));
        }

        $nombre = $col . $certificado->id . time();
        $certificado[$col] = $this->cargarArchivoService->cargarArchivo($archivo, public_path("files/certificados"), $nombre);
        $certificado->save();
    }
}
