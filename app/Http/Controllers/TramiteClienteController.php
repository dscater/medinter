<?php

namespace App\Http\Controllers;

use App\Http\Requests\CertificadoStoreRequest;
use App\Models\TramiteCliente;
use App\Services\CertificadoService;
use App\Services\TramiteClienteService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;

class TramiteClienteController extends Controller
{
    public function __construct(private TramiteClienteService $tramite_cliente_service, private CertificadoService $certificadoService) {}
    public function byTramite(Request $request)
    {
        $id = $request->tramite_id;
        $tramite_clientes = TramiteCliente::with(
            [
                "cliente:id,nombre,paterno,materno,ci,complemento,ci_exp,fecha_nac,edad,cel"
            ]
        )
            ->where("tramite_id", $id);
        $tramite_clientes->orderBy("estado", "ASC");
        $tramite_clientes = $tramite_clientes->get();

        return response()->JSON([
            "tramite_clientes" => $tramite_clientes,
        ]);
    }

    public function registrarCertificado(CertificadoStoreRequest $request, TramiteCliente $tramite_cliente)
    {
        DB::beginTransaction();
        try {
            // crear el Cliente
            $datos = $request->validated();
            $datos["tipo"] = "TRAMITE";
            $certificado = $this->certificadoService->crear($datos);
            $tramite_cliente->certificado_id = $certificado->id;
            $tramite_cliente->estado = 1;
            $tramite_cliente->save();
            DB::commit();
            return response()->JSON([
                "certificado" => $certificado,
                "tramite_cliente" => $tramite_cliente,
                "sw" => true,
                "message" => "Registro realizado"
            ]);
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }
}
