<?php

namespace App\Http\Controllers;

use App\Models\Certificado;
use App\Models\Cliente;
use App\Models\Configuracion;
use App\Models\HistorialAccion;
use App\Models\Inscripcion;
use App\Models\TipoCertificado;
use App\Models\User;
use App\Services\ReporteService;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Inertia\Inertia;
use PDF;
use Carbon\Carbon;
use FPDF;
use Illuminate\Support\Facades\DB;
use PhpOffice\PhpSpreadsheet\IOFactory;
use PhpOffice\PhpSpreadsheet\Spreadsheet;

class ReporteController extends Controller
{
    private $configuracion = null;
    public function __construct()
    {
        $this->configuracion = Configuracion::first();
        if (!$this->configuracion) {
            $this->configuracion = new Configuracion([
                "nombre_sistema" => "SISPRENDASOL S.A.",
                "alias" => "SP",
                "logo" => "logo.png",
                "fono" => "2222222",
                "dir" => "LOS OLIVOS",
            ]);
        }
    }

    public function usuarios()
    {
        return Inertia::render("Admin/Reportes/Usuarios");
    }

    public function r_usuarios(Request $request)
    {
        ini_set('memory_limit', '1024M');
        set_time_limit(-1);
        $tipo =  $request->tipo;
        $usuarios = User::select("users.*")
            ->where('id', '!=', 1);

        if ($tipo != 'todos') {
            $request->validate([
                'tipo' => 'required',
            ]);
            $usuarios->where('tipo', $tipo);
        }

        $usuarios = $usuarios->get();

        $pdf = PDF::loadView('reportes.usuarios', compact('usuarios'))->setPaper('legal', 'landscape');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->stream('usuarios.pdf');
    }

    public function clientes()
    {
        return Inertia::render("Admin/Reportes/Clientes");
    }

    public function r_clientes(Request $request)
    {
        ini_set('memory_limit', '1024M');
        set_time_limit(-1);
        $fecha_ini =  $request->fecha_ini;
        $fecha_fin =  $request->fecha_fin;
        $clientes = Cliente::select("clientes.*");

        if ($fecha_ini && $fecha_fin) {
            $clientes->whereBetween('fecha_registro', [$fecha_ini, $fecha_fin]);
        }

        $clientes = $clientes->get();

        $pdf = PDF::loadView('reportes.clientes', compact('clientes'))->setPaper('letter', 'portrait');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->stream('clientes.pdf');
    }

    public function certificados()
    {
        return Inertia::render("Admin/Reportes/Certificados");
    }

    public function r_certificados(Request $request)
    {
        ini_set('memory_limit', '1024M');
        set_time_limit(-1);
        $cliente_id =  $request->cliente_id;
        $sucursal_id =  $request->sucursal_id;
        $user_id =  $request->user_id;
        $tipo_certificado_id =  $request->tipo_certificado_id;
        $certificados = Certificado::select("certificados.*");

        if ($cliente_id != 'todos') {
            $certificados->where('cliente_id', $cliente_id);
        }

        if ($sucursal_id != 'todos') {
            $certificados->where('sucursal_id', $sucursal_id);
        }

        if ($user_id != 'todos') {
            $certificados->where('user_id', $user_id);
        }

        if ($tipo_certificado_id != 'todos') {
            $certificados->where('tipo_certificado_id', $tipo_certificado_id);
        }

        $certificados = $certificados->get();

        $pdf = PDF::loadView('reportes.certificados', compact('certificados'))->setPaper('letter', 'portrait');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->stream('certificados.pdf');
    }

    public function historial_accions()
    {
        return Inertia::render("Admin/Reportes/HistorialAccions");
    }

    public function r_historial_accions(Request $request)
    {
        ini_set('memory_limit', '1024M');
        set_time_limit(-1);
        $user_id =  $request->user_id;
        $fecha_ini =  $request->fecha_ini;
        $fecha_fin =  $request->fecha_fin;
        $historial_accions = HistorialAccion::select("historial_accions.*");

        if ($user_id != 'todos') {
            $historial_accions->where('user_id', $user_id);
        }

        if ($fecha_ini && $fecha_fin) {
            $historial_accions->whereBetween('fecha', [$fecha_ini, $fecha_fin]);
        }

        $historial_accions = $historial_accions->get();

        $pdf = PDF::loadView('reportes.historial_accions', compact('historial_accions'))->setPaper('letter', 'portrait');

        // ENUMERAR LAS PÁGINAS USANDO CANVAS
        $pdf->output();
        $dom_pdf = $pdf->getDomPDF();
        $canvas = $dom_pdf->get_canvas();
        $alto = $canvas->get_height();
        $ancho = $canvas->get_width();
        $canvas->page_text($ancho - 90, $alto - 25, "Página {PAGE_NUM} de {PAGE_COUNT}", null, 9, array(0, 0, 0));

        return $pdf->stream('historial_accions.pdf');
    }

    public function gcemitidos()
    {
        return Inertia::render("Admin/Reportes/Gcemitidos");
    }
    public function r_gcemitidos(Request $request)
    {
        $cliente_id =  $request->cliente_id;
        $sucursal_id =  $request->sucursal_id;
        $user_id =  $request->user_id;
        $tipo_certificado_id =  $request->tipo_certificado_id;
        $fecha_ini = $request->fecha_ini;
        $fecha_fin = $request->fecha_fin;


        $users = User::select("users.*")
            ->where("tipo", "MÉDICO");
        if ($user_id != 'todos') {
            $users->where("id", $user_id);
        }


        $users = $users->get();
        $categorias = $users->map(function ($user) {
            return $user->nombre . ' ' . $user->paterno . ' ' . $user->materno;
        })->toArray();

        $tipo_certificados = TipoCertificado::select("tipo_certificados.*");

        if ($tipo_certificado_id != 'todos') {
            $tipo_certificados->where("id", $tipo_certificado_id);
        }

        $tipo_certificados = $tipo_certificados->get();


        $data = [];
        $total_final = 0;
        foreach ($tipo_certificados as $tipo_certificado) {
            $cantidad_por_tipo = [];
            foreach ($users as $key => $user) {
                $total = Certificado::where("user_id", $user->id)
                    ->where("tipo_certificado_id", $tipo_certificado->id);
                if ($fecha_ini && $fecha_fin) {
                    $total->whereBetween("fecha_registro", [$fecha_ini, $fecha_fin]);
                }
                if ($sucursal_id != 'todos') {
                    $total->where("sucursal_id", $sucursal_id);
                }
                if ($cliente_id != 'todos') {
                    $total->where("cliente_id", $cliente_id);
                }
                $total = $total->count();
                $cantidad_por_tipo[] = $total;
                $total_final += (int)$total;
            }

            $data[] = [
                'name' => $tipo_certificado->nombre,
                'data' => $cantidad_por_tipo,
            ];
        }

        return response()->JSON([
            "categories" => $categorias,
            "data" => $data,
            "total_final" => $total_final
        ]);
    }

    public function gmemitidos()
    {
        return Inertia::render("Admin/Reportes/Gmemitidos");
    }
    public function r_gmemitidos(Request $request)
    {
        $cliente_id =  $request->cliente_id;
        $sucursal_id =  $request->sucursal_id;
        $user_id =  $request->user_id;
        $tipo_certificado_id =  $request->tipo_certificado_id;
        $fecha_ini = $request->fecha_ini;
        $fecha_fin = $request->fecha_fin;

        $tipo_certificados = TipoCertificado::select("tipo_certificados.*");

        if ($tipo_certificado_id != 'todos') {
            $tipo_certificados->where("id", $tipo_certificado_id);
        }

        $tipo_certificados = $tipo_certificados->get();


        $data = [];
        $total_final = 0;
        foreach ($tipo_certificados as $tipo_certificado) {
            $categorias[] = $tipo_certificado->nombre;
            $total = Certificado::where("tipo_certificado_id", $tipo_certificado->id);
            if ($fecha_ini && $fecha_fin) {
                $total->whereBetween("fecha_registro", [$fecha_ini, $fecha_fin]);
            }
            if ($user_id != 'todos') {
                $total->where("user_id", $user_id);
            }
            if ($sucursal_id != 'todos') {
                $total->where("sucursal_id", $sucursal_id);
            }
            if ($cliente_id != 'todos') {
                $total->where("cliente_id", $cliente_id);
            }
            $total = $total->sum("precio");
            $total_final += (int)$total;

            $data[] = [
                'name' => $tipo_certificado->nombre,
                'y' => (float) $total,
            ];
        }

        return response()->JSON([
            "categories" => $categorias,
            "data" => $data,
            "total_final" => number_format($total_final, 2, ".", ",")
        ]);
    }
}
