<?php

namespace App\Http\Requests;

use App\Rules\CertificadoDetalleRule;
use Illuminate\Contracts\Validation\ValidationRule;
use Illuminate\Foundation\Http\FormRequest;

class CertificadoStoreRequest extends FormRequest
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
        return [
            "cliente_id" => "required",
            "total" => "required|numeric|decimal:0,2|min:0",
            "tipo_pago" => "required",
            "sucursal_id" => "required",
            "certificado_detalles" => ["required", "array", "min:1", new CertificadoDetalleRule()]
        ];
    }


    public function messages(): array
    {
        return [
            "cliente_id.required" => "No se seleccionó ningún cliente",
            "total.required" => "Debes ingresar el costo",
            "total.numeric" => "Debes ingresar un valor númerico",
            "total.numeric" => "Debes ingresar un número con hasta 2 decimales",
            "total.numeric" => "Debes ingresar un monto minimo de :min",
            "tipo_pago.required" => "Debes completar este campo",
            "certificado_detalles.required" => "Debes agregar al menos 1 certificado",
            "certificado_detalles.array" => "Debes enviar una lista de certificados",
            "certificado_detalles.min" => "Debes agregar al menos :min certificado",
        ];
    }
}
