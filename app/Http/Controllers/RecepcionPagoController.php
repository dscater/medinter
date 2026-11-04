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
        return Inertia::render("Admin/RecepcionPagos/Index", [
            "pagos" => Inertia::defer(fn() => $this->pago_service->listadoRecepcionPagos()),
        ]);
    }
}
