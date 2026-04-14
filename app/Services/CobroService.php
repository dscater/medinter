<?php

namespace App\Services;

use App\Models\Certificado;
use App\Services\HistorialAccionService;
use Carbon\Carbon;
use Illuminate\Http\UploadedFile;
use Exception;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Illuminate\Validation\ValidationException;

class CobroService
{
    private $modulo = "CERTIFICADOS PAGOS";

    public function __construct(private HistorialAccionService $historialAccionService, private PagoService $pago_service) {}

    public function crear(Certificado $certificado, $datos)
    {
        $datos["registro_id"] = $certificado->id;
        $datos["modulo"] = "Certificado";
        $certificado_pago = $this->pago_service->crear($datos);

        // actualizar Saldo
        $certificado->saldo = $certificado->total - ((float)$certificado->cancelado + (float)$datos["monto"]);
        $certificado->save();

        return $certificado_pago;
    }
}
