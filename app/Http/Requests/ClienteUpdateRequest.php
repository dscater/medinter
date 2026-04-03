<?php

namespace App\Http\Requests;

use App\Rules\ClienteCiComplementoRule;
use Illuminate\Contracts\Validation\ValidationRule;
use Illuminate\Foundation\Http\FormRequest;

class ClienteUpdateRequest extends FormRequest
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
            "nombre" => "required|string",
            "paterno" => "required|string",
            "materno" => "nullable|string",
            "ci" => [
                "required",
                new ClienteCiComplementoRule($this->complemento, $this->cliente->id)
            ],
            "ci_exp" => "required",
            "complemento" => "nullable",
            "fecha_nac" => "nullable|date",
            "cel" => "nullable",
        ];
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
        ];
    }
}
