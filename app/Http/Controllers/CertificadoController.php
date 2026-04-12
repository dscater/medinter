<?php

namespace App\Http\Controllers;

use App\Http\Requests\CertificadoStoreRequest;
use App\Http\Requests\CertificadoUpdateRequest;
use App\Models\Certificado;
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
        $tipo_certificado_id = $request->input("tipo_certificado_id", []);
        $tipo_pago = (string)$request->input("tipo_pago", "todos");
        $sucursal_id = (string)$request->input("sucursal_id", "todos");
        $medico = (string)$request->input("medico", "");
        $fecha = (string)$request->input("fecha", "");
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
            $tipo_certificado_id,
            $tipo_pago,
            $sucursal_id,
            $medico,
            $fecha
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
            $this->certificadoService->crear($request->validated());
            DB::commit();
            return redirect()->route("certificados.index")->with("bien", "Registro realizado");
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
        $certificado = $certificado->load(["certificado_detalles"]);
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
}
