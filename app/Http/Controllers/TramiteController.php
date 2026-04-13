<?php

namespace App\Http\Controllers;

use App\Http\Requests\TramiteStoreRequest;
use App\Http\Requests\TramiteUpdateRequest;
use App\Models\Tramite;
use App\Models\User;
use App\Services\TramiteService;
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

class TramiteController extends Controller
{
    public function __construct(private TramiteService $tramiteService) {}

    /**
     * Página index
     *
     * @return Response
     */
    public function index(): ResponseInertia
    {
        return Inertia::render("Admin/Tramites/Index");
    }

    public function atencion()
    {
        return Inertia::render("Admin/Tramites/Atencion");
    }

    /**
     * Listado de tramites
     *
     * @return JsonResponse
     */
    public function listado(Request $request): JsonResponse
    {
        $codigo = $request->input("codigo", "");
        $fecha = $request->input("fecha", "");

        return response()->JSON([
            "tramites" => $this->tramiteService->listado($codigo, $fecha)
        ]);
    }

    public function listadoExacto(Request $request): JsonResponse
    {
        $codigo = $request->input("codigo", "");
        $fecha = $request->input("fecha", "");

        $tramites = [];
        if ($codigo || $fecha) {
            $tramites = Tramite::select("tramites.*")
                ->with(["tramitador:id,nombre"])
                ->withCount(["tramite_clientes"]);
            if (trim($codigo) != '') {
                $tramites->where("codigo", $codigo);
            }
            if ($fecha && trim($fecha) != '') {
                $tramites->where("fecha", $fecha);
            }
            $tramites = $tramites->get();
        }

        return response()->JSON([
            "tramites" => $tramites
        ]);
    }


    public function paginado(Request $request)
    {
        $perPage = $request->perPage;
        $page = (int)($request->input("page", 1));
        $cliente = (string)$request->input("cliente", "");
        $tipo_tramite_id = $request->input("tipo_tramite_id", []);
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

        $tramites = $this->tramiteService->listadoPaginado(
            $perPage,
            $page,
            $arrayOrderBy,
            $cliente,
            $tipo_tramite_id,
            $tipo_pago,
            $sucursal_id,
            $medico,
            $fecha
        );
        return response()->JSON([
            "data" => $tramites->items(),
            "total" => $tramites->total(),
            "lastPage" => $tramites->lastPage()
        ]);
    }

    public function create()
    {
        return Inertia::render("Admin/Tramites/Create");
    }

    /**
     * Registrar un nuevo tramite
     *
     * @param TramiteStoreRequest $request
     * @return RedirectResponse|Response
     */
    public function store(TramiteStoreRequest $request): RedirectResponse|Response
    {
        DB::beginTransaction();
        try {
            // crear el Tramite
            $this->tramiteService->crear($request->validated());
            DB::commit();
            return redirect()->route("tramites.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }


    /**
     * Editar un tramite
     *
     * @param Tramite $tramite
     * @return ResponseInertia
     */
    public function edit(Tramite $tramite): ResponseInertia
    {
        $tramite = $tramite->load(["tramite_clientes.cliente"]);
        return Inertia::render("Admin/Tramites/Edit", compact("tramite"));
    }


    /**
     * Mostrar un tramite
     *
     * @param Tramite $tramite
     * @return JsonResponse
     */
    public function show(Tramite $tramite): JsonResponse
    {
        return response()->JSON($tramite);
    }

    public function update(Tramite $tramite, TramiteUpdateRequest $request)
    {
        DB::beginTransaction();
        try {
            // actualizar tramite
            $this->tramiteService->actualizar($request->validated(), $tramite);
            DB::commit();
            return redirect()->route("tramites.index")->with("bien", "Registro actualizado");
        } catch (\Exception $e) {
            DB::rollBack();
            // Log::debug($e->getMessage());
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }

    /**
     * Eliminar tramite
     *
     * @param Tramite $tramite
     * @return JsonResponse|Response
     */
    public function destroy(Tramite $tramite): JsonResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->tramiteService->eliminar($tramite);
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
