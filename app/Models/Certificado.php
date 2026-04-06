<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Certificado extends Model
{
    protected $fillable = [
        "cliente_id",
        "precio",
        "tipo_certificado_id",
        "tipo_pago",
        "archivo1",
        "archivo2",
        "user_id",
        "sucursal_id",
        "fecha_registro",
        "hora_registro",
        "status",
    ];

    protected $appends = ["fecha_registro_t", "url_archivo1", "url_archivo2"];

    public function getUrlArchivo2Attribute()
    {
        if ($this->archivo2)
            return asset("files/certificados/" . $this->archivo2);

        return "";
    }

    public function getUrlArchivo1Attribute()
    {
        if ($this->archivo1)
            return asset("files/certificados/" . $this->archivo1);

        return "";
    }

    public function getFechaRegistroTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha_registro));
    }

    public function cliente()
    {
        return $this->belongsTo(Cliente::class, 'cliente_id');
    }

    public function tipo_certificado()
    {
        return $this->belongsTo(TipoCertificado::class, 'tipo_certificado_id');
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
