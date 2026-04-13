<?php

namespace App\Services;

use App\Models\Certificado;
use App\Models\CertificadoDetalle;
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
    public function listadoPaginado(
        int $length,
        int $page,
        array $orderBy = [],
        $cliente,
        $tipo_certificado_id,
        $tipo_pago,
        $sucursal_id,
        $medico,
        $fecha
    ): LengthAwarePaginator {
        $certificados = Certificado::select("certificados.*")
            ->with(["cliente:id,nombre,paterno,materno,ci,ci_exp,complemento", "sucursal:id,nombre", "user:id,nombre,paterno,materno", "certificado_detalles.tipo_certificado"])->where("status", 1);

        if (Auth::user()->tipo == 'MÉDICO') {
            $certificados->where("user_id", Auth::user()->id);
        }

        // FILTROS
        $certificados
            ->when($cliente, function ($q) use ($cliente) {
                $q->whereHas('cliente', function ($sub) use ($cliente) {
                    $sub->buscarNombre($cliente);
                });
            })
            ->when($tipo_certificado_id && $tipo_certificado_id !== 'todos', function ($q) use ($tipo_certificado_id) {
                $q->whereHas("certificado_detalles", function ($sub) use ($tipo_certificado_id) {
                    $sub->whereIn("tipo_certificado_id", $tipo_certificado_id);
                });
            })
            ->when($tipo_pago && $tipo_pago !== 'todos', function ($q) use ($tipo_pago) {
                $q->where("tipo_pago", $tipo_pago);
            })
            ->when($sucursal_id && $sucursal_id !== 'todos', function ($q) use ($sucursal_id) {
                $q->where("sucursal_id", $sucursal_id);
            })
            ->when($medico && $medico !== '', function ($q) use ($medico) {
                $q->whereHas('user', function ($sub) use ($medico) {
                    $sub->where(function ($query) use ($medico) {
                        $query->where('nombre', 'like', "%$medico%")
                            ->orWhere('paterno', 'like', "%$medico%")
                            ->orWhere('materno', 'like', "%$medico%");
                    });
                });
            })
            ->when($fecha, function ($q) use ($fecha) {
                $q->whereDate("fecha_registro", $fecha); // ajusta el campo si es otro
            });


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
            "total" => $datos["total"],
            "saldo" => 0,
            "cancelado" => $datos["total"],
            "tipo_pago" => $datos["tipo_pago"],
            "user_id" => Auth::user()->id,
            "sucursal_id" => $datos["sucursal_id"],
            "fecha_registro" => $fecha_actual,
            "hora_registro" => $hora_actual,
            "tipo" => isset($datos["tipo"]) ? $datos["tipo"] : 'NORMAL',
        ]);

        // detalles
        foreach ($datos["certificado_detalles"] as $key => $item) {
            $certificado_detalle = $certificado->certificado_detalles()->create([
                "precio" => $item["precio"],
                "cancelado" => $item["precio"],
                "saldo" => 0,
                "tipo_certificado_id" => $item["tipo_certificado_id"],
            ]);

            $this->certificado_emitido_service->actualizarCertificadoEmitido($item["tipo_certificado_id"], $fecha_actual, Auth::user()->id);

            // cargar archivo
            if (!is_string($item["archivo"])) {
                $archivo = $item["archivo"];
                $this->cargarArchivoDetalle($certificado_detalle, $archivo, $key);
            }
        }



        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REGISTRO UN CERTIFICADO", $certificado, null, ["certificado_detalles"]);

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
            "total" => $datos["total"],
            "saldo" => 0,
            "cancelado" => $datos["total"],
            "tipo_pago" => $datos["tipo_pago"],
            "user_id" => Auth::user()->id,
            "sucursal_id" => $datos["sucursal_id"],
            "tipo" => isset($datos["tipo"]) ? $datos["tipo"] : 'NORMAL',
        ]);

        // detalles
        foreach ($datos["certificado_detalles"] as $key => $item) {
            if ($item["id"] == 0) {
                $certificado_detalle = $certificado->certificado_detalles()->create([
                    "precio" => $item["precio"],
                    "cancelado" => $item["cancelado"],
                    "saldo" => 0,
                    "tipo_certificado_id" => $item["tipo_certificado_id"],
                ]);

                // cargar archivo
                if (!is_string($item["archivo"])) {
                    $archivo = $item["archivo"];

                    $this->cargarArchivoDetalle($certificado_detalle, $archivo, $key);
                }

                $this->certificado_emitido_service->actualizarCertificadoEmitido($item["tipo_certificado_id"], $certificado->fecha_registro, Auth::user()->id);
            } else {
                $certificado_detalle = CertificadoDetalle::find($item["id"]);
                // cargar archivo
                if (!is_string($item["archivo"])) {
                    $archivo = $item["archivo"];
                    \File::delete(public_path("files/certificados/" . $certificado_detalle->archivo));
                    $this->cargarArchivoDetalle($certificado_detalle, $archivo, $key);
                }

                $this->certificado_emitido_service->actualizarCertificadoEmitido($item["tipo_certificado_id"], $certificado->fecha_registro, Auth::user()->id, $certificado_detalle->tipo_certificado_id);

                $certificado_detalle->update([
                    "precio" => $item["precio"],
                    "cancelado" => $item["precio"],
                    "saldo" => 0,
                    "tipo_certificado_id" => $item["tipo_certificado_id"],
                ]);
            }
        }

        if (isset($datos["eliminados"])) {
            foreach ($datos["eliminados"] as $value) {
                $certificado_detalle = CertificadoDetalle::find($value);
                $this->certificado_emitido_service->descontarCertificadoEmitido($certificado_detalle->tipo_certificado_id, $certificado->fecha_registro, Auth::user()->id);
                \File::delete(public_path("files/certificados/" . $certificado_detalle->archivo));
                $certificado_detalle->delete();
            }
        }

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "MODIFICACIÓN", "ACTUALIZÓ UN CERTIFICADO", $old_certificado, $certificado, ["certificado_detalles"]);

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

        foreach ($certificado->certificado_detalles as $item) {
            $this->certificado_emitido_service->descontarCertificadoEmitido($item->tipo_certificado_id, $certificado->fecha_registro, Auth::user()->id);
        }

        $certificado->status = 0;
        $certificado->save();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ UN CERTIFICADO", $old_certificado, $certificado, ["certificado_detalles"]);

        return true;
    }

    /**
     * Cargar archivo
     *
     * @param CertificadoDetalle $certificado_detalle
     * @param UploadedFile $archivo
     * @return void
     */
    public function cargarArchivoDetalle(CertificadoDetalle $certificado_detalle, UploadedFile $archivo, int $index): void
    {
        if ($certificado_detalle->archivo) {
            \File::delete(public_path("files/certificados/" . $certificado_detalle->archivo));
        }

        $nombre = $index . $certificado_detalle->id . time();
        $certificado_detalle->archivo = $this->cargarArchivoService->cargarArchivo($archivo, public_path("files/certificados"), $nombre);
        $certificado_detalle->save();
    }
}
