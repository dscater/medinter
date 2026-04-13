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

    public function __construct(private HistorialAccionService $historialAccionService, private CertificadoPagoService $certificado_pago_service) {}

    public function crear(Certificado $certificado, $datos)
    {
        $certificado_pago = $this->certificado_pago_service->crear($certificado, $datos);
        return $certificado_pago;
    }
}
