<?php

namespace App\Services;

use App\Models\CertificadoEmitido;
use Exception;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;

class CertificadoEmitidoService
{
    private $modulo = "CERTIFICADOS EMITIDOS";

    public function __construct() {}

    /**
     * Crear certificado
     *
     * @param array $datos
     * @return CertificadoEmitido
     */
    public function actualizarCertificadoEmitido(
        $tipo_certificado_id,
        $fecha_actual,
        $user_id,
        $old_tipo_certificado_id = null
    ) {
        // Buscar el registro del tipo actual
        $certificado_emitido = CertificadoEmitido::where(
            "tipo_certificado_id",
            $tipo_certificado_id
        )
            ->where("fecha", $fecha_actual)
            ->where("user_id", $user_id)
            ->first();

        // NUEVO: incrementar el conteo del tipo actual
        if (!$old_tipo_certificado_id) {
            if (!$certificado_emitido) {
                return CertificadoEmitido::create([
                    "fecha" => $fecha_actual,
                    "user_id" => $user_id,
                    "tipo_certificado_id" => $tipo_certificado_id,
                    "conteo" => 1,
                ]);
            }

            $certificado_emitido->increment("conteo");

            return $certificado_emitido->refresh();
        }

        // EDICIÓN: si no cambió el tipo, no hacer nada
        if ((int) $old_tipo_certificado_id === (int) $tipo_certificado_id) {
            return $certificado_emitido;
        }

        // EDICIÓN: descontar el tipo anterior
        $certificado_emitido_anterior = CertificadoEmitido::where(
            "tipo_certificado_id",
            $old_tipo_certificado_id
        )
            ->where("fecha", $fecha_actual)
            ->where("user_id", $user_id)
            ->first();

        if ($certificado_emitido_anterior) {
            $certificado_emitido_anterior->decrement("conteo");
        }

        // Buscar o crear el registro del nuevo tipo
        if (!$certificado_emitido) {
            return CertificadoEmitido::create([
                "fecha" => $fecha_actual,
                "user_id" => $user_id,
                "tipo_certificado_id" => $tipo_certificado_id,
                "conteo" => 1,
            ]);
        }

        $certificado_emitido->increment("conteo");

        return $certificado_emitido->refresh();
    }

    public function descontarCertificadoEmitido($tipo_certificado_id, $fecha_actual, $user_id)
    {
        $certificado_emitido = CertificadoEmitido::where("tipo_certificado_id", $tipo_certificado_id)
            ->where("fecha", $fecha_actual)
            ->where("user_id", $user_id)
            ->get()
            ->first();

        if ($certificado_emitido) {
            $certificado_emitido->conteo = (int)$certificado_emitido->conteo - 1;
            $certificado_emitido->save();
            return $certificado_emitido;
        }
        return null;
    }
}
