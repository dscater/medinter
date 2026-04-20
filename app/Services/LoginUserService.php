<?php

namespace App\Services;

use App\Models\LoginUser;
use Carbon\Carbon;
use Exception;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;

class LoginUserService
{
    public function __construct() {}

    public function verificaSucursal()
    {
        $fecha_actual = Carbon::now("America/La_Paz")->format("Y-m-d");
        $user = Auth::user();
        $login_user = LoginUser::where("user_id", $user->id)
            ->where("fecha", $fecha_actual)
            ->get()
            ->first();

        return $login_user ? $login_user->load("sucursal") : null;
    }


    public function getTipoUsuarioLogin()
    {
        $user = Auth::user();
        return $user->tipo;
    }

    public function verificaSecretariaSucursal($sucursal_id)
    {
        $fecha_actual = Carbon::now("America/La_Paz")->format("Y-m-d");

        $login_secretaria = LoginUser::where("fecha", $fecha_actual)
            ->whereHas("user", function ($q) use ($sucursal_id) {
                $q->where("tipo", "SECRETARIA");
            })
            ->get()->first();

        return $login_secretaria;
    }

    public function asignaSucursal($sucursal_id)
    {
        $user = Auth::user();
        $fecha_actual = Carbon::now("America/La_Paz")->format("Y-m-d");
        $hora_actual = Carbon::now("America/La_Paz")->format("H:i:s");
        $login_user = LoginUser::create([
            "user_id" => $user->id,
            "sucursal_id" => $sucursal_id,
            "fecha" => $fecha_actual,
            "hora" => $hora_actual,
        ]);

        return $login_user->load("sucursal");
    }
}
