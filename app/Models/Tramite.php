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
    ];
}
