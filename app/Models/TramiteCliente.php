<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class TramiteCliente extends Model
{
    protected $fillable = [
        "tramite_id",
        "cliente_id",
        "certificado_id",
        "estado",
        "existente",
    ];

    protected $casts = [
        'existente' => 'boolean',
    ];

    public function tramite()
    {
        return $this->belongsTo(Tramite::class, 'tramite_id');
    }

    public function cliente()
    {
        return $this->belongsTo(Cliente::class, 'cliente_id');
    }

    public function certificado()
    {
        return $this->belongsTo(Certificado::class, 'certificado_id');
    }
}
