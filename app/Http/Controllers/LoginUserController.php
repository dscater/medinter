<?php

namespace App\Http\Controllers;

use App\Models\LoginUser;
use App\Models\Sucursal;
use App\Services\LoginUserService;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class LoginUserController extends Controller
{
    public function __construct(private LoginUserService $login_user_service) {}

    public function verificaSucursal()
    {
        return response()->JSON([
            "login_user" => $this->login_user_service->verificaSucursal(),
        ]);
    }
    public function asignaSucursal(Request $request)
    {
        $request->validate([
            "sucursal_id" => "required",
            "verifica_pagos" => "required",
        ], [
            "sucursal_id.required" => "Debes seleccionar una sucursal",
            "verifica_pagos.required" => "No se seleccionó una opción"
        ]);
        return response()->JSON([
            "login_user" => $this->login_user_service->asignaSucursal($request->sucursal_id, $request->verifica_pagos)
        ]);
    }
}
