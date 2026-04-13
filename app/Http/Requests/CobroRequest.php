<?php

namespace App\Http\Requests;

use Illuminate\Contracts\Validation\ValidationRule;
use Illuminate\Foundation\Http\FormRequest;

class CobroRequest extends FormRequest
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
            "monto" => "required|numeric|decimal:0,2|min:1",
            "tipo_pago" => "required",
        ];
    }

    public function messages(): array
    {
        return [
            "monto.required" => "Debes completar este campo",
            "monto.numeric" => "Debes ingresar un valor númerico",
            "monto.decimal" => "Debes ingresar un valor con hasta 2 decimales",
            "monto.min" => "Debes ingresar al menos :min",
            "tipo_pago.required" => "Debes seleccionar una opción"
        ];
    }
}
