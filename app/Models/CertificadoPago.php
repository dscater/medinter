<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CertificadoPago extends Model
{
    protected $fillable = [
        "certificado_id",
        "monto",
        "tipo_pago",
        "fecha",
        "hora",
        "verificado",
    ];

    protected $appends = ["fecha_t"];

    public function getFechaTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha));
    }

    public function certificado()
    {
        return $this->belongsTo(Certificado::class, 'certificado_id');
    }
}
