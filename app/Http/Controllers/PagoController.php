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
        $inicio = microtime(true);
        $tipo_pagos = $this->tipo_pago_service->listado();
        $t1 = microtime(true);
        $sucursals = $this->sucursal_service->listado();
        $t2 = microtime(true);
        $usuarios = $this->user_service->listado();
        $t3 = microtime(true);
        $medicos = $this->user_service->listadoByTipo("MÉDICO");

        $t4 = microtime(true);
        logger()->info("RENDIMIENTO PAGOS INDEX", [
            "tipo_pagos_ms" => round(($t1 - $inicio) * 1000, 2),
            "sucursals_ms" => round(($t2 - $t1) * 1000, 2),
            "usuarios_ms" => round(($t3 - $t2) * 1000, 2),
            "medicos_ms" => round(($t4 - $t3) * 1000, 2),
            "total_ms" => round(($t4 - $inicio) * 1000, 2),
            "memoria_kb" => round(memory_get_usage(true) / 1024, 2),
        ]);

        return Inertia::render("Admin/Pagos/Index", [
            "tipo_pagos" => $tipo_pagos,
            "sucursals" => $sucursals,
            "usuarios" => $usuarios,
            "medicos" => $medicos,
        ]);
    }

    /**
     * PAGOS VERIFICADOS
     */
    public function verificados(Request $request)
    {
        $resultado = $this->pagoService->listadoPagosVerificados(
            $request->input('fecha_ini', ""),
            $request->input('fecha_fin', ""),
            $request->input('sucursal_id', "") ?? null,
            $request->input('medico_id', "") ?? null,
            $request->input('user_id', "") ?? null,
            max(1, $request->integer('pagina_verificados', 1))
        );

        return response()->json($resultado);
    }

    /**
     * PAGOS SIN VERIFICAR
     */
    public function noVerificados(Request $request)
    {
        $resultado = $this->pagoService->listadoPagosSinVerificar(
            $request->input('fecha_ini', ""),
            $request->input('fecha_fin', ""),
            $request->input('sucursal_id', "") ?? null,
            $request->input('medico_id', "") ?? null,
            max(1, $request->integer('pagina_sin_verificar', 1))
        );

        return response()->json($resultado);
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
