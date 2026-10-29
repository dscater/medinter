<?php

namespace App\Http\Controllers;

use App\Models\Pago;
use App\Services\LoginUserService;
use App\Services\PagoService;
use App\Services\SucursalService;
use App\Services\TipoPagoService;
use App\Services\UserService;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Inertia\Inertia;

class PagoController extends Controller
{
    public function __construct(
        private PagoService $pagoService,
        private TipoPagoService $tipo_pago_service,
        private SucursalService $sucursal_service,
        private UserService $user_service
    ) {}

    public function index()
    {

        $tipo_pagos = $this->tipo_pago_service->listado();
        $sucursals = $this->sucursal_service->listado();

        $usuarios = $this->user_service->listado();
        $medicos = $this->user_service->listadoByTipo("MÉDICO");

        return Inertia::render("Admin/Pagos/Index", [
            "tipo_pagos" => $tipo_pagos,
            "sucursals" => $sucursals,
            "usuarios" => $usuarios,
            "medicos" => $medicos,
        ]);
    }

    public function verificados(Request $request)
    {
        $fecha_ini = $request->fecha_ini;
        $fecha_fin = $request->fecha_fin;
        $sucursal_id = $request->sucursal_id;
        $medico_id = $request->medico_id;
        $user_id = $request->user_id;

        $array_res = $this->pagoService->listadoArqueoPaginado(
            $fecha_ini,
            $fecha_fin,
            $sucursal_id,
            $medico_id,
            $user_id
        );


        return response()->JSON($array_res);
    }

    public function registrarPagos(Request $request)
    {
        DB::beginTransaction();
        try {
            $ids = $request->ids;
            $this->pagoService->registrarPagos($ids);
            DB::commit();
            return response()->JSON([
                "sw" => true,
                "message" => "Proceso realizado con éxito"
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }
}
