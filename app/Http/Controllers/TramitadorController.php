<?php

namespace App\Http\Controllers;

use App\Http\Requests\TramitadorStoreRequest;
use App\Http\Requests\TramitadorUpdateRequest;
use App\Models\Tramitador;
use App\Models\User;
use App\Services\TramitadorService;
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

class TramitadorController extends Controller
{
    public function __construct(private TramitadorService $tramitadorService) {}

    /**
     * Página index
     *
     * @return Response
     */
    public function index(): ResponseInertia
    {
        return Inertia::render("Admin/Tramitadors/Index");
    }

    /**
     * Listado de tramitadors
     *
     * @return JsonResponse
     */
    public function listado(): JsonResponse
    {
        return response()->JSON([
            "tramitadors" => $this->tramitadorService->listado()
        ]);
    }

    public function byCi(Request $request)
    {
        $ci = $request->input("ci", "");
        $tramitadors = Tramitador::where("ci", $ci)->get();
        return response()->JSON($tramitadors);
    }

    public function paginado(Request $request)
    {
        $perPage = $request->perPage;
        $page = (int)($request->input("page", 1));
        $search = (string)$request->input("search", "");
        $orderBy = $request->orderBy;
        $orderAsc = $request->orderAsc;

        $columnsSerachLike = [
            "ci",
        ];
        $columnsFilter = [];
        $columnsBetweenFilter = [];
        $arrayOrderBy = [];
        if ($orderBy && $orderAsc) {
            $arrayOrderBy = [
                [$orderBy, $orderAsc]
            ];
        }

        $tramitadors = $this->tramitadorService->listadoPaginado($perPage, $page, $search, $columnsSerachLike, $columnsFilter, $columnsBetweenFilter, $arrayOrderBy);
        return response()->JSON([
            "data" => $tramitadors->items(),
            "total" => $tramitadors->total(),
            "lastPage" => $tramitadors->lastPage()
        ]);
    }

    /**
     * Registrar un nuevo tramitador
     *
     * @param TramitadorStoreRequest $request
     * @return RedirectResponse|Response
     */
    public function store(TramitadorStoreRequest $request): RedirectResponse|Response
    {
        DB::beginTransaction();
        try {
            // crear el Tramitador
            $this->tramitadorService->crear($request->validated());
            DB::commit();
            return redirect()->route("tramitadors.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    public function nuevo(TramitadorStoreRequest $request): JsonResponse|Response
    {
        DB::beginTransaction();
        try {
            // crear el Tramitador
            $tramitador = $this->tramitadorService->crear($request->validated());
            DB::commit();
            return response()->JSON([
                "tramitador" => $tramitador,
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


    /**
     * Mostrar un tramitador
     *
     * @param Tramitador $tramitador
     * @return JsonResponse
     */
    public function show(Tramitador $tramitador): JsonResponse
    {
        return response()->JSON($tramitador);
    }

    public function update(Tramitador $tramitador, TramitadorUpdateRequest $request)
    {
        DB::beginTransaction();
        try {
            // actualizar tramitador
            $this->tramitadorService->actualizar($request->validated(), $tramitador);
            DB::commit();
            return redirect()->route("tramitadors.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    /**
     * Eliminar tramitador
     *
     * @param Tramitador $tramitador
     * @return JsonResponse|Response
     */
    public function destroy(Tramitador $tramitador): JsonResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->tramitadorService->eliminar($tramitador);
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
