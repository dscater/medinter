<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Log;
use Carbon\Carbon;

class Cliente extends Model
{
    protected $fillable = [
        "nombre",
        "paterno",
        "materno",
        "ci",
        "ci_exp",
        "complemento",
        "fecha_nac",
        "edad",
        "cel",
        "fecha_registro",
        "status",
        "user_id"
    ];

    protected $appends = ["fecha_registro_t", "full_ci", "fecha_nac_t", "full_name"];

    public function getFullNameAttribute(): string
    {
        return trim(implode(' ', array_filter([
            $this->nombre,
            $this->paterno,
            $this->materno,
        ])));
    }

    public function getFechaNacTAttribute(): string
    {
        return $this->fecha_nac
            ? Carbon::parse($this->fecha_nac)->format('d/m/Y')
            : '';
    }

    public function getFullCiAttribute(): string
    {
        return trim(
            $this->ci .
                ($this->complemento ? '-' . $this->complemento : '') .
                ($this->ci_exp ? ' ' . $this->ci_exp : '')
        );
    }

    public function getFechaRegistroTAttribute(): string
    {
        return $this->fecha_registro
            ? Carbon::parse($this->fecha_registro)->format('d/m/Y')
            : '';
    }

    public function scopeBuscarNombre($query, $texto)
    {
        if (!$texto) return $query;

        $palabras = explode(' ', $texto);

        foreach ($palabras as $palabra) {
            $query->where(function ($q) use ($palabra) {
                $q->where('nombre', 'like', "%$palabra%")
                    ->orWhere('paterno', 'like', "%$palabra%")
                    ->orWhere('materno', 'like', "%$palabra%")
                    ->orWhere('ci', 'like', "%$palabra%");
            });
        }

        return $query;
    }

    public function user()
    {
        return $this->belongsTo(User::class);
    }
}
