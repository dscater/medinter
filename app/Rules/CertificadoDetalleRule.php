<?php

namespace App\Rules;

use Closure;
use Illuminate\Contracts\Validation\ValidationRule;
use Illuminate\Support\Facades\Log;
use Illuminate\Translation\PotentiallyTranslatedString;

class CertificadoDetalleRule implements ValidationRule
{
    /**
     * Run the validation rule.
     *
     * @param  Closure(string, ?string=): PotentiallyTranslatedString  $fail
     */
    public function validate(string $attribute, mixed $value, Closure $fail): void
    {
        if (!is_array($value)) {
            $fail('Debes ingresar al menos 1 certificado');
            return;
        }

        foreach ($value as $index => $detalle) {
            // categoria
            if ($detalle['categoria'] === "" || $detalle['categoria'] === null) {
                $fail("La categoría en la fila " . ($index + 1) . " es obligatorio.");
                continue;
            }

            // precio
            if ($detalle['precio'] === "" || $detalle['precio'] === null) {
                $fail("El precio en la fila " . ($index + 1) . " es obligatorio.");
                continue;
            }

            if (!is_numeric($detalle['precio']) || $detalle['precio'] < 0) {
                $fail("El precio en la fila " . ($index + 1) . " debe ser mayor o igual a 0.");
            }

            // tipo_certificado_id
            if (empty($detalle['tipo_certificado_id'])) {
                $fail("El tipo de certificado en la fila " . ($index + 1) . " es obligatorio.");
            }

            // archivo
            if (!isset($detalle['archivo']) || $detalle['archivo'] === null) {
                $fail("El archivo en la fila " . ($index + 1) . " es obligatorio.");
            } else if (!is_string($detalle["archivo"])) {
                // validar tamaño (2MB = 2048 KB)
                if ($detalle['archivo']->getSize() > 2048 * 1024) {
                    $fail("El archivo en la fila " . ($index + 1) . " no debe superar los 2MB.");
                }
            }
        }
    }
}
