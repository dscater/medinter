<?php

namespace App\Services;

use App\Models\Certificado;
use App\Models\CertificadoDetalle;
use App\Models\LoginUser;
use App\Models\Pago;
use App\Services\HistorialAccionService;
use Carbon\Carbon;
use Illuminate\Http\UploadedFile;
use Exception;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Illuminate\Validation\ValidationException;

class PagoService
{
    private $modulo = "PAGOS";

    public function __construct(private HistorialAccionService $historialAccionService, private LoginUserService $login_user_service, private TipoPagoService $tipo_pago_service) {}

    public function reporteArqueo(
        $fecha_ini,
        $fecha_fin,
        $sucursal_id,
        $medico_id
    ) {
        $pagos = [];
        $suma_tipos = [];
        $suma_tipos_sin_verificar = [];
        $suma_total_tipos = [];
        if ($fecha_ini && $fecha_fin) {
            $pagos = Pago::with([
                "sucursal:id,nombre",
                "user:id,nombre,paterno,materno",
                "medico:id,nombre,paterno,materno",
                "certificado_detalle.tipo_certificado",
                "certificado_detalle.certificado.tramitador",
                "cliente:id,nombre,paterno,materno,ci,ci_exp,complemento",
            ])
                ->whereBetween("fecha_verificado", [$fecha_ini, $fecha_fin]);

            if ($sucursal_id != 'todos' || !$sucursal_id   || $sucursal_id == '') {
                $pagos->where("sucursal_id", $sucursal_id);
            }

            $login_user = $this->login_user_service->verificaSucursal();

            if (Auth::user()->tipo == 'ADMINISTRADOR' || Auth::user()->tipo == 'GERENTE') {
                if ($medico_id) {
                    $pagos->where("medico_id", $medico_id);
                }
            }
            if (Auth::user()->tipo == 'SECRETARIA') {
                $pagos->where("sucursal_id", $login_user->sucursal_id);
            }

            if (Auth::user()->tipo == 'MÉDICO') {
                $pagos->where("medico_id", Auth::user()->id);
            }

            $pagos->where("status", 1);

            $pagos_sin_verificar = clone $pagos;
            $pagos_sin_verificar->where("verificado", 0);

            $pagos->where("verificado", 1);

            $tipo_pagos = $this->tipo_pago_service->listado();

            foreach ($tipo_pagos as $item) {
                // Inicializar si no existe
                if (!isset($suma_total_tipos[$item["value"]])) {
                    $suma_total_tipos[$item["value"]] = 0;
                }

                $query = clone $pagos;
                $suma_total = $query->where("tipo_pago", $item["value"])->sum("monto");
                $suma_tipos[$item["value"]] = $suma_total;
                $suma_total_tipos[$item["value"]] += (float)$suma_total;
                // sin verificar
                $query2 = clone $pagos_sin_verificar;
                $suma_total = $query2->where("tipo_pago", $item["value"])->sum("monto");
                $suma_tipos_sin_verificar[$item["value"]] = $suma_total;
                $suma_total_tipos[$item["value"]] += (float)$suma_total;
            }

            $pagos_sin_verificar = $pagos_sin_verificar->get();
            $pagos = $pagos->get();
        }

        return [$pagos, $suma_tipos, $pagos_sin_verificar, $suma_tipos_sin_verificar, $suma_total_tipos];
    }

    public function crear($datos)
    {
        $fecha_actual = Carbon::now("America/La_Paz")->format("Y-m-d");
        $hora_actual = Carbon::now("America/La_Paz")->format("H:i:s");

        $login_user = $this->login_user_service->verificaSucursal();
        if (!$login_user) {
            throw new Exception("Error no se encontró la sucursal del usuario");
        }
        $sucursal_id = $login_user->sucursal_id;
        $verificado = 0;
        $fecha_verificado = $fecha_actual;
        $hora_verificado = $hora_actual;
        $tipo_usuario = $this->login_user_service->getTipoUsuarioLogin();
        if ($tipo_usuario == 'SECRETARIA' || !$this->login_user_service->verificaSecretariaSucursal($sucursal_id)) {
            // si es secretaria
            // o no hay secretaria en sucursal
            $verificado = 1;
        }

        $pago = Pago::create([
            "registro_id" => $datos["registro_id"],
            "modulo" => $datos["modulo"],
            "monto" => $datos["monto"],
            "descripcion" => isset($datos["descripcion"]) && $datos["descripcion"] ? $datos["descripcion"] : '',
            "tipo_pago" => $datos["tipo_pago"],
            "cliente_id" => isset($datos["cliente_id"]) ? $datos["cliente_id"] : NULL,
            "fecha" => $fecha_actual,
            "hora" => $hora_actual,
            "user_id" => Auth::user()->id, // ACTUALIZAR SI NO ESTA VERIFICADO EL PAGO (En verificación de Pago)
            "sucursal_id" => $sucursal_id,
            "verificado" => $verificado,
            "fecha_verificado" => $fecha_verificado,
            "hora_verificado" => $hora_verificado,
        ]);

        if (isset($datos["certificado_atendido"])) {
            $pago->medico_id = $datos["certificado_atendido"] == 1 ? Auth::user()->id : NULL;
        }

        if (isset($datos["medico_id"])) {
            $pago->medico_id = $datos["medico_id"];
            $pago->save();
        }

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REGISTRO EL PAGO DE UN CERTIFICADO", $pago, null);

        return $pago;
    }

    public function asignarMedicoPago(CertificadoDetalle $certificado_detalle)
    {
        $pago = Pago::where("modulo", "CertificadoDetalle")
            ->where("registro_id", $certificado_detalle->id)
            ->where("status", 1)
            ->get()->first();
        if ($pago) {
            // SI NO HAY PAGO EXISTE UN COBRO PENDIENTE
            $pago->medico_id = Auth::user()->id;
            $pago->save();
        }
    }


    public function registrarPagos($ids)
    {
        $fecha_actual = Carbon::now("America/La_Paz")->format("Y-m-d");
        $hora_actual = Carbon::now("America/La_Paz")->format("H:i:s");
        Pago::whereIn("id", $ids)->update([
            "verificado" => 1,
            "fecha_verificado" => $fecha_actual,
            "hora_verificado" => $hora_actual,
            "user_id" => Auth::user()->id // Usuario que recepciono el dinero
        ]);

        return true;
    }

    public function listadoRecepcionPagos()
    {
        $pagos = Pago::with(["sucursal:id,nombre", "user:id,nombre,paterno,materno"])
            ->where("status", 1)
            ->where("verificado", 0);

        $login_user = $this->login_user_service->verificaSucursal();
        if (!$login_user) {
            throw new Exception("Error no se encontró la sucursal del usuario");
        }
        $sucursal_id = $login_user->sucursal_id;

        if (Auth::user()->tipo != 'ADMINISTRADOR' && Auth::user()->tipo != 'GERENTE') {
            $pagos->where("sucursal_id", $sucursal_id);
        }

        $pagos = $pagos->get();

        return $pagos;
    }
}
