<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class CertificadoDetalle extends Model
{
    protected $fillable = [
        "certificado_id",
        "categoria",
        "precio",
        "cancelado",
        "saldo",
        "tipo_certificado_id",
        "archivo",
    ];

    protected $appends = ["url_archivo", "name", "con_saldo"];

    public function getConSaldoAttribute()
    {
        if ($this->saldo > 0) {
            // CHECBOX DESMARCADO
            // EXISTE SALDO
            return false;
        }
        return true;
    }

    public function getNameAttribute()
    {
        return $this->archivo;
    }

    public function getUrlArchivoAttribute()
    {
        return asset("files/certificados/" . $this->archivo);
    }

    public function certificado()
    {
        return $this->belongsTo(Certificado::class, 'certificado_id');
    }

    public function tipo_certificado()
    {
        return $this->belongsTo(TipoCertificado::class, 'tipo_certificado_id');
    }

    public function pago()
    {
        return $this->hasOne(Pago::class, 'registro_id')->where("modulo", "CertificadoDetalle");
    }
}
