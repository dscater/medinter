<?php

namespace App\Http\Controllers;

use App\Models\Certificado;
use App\Models\Cliente;
use App\Models\User;
use App\Services\PermisoService;
use Illuminate\Support\Facades\Auth;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class UserController extends Controller
{

    public function permisosUsuario(Request $request)
    {
        $permisoService = new PermisoService();
        return response()->JSON([
            "permisos" => $permisoService->getPermisosUser()
        ]);
    }

    public function getUser()
    {
        return response()->JSON([
            "user" => Auth::user()
        ]);
    }

    public static function getInfoBoxUser()
    {
        $permisos = [];
        $array_infos = [];
        if (Auth::check()) {
            $oUser = new User();
            $permisos = $oUser->permisos;
            if ($permisos == '*' || (is_array($permisos) && in_array('usuarios.index', $permisos))) {
                $array_infos[] = [
                    'label' => 'USUARIOS',
                    'cantidad' => User::where('id', '!=', 1)->count(),
                    'color' => 'bgWhite',
                    'icon' => "fa-users",
                    "url" => "usuarios.index"
                ];
            }
            if ($permisos == '*' || (is_array($permisos) && in_array('clientes.index', $permisos))) {
                $array_infos[] = [
                    'label' => 'CLIENTES',
                    'cantidad' => Cliente::where('status', 1)->count(),
                    'color' => 'bgWhite',
                    'icon' => "fa-user-friends",
                    "url" => "clientes.index"
                ];
            }
            if ($permisos == '*' || (is_array($permisos) && in_array('certificados.index', $permisos))) {
                $certificados = Certificado::select("certificados.id");
                if (Auth::user()->tipo == 'MÉDICO') {
                    $certificados->where("user_id", Auth::user()->id);
                }
                $certificados = $certificados->count();
                $array_infos[] = [
                    'label' => 'CERTIFICADOS',
                    'cantidad' => $certificados,
                    'color' => 'bgWhite',
                    'icon' => "fa-clipboard-list",
                    "url" => "certificados.index"
                ];
            }
        }


        return $array_infos;
    }
}
