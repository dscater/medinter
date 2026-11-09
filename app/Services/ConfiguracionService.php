<?php

namespace App\Services;

use App\Models\Configuracion;
use Illuminate\Http\UploadedFile;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Cache;

class ConfiguracionService
{
    private const CACHE_KEY = 'configuracion_app';

    public function __construct(private CargarArchivoService $cargarArchivoService) {}

    /**
     * Actualizar configuracion
     *
     * @param array $datos
     * @param Configuracion $configuracion
     * @return Configuracion
     */
    public function actualizar(array $datos, Configuracion $configuracion): Configuracion
    {
        $old_area = clone $configuracion;

        $configuracion = Configuracion::first();

        if (!$configuracion) {
            $configuracion = Configuracion::create([
                "nombre_sistema" => $datos["nombre_sistema"],
                "alias" => $datos["alias"],
                "razon_social" => $datos["razon_social"],
                "nit" => $datos["nit"],
                "dir" => $datos["dir"],
                "fono" => $datos["fono"],
                "actividad" => $datos["actividad"],
                "correo" => $datos["correo"],
            ]);
        } else {
            $configuracion->update([
                "nombre_sistema" => $datos["nombre_sistema"],
                "alias" => $datos["alias"],
                "razon_social" => $datos["razon_social"],
                "nit" => $datos["nit"],
                "dir" => $datos["dir"],
                "fono" => $datos["fono"],
                "actividad" => $datos["actividad"],
                "correo" => $datos["correo"],
            ]);
        }
        // cargar logo
        if ($datos["logo"] && !is_string($datos["logo"])) {
            $this->cargarLogo($configuracion, $datos["logo"]);
        }

        $this->actualizarCache();

        return $configuracion;
    }

    public function cargarLogo(Configuracion $configuracion, UploadedFile $logo): void
    {
        if ($configuracion->logo) {
            \File::delete(public_path("imgs/" . $configuracion->logo));
        }
        $nombre = $configuracion->id . time();
        $configuracion->logo = $this->cargarArchivoService->cargarArchivo($logo, public_path("imgs"), $nombre);
        $configuracion->save();
    }

    /**
     * Obtener configuración desde caché.
     * Si no existe, consultar la BD y almacenarla.
     */
    public function obtenerConfiguracion()
    {
        return Cache::rememberForever(self::CACHE_KEY, function () {
            return Configuracion::first()
                ?->append('url_logo')->makeHidden("logo_b64");
        });
    }

    /**
     * Actualizar la caché con los datos actuales de la BD.
     * Llamar después de modificar la configuración.
     */
    public function actualizarCache()
    {
        $configuracion = Configuracion::first()
            ?->append('url_logo')->makeHidden("logo_b64");

        Cache::forever(self::CACHE_KEY, $configuracion);

        return $configuracion;
    }
}
