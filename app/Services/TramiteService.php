<?php

namespace App\Services;

use App\Models\Cliente;
use App\Models\Tramite;
use App\Models\TramiteCliente;
use App\Models\TramiteEmitido;
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

class TramiteService
{
    private $modulo = "TRAMITES";

    public function __construct(private  CargarArchivoService $cargarArchivoService, private HistorialAccionService $historialAccionService, private ClienteService $cliente_service) {}

    public function listado($codigo = "", $fecha = ""): Collection
    {
        $tramites = Tramite::select("tramites.*");

        if (trim($codigo) != '') {
            $tramites->where("codigo", $codigo);
        }
        if ($fecha && trim($fecha) != '') {
            $tramites->where("fecha", $fecha);
        }

        $tramites = $tramites->get();
        return $tramites;
    }
    /**
     * Lista de tramites paginado con filtros
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
        $tramitador,
        $tipo_tramite_id,
        $tipo_pago,
        $sucursal_id,
        $medico,
        $fecha
    ): LengthAwarePaginator {
        $tramites = Tramite::select("tramites.*")
            ->with(["tramitador:id,nombre", "user:id,nombre,paterno,materno"])
            ->withCount("tramite_clientes");

        if (Auth::user()->tipo == 'MÉDICO') {
            $tramites->where("user_id", Auth::user()->id);
        }

        // FILTROS
        $tramites
            ->when($tramitador, function ($q) use ($tramitador) {
                $q->whereHas('tramitador', function ($sub) use ($tramitador) {
                    $sub->buscarNombre($tramitador);
                });
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
                $tramites->orderBy($value[0], $value[1]);
            }
        }

        $tramites = $tramites->paginate($length, ['*'], 'page', $page);
        return $tramites;
    }

    public function getCodigoNuevoTramite()
    {
        $ultimo = Tramite::orderBy("id", "desc")->get()->first();
        $nro = 1;
        if ($ultimo) {
            $nro = (int)$ultimo->nro + 1;
        }
        $codigo = "T" . $nro;

        return [$nro, $codigo];
    }

    /**
     * Crear tramite
     *
     * @param array $datos
     * @return Tramite
     */
    public function crear(array $datos): Tramite
    {
        $fecha_actual = Carbon::now("America/La_Paz")->format("Y-m-d");
        $hora_actual = Carbon::now("America/La_Paz")->format("H:i:s");

        $array_codigo = $this->getCodigoNuevoTramite();

        $tramite = Tramite::create([
            "nro" => $array_codigo[0],
            "codigo" => $array_codigo[1],
            "tramitador_id" => $datos["tramitador_id"],
            "fecha" => $fecha_actual,
            "hora" => $hora_actual,
            "sucursal_id" => $datos["sucursal_id"],
            "user_id" => Auth::user()->id,
        ]);

        // detalles
        foreach ($datos["tramite_clientes"] as $key => $item) {
            if ($item['existente']) {
                $cliente = Cliente::find($item["cliente_id"]);
            } else {
                $datos_cliente = $item["cliente"];
                $cliente = $this->cliente_service->crear([
                    "nombre" => $datos_cliente["nombre"],
                    "paterno" => $datos_cliente["paterno"],
                    "materno" => $datos_cliente["materno"],
                    "ci" => $datos_cliente["ci"],
                    "ci_exp" => $datos_cliente["ci_exp"],
                    "complemento" => $datos_cliente["complemento"],
                    "fecha_nac" => $datos_cliente["fecha_nac"],
                    "cel" => $datos_cliente["cel"],
                ]);
            }
            $tramite->tramite_clientes()->create([
                "tramite_id" => $item["tramite_id"],
                "cliente_id" => $cliente->id,
                "certificado_id" => null,
                "existente" => $item["existente"],
            ]);
        }

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REGISTRO UN TRAMITE", $tramite, null, ["tramite_clientes"]);

        return $tramite;
    }

    /**
     * Actualizar tramite
     *
     * @param array $datos
     * @param Tramite $tramite
     * @return Tramite
     */
    public function actualizar(array $datos, Tramite $tramite): Tramite
    {
        $old_tramite = clone $tramite;

        $tramite->update([
            "tramitador_id" => $datos["tramitador_id"],
        ]);

        // detalles
        foreach ($datos["tramite_clientes"] as $key => $item) {
            if ($item['existente'] || ($item["cliente_id"] && $item["cliente_id"] != '')) {
                $cliente = Cliente::find($item["cliente_id"]);
            } else {
                $datos_cliente = $item["cliente"];
                $cliente = $this->cliente_service->crear([
                    "nombre" => $datos_cliente["nombre"],
                    "paterno" => $datos_cliente["paterno"],
                    "materno" => $datos_cliente["materno"],
                    "ci" => $datos_cliente["ci"],
                    "ci_exp" => $datos_cliente["ci_exp"],
                    "complemento" => $datos_cliente["complemento"],
                    "fecha_nac" => $datos_cliente["fecha_nac"],
                    "cel" => $datos_cliente["cel"],
                ]);
            }
            if ($item["id"] == 0) {
                $tramite->tramite_clientes()->create([
                    "tramite_id" => $item["tramite_id"],
                    "cliente_id" => $cliente->id,
                    "certificado_id" => null,
                    "existente" => $item["existente"],
                ]);
            }
        }

        if (isset($datos["eliminados"])) {
            foreach ($datos["eliminados"] as $value) {
                $tramite_cliente = TramiteCliente::find($value);
                $tramite_cliente->delete();
            }
        }

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "MODIFICACIÓN", "ACTUALIZÓ UN TRAMITE", $old_tramite, $tramite, ["tramite_clientes"]);

        return $tramite;
    }

    /**
     * Eliminar tramite
     *
     * @param Tramite $tramite
     * @return boolean
     */
    public function eliminar(Tramite $tramite): bool|Exception
    {
        $old_tramite = clone $tramite;

        foreach ($tramite->tramite_clientes as $item) {
            if ($item->certificado_id) {
                throw new Exception("No es posible eliminar el registro debido a que hay Certificados registrados");
            }
            $item->delete();
        }

        $tramite->delete();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ UN TRAMITE", $old_tramite, $tramite, ["tramite_clientes"]);

        return true;
    }

    /**
     * Cargar archivo
     *
     * @param TramiteCliente $tramite_cliente
     * @param UploadedFile $archivo
     * @return void
     */
    public function cargarArchivoDetalle(TramiteCliente $tramite_cliente, UploadedFile $archivo, int $index): void
    {
        if ($tramite_cliente->archivo) {
            \File::delete(public_path("files/tramites/" . $tramite_cliente->archivo));
        }

        $nombre = $index . $tramite_cliente->id . time();
        $tramite_cliente->archivo = $this->cargarArchivoService->cargarArchivo($archivo, public_path("files/tramites"), $nombre);
        $tramite_cliente->save();
    }
}
