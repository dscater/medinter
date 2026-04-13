<?php

namespace App\Services;

use App\Services\HistorialAccionService;
use Carbon\Carbon;
use Illuminate\Http\UploadedFile;
use Exception;

class TramiteClienteService
{
    private $modulo = "TRAMITES";

    public function __construct(private HistorialAccionService $historialAccionService,) {}
}
