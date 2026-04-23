<?php

namespace App\Http\Requests;

use App\Models\CertificadoDetalle;
use App\Rules\CertificadoDetalleRule;
use App\Rules\ClienteCiComplementoRule;
use Illuminate\Contracts\Validation\ValidationRule;
use Illuminate\Foundation\Http\FormRequest;

class ClienteStoreRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        $rule = [
            "nombre" => "required|string",
            "paterno" => "required|string",
            "materno" => "nullable|string",
            "ci" => [
                "required",
                new ClienteCiComplementoRule($this->complemento, null)
            ],
            "ci_exp" => "required",
            "complemento" => "nullable",
            "fecha_nac" => "required|date",
            "edad" => "nullable",
            "cel" => "nullable",
            "con_certificado" => "required",
        ];

        if ($this->con_certificado) {
            $rule["tipo_pago"] = ["required"];
            $rule["tipo"] = ["required"];
            $rule["tramitador_id"] = ["nullable"];
            if ($this->tipo != 'NORMAL') {
                $rule["tramitador_id"] = ["required"];
            }
            $rule["certificado_detalles"] = ["required", "array", "min:1", new CertificadoDetalleRule(false, false)];
            $rule["total"] = ["required"];
            $rule["cancelado"] = ["required"];
            $rule["saldo"] = ["required"];
        }

        return $rule;
    }

    public function messages(): array
    {
        return [
            "nombre.required" => "Debes completar este campo",
            "nombre.string" => "Debes ingresar un texto valido",
            "paterno.required" => "Debes completar este campo",
            "paterno.string" => "Debes ingresar un texto valido",
            "materno.string" => "Debes ingresar un texto valido",
            "ci.required" => "Debes completar este campo",
            "ci_exp.required" => "Debes completar este campo",
            "fecha_nac.required" => "Debes completar este campo",
            "fecha_nac.date" => "Debes ingresar una fecha valida",

            "tramitador_id.required" => "Debes seleccionar una opción",
            "total.required" => "Debes ingresar el costo",
            "total.numeric" => "Debes ingresar un valor númerico",
            "total.decimal" => "Debes ingresar un número con hasta 2 decimales",
            "total.min" => "Debes ingresar un monto minimo de :min",
            "cancelado.required" => "Debes ingresar el monto cancelado",
            "cancelado.numeric" => "Debes ingresar un valor númerico",
            "cancelado.decimal" => "Debes ingresar un número con hasta 2 decimales",
            "cancelado.min" => "Debes ingresar un monto minimo de :min",
            "saldo.required" => "No se obtuvo el saldo",
            "saldo.numeric" => "Debes ingresar un valor númerico",
            "saldo.decimal" => "Debes ingresar un número con hasta 2 decimales",
            "saldo.min" => "Debes ingresar un monto minimo de :min",
            "tipo_pago.required" => "Debes completar este campo",
        ];
    }
}
