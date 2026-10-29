<?php

namespace App\Http\Controllers;

use App\Models\Certificado;
use App\Models\CertificadoDetalle;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Inertia\Inertia;
use Illuminate\Support\Facades\DB;

class InicioController extends Controller
{

    public function verificaLogin()
    {
        $sw = false;
        if (Auth::check()) {
            $sw = true;
        }

        return response()->JSON(["sw" => $sw]);
    }

    public function inicio()
    {
        $array_infos = UserController::getInfoBoxUser();

        return Inertia::render('Admin/Home', compact('array_infos'));
    }

    public function login()
    {
        return Inertia::render("Auth/Login");
    }


    public function certificadosEmitidosLinea(Request $request)
    {
        $tipo = $request->tipo;

        if (!in_array($tipo, ['semanal', 'meses', 'gestion'])) {
            return response()->json([
                'message' => 'Tipo de reporte no válido'
            ], 422);
        }

        $usuario = Auth::user();

        $categories = [];
        $data = [];

        $query = CertificadoDetalle::query()
            ->join(
                'certificados',
                'certificado_detalles.certificado_id',
                '=',
                'certificados.id'
            )
            ->where('certificado_detalles.estado', 1)
            ->where('certificados.status', 1);

        // Mantener el filtro de los médicos.
        if ($usuario->tipo == 'MÉDICO') {
            $query->where(
                'certificado_detalles.user_id',
                $usuario->id
            );
        }

        if ($tipo == 'semanal') {
            $fecha = Carbon::now('America/La_Paz');

            $inicio = $fecha->copy()->subDays(6)->startOfDay();
            $fin = $fecha->copy()->endOfDay();

            // Una consulta para los siete días.
            $resultados = $query
                ->whereBetween('certificados.fecha_registro', [
                    $inicio,
                    $fin
                ])
                ->selectRaw(
                    'DATE(certificados.fecha_registro) as periodo,
                 COUNT(*) as total'
                )
                ->groupBy('periodo')
                ->get()
                ->keyBy('periodo');

            for ($i = 6; $i >= 0; $i--) {
                $dia = $fecha->copy()
                    ->subDays($i)
                    ->format('Y-m-d');

                $categories[] = Carbon::parse($dia)
                    ->format('d/m/Y');

                $data[] = (float) (
                    $resultados->get($dia)->total ?? 0
                );
            }
        }

        if ($tipo == 'meses') {
            $fecha = Carbon::now('America/La_Paz');
            $gestion = $fecha->year;

            // Una consulta para todos los meses del año.
            $resultados = $query
                ->whereYear('certificados.fecha_registro', $gestion)
                ->whereMonth('certificados.fecha_registro', '<=', $fecha->month)
                ->selectRaw(
                    'MONTH(certificados.fecha_registro) as periodo,
                 COUNT(*) as total'
                )
                ->groupBy('periodo')
                ->get()
                ->keyBy('periodo');

            $array_meses = [
                1 => 'Enero',
                2 => 'Febrero',
                3 => 'Marzo',
                4 => 'Abril',
                5 => 'Mayo',
                6 => 'Junio',
                7 => 'Julio',
                8 => 'Agosto',
                9 => 'Septiembre',
                10 => 'Octubre',
                11 => 'Noviembre',
                12 => 'Diciembre',
            ];

            for ($mes = 1; $mes <= $fecha->month; $mes++) {
                $categories[] = $array_meses[$mes];

                $data[] = (float) (
                    $resultados->get($mes)->total ?? 0
                );
            }
        }

        if ($tipo == 'gestion') {
            // Mantener los años con certificados registrados.
            $gestiones = Certificado::query()
                ->where('status', 1)
                ->selectRaw('YEAR(fecha_registro) as gestion')
                ->groupBy('gestion')
                ->orderBy('gestion')
                ->pluck('gestion');

            // Una consulta para contar todos los años.
            $resultados = $query
                ->selectRaw(
                    'YEAR(certificados.fecha_registro) as periodo,
                 COUNT(*) as total'
                )
                ->groupBy('periodo')
                ->get()
                ->keyBy('periodo');

            foreach ($gestiones as $gestion) {
                $categories[] = $gestion;

                $data[] = (float) (
                    $resultados->get($gestion)->total ?? 0
                );
            }
        }

        return response()->json([
            'categories' => $categories,
            'data' => $data,
            'total_final' => array_sum($data)
        ]);
    }

    public function cantidadTramitesNormal()
    {
        $usuario = Auth::user();

        $query = CertificadoDetalle::query()
            ->join(
                'certificados',
                'certificado_detalles.certificado_id',
                '=',
                'certificados.id'
            )
            ->whereIn('certificados.tipo', ['NORMAL', 'TRAMITE'])
            ->where('certificados.status', 1);

        // Si es médico, contar solamente sus certificados.
        if ($usuario->tipo === 'MÉDICO') {
            $query->where(
                'certificado_detalles.user_id',
                $usuario->id
            );
        }

        // Obtener ambos totales en una consulta.
        $resultados = $query
            ->select('certificados.tipo', DB::raw('COUNT(*) as total'))
            ->groupBy('certificados.tipo')
            ->pluck('total', 'tipo');

        $normales = (int) ($resultados['NORMAL'] ?? 0);
        $tramites = (int) ($resultados['TRAMITE'] ?? 0);

        $data = [
            [
                'name' => 'TRÁMITE',
                'y' => (float) $tramites,
            ],
            [
                'name' => 'NORMAL',
                'y' => (float) $normales,
            ],
        ];

        return response()->json([
            'data' => $data,
            'total_final' => (float) ($normales + $tramites),
        ]);
    }
}
