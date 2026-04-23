<?php

namespace App\Http\Controllers;

use App\Models\Pago;
use App\Services\PagoService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;

class RecepcionPagoController extends Controller
{
    public function __construct(private PagoService $pago_service) {}

    public function index()
    {
        $pagos = $this->pago_service->listadoRecepcionPagos();
        return Inertia::render("Admin/RecepcionPagos/Index", compact("pagos"));
    }
}
