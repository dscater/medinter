<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Log;
use Symfony\Component\HttpFoundation\Response;

class PermisoUsuarioMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {
        $user = $request->user();

        if ($user) {
            $permisos = $user->permisos;

            $prefijo = $request->route()->getPrefix();
            $nom_ruta = $request->route()->getName();

            $excepciones = [
                'inicio',
                'profile.edit',
                'profile.update',
                'profile.update_foto',
                'users.getUser',
            ];

            if (!is_string($permisos) && $permisos !== '*') {
                if (
                    ($prefijo === 'admin') &&
                    !in_array($nom_ruta, $permisos) &&
                    !in_array($nom_ruta, $excepciones)
                ) {
                    abort(401, 'Acceso denegado');
                }
            }
        }

        return $next($request);
    }
}
