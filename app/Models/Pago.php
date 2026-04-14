<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Pago extends Model
{
    protected $fillable = [
        "registro_id",
        "modulo",
        "monto",
        "tipo_pago",
        "descripcion",
        "fecha",
        "hora",
        "user_id",
        "sucursal_id",
        "verificado",
        "fecha_verificado",
        "hora_verificado"
    ];

    protected $appends = ["fecha_t", "fecha_verificado_t"];

    public function getFechaVerificadoTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha_verificado));
    }

    public function getFechaTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha));
    }

    public function certificado()
    {
        return $this->belongsTo(Certificado::class, 'certificado_id');
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function sucursal()
    {
        return $this->belongsTo(Sucursal::class, 'sucursal_id');
    }
}
