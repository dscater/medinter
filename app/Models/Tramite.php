<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Tramite extends Model
{
    protected $fillable = [
        "nro",
        "codigo",
        "tramitador_id",
        "fecha",
        "hora",
        "sucursal_id",
        "user_id",
    ];

    protected $appends = ["fecha_t"];

    public function getFechaTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha));
    }

    public function tramitador()
    {
        return $this->belongsTo(Tramitador::class, 'tramitador_id');
    }

    public function sucursal()
    {
        return $this->belongsTo(Sucursal::class, 'sucursal_id');
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }

    public function tramite_clientes()
    {
        return $this->hasMany(TramiteCliente::class, 'tramite_id');
    }
}
