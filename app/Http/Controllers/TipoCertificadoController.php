<?php

namespace App\Http\Controllers;

use App\Http\Requests\TipoCertificadoStoreRequest;
use App\Http\Requests\TipoCertificadoUpdateRequest;
use App\Models\TipoCertificado;
use App\Models\User;
use App\Services\TipoCertificadoService;
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

class TipoCertificadoController extends Controller
{
    public function __construct(private TipoCertificadoService $tipo_certificadoService) {}

    /**
     * Página index
     *
     * @return Response
     */
    public function index(): ResponseInertia
    {
        return Inertia::render("Admin/TipoCertificados/Index");
    }

    /**
     * Listado de tipo_certificados
     *
     * @return JsonResponse
     */
    public function listado(): JsonResponse
    {
        return response()->JSON([
            "tipo_certificados" => $this->tipo_certificadoService->listado()
        ]);
    }

    public function paginado(Request $request)
    {
        $perPage = $request->perPage;
        $page = (int)($request->input("page", 1));
        $search = (string)$request->input("search", "");
        $orderByCol = $request->orderByCol;
        $desc = $request->desc;

        $columnsSerachLike = [
            "codigo",
            "modelo",
            "marca",
            "talla",
            "nombre"
        ];
        $columnsFilter = [];
        $columnsBetweenFilter = [];
        $arrayOrderBy = [];
        if ($orderByCol && $desc) {
            $arrayOrderBy = [
                [$orderByCol, $desc]
            ];
        }

        $tipo_certificados = $this->tipo_certificadoService->listadoPaginado($perPage, $page, $search, $columnsSerachLike, $columnsFilter, $columnsBetweenFilter, $arrayOrderBy);
        return response()->JSON([
            "data" => $tipo_certificados->items(),
            "total" => $tipo_certificados->total(),
            "lastPage" => $tipo_certificados->lastPage()
        ]);
    }

    /**
     * Registrar un nuevo tipo_certificado
     *
     * @param TipoCertificadoStoreRequest $request
     * @return RedirectResponse|Response
     */
    public function store(TipoCertificadoStoreRequest $request): RedirectResponse|Response
    {
        DB::beginTransaction();
        try {
            // crear el TipoCertificado
            $this->tipo_certificadoService->crear($request->validated());
            DB::commit();
            return redirect()->route("tipo_certificados.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    /**
     * Mostrar un tipo_certificado
     *
     * @param TipoCertificado $tipo_certificado
     * @return JsonResponse
     */
    public function show(TipoCertificado $tipo_certificado): JsonResponse
    {
        return response()->JSON($tipo_certificado);
    }

    public function update(TipoCertificado $tipo_certificado, TipoCertificadoUpdateRequest $request)
    {
        DB::beginTransaction();
        try {
            // actualizar tipo_certificado
            $this->tipo_certificadoService->actualizar($request->validated(), $tipo_certificado);
            DB::commit();
            return redirect()->route("tipo_certificados.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    /**
     * Eliminar tipo_certificado
     *
     * @param TipoCertificado $tipo_certificado
     * @return JsonResponse|Response
     */
    public function destroy(TipoCertificado $tipo_certificado): JsonResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->tipo_certificadoService->eliminar($tipo_certificado);
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
