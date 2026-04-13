<?php

namespace App\Http\Controllers;

use App\Http\Requests\CobroRequest;
use App\Models\Certificado;
use App\Services\CobroService;
use Exception;
use Illuminate\Http\Request;
use Inertia\Inertia;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\RedirectResponse;
use Illuminate\Support\Facades\DB;
use Illuminate\Validation\ValidationException;
use Illuminate\Support\Facades\Response;

class CobroController extends Controller
{
    public function __construct(private CobroService $cobro_service) {}
    public function index()
    {
        return Inertia::render("Admin/Cobros/Index");
    }

    public function registrarPago(CobroRequest $request, Certificado $certificado): RedirectResponse|Response
    {
        DB::beginTransaction();
        try {
            $this->cobro_service->crear($certificado, $request->validated());

            DB::commit();
            return redirect()->route("cobros.index")->with("bien", "Registro realizado");
        } catch (\Exception $e) {
            DB::rollBack();
            throw ValidationException::withMessages([
                'error' =>  $e->getMessage(),
            ]);
        }
    }
}
