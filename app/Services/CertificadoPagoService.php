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

class CertificadoPagoService
{
    private $modulo = "CERTIFICADOS PAGOS";

    public function __construct(private HistorialAccionService $historialAccionService) {}

    public function crear(Certificado $certificado, $datos)
    {
        $fecha_actual = Carbon::now("America/La_Paz")->format("Y-m-d");
        $hora_actual = Carbon::now("America/La_Paz")->format("H:i:s");

        $certificado_pago =   $certificado->certificado_pagos()->create([
            "monto" => $datos["monto"],
            "tipo_pago" => $datos["tipo_pago"],
            "fecha" => $fecha_actual,
            "hora" => $hora_actual,
        ]);

        $certificado->saldo = (float)$certificado->total - ((float)$certificado->cancelado + (float)$certificado_pago->monto);
        $certificado->cancelado = (float)$certificado->cancelado + (float)$certificado_pago->monto;
        $certificado->save();
        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REGISTRO EL PAGO DE UN CERTIFICADO", $certificado_pago, null, ["certificado"]);

        return $certificado_pago;
    }
}
