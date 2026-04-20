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
        ], [
            "sucursal_id.required" => "Debes seleccionar una sucursal"
        ]);
        return response()->JSON([
            "login_user" => $this->login_user_service->asignaSucursal($request->sucursal_id)
        ]);
    }
}
