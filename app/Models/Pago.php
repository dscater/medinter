<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;
use Carbon\Carbon;

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
        "cliente_id",
        "user_id",
        "medico_id",
        "sucursal_id",
        "verificado",
        "fecha_verificado",
        "hora_verificado",
        "status"
    ];

    protected $appends = ["fecha_t", "fecha_verificado_t"];

    protected $casts = [
        'monto' => 'decimal:2',
        'verificado' => 'boolean',
        'fecha' => 'date',
        'fecha_verificado' => 'date',
    ];

    public function getFechaTAttribute(): string
    {
        return $this->fecha
            ? Carbon::parse($this->fecha)->format('d/m/Y')
            : '';
    }

    public function getFechaVerificadoTAttribute(): string
    {
        return $this->fecha_verificado
            ? Carbon::parse($this->fecha_verificado)->format('d/m/Y')
            : '';
    }

    public function certificado_detalle()
    {
        return $this->belongsTo(
            CertificadoDetalle::class,
            'registro_id'
        );
    }

    public function cliente()
    {
        return $this->belongsTo(
            Cliente::class,
            'cliente_id'
        );
    }

    public function user()
    {
        return $this->belongsTo(
            User::class,
            'user_id'
        );
    }

    public function medico()
    {
        return $this->belongsTo(
            User::class,
            'medico_id'
        );
    }

    public function sucursal()
    {
        return $this->belongsTo(
            Sucursal::class,
            'sucursal_id'
        );
    }
}
