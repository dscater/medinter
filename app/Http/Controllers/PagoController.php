<?php

namespace App\Http\Controllers;

use App\Models\Pago;
use App\Services\PagoService;
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
        $fecha = $request->fecha;
        $pagos = [];
        if ($fecha) {
            $pagos = Pago::with(["sucursal:id,nombre", "user:id,nombre,paterno,materno"])
                ->where("fecha_verificado", $fecha);

            $sucursal_id = Auth::user()->sucursal_id;
            $pagos->where("sucursal_id", $sucursal_id);
            $pagos = $pagos->where("verificado", 1)->get();
        }


        return response()->JSON($pagos);
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
