<?php

namespace App\Services;

use App\Models\Certificado;
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

    public function __construct(private HistorialAccionService $historialAccionService) {}

    public function crear($datos)
    {
        $fecha_actual = Carbon::now("America/La_Paz")->format("Y-m-d");
        $hora_actual = Carbon::now("America/La_Paz")->format("H:i:s");

        $pago = Pago::create([
            "registro_id" => $datos["registro_id"],
            "modulo" => $datos["modulo"],
            "monto" => $datos["monto"],
            "tipo_pago" => $datos["tipo_pago"],
            "fecha" => $fecha_actual,
            "hora" => $hora_actual,
        ]);

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REGISTRO EL PAGO DE UN CERTIFICADO", $pago, null, ["certificado"]);

        return $pago;
    }
}
