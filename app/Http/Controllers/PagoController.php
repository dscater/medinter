<?php

namespace App\Http\Controllers;

use App\Models\Pago;
use App\Services\LoginUserService;
use App\Services\PagoService;
use App\Services\TipoPagoService;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Inertia\Inertia;

class PagoController extends Controller
{
    public function __construct(private PagoService $pagoService) {}

    public function index()
    {
        return Inertia::render("Admin/Pagos/Index");
    }

    public function verificados(Request $request)
    {
        $fecha_ini = $request->fecha_ini;
        $fecha_fin = $request->fecha_fin;
        $sucursal_id = $request->sucursal_id;
        $medico_id = $request->medico_id;

        $array_res = $this->pagoService->reporteArqueo($fecha_ini, $fecha_fin, $sucursal_id, $medico_id);
        $pagos = $array_res[0];
        $suma_tipos = $array_res[1];
        $pagos_sin_verificar = $array_res[2];
        $suma_tipos_sin_verificar = $array_res[3];
        $suma_total_tipos = $array_res[4];

        return response()->JSON([
            "pagos" => $pagos,
            "suma_tipos" => $suma_tipos,
            "pagos_sin_verificar" => $pagos_sin_verificar,
            "suma_tipos_sin_verificar" => $suma_tipos_sin_verificar,
            "suma_total_tipos" => $suma_total_tipos,
        ]);
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
