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

    public function __construct(private HistorialAccionService $historialAccionService, private LoginUserService $login_user_service) {}

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
        $fecha_verificado = null;
        $hora_verificado = null;
        $tipo_usuario = $this->login_user_service->getTipoUsuarioLogin();
        if ($tipo_usuario == 'SECRETARIA' || !$this->login_user_service->verificaSecretariaSucursal($sucursal_id)) {
            // si es secretaria
            // o no hay secretaria en sucursal
            $verificado = 1;
            $fecha_verificado = $fecha_actual;
            $hora_verificado = $hora_actual;
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
}
