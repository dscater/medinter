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
use Illuminate\Support\Facades\File;
use Illuminate\Support\Str;
use RuntimeException;
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
        ?string $cliente = null,
        ?string $ci = null,
        ?string $fecha_ini = null,
        ?string $fecha_fin = null,
    ): LengthAwarePaginator {
        $length = min(max($length, 1), 50);
        $page = max($page, 1);

        $cliente = trim((string) $cliente);
        $ci = trim((string) $ci);

        $buscarPorCliente = $cliente !== '';
        $buscarPorCi = $ci !== '';

        $buscarRegistroEspecifico =
            $buscarPorCliente || $buscarPorCi;

        $certificados = Certificado::query()
            ->select("certificados.*")
            ->with([
                "cliente:id,nombre,paterno,materno,fecha_nac,fecha_registro,ci,ci_exp,complemento",
                "sucursal:id,nombre",
                "user:id,nombre,paterno,materno",
                "inicio:id,nombre,paterno,materno",
                "certificado_detalles.tipo_certificado",
                "certificado_detalles.user",
                "tramitador:id,nombre",
            ])
            ->where("certificados.status", 1);

        if ($buscarPorCliente) {
            $certificados->whereHas(
                "cliente",
                function ($query) use ($cliente) {
                    $query->where(function ($q) use ($cliente) {
                        $q->where(
                            "nombre",
                            "like",
                            "{$cliente}%"
                        )
                            ->orWhere(
                                "paterno",
                                "like",
                                "{$cliente}%"
                            )
                            ->orWhere(
                                "materno",
                                "like",
                                "{$cliente}%"
                            );
                    });
                }
            );
        }

        if ($buscarPorCi) {
            $certificados->whereHas(
                "cliente",
                function ($query) use ($ci) {
                    $query->where(
                        "ci",
                        "like",
                        "{$ci}%"
                    );
                }
            );
        }

        /*
    |--------------------------------------------------------------------------
    | Las fechas solo se aplican cuando no se busca por cliente o CI
    |--------------------------------------------------------------------------
    */

        if (!$buscarRegistroEspecifico) {
            if (!$fecha_ini || !$fecha_fin) {
                $fecha_fin = now("America/La_Paz")
                    ->toDateString();

                $fecha_ini = now("America/La_Paz")
                    ->subDays(6)
                    ->toDateString();
            }

            $certificados->whereBetween(
                "certificados.fecha_registro",
                [
                    $fecha_ini,
                    $fecha_fin,
                ]
            );
        }

        $allowedOrderColumns = [
            "id",
            "fecha_registro",
            "status",
            "cliente_id",
            "sucursal_id",
            "user_id",
        ];

        $hasOrder = false;

        foreach ($orderBy as $value) {
            $column = $value[0] ?? null;
            $direction = strtolower(
                $value[1] ?? "asc"
            );

            if (
                in_array(
                    $column,
                    $allowedOrderColumns,
                    true
                ) &&
                in_array(
                    $direction,
                    ["asc", "desc"],
                    true
                )
            ) {
                $certificados->orderBy(
                    "certificados.{$column}",
                    $direction
                );

                $hasOrder = true;
            }
        }

        if (!$hasOrder) {
            $certificados->orderBy(
                "certificados.fecha_registro",
                "desc"
            );
        }

        return $certificados->paginate(
            $length,
            ["*"],
            "page",
            $page
        );
    }

    public function listadoPaginadoEliminados(
        int $length,
        int $page,
        array $orderBy = [],
        $cliente,
        $ci,
    ): LengthAwarePaginator {
        $certificados = Certificado::select("certificados.*")
            ->with(["cliente:id,nombre,paterno,materno,ci,ci_exp,complemento", "sucursal:id,nombre", "user:id,nombre,paterno,materno", "inicio:id,nombre,paterno,materno", "certificado_detalles.tipo_certificado", "certificado_detalles.user", "tramitador:id,nombre"])->where("status", 0);

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
        $tramitador_id,
    ): LengthAwarePaginator {
        $certificados = Certificado::select("certificados.*")
            ->with(["cliente:id,nombre,paterno,materno,ci,ci_exp,complemento", "sucursal:id,nombre", "user:id,nombre,paterno,materno", "inicio:id,nombre,paterno,materno", "certificado_detalles.tipo_certificado", "certificado_detalles.user", "tramitador:id,nombre"])->where("status", 1);

        $certificados->where("saldo", ">", 0);

        // if (Auth::user()->tipo == 'MÉDICO') {
        //     $login_user = $this->login_user_service->verificaSucursal();
        //     $certificados->where("sucursal_id", $login_user->sucursal_id ?? '');
        // }

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
            })
            ->when($tramitador_id, function ($q) use ($tramitador_id) {
                $q->where('tramitador_id', $tramitador_id);
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
        $userId = Auth::id();

        $estado = $datos["estado"] ?? 1;

        $certificadoData = [
            "cliente_id" => $datos["cliente_id"],
            "total" => $datos["total"],
            "cancelado" => $datos["cancelado"] ?? $datos["total"],
            "saldo" => $datos["saldo"] ?? 0,
            "tipo_pago" => $datos["tipo_pago"],
            "tramitador_id" => $datos["tramitador_id"] ?? null,
            "inicio_id" => $userId,
            "user_id" => $estado == 1 ? $userId : null,
            "sucursal_id" => $sucursal_id,
            "estado" => $estado,
            "fecha_registro" => $fecha_actual,
            "hora_registro" => $hora_actual,
            "tipo" => $datos["tipo"] ?? "NORMAL",
        ];

        // $certificado = Certificado::create([
        //     "cliente_id" => $datos["cliente_id"],
        //     "total" => $datos["total"],
        //     "cancelado" => isset($datos["cancelado"]) ? $datos["cancelado"] : $datos["total"],
        //     "saldo" => isset($datos["saldo"]) ? $datos["saldo"] : 0,
        //     "tipo_pago" => $datos["tipo_pago"],
        //     "tramitador_id" => $datos["tramitador_id"] ?? null,
        //     "inicio_id" => Auth::user()->id,
        //     "user_id" => $datos["estado"] == 1 ? Auth::user()->id : NULL,
        //     "sucursal_id" => $sucursal_id,
        //     "estado" => isset($datos["estado"]) ? $datos["estado"] : 1,
        //     "fecha_registro" => $fecha_actual,
        //     "hora_registro" => $hora_actual,
        //     "tipo" => isset($datos["tipo"]) ? $datos["tipo"] : 'NORMAL',
        // ]);

        // HORA INICIO-FIN
        // atendido
        if ($estado == 1) {
            $certificadoData["fecha_inicio"] = $datos["fecha_inicio"];
            $certificadoData["hora_inicio"] = $datos["hora_inicio"];
            $certificadoData["fecha_fin"] = $fecha_actual;
            $certificadoData["hora_fin"] = $hora_actual;
        }

        $certificado = Certificado::create($certificadoData);

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
                    // ATENDIDO
                    $certificado_detalle->estado = 1;
                    $certificado_detalle->user_id = Auth::user()->id;
                    $certificado_detalle->fecha_inicio = $datos["fecha_inicio"];
                    $certificado_detalle->hora_inicio = $datos["hora_inicio"];
                    $certificado_detalle->fecha_fin = $fecha_actual;
                    $certificado_detalle->hora_fin = $hora_actual;
                    $certificado_detalle->save();
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

        $this->actualizaEstadoCertificado($certificado);
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

    public function actualizar(
        array $datos,
        Certificado $certificado
    ): Certificado {

        $userId = Auth::id();

        $now = Carbon::now("America/La_Paz");

        $fechaActual = $now->toDateString();
        $horaActual = $now->format("H:i:s");

        $estadoAnterior = (int) $certificado->estado;
        $oldCertificado = clone $certificado;

        /*
        |--------------------------------------------------------------------------
        | Guardar detalles originales para auditoría
        |--------------------------------------------------------------------------
        */

        $datosOriginalDetalles = $certificado
            ->certificado_detalles()
            ->get()
            ->toArray();

        /*
        |--------------------------------------------------------------------------
        | Preparar datos del certificado
        |--------------------------------------------------------------------------
        */

        $certificadoData = [
            "cliente_id" => $datos["cliente_id"],
            "total" => $datos["total"],
            "cancelado" => $datos["cancelado"] ?? 0,
            "saldo" => $datos["saldo"] ?? 0,
            "tipo_pago" => $datos["tipo_pago"],
            "tipo" => $datos["tipo"] ?? "NORMAL",
            "tramitador_id" => $datos["tramitador_id"] ?? null,
        ];

        /*
        |--------------------------------------------------------------------------
        | Cambio de pendiente a atendido
        |--------------------------------------------------------------------------
        */

        if ($estadoAnterior === 0) {
            $certificadoData = array_merge(
                $certificadoData,
                [
                    "fecha_inicio" => $datos["fecha_inicio"],
                    "hora_inicio" => $datos["hora_inicio"],
                    "user_id" => $userId,
                    "fecha_fin" => $fechaActual,
                    "hora_fin" => $horaActual,
                    "estado" => 1,
                ]
            );
        }

        /*
        |--------------------------------------------------------------------------
        | Un solo UPDATE del certificado
        |--------------------------------------------------------------------------
        */

        $certificado->update($certificadoData);

        /*
        |--------------------------------------------------------------------------
        | Precargar detalles existentes
        |--------------------------------------------------------------------------
        */

        $detalleIds = collect(
            $datos["certificado_detalles"] ?? []
        )
            ->pluck("id")
            ->filter(fn($id) => (int) $id > 0)
            ->map(fn($id) => (int) $id)
            ->values();

        $detallesExistentes = $detalleIds->isEmpty()
            ? collect()
            : CertificadoDetalle::query()
            ->where("certificado_id", $certificado->id)
            ->whereIn("id", $detalleIds)
            ->get()
            ->keyBy("id");

        $sucursalId = null;

        $obtenerSucursalId = function () use (
            &$sucursalId
        ) {
            if ($sucursalId !== null) {
                return $sucursalId;
            }

            $loginUser = $this
                ->login_user_service
                ->verificaSucursal();

            if (!$loginUser) {
                throw new Exception(
                    "Error: no se encontró la sucursal del usuario"
                );
            }

            $sucursalId = $loginUser->sucursal_id;

            return $sucursalId;
        };

        /*
        |--------------------------------------------------------------------------
        | Procesar detalles
        |--------------------------------------------------------------------------
        */

        foreach (
            $datos["certificado_detalles"] ?? []
            as $key => $item
        ) {
            $precio = $item["precio"];

            $saldo = $item["con_saldo"]
                ? 0
                : $precio;

            $cancelado = $item["con_saldo"]
                ? $precio
                : 0;

            $detalleId = (int) ($item["id"] ?? 0);

            /*
            |--------------------------------------------------------------------------
            | Detalle nuevo
            |--------------------------------------------------------------------------
            */

            if ($detalleId === 0) {
                $certificadoDetalle = $certificado
                    ->certificado_detalles()
                    ->create([
                        "categoria" => $item["categoria"] ?? "",
                        "precio" => $precio,
                        "cancelado" => $cancelado,
                        "saldo" => $saldo,
                        "tipo_certificado_id" =>
                        $item["tipo_certificado_id"],
                    ]);

                if (
                    isset($item["archivo"]) &&
                    !is_string($item["archivo"])
                ) {
                    $archivo = $item["archivo"];

                    $this->cargarArchivoDetalle(
                        $certificadoDetalle,
                        $archivo,
                        $key
                    );

                    if ($certificadoDetalle->estado == 0) {
                        $certificadoDetalle->update([
                            "sucursal_id" =>
                            $obtenerSucursalId(),
                            "estado" => 1,
                            "user_id" => $userId,
                            "fecha_inicio" =>
                            $datos["fecha_inicio"],
                            "hora_inicio" =>
                            $datos["hora_inicio"],
                            "fecha_fin" => $fechaActual,
                            "hora_fin" => $horaActual,
                        ]);
                    }
                }

                if ($estadoAnterior === 1) {
                    $this
                        ->certificado_emitido_service
                        ->actualizarCertificadoEmitido(
                            $item["tipo_certificado_id"],
                            $certificado->fecha_registro,
                            $userId
                        );
                }

                if ($cancelado > 0) {
                    $this->pago_service->crear([
                        "registro_id" =>
                        $certificadoDetalle->id,
                        "modulo" =>
                        "CertificadoDetalle",
                        "monto" => $cancelado,
                        "tipo_pago" =>
                        $certificado->tipo_pago,
                        "descripcion" =>
                        "PAGO POR CERTIFICADO",
                        "cliente_id" =>
                        $certificado->cliente_id,
                        "certificado_atendido" =>
                        $certificado->estado,
                    ]);
                }

                continue;
            }

            /*
            |--------------------------------------------------------------------------
            | Detalle existente
            |--------------------------------------------------------------------------
            */

            $certificadoDetalle =
                $detallesExistentes->get($detalleId);

            if (!$certificadoDetalle) {
                throw new Exception(
                    "El detalle {$detalleId} no pertenece al certificado"
                );
            }

            $oldCancelado = $certificadoDetalle->cancelado;

            if (
                isset($item["archivo"]) &&
                !is_string($item["archivo"])
            ) {
                $this->cargarArchivoDetalle(
                    $certificadoDetalle,
                    $item["archivo"],
                    $key
                );

                if ($certificadoDetalle->estado == 0) {
                    $certificadoDetalle->update([
                        "sucursal_id" =>
                        $obtenerSucursalId(),
                        "estado" => 1,
                        "user_id" => $userId,
                        "fecha_inicio" =>
                        $datos["fecha_inicio"],
                        "hora_inicio" =>
                        $datos["hora_inicio"],
                        "fecha_fin" => $fechaActual,
                        "hora_fin" => $horaActual,
                    ]);
                }
            }

            if ($estadoAnterior === 1) {
                $this
                    ->certificado_emitido_service
                    ->actualizarCertificadoEmitido(
                        $item["tipo_certificado_id"],
                        $certificado->fecha_registro,
                        $certificado->user_id,
                        $certificadoDetalle
                            ->tipo_certificado_id
                    );
            } else {
                $this
                    ->pago_service
                    ->asignarMedicoPago(
                        $certificadoDetalle
                    );

                $this
                    ->certificado_emitido_service
                    ->actualizarCertificadoEmitido(
                        $item["tipo_certificado_id"],
                        $certificado->fecha_registro,
                        $userId
                    );
            }

            $certificadoDetalle->update([
                "categoria" => $item["categoria"] ?? "",
                "precio" => $precio,
                "cancelado" => $cancelado,
                "saldo" => $saldo,
                "tipo_certificado_id" =>
                $item["tipo_certificado_id"],
            ]);

            $existePago = $this
                ->pago_service
                ->obtienePagoAnuladoExistente(
                    $certificadoDetalle
                );

            if (!$existePago && $cancelado > 0) {
                $this->pago_service->crear([
                    "registro_id" =>
                    $certificadoDetalle->id,
                    "modulo" =>
                    "CertificadoDetalle",
                    "monto" => $cancelado,
                    "tipo_pago" =>
                    $certificado->tipo_pago,
                    "descripcion" =>
                    "PAGO POR CERTIFICADO",
                    "cliente_id" =>
                    $certificado->cliente_id,
                    "certificado_atendido" =>
                    $certificado->estado,
                ]);
            } else {
                $this
                    ->pago_service
                    ->actualizarPagoCertificadoDetalle(
                        $certificadoDetalle,
                        $oldCancelado,
                        $saldo,
                        $existePago
                    );
            }
        }

        /*
        |--------------------------------------------------------------------------
        | Eliminar detalles
        |--------------------------------------------------------------------------
        */

        foreach ($datos["eliminados"] ?? [] as $detalleId) {
            $detalle = $certificado
                ->certificado_detalles()
                ->whereKey($detalleId)
                ->first();

            if (!$detalle) {
                continue;
            }

            $this
                ->certificado_emitido_service
                ->descontarCertificadoEmitido(
                    $detalle->tipo_certificado_id,
                    $certificado->fecha_registro,
                    $userId
                );

            if ($detalle->archivo) {
                File::delete(
                    public_path(
                        "files/certificados/{$detalle->archivo}"
                    )
                );
            }

            $this
                ->pago_service
                ->eliminarPagoCertificadoDetalle($detalle);

            $detalle->delete();
        }

        /*
        |--------------------------------------------------------------------------
        | Actualizar estado final
        |--------------------------------------------------------------------------
        */

        $this->actualizaEstadoCertificado($certificado);

        /*
        |--------------------------------------------------------------------------
        | Historial
        |--------------------------------------------------------------------------
        */

        if ($estadoAnterior === 0) {
            $this
                ->historialAccionService
                ->registrarAccion(
                    $this->modulo,
                    "CREACIÓN",
                    "REGISTRO UN CERTIFICADO",
                    $certificado,
                    null,
                    ["certificado_detalles"]
                );
        } else {
            $this
                ->historialAccionService
                ->registrarAccion(
                    $this->modulo,
                    "MODIFICACIÓN",
                    "ACTUALIZÓ UN CERTIFICADO",
                    $oldCertificado,
                    $certificado,
                    ["certificado_detalles"]
                );
        }

        return $certificado->fresh();
    }

    public function actualizaEstadoCertificado(Certificado $certificado)
    {
        $detalle_pendientes = $certificado->certificado_detalles->where("estado", 0)->count();
        $certificado->estado = 1;
        if ($detalle_pendientes > 0) {
            $certificado->estado = 0;
        }
        $certificado->save();
    }


    /**
     * Actualizar detalles de certificado 
     * Solo detalles sin archivos
     * no se Toma en cuenta los Médicos
     *
     * @param array $datos
     * @param Certificado $certificado
     * @return Certificado
     */
    public function actualizarCertificadoDetalle(array $datos, Certificado $certificado): Certificado
    {
        $old_certificado = clone $certificado;
        $fecha_actual = Carbon::now("America/La_Paz")->format("Y-m-d");
        $hora_actual = Carbon::now("America/La_Paz")->format("H:i:s");

        $certificado->update([
            "total" => $datos["total"],
            "cancelado" => isset($datos["cancelado"]) ? $datos["cancelado"] : 0,
            "saldo" => isset($datos["saldo"]) ? $datos["saldo"] : 0,
            "tipo_pago" => $datos["tipo_pago"],
            "tipo" => isset($datos["tipo"]) ? $datos["tipo"] : 'NORMAL',
            "tramitador_id" => $datos["tramitador_id"] ?? null,
            // "user_id" => Auth::user()->id,
            "tipo" => isset($datos["tipo"]) ? $datos["tipo"] : 'NORMAL',
        ]);

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

                // PAGO POR DETALLE
                if ($cancelado > 0) {
                    $this->pago_service->crear([
                        "registro_id" => $certificado_detalle->id,
                        "modulo" => "CertificadoDetalle",
                        "monto" => $cancelado,
                        "tipo_pago" => $certificado->tipo_pago,
                        "descripcion" => "PAGO POR CERTIFICADO",
                        "cliente_id" => $certificado->cliente_id,
                        "certificado_atendido" => $certificado->estado,
                    ]);
                }
            } else {
                $certificado_detalle = CertificadoDetalle::find($item["id"]);
                $old_cancelado = $certificado_detalle->cancelado;

                $certificado_detalle->update([
                    "precio" => $item["precio"],
                    "cancelado" => $cancelado,
                    "saldo" => $saldo,
                    "tipo_certificado_id" => $item["tipo_certificado_id"],
                ]);

                // PAGO POR DETALLE
                $existe_pago = $this->pago_service->obtienePagoAnuladoExistente($certificado_detalle);
                if (!$existe_pago  && $cancelado > 0) {
                    // si no hay pago registrado y el cancelado es mayor a 0, crear el pago
                    $this->pago_service->crear([
                        "registro_id" => $certificado_detalle->id,
                        "modulo" => "CertificadoDetalle",
                        "monto" => $cancelado,
                        "tipo_pago" => $certificado->tipo_pago,
                        "descripcion" => "PAGO POR CERTIFICADO",
                        "cliente_id" => $certificado->cliente_id,
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
                \File::delete(public_path("files/certificados/" . $certificado_detalle->archivo));
                $this->pago_service->eliminarPagoCertificadoDetalle($certificado_detalle);
                $certificado_detalle->delete();
            }
        }

        $this->actualizaEstadoCertificado($certificado);

        $this->historialAccionService->registrarAccion($this->modulo, "MODIFICACIÓN", "ACTUALIZÓ UN LOS DETALLES DE UN CERTIFICADO", $old_certificado, $certificado, ["certificado_detalles"]);

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
            $this->certificado_emitido_service->descontarCertificadoEmitido($item->tipo_certificado_id, $certificado->fecha_registro, $certificado->user_id);

            // ELIMINAR ARCHIVO
            // \File::delete(public_path("files/certificados/" . $item->archivo));

            // PAGOS
            $this->pago_service->eliminarPagoPorCertificadoDetalle($item);
        }

        $certificado->status = 0;
        $certificado->save();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ UN CERTIFICADO", $old_certificado, $certificado, ["certificado_detalles"]);

        return true;
    }



    public function restaurar(Certificado $certificado): bool|Exception
    {
        $old_certificado = clone $certificado;

        foreach ($certificado->certificado_detalles as $item) {
            $this->certificado_emitido_service->actualizarCertificadoEmitido($item->tipo_certificado_id, $certificado->fecha_registro, $certificado->user_id);
            // PAGOS
            $this->pago_service->restaurarPagoPorCertificadoDetalle($item);
        }

        $certificado->status = 1;
        $certificado->save();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "RESTAURACIÓN", "RESTAURÓ UN CERTIFICADO", $old_certificado, $certificado, ["certificado_detalles"]);

        return true;
    }

    public function eliminacionPermanente(Certificado $certificado): bool|Exception
    {
        $old_certificado = clone $certificado;

        foreach ($certificado->certificado_detalles as $item) {
            $this->certificado_emitido_service->descontarCertificadoEmitido($item->tipo_certificado_id, $certificado->fecha_registro, $certificado->user_id);

            // ELIMINAR ARCHIVO
            \File::delete(public_path("files/certificados/" . $item->archivo));

            // PAGOS
            $this->pago_service->eliminaPagoPorCertificadoDetallePermanente($item);

            $item->delete();
        }

        $certificado->delete();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ PERMANENTEMENTE UN CERTIFICADO", $old_certificado, $certificado, ["certificado_detalles"]);

        return true;
    }

    /**
     * Cargar archivo
     *
     * @param CertificadoDetalle $certificado_detalle
     * @param UploadedFile $archivo
     * @return void
     */

    public function cargarArchivoDetalle(
        CertificadoDetalle $certificado_detalle,
        UploadedFile $archivo,
        int $index
    ): void {
        // $inicio = microtime(true);

        // Obtener el tamaño antes de mover el archivo temporal.
        // $tamanoBytes = $archivo->getSize();

        $directorio = public_path('files/certificados');

        if (!File::isDirectory($directorio)) {
            File::makeDirectory($directorio, 0755, true);
        }

        $nombre = $certificado_detalle->id . '_' . Str::uuid();

        // Guardar el nuevo archivo.
        $nuevoArchivo = $this->cargarArchivoService->cargarArchivo(
            $archivo,
            $directorio,
            $nombre
        );

        if (!$nuevoArchivo) {
            throw new RuntimeException(
                'No se pudo guardar el archivo del certificado.'
            );
        }

        $archivoAnterior = $certificado_detalle->archivo;

        // Actualizar la referencia en la base de datos.
        $certificado_detalle->archivo = $nuevoArchivo;
        $certificado_detalle->save();

        // Eliminar el archivo anterior después de guardar el nuevo.
        if ($archivoAnterior && $archivoAnterior !== $nuevoArchivo) {
            File::delete(
                $directorio . DIRECTORY_SEPARATOR . $archivoAnterior
            );
        }

        // $duracionMs = round((microtime(true) - $inicio) * 1000, 2);

        // Log::info('Rendimiento carga archivo certificado', [
        //     'certificado_detalle_id' => $certificado_detalle->id,
        //     'tamano_bytes' => $tamanoBytes,
        //     'duracion_ms' => $duracionMs,
        // ]);
    }
}
