<?php

namespace App\Http\Controllers;

use App\Models\Certificado;
use App\Models\CertificadoEmitido;
use App\Models\HistorialAccion;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;

class CertificadoEmitidoController extends Controller
{
    public function verificaCantidad(Request $request)
    {
        $tipo_certificado_id = $request->input("tipo_certificado_id", "");

        $fecha_actual = Carbon::now("America/La_Paz")->format("Y-m-d");

        $user = Auth::user();

        $certificado_emitido = CertificadoEmitido::where("user_id", $user->id)
            ->where("tipo_certificado_id", $tipo_certificado_id)
            ->where("fecha", $fecha_actual)
            ->get()->first();
        if (!$certificado_emitido) {
            $certificado_emitido = CertificadoEmitido::create([
                "user_id" => $user->id,
                "fecha" => $fecha_actual,
                "tipo_certificado_id" => $tipo_certificado_id,
                "conteo" => 0,
            ]);
        }

        return response()->JSON([
            "tipo_certificado_id" => $tipo_certificado_id,
            "certificado_emitido" => $certificado_emitido,
            "conteo" => $certificado_emitido->conteo,
            "conteo_siguiente" => (int)$certificado_emitido->conteo + 1
        ]);
    }

    public function sincronizarInicio()
    {
        $certificados = Certificado::all();

        foreach ($certificados as $certificado) {
            $accion = HistorialAccion::where('datos_original->id', $certificado->id)
                ->where("accion", "CREACIÓN")
                ->where("modulo", "CERTIFICADOS")
                ->first();

            if ($accion) {
                $certificado = Certificado::find($accion->datos_original["id"]);
                if ($certificado) {
                    $certificado->inicio_id = $accion->user_id;
                    $certificado->save();
                }
                // Log::debug($accion->user_id);
                // Log::debug($accion->datos_original["id"]);
                // Log::debug("--------------");
            }
        }

        return 'Sincronización Correcta<br/><a href="' . route('inicio') . '">Volver al inicio</a>';
    }
}
