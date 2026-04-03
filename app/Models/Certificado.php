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
        return asset("files/certificados/" . $this->archivo2);
    }

    public function getUrlArchivo1Attribute()
    {
        return asset("files/certificados/" . $this->archivo1);
    }

    public function getFechaRegistroTAttribute()
    {
        return date("d/m/Y", strtotime($this->fecha_registro));
    }
}
