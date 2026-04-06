<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\ValidationRule;
use Illuminate\Foundation\Http\FormRequest;

class CertificadoUpdateRequest extends FormRequest
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
            "precio" => "required|numeric|decimal:0,2|min:0",
            "tipo_certificado_id" => "required",
            "tipo_pago" => "required",
            "archivo1" => "nullable|file|max:2048",
            "archivo2" => "nullable|file|max:2048",
            "sucursal_id" => "required",
        ];
    }

    public function messages(): array
    {
        return [
            "cliente_id.required" => "No se seleccionó ningún cliente",
            "precio.required" => "Debes ingresar el costo",
            "precio.numeric" => "Debes ingresar un valor númerico",
            "precio.numeric" => "Debes ingresar un número con hasta 2 decimales",
            "precio.numeric" => "Debes ingresar un monto minimo de :min",
            "tipo_certitificado_id.required" => "Debes completar este campo",
            "tipo_pago.required" => "Debes completar este campo",
            "archivo1.file" => "Debes ingresar un archivo",
            "archivo1.max" => "No puedes subir un archivo con mas de 2MB",
            "archivo2.file" => "Debes ingresar un archivo",
            "archivo2.max" => "No puedes subir un archivo con mas de 2MB",
        ];
    }
}
