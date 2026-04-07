<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

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
        "cel",
        "fecha_registro",
        "status",
    ];

    protected $appends = ["fecha_registro_t", "full_ci", "fecha_nac_t", "full_name"];

    public function getFullNameAttribute()
    {
        return $this->nombre . ' ' . $this->paterno . ($this->materno ? ' ' . $this->materno : '');
    }
    public function getFechaNacTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha_nac));
    }
    public function getFullCiAttribute()
    {
        return $this->ci . ($this->complemento ? '-' . $this->complemento : '') . ' ' . $this->ci_exp;
    }

    public function getFechaRegistroTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha_registro));
    }
}
