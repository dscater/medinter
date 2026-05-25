<?php

namespace App\Http\Controllers;

use App\Models\Certificado;
use App\Models\Cliente;
use App\Models\HistorialAccion;
use App\Models\Tramitador;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;

class SincronizacionController extends Controller
{

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

    public function sincronizarClientesTramitador()
    {
        $clientes = Cliente::all();

        foreach ($clientes as $cliente) {
            $accion = HistorialAccion::where('datos_original->id', $cliente->id)
                ->where("accion", "CREACIÓN")
                ->where("modulo", "CLIENTES")
                ->first();

            if ($accion) {
                // Log::debug($accion);
                $cliente = Cliente::find($accion->datos_original["id"]);
                if ($cliente) {
                    $cliente->user_id = $accion->user_id;
                    $cliente->save();
                }
            }
        }

        $tramitadores = Tramitador::all();
        foreach ($tramitadores as $tramitador) {
            $accion = HistorialAccion::where('datos_original->id', $tramitador->id)
                ->where("accion", "CREACIÓN")
                ->where("modulo", "TRAMITADORES")
                ->first();

            if ($accion) {
                $tramitador = Tramitador::find($accion->datos_original["id"]);
                if ($tramitador) {
                    $tramitador->user_id = $accion->user_id;
                    $tramitador->save();
                }
            }
        }

        return 'Sincronización Correcta<br/><a href="' . route('inicio') . '">Volver al inicio</a>';
    }
}
