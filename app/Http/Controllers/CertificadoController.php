<?php

namespace App\Http\Controllers;

use App\Http\Requests\CertificadoClienteRequest;
use App\Http\Requests\CertificadoDetalleRequest;
use App\Http\Requests\CertificadoStoreRequest;
use App\Http\Requests\CertificadoUpdateRequest;
use App\Models\Certificado;
use App\Models\Cliente;
use App\Models\User;
use App\Services\CertificadoService;
use Exception;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\RedirectResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Response;
use Illuminate\Validation\ValidationException;
use Inertia\Inertia;
use Inertia\Response as ResponseInertia;

class CertificadoController extends Controller
{
    public function __construct(private CertificadoService $certificadoService) {}

    /**
     * Página index
     *
     * @return Response
     */
    public function index(): ResponseInertia
    {
        return Inertia::render("Admin/Certificados/Index");
    }

    public function eliminados(): ResponseInertia
    {
        return Inertia::render("Admin/Certificados/Eliminados");
    }

    /**
     * Listado de certificados
     *
     * @return JsonResponse
     */
    public function listado(): JsonResponse
    {
        return response()->JSON([
            "certificados" => $this->certificadoService->listado()
        ]);
    }

    public function paginado(Request $request)
    {
        $perPage = $request->perPage;
        $page = (int)($request->input("page", 1));
        $cliente = (string)$request->input("cliente", "");
        $ci = (string)$request->input("ci", "");
        // $tipo_certificado_id = $request->input("tipo_certificado_id", []);
        // $tipo_pago = (string)$request->input("tipo_pago", "todos");
        // $sucursal_id = (string)$request->input("sucursal_id", "todos");
        // $medico = (string)$request->input("medico", "");
        // $fecha = (string)$request->input("fecha", "");
        $orderBy = $request->orderBy;
        $orderAsc = $request->orderAsc;

        $arrayOrderBy = [];
        if ($orderBy && $orderAsc) {
            $arrayOrderBy = [
                [$orderBy, $orderAsc]
            ];
        }

        $certificados = $this->certificadoService->listadoPaginado(
            $perPage,
            $page,
            $arrayOrderBy,
            $cliente,
            $ci,
        );
        return response()->JSON([
            "data" => $certificados->items(),
            "total" => $certificados->total(),
            "lastPage" => $certificados->lastPage()
        ]);
    }

    public function paginadoEliminados(Request $request)
    {
        $perPage = $request->perPage;
        $page = (int)($request->input("page", 1));
        $cliente = (string)$request->input("cliente", "");
        $ci = (string)$request->input("ci", "");
        // $tipo_certificado_id = $request->input("tipo_certificado_id", []);
        // $tipo_pago = (string)$request->input("tipo_pago", "todos");
        // $sucursal_id = (string)$request->input("sucursal_id", "todos");
        // $medico = (string)$request->input("medico", "");
        // $fecha = (string)$request->input("fecha", "");
        $orderBy = $request->orderBy;
        $orderAsc = $request->orderAsc;

        $arrayOrderBy = [];
        if ($orderBy && $orderAsc) {
            $arrayOrderBy = [
                [$orderBy, $orderAsc]
            ];
        }

        $certificados = $this->certificadoService->listadoPaginadoEliminados(
            $perPage,
            $page,
            $arrayOrderBy,
            $cliente,
            $ci,
        );
        return response()->JSON([
            "data" => $certificados->items(),
            "total" => $certificados->total(),
            "lastPage" => $certificados->lastPage()
        ]);
    }



    public function listadoCobros(Request $request)
    {
        $perPage = $request->perPage;
        $page = (int)($request->input("page", 1));
        $cliente = (string)$request->input("cliente", "");
        $ci = $request->input("ci", "");
        $tramitador_id = $request->input("tramitador_id", "");
        // $fecha = (string)$request->input("fecha", "");
        // $codigo = (string)$request->input("codigo", "");
        $orderBy = $request->orderBy;
        $orderAsc = $request->orderAsc;

        $arrayOrderBy = [];
        if ($orderBy && $orderAsc) {
            $arrayOrderBy = [
                [$orderBy, $orderAsc]
            ];
        }

        $certificados = $this->certificadoService->listadoCobros(
            $perPage,
            $page,
            $arrayOrderBy,
            $cliente,
            $ci,
            $tramitador_id
        );
        return response()->JSON([
            "data" => $certificados->items(),
            "total" => $certificados->total(),
            "lastPage" => $certificados->lastPage()
        ]);
    }

    public function create()
    {
        return Inertia::render("Admin/Certificados/Create");
    }

    /**
     * Registrar un nuevo certificado
     *
     * @param CertificadoStoreRequest $request
     * @return RedirectResponse|Response
     */
    public function store(CertificadoStoreRequest $request): RedirectResponse|Response
    {
        DB::beginTransaction();
        try {
            // crear el Certificado
            $datos = $request->validated();
            $datos["estado"] = 1;
            $this->certificadoService->crear($datos);
            DB::commit();
            return redirect()->route("certificados.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function registroCliente(CertificadoClienteRequest $request, Cliente $cliente)
    {

        DB::beginTransaction();
        try {
            // crear el Certificado
            $datos = $request->validated();
            $datos["cliente_id"] = $cliente->id;
            $datos["estado"] = 0;
            $this->certificadoService->crear($datos);
            DB::commit();
            return redirect()->route("clientes.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }


    /**
     * Editar un certificado
     *
     * @param Certificado $certificado
     * @return ResponseInertia
     */
    public function edit(Certificado $certificado): ResponseInertia
    {
        $cliente = $certificado->cliente;
        $certificado = $certificado->load(["certificado_detalles.pago"]);
        return Inertia::render("Admin/Certificados/Edit", compact("certificado", "cliente"));
    }


    /**
     * Mostrar un certificado
     *
     * @param Certificado $certificado
     * @return JsonResponse
     */
    public function show(Certificado $certificado): JsonResponse
    {
        return response()->JSON($certificado);
    }

    public function verificaPendienteCliente(Cliente $cliente)
    {
        $certificado = Certificado::where("cliente_id", $cliente->id)
            ->where("estado", 0)
            ->where("status", 1)
            ->get()->last();

        if ($certificado) {
            $certificado = $certificado->load(["certificado_detalles"]);
        }

        return response()->JSON(
            [
                "existe" => $certificado ? true : false,
                "certificado" => $certificado
            ]
        );
    }

    public function update(Certificado $certificado, CertificadoUpdateRequest $request)
    {
        DB::beginTransaction();
        try {
            // actualizar certificado
            $this->certificadoService->actualizar($request->validated(), $certificado);
            DB::commit();
            return redirect()->route("certificados.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function updateDetalles(Certificado $certificado, CertificadoDetalleRequest $request)
    {
        DB::beginTransaction();
        try {
            // actualizar certificado
            $this->certificadoService->actualizarCertificadoDetalle($request->validated(), $certificado);
            DB::commit();
            return redirect()->route("certificados.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    /**
     * Eliminar certificado
     *
     * @param Certificado $certificado
     * @return JsonResponse|Response
     */
    public function destroy(Certificado $certificado): JsonResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->certificadoService->eliminar($certificado);
            DB::commit();
            return response()->JSON([
                'sw' => true,
                'message' => 'El registro se eliminó correctamente'
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function restaurar(Certificado $certificado): JsonResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->certificadoService->restaurar($certificado);
            DB::commit();
            return response()->JSON([
                'sw' => true,
                'message' => 'El registro se restauro correctamente'
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    /**
     * Eliminar certificado
     *
     * @param Certificado $certificado
     * @return JsonResponse|Response
     */
    public function eliminacionPermanente(Certificado $certificado): JsonResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->certificadoService->eliminacionPermanente($certificado);
            DB::commit();
            return response()->JSON([
                'sw' => true,
                'message' => 'El registro se eliminó correctamente'
            ], 200);
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }
}
