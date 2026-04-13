<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Certificado extends Model
{
    protected $fillable = [
        "cliente_id",
        "total",
        "cancelado",
        "saldo",
        "tipo_pago",
        "user_id",
        "sucursal_id",
        "tipo", //NORMAL: registrado por medicto, TRAMITE: grupo
        "fecha_inicio",
        "hora_inicio",
        "fecha_fin",
        "hora_fin",
        "fecha_registro",
        "hora_registro",
        "status",
    ];

    protected $appends = ["fecha_registro_t"];


    public function getFechaRegistroTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha_registro));
    }

    public function cliente()
    {
        return $this->belongsTo(Cliente::class, 'cliente_id');
    }

    public function user()
    {
        return $this->belongsTo(User::class, 'user_id');
    }
    public function sucursal()
    {
        return $this->belongsTo(Sucursal::class, 'sucursal_id');
    }

    public function certificado_detalles()
    {
        return $this->hasMany(CertificadoDetalle::class, 'certificado_id');
    }

    public function certificado_pagos()
    {
        return $this->hasMany(CertificadoPago::class, 'certificado_id');
    }


    public function tramite_cliente()
    {
        return $this->hasOne(TramiteCliente::class, 'certificado_id');
    }
}
