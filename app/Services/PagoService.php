<?php

namespace App\Services;

use App\Models\Certificado;
use App\Models\CertificadoDetalle;
use App\Models\LoginUser;
use App\Models\Pago;
use App\Services\HistorialAccionService;
use Carbon\Carbon;
use Illuminate\Http\UploadedFile;
use Exception;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Illuminate\Validation\ValidationException;
use Illuminate\Database\Eloquent\Builder;

class PagoService
{
    private $modulo = "PAGOS";

    public function __construct(
        private HistorialAccionService $historialAccionService,
        private LoginUserService $login_user_service,
        private TipoPagoService $tipo_pago_service
    ) {}

    private function columnasPago(): array
    {
        return [
            'pagos.id',
            'pagos.registro_id',
            'pagos.modulo',
            'pagos.monto',
            'pagos.tipo_pago',
            'pagos.descripcion',
            'pagos.fecha',
            'pagos.hora',
            'pagos.cliente_id',
            'pagos.user_id',
            'pagos.medico_id',
            'pagos.sucursal_id',
            'pagos.verificado',
            'pagos.fecha_verificado',
            'pagos.hora_verificado',
            'pagos.status',
        ];
    }

    private function aplicarRangoFecha(
        Builder $query,
        ?string $fechaIni,
        ?string $fechaFin,
        string $columna
    ): Builder {
        if ($fechaIni) {
            $query->where(
                $columna,
                '>=',
                Carbon::parse($fechaIni)->startOfDay()
            );
        }

        if ($fechaFin) {
            $query->where(
                $columna,
                '<',
                Carbon::parse($fechaFin)
                    ->addDay()
                    ->startOfDay()
            );
        }

        return $query;
    }


    private function consultaPagosVerificados(
        ?string $fechaIni,
        ?string $fechaFin,
        $sucursalId,
        ?int $medicoId,
        ?int $userId
    ): Builder {
        $usuario = Auth::user();

        $query = Pago::query()
            ->select($this->columnasPago())
            ->where('pagos.status', 1)
            ->where('pagos.verificado', 1);

        $query = $this->aplicarRangoFecha(
            $query,
            $fechaIni,
            $fechaFin,
            'pagos.fecha_verificado'
        );

        if ($sucursalId && $sucursalId !== 'todos') {
            $query->where(
                'pagos.sucursal_id',
                (int) $sucursalId
            );
        }

        if (
            in_array($usuario->tipo, [
                'ADMINISTRADOR',
                'GERENTE',
            ], true) &&
            $medicoId
        ) {
            $query->where(
                'pagos.medico_id',
                $medicoId
            );
        }

        if (in_array($usuario->tipo, [
            'MÉDICO',
            'SECRETARIA',
        ], true)) {
            $userId = $usuario->id;
        }

        if ($userId) {
            $query->where(
                'pagos.user_id',
                $userId
            );
        }

        return $query;
    }

    private function consultaPagosSinVerificar(
        ?string $fechaIni,
        ?string $fechaFin,
        $sucursalId,
        ?int $medicoId
    ): Builder {
        $usuario = Auth::user();

        $query = Pago::query()
            ->select($this->columnasPago())
            ->where('pagos.status', 1)
            ->where('pagos.verificado', 0);

        /*
     * Los pagos pendientes se filtran por fecha de registro,
     * no por fecha_verificado.
     */
        $query = $this->aplicarRangoFecha(
            $query,
            $fechaIni,
            $fechaFin,
            'pagos.fecha'
        );

        if ($sucursalId && $sucursalId !== 'todos') {
            $query->where(
                'pagos.sucursal_id',
                (int) $sucursalId
            );
        }

        if (
            in_array($usuario->tipo, [
                'ADMINISTRADOR',
                'GERENTE',
            ], true) &&
            $medicoId
        ) {
            $query->where(
                'pagos.medico_id',
                $medicoId
            );
        }

        if ($usuario->tipo === 'MÉDICO') {
            $query->where(
                'pagos.user_id',
                $usuario->id
            );
        }

        if ($usuario->tipo === 'SECRETARIA') {
            $loginUser = $this->login_user_service
                ->verificaSucursal();

            $query->where(
                'pagos.sucursal_id',
                $loginUser->sucursal_id
            );
        }

        return $query;
    }

    private function relacionesPagos(Builder $query): Builder
    {
        return $query->with([
            'sucursal:id,nombre',

            'user:id,nombre,paterno,materno',

            'medico:id,nombre,paterno,materno',

            'cliente:id,nombre,paterno,materno,ci,ci_exp,complemento',

            'certificado_detalle:id,certificado_id,tipo_certificado_id',

            'certificado_detalle.tipo_certificado:id,nombre',

            'certificado_detalle.certificado:id,tipo,tramitador_id',

            'certificado_detalle.certificado.tramitador:id,nombre',
        ]);
    }

    public function listadoPagosVerificados(
        ?string $fechaIni,
        ?string $fechaFin,
        $sucursalId,
        ?int $medicoId,
        ?int $userId,
        int $pagina = 1
    ): array {
        $query = $this->consultaPagosVerificados(
            $fechaIni,
            $fechaFin,
            $sucursalId,
            $medicoId,
            $userId
        );

        return $this->resultadoPagos(
            query: $query,
            pageName: 'pagina_verificados',
            pagina: $pagina,
            sumKey: 'suma_tipos',
            fechaOrden: 'pagos.fecha_verificado'
        );
    }

    public function listadoPagosSinVerificar(
        ?string $fechaIni,
        ?string $fechaFin,
        $sucursalId,
        ?int $medicoId,
        int $pagina = 1
    ): array {
        $query = $this->consultaPagosSinVerificar(
            $fechaIni,
            $fechaFin,
            $sucursalId,
            $medicoId
        );

        return $this->resultadoPagos(
            query: $query,
            pageName: 'pagina_sin_verificar',
            pagina: $pagina,
            sumKey: 'suma_tipos_sin_verificar',
            fechaOrden: 'pagos.fecha'
        );
    }

    private function resultadoPagos(
        Builder $query,
        string $pageName,
        int $pagina,
        string $sumKey,
        string $fechaOrden
    ): array {
        $sumas = $this->sumasPorTipoPago($query);

        $pagos = $this->relacionesPagos($query)
            ->orderByDesc($fechaOrden)
            ->paginate(
                perPage: 20,
                columns: $this->columnasPago(),
                pageName: $pageName,
                page: max($pagina, 1)
            );

        return [
            'pagos' => $pagos,
            $sumKey => $sumas,
        ];
    }

    public function sumasArqueo(
        ?string $fechaIni,
        ?string $fechaFin,
        $sucursalId,
        ?int $medicoId,
        ?int $userId
    ): array {
        $verificados = $this->consultaPagosVerificados(
            $fechaIni,
            $fechaFin,
            $sucursalId,
            $medicoId,
            $userId
        );

        $sinVerificar = $this->consultaPagosSinVerificar(
            $fechaIni,
            $fechaFin,
            $sucursalId,
            $medicoId
        );

        $sumasVerificados = $this->sumasPorTipoPago(
            $verificados
        );

        $sumasSinVerificar = $this->sumasPorTipoPago(
            $sinVerificar
        );

        $sumaTotalTipos = [];

        $tipos = array_unique(array_merge(
            array_keys($sumasVerificados),
            array_keys($sumasSinVerificar)
        ));

        foreach ($tipos as $tipo) {
            $sumaTotalTipos[$tipo] =
                (float) ($sumasVerificados[$tipo] ?? 0) +
                (float) ($sumasSinVerificar[$tipo] ?? 0);
        }

        return [
            'suma_tipos' => $sumasVerificados,
            'suma_tipos_sin_verificar' => $sumasSinVerificar,
            'suma_total_tipos' => $sumaTotalTipos,
        ];
    }

    private function sumasPorTipoPago(Builder $query): array
    {
        $tiposPermitidos = collect(
            $this->tipo_pago_service->listado()
        )
            ->pluck('value')
            ->mapWithKeys(function ($tipo) {
                return [$tipo => 0.0];
            })
            ->toArray();

        $sumasConsulta = (clone $query)
            ->reorder()
            ->select('pagos.tipo_pago')
            ->selectRaw('SUM(pagos.monto) AS total')
            ->groupBy('pagos.tipo_pago')
            ->pluck('total', 'tipo_pago')
            ->toArray();

        foreach ($sumasConsulta as $tipo => $total) {
            /*
         * Conserva tipos inesperados que existan en la base de datos,
         * pero convierte siempre el total a número.
         */
            $tiposPermitidos[$tipo] = (float) $total;
        }

        return $tiposPermitidos;
    }

    public function listadoArqueoCompleto(
        ?string $fechaIni,
        ?string $fechaFin,
        $sucursalId,
        ?int $medicoId,
        ?int $userId
    ): array {
        $queryVerificados = $this->consultaPagosVerificados(
            $fechaIni,
            $fechaFin,
            $sucursalId,
            $medicoId,
            $userId
        );

        $querySinVerificar = $this->consultaPagosSinVerificar(
            $fechaIni,
            $fechaFin,
            $sucursalId,
            $medicoId
        );

        $pagos = $this->relacionesPagos($queryVerificados)
            ->orderBy('pagos.fecha_verificado')
            ->get();

        $pagosSinVerificar = $this->relacionesPagos($querySinVerificar)
            ->orderBy('pagos.fecha')
            ->get();

        $sumas = $this->sumasArqueo(
            $fechaIni,
            $fechaFin,
            $sucursalId,
            $medicoId,
            $userId
        );

        return [
            'pagos' => $pagos,
            'suma_tipos' => $sumas['suma_tipos'],
            'pagos_sin_verificar' => $pagosSinVerificar,
            'suma_tipos_sin_verificar' =>
            $sumas['suma_tipos_sin_verificar'],
            'suma_total_tipos' =>
            $sumas['suma_total_tipos'],
        ];
    }

    public function reporteArqueo(
        $fecha_ini,
        $fecha_fin,
        $sucursal_id,
        $medico_id,
        $user_id
    ) {
        $pagos = [];
        $pagos_sin_verificar = [];

        $suma_tipos = [];
        $suma_tipos_sin_verificar = [];
        $suma_total_tipos = [];

        if ($fecha_ini && $fecha_fin) {

            $usuario = Auth::user();

            $login_user = $this->login_user_service
                ->verificaSucursal();

            // Consulta base compartida.
            $base = Pago::query()
                ->whereBetween('fecha_verificado', [
                    $fecha_ini,
                    $fecha_fin
                ]);

            if ($sucursal_id && $sucursal_id !== 'todos') {
                $base->where('sucursal_id', $sucursal_id);
            }

            if (
                in_array($usuario->tipo, [
                    'ADMINISTRADOR',
                    'GERENTE'
                ])
                && $medico_id
            ) {
                $base->where('medico_id', $medico_id);
            }

            // Consulta de pagos sin verificar.
            $pagos_sin_verificar = clone $base;

            // Consulta de pagos verificados.
            $pagos = clone $base;

            if (
                in_array($usuario->tipo, [
                    'MÉDICO',
                    'SECRETARIA'
                ])
            ) {
                $user_id = $usuario->id;
            }

            if ($user_id) {
                $pagos->where('user_id', $user_id);
            }

            $pagos->where('status', 1)
                ->where('verificado', 1);

            $pagos_sin_verificar
                ->where('status', 1)
                ->where('verificado', 0);

            if ($usuario->tipo === 'MÉDICO') {
                $pagos_sin_verificar->where(
                    'user_id',
                    $usuario->id
                );
            }

            if ($usuario->tipo === 'SECRETARIA') {
                $pagos_sin_verificar->where(
                    'sucursal_id',
                    $login_user->sucursal_id
                );
            }

            /*
         * Obtener los totales agrupados.
         * Una consulta para verificados y otra para pendientes.
         */
            $sumas_verificados = (clone $pagos)
                ->selectRaw('tipo_pago, SUM(monto) AS total')
                ->groupBy('tipo_pago')
                ->pluck('total', 'tipo_pago');

            $sumas_pendientes = (clone $pagos_sin_verificar)
                ->selectRaw('tipo_pago, SUM(monto) AS total')
                ->groupBy('tipo_pago')
                ->pluck('total', 'tipo_pago');

            // Inicializar las claves de todos los tipos de pago.
            $tipo_pagos = $this->tipo_pago_service->listado();

            foreach ($tipo_pagos as $item) {
                $tipo = $item['value'];

                $verificado = (float) (
                    $sumas_verificados[$tipo] ?? 0
                );

                $pendiente = (float) (
                    $sumas_pendientes[$tipo] ?? 0
                );

                $suma_tipos[$tipo] = $verificado;

                $suma_tipos_sin_verificar[$tipo] = $pendiente;

                $suma_total_tipos[$tipo] =
                    $verificado + $pendiente;
            }

            // Cargar relaciones solamente para los listados.
            $relaciones = [
                'sucursal:id,nombre',
                'user:id,nombre,paterno,materno',
                'medico:id,nombre,paterno,materno',
                'certificado_detalle.tipo_certificado',
                'certificado_detalle.certificado.tramitador',
                'cliente:id,nombre,paterno,materno,ci,ci_exp,complemento',
            ];

            $pagos_sin_verificar = $pagos_sin_verificar
                ->with($relaciones)
                ->get();

            $pagos = $pagos
                ->with($relaciones)
                ->get();
        }

        return [
            $pagos,
            $suma_tipos,
            $pagos_sin_verificar,
            $suma_tipos_sin_verificar,
            $suma_total_tipos
        ];
    }

    public function crear($datos)
    {
        $fecha_actual = Carbon::now("America/La_Paz")->format("Y-m-d");
        $hora_actual = Carbon::now("America/La_Paz")->format("H:i:s");

        $login_user = $this->login_user_service->verificaSucursal();
        if (!$login_user) {
            throw new Exception("Error no se encontró la sucursal del usuario");
        }
        $sucursal_id = $login_user->sucursal_id;
        $verificado = $this->obtieneEstadoVerificado($sucursal_id, $login_user);
        $fecha_verificado = $fecha_actual;
        $hora_verificado = $hora_actual;


        $pago = Pago::create([
            "registro_id" => $datos["registro_id"],
            "modulo" => $datos["modulo"],
            "monto" => $datos["monto"],
            "descripcion" => isset($datos["descripcion"]) && $datos["descripcion"] ? $datos["descripcion"] : '',
            "tipo_pago" => $datos["tipo_pago"],
            "cliente_id" => isset($datos["cliente_id"]) ? $datos["cliente_id"] : NULL,
            "fecha" => $fecha_actual,
            "hora" => $hora_actual,
            "user_id" => Auth::user()->id, // ACTUALIZAR SI NO ESTA VERIFICADO EL PAGO (En verificación de Pago)
            "sucursal_id" => $sucursal_id,
            "verificado" => $verificado,
            "fecha_verificado" => $fecha_verificado,
            "hora_verificado" => $hora_verificado,
        ]);

        if (isset($datos["certificado_atendido"])) {
            $pago->medico_id = $datos["certificado_atendido"] == 1 ? Auth::user()->id : NULL;
        }

        if (isset($datos["medico_id"])) {
            $pago->medico_id = $datos["medico_id"];
            $pago->save();
        }

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REGISTRO EL PAGO DE UN CERTIFICADO", $pago, null);

        return $pago;
    }

    public function obtieneEstadoVerificado($sucursal_id, $login_user)
    {
        $verificado = 0;
        $tipo_usuario = $this->login_user_service->getTipoUsuarioLogin();
        // if ($tipo_usuario == 'SECRETARIA' || !$this->login_user_service->verificaSecretariaSucursal($sucursal_id)) {
        //     // si es secretaria
        //     // o no hay secretaria en sucursal
        //     $verificado = 1;
        // }

        if ($login_user->verifica_pagos == 1) {
            $verificado = 1;
        }

        return $verificado;
    }

    public function asignarMedicoPago(CertificadoDetalle $certificado_detalle)
    {
        $pago = Pago::where("modulo", "CertificadoDetalle")
            ->where("registro_id", $certificado_detalle->id)
            ->where("status", 1)
            ->get()->first();
        if ($pago) {
            // SI NO HAY PAGO EXISTE UN COBRO PENDIENTE
            $pago->medico_id = Auth::user()->id;
            $pago->save();
        }
    }


    public function registrarPagos($ids)
    {
        $fecha_actual = Carbon::now("America/La_Paz")->format("Y-m-d");
        $hora_actual = Carbon::now("America/La_Paz")->format("H:i:s");
        Pago::whereIn("id", $ids)->update([
            "verificado" => 1,
            "fecha_verificado" => $fecha_actual,
            "hora_verificado" => $hora_actual,
            "user_id" => Auth::user()->id // Usuario que recepciono el dinero
        ]);

        return true;
    }

    public function actualizarPagoCertificadoDetalle(
        CertificadoDetalle $certificado_detalle,
        $old_cancelado,
        $nuevo_saldo,
        ?Pago $pago = null
    ) {
        $pago ??= $this->obtienePagoAnuladoExistente($certificado_detalle);
        if (!$pago) {
            return;
        }
        if ($pago) {
            // si el monto del pago es diferente al cancelado del detalle, actualizar el monto del pago
            $pago->tipo_pago = $certificado_detalle->certificado->tipo_pago;
            // $pago->status = 1;
            if ($pago->monto != $certificado_detalle->cancelado && $certificado_detalle->cancelado > 0) {
                $pago->monto = $certificado_detalle->cancelado;
                $pago->save();
                // registrar accion
                $this->historialAccionService->registrarAccion($this->modulo, "ACTUALIZACIÓN", "ACTUALIZÓ EL MONTO DEL PAGO DE UN CERTIFICADO DETALLE DE $old_cancelado A " . $certificado_detalle->cancelado, $pago, null);
            } else {
                $pago->tipo_pago = $certificado_detalle->certificado->tipo_pago;
                $certificado_detalle->saldo = $nuevo_saldo;
                if ((float)$nuevo_saldo > 0) {
                    // ELIMINAR PAGO
                    $certificado_detalle->cancelado = 0;
                    $pago->status = 0;
                } else {
                    // REESTABLECER PAGO
                    if ($pago->status == 0) {
                        $fecha_actual = Carbon::now("America/La_Paz")->format("Y-m-d");
                        $hora_actual = Carbon::now("America/La_Paz")->format("H:i:s");
                        $login_user = $this->login_user_service->verificaSucursal();
                        if (!$login_user) {
                            throw new Exception("Error no se encontró la sucursal del usuario");
                        }
                        // Log::debug("actuliazo");
                        // Log::debug($login_user);

                        $sucursal_id = $login_user->sucursal_id;
                        $verificado = $this->obtieneEstadoVerificado($sucursal_id, $login_user);
                        $pago->fecha_verificado = $fecha_actual;
                        $pago->hora_verificado = $hora_actual;
                        $pago->user_id = $login_user->user_id;
                        $pago->sucursal_id = $sucursal_id;
                        $pago->verificado = $verificado;
                        $pago->status = 1;
                    }
                    $certificado_detalle->cancelado = $certificado_detalle->precio;
                    $pago->monto = $certificado_detalle->precio;
                }
                $certificado_detalle->save();
                // el monto es 0 o no se ha cancelado, eliminar el pago
                $pago->save();
            }
        }
    }

    public function verificaPagoCertificadoDetalle(CertificadoDetalle $certificado_detalle)
    {
        $pago = Pago::where("modulo", "CertificadoDetalle")
            ->where("registro_id", $certificado_detalle->id)
            ->where("status", 1)
            ->get()->first();
        if ($pago) {
            return $pago;
        }
        return null;
    }



    public function obtienePagoAnuladoExistente(CertificadoDetalle $certificado_detalle)
    {
        return Pago::where("modulo", "CertificadoDetalle")
            ->where("registro_id", $certificado_detalle->id)
            ->first();
    }

    /**
     * LISTADO DE PAGOS PARA EL MODULO DE RECEPCION
     *
     */
    public function listadoRecepcionPagos()
    {
        $pagos = Pago::with(["sucursal:id,nombre", "user:id,nombre,paterno,materno"])
            ->where("status", 1)
            ->where("verificado", 0);

        $login_user = $this->login_user_service->verificaSucursal();
        if (!$login_user) {
            throw new Exception("Error no se encontró la sucursal del usuario");
        }
        $sucursal_id = $login_user->sucursal_id;

        if (Auth::user()->tipo != 'ADMINISTRADOR' && Auth::user()->tipo != 'GERENTE') {
            $pagos->where("sucursal_id", $sucursal_id);
        }

        $pagos = $pagos->get();

        return $pagos;
    }

    public function eliminarPagoPorCertificadoDetalle(CertificadoDetalle $certificado_detalle)
    {
        $pago = $this->verificaPagoCertificadoDetalle($certificado_detalle);
        if ($pago) {
            $this->eliminarPago($pago);
        }
    }

    public function eliminarPago(Pago $pago)
    {
        $pago->status = 0;
        $pago->save();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ EL PAGO DE UN CERTIFICADO", $pago, null);

        return true;
    }

    public function restaurarPagoPorCertificadoDetalle(CertificadoDetalle $certificado_detalle)
    {
        $pago = $this->obtienePagoAnuladoExistente($certificado_detalle);
        if ($pago) {
            $this->restaurarPago($pago);
        }
    }

    public function restaurarPago(Pago $pago)
    {
        $pago->status = 1;
        $pago->save();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "RESTAURACIÓN", "RESTAURÓ EL PAGO DE UN CERTIFICADO", $pago, null);

        return true;
    }

    public function eliminarPagoCertificadoDetalle(CertificadoDetalle $certificado_detalle)
    {
        $pago = $this->verificaPagoCertificadoDetalle($certificado_detalle);
        if ($pago) {
            $pago->delete();
        }
    }


    public function eliminaPagoPorCertificadoDetallePermanente(CertificadoDetalle $certificado_detalle)
    {
        $pago = $this->obtienePagoAnuladoExistente($certificado_detalle);
        if ($pago) {
            $this->eliminarPagoPermanente($pago);
        }
    }

    public function eliminarPagoPermanente(Pago $pago)
    {
        $pago->delete();
        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ PERMANENTEMENTE EL PAGO DE UN CERTIFICADO", $pago, null);

        return true;
    }
}
