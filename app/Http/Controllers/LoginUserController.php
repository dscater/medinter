<?php

namespace App\Http\Controllers;

use App\Models\LoginUser;
use App\Models\Sucursal;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class LoginUserController extends Controller
{
    public function verificaSucursal()
    {
        $user = Auth::user();
        $fecha_actual = Carbon::now("America/La_Paz")->format("Y-m-d");
        $login_user = LoginUser::where("user_id", $user->id)
            ->where("fecha", $fecha_actual)
            ->get()
            ->first();

        return response()->JSON([
            "login_user" => $login_user ? $login_user->load("sucursal") : null,
        ]);
    }
    public function asignaSucursal(Request $request)
    {
        $request->validate([
            "sucursal_id" => "required",
        ], [
            "sucursal_id.required" => "Debes seleccionar una sucursal"
        ]);

        $user = Auth::user();
        $fecha_actual = Carbon::now("America/La_Paz")->format("Y-m-d");
        $hora_actual = Carbon::now("America/La_Paz")->format("H:i:s");
        $login_user = LoginUser::create([
            "user_id" => $user->id,
            "sucursal_id" => $request->sucursal_id,
            "fecha" => $fecha_actual,
            "hora" => $hora_actual,
        ]);
        return response()->JSON([
            "login_user" => $login_user->load("sucursal"),
        ]);
    }
}
