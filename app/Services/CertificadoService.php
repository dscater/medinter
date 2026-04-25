<?php

namespace App\Services;

use App\Models\Certificado;
use App\Models\CertificadoDetalle;
use App\Models\CertificadoEmitido;
use App\Models\TramiteCliente;
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

    public function __construct(private  CargarArchivoService $cargarArchivoService, private HistorialAccionService $historialAccionService, private CertificadoEmitidoService $certificado_emitido_service, private PagoService $pago_service, private LoginUserService $login_user_service) {}

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
        $ci,
    ): LengthAwarePaginator {
        $certificados = Certificado::select("certificados.*")
            ->with(["cliente:id,nombre,paterno,materno,ci,ci_exp,complemento", "sucursal:id,nombre", "user:id,nombre,paterno,materno", "certificado_detalles.tipo_certificado", "tramitador:id,nombre"])->where("status", 1);

        // FILTROS
        $certificados->when($cliente, function ($q) use ($cliente) {
            $q->whereHas('cliente', function ($sub) use ($cliente) {
                $sub->whereRaw("CONCAT(nombre, ' ', paterno, ' ', materno) LIKE ?", ["%$cliente%"]);
            });
        })
            ->when($ci, function ($q) use ($ci) {
                $q->whereHas('cliente', function ($sub) use ($ci) {
                    $sub->where('ci', 'like', "%$ci%");
                });
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
     * Lista de certificados paginado con filtros
     *
     * @param integer $length
     * @param integer $page
     * @param string $search
     * @param array $columnsSerachLike
     * @param array $columnsFilter
     * @return LengthAwarePaginator
     */
    public function listadoCobros(
        int $length,
        int $page,
        array $orderBy = [],
        $cliente,
        $ci,
    ): LengthAwarePaginator {
        $certificados = Certificado::select("certificados.*")
            ->with(["cliente:id,nombre,paterno,materno,ci,ci_exp,complemento", "sucursal:id,nombre", "user:id,nombre,paterno,materno", "certificado_detalles.tipo_certificado", "tramitador:id,nombre"])->where("status", 1);

        $certificados->where("saldo", ">", 0);

        if (Auth::user()->tipo == 'MÉDICO') {
            $login_user = $this->login_user_service->verificaSucursal();
            $certificados->where("sucursal_id", $login_user->sucursal_id ?? '');
        }

        // FILTROS
        $certificados
            ->when($cliente, function ($q) use ($cliente) {
                $q->whereHas('cliente', function ($sub) use ($cliente) {
                    $sub->whereRaw("CONCAT(nombre, ' ', paterno, ' ', materno) LIKE ?", ["%$cliente%"]);
                });
            })
            ->when($ci, function ($q) use ($ci) {
                $q->whereHas('cliente', function ($sub) use ($ci) {
                    $sub->where("ci", $ci);
                });
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
        $login_user = $this->login_user_service->verificaSucursal();
        if (!$login_user) {
            throw new Exception("Error no se encontró la sucursal del usuario");
        }
        $sucursal_id = $login_user->sucursal_id;
        $certificado = Certificado::create([
            "cliente_id" => $datos["cliente_id"],
            "total" => $datos["total"],
            "cancelado" => isset($datos["cancelado"]) ? $datos["cancelado"] : $datos["total"],
            "saldo" => isset($datos["saldo"]) ? $datos["saldo"] : 0,
            "tipo_pago" => $datos["tipo_pago"],
            "tramitador_id" => $datos["tramitador_id"] ?? null,
            "user_id" => $datos["estado"] == 1 ? Auth::user()->id : NULL,
            "sucursal_id" => $sucursal_id,
            "estado" => isset($datos["estado"]) ? $datos["estado"] : 1,
            "fecha_registro" => $fecha_actual,
            "hora_registro" => $hora_actual,
            "tipo" => isset($datos["tipo"]) ? $datos["tipo"] : 'NORMAL',
        ]);

        // HORA INICIO-FIN
        // atendido
        if ($certificado->estado == 1) {
            $certificado->fecha_inicio = $datos["fecha_inicio"];
            $certificado->hora_inicio = $datos["hora_inicio"];

            $certificado->fecha_fin = $fecha_actual;
            $certificado->hora_fin = $hora_actual;
        }

        // detalles
        foreach ($datos["certificado_detalles"] as $key => $item) {
            $saldo = 0;
            $cancelado = $item["precio"];
            if (!$item["con_saldo"]) {
                // CHECKBOX DESMARCADO == FALSE | 1
                $saldo = $item["precio"];
                $cancelado = 0;
            }

            $certificado_detalle = $certificado->certificado_detalles()->create([
                "categoria" => $item["categoria"] ?? '',
                "precio" => $item["precio"],
                "cancelado" => $cancelado,
                "saldo" => $saldo,
                "tipo_certificado_id" => $item["tipo_certificado_id"],
            ]);

            if ($datos["estado"] == 1) {
                // CERTIFICADO ATENDIDO
                $this->certificado_emitido_service->actualizarCertificadoEmitido($item["tipo_certificado_id"], $fecha_actual, Auth::user()->id);
                // cargar archivo
                if (!is_string($item["archivo"])) {
                    $archivo = $item["archivo"];
                    $this->cargarArchivoDetalle($certificado_detalle, $archivo, $key);
                }
            }

            // PAGO POR DETALLE
            if ($cancelado > 0) {
                $this->pago_service->crear([
                    "registro_id" => $certificado_detalle->id,
                    "modulo" => "CertificadoDetalle",
                    "monto" => $cancelado,
                    "tipo_pago" => $certificado->tipo_pago,
                    "descripcion" => "PAGO POR CERTIFICADO",
                    "cliente_id" => $datos["cliente_id"],
                    "certificado_atendido" => $certificado->estado,
                ]);
            }
        }

        // registrar accion
        if ($certificado->estado == 1) {
            $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REGISTRO UN CERTIFICADO", $certificado, null, ["certificado_detalles"]);
        } else {
            $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "INICIO UN CERTIFICADO", $certificado, null, ["certificado_detalles"]);
        }

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


        $fecha_actual = Carbon::now("America/La_Paz")->format("Y-m-d");
        $hora_actual = Carbon::now("America/La_Paz")->format("H:i:s");

        $certificado->update([
            "cliente_id" => $datos["cliente_id"],
            "total" => $datos["total"],
            "cancelado" => isset($datos["cancelado"]) ? $datos["cancelado"] : 0,
            "saldo" => isset($datos["saldo"]) ? $datos["saldo"] : 0,
            "tipo_pago" => $datos["tipo_pago"],
            "user_id" => Auth::user()->id,
            "tipo" => isset($datos["tipo"]) ? $datos["tipo"] : 'NORMAL',
        ]);

        // HORA INICIO-FIN
        // atendido
        if ($old_certificado->estado == 0) {
            $certificado->fecha_inicio = $datos["fecha_inicio"];
            $certificado->hora_inicio = $datos["hora_inicio"];

            $certificado->fecha_fin = $fecha_actual;
            $certificado->hora_fin = $hora_actual;
            $certificado->estado = 1;
            $certificado->save();
        }

        // detalles
        foreach ($datos["certificado_detalles"] as $key => $item) {
            $saldo = 0;
            $cancelado = $item["precio"];
            if (!$item["con_saldo"]) {
                // CHECKBOX DESMARCADO == FALSE | 1
                $saldo = $item["precio"];
                $cancelado = 0;
            }
            if ($item["id"] == 0) {
                $certificado_detalle = $certificado->certificado_detalles()->create([
                    "categoria" => $item["categoria"] ?? '',
                    "precio" => $item["precio"],
                    "cancelado" => $cancelado,
                    "saldo" => $saldo,
                    "tipo_certificado_id" => $item["tipo_certificado_id"],
                ]);

                // cargar archivo
                if (!is_string($item["archivo"])) {
                    $archivo = $item["archivo"];
                    $this->cargarArchivoDetalle($certificado_detalle, $archivo, $key);
                }

                $this->certificado_emitido_service->actualizarCertificadoEmitido($item["tipo_certificado_id"], $certificado->fecha_registro, Auth::user()->id);

                // PAGO POR DETALLE
                if ($cancelado > 0) {
                    $this->pago_service->crear([
                        "registro_id" => $certificado_detalle->id,
                        "modulo" => "CertificadoDetalle",
                        "monto" => $cancelado,
                        "tipo_pago" => $certificado->tipo_pago,
                        "descripcion" => "PAGO POR CERTIFICADO",
                        "cliente_id" => $datos["cliente_id"],
                        "certificado_atendido" => $certificado->estado,
                    ]);
                }
            } else {
                $certificado_detalle = CertificadoDetalle::find($item["id"]);
                // cargar archivo
                if (!is_string($item["archivo"])) {
                    $archivo = $item["archivo"];
                    \File::delete(public_path("files/certificados/" . $certificado_detalle->archivo));
                    $this->cargarArchivoDetalle($certificado_detalle, $archivo, $key);
                }

                if ($old_certificado->estado == 1) {
                    // previamente atendido
                    $this->certificado_emitido_service->actualizarCertificadoEmitido($item["tipo_certificado_id"], $certificado->fecha_registro, Auth::user()->id, $certificado_detalle->tipo_certificado_id);
                } else {
                    $this->pago_service->asignarMedicoPago($certificado_detalle);

                    $this->certificado_emitido_service->actualizarCertificadoEmitido($item["tipo_certificado_id"], $certificado->fecha_registro, Auth::user()->id);
                }

                $old_cancelado = $certificado_detalle->cancelado;

                $certificado_detalle->update([
                    "categoria" => $item["categoria"],
                    "precio" => $item["precio"],
                    "cancelado" => $cancelado,
                    "saldo" => $saldo,
                    "tipo_certificado_id" => $item["tipo_certificado_id"],
                ]);

                // PAGO POR DETALLE
                if ((!$this->pago_service->verificaPagoCertificadoDetalle($certificado_detalle) || $certificado->estado == 0) && $cancelado > 0) {
                    // si no hay pago registrado y el cancelado es mayor a 0, crear el pago
                    $this->pago_service->crear([
                        "registro_id" => $certificado_detalle->id,
                        "modulo" => "CertificadoDetalle",
                        "monto" => $cancelado,
                        "tipo_pago" => $certificado->tipo_pago,
                        "descripcion" => "PAGO POR CERTIFICADO",
                        "cliente_id" => $datos["cliente_id"],
                        "certificado_atendido" => $certificado->estado,
                    ]);
                } else {
                    // si hay pago registrado, verificar si el monto del pago es diferente al cancelado del detalle, si es diferente actualizar el monto del pago
                    $this->pago_service->actualizarPagoCertificadoDetalle($certificado_detalle, $old_cancelado, $saldo);
                }
            }
        }

        if (isset($datos["eliminados"])) {
            foreach ($datos["eliminados"] as $value) {
                $certificado_detalle = CertificadoDetalle::find($value);
                $this->certificado_emitido_service->descontarCertificadoEmitido($certificado_detalle->tipo_certificado_id, $certificado->fecha_registro, Auth::user()->id);
                \File::delete(public_path("files/certificados/" . $certificado_detalle->archivo));
                $this->pago_service->eliminarPagoCertificadoDetalle($certificado_detalle);
                $certificado_detalle->delete();
            }
        }

        // registrar accion
        if ($old_certificado->estado == 0) {
            // registrar accion
            $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REGISTRO UN CERTIFICADO", $certificado, null, ["certificado_detalles"]);
        } else {
            $this->historialAccionService->registrarAccion($this->modulo, "MODIFICACIÓN", "ACTUALIZÓ UN CERTIFICADO", $old_certificado, $certificado, ["certificado_detalles"]);
        }

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
            // if ($item->tipo == 'NORMAL') {
            $this->certificado_emitido_service->descontarCertificadoEmitido($item->tipo_certificado_id, $certificado->fecha_registro, Auth::user()->id);
            // } else {
            $tramite_cliente = TramiteCliente::where("certificado_id", $item->id);
            $tramite_cliente->certificado_id = null;
            $tramite_cliente->save();
            // }
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
