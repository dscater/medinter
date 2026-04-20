<?php

namespace App\Http\Controllers;

use App\Services\TipoPagoService;
use Illuminate\Http\Request;

class TipoPagoController extends Controller
{
    public function __construct(private TipoPagoService $tipo_pago_service) {}

    public function listado()
    {
        return response()->JSON($this->tipo_pago_service->listado());
    }
}
