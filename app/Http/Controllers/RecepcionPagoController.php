<?php

namespace App\Http\Controllers;

use App\Models\Pago;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Inertia\Inertia;

class RecepcionPagoController extends Controller
{
    public function index()
    {
        $pagos = Pago::with(["sucursal:id,nombre", "user:id,nombre,paterno,materno"])->where("verificado", 0);

        if (Auth::user()->tipo != 'ADMINISTRADOR' && Auth::user()->tipo != 'GERENTE') {
            $pagos->where("sucursal_id", Auth::user()->sucursal_id);
        }

        $pagos = $pagos->get();
        return Inertia::render("Admin/RecepcionPagos/Index", compact("pagos"));
    }
}
