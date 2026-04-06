<?php

namespace App\Services;

use App\Models\Permiso;
use App\Models\Role;
use Illuminate\Support\Facades\Auth;

class PermisoService
{
    protected $arrayPermisos = [
        "ADMINISTRADOR" => [
            "usuarios.paginado",
            "usuarios.index",
            "usuarios.listado",
            "usuarios.create",
            "usuarios.store",
            "usuarios.edit",
            "usuarios.show",
            "usuarios.update",
            "usuarios.destroy",
            "usuarios.password",

            "tipo_usuarios.listado",

            "sucursals.paginado",
            "sucursals.index",
            "sucursals.listado",
            "sucursals.create",
            "sucursals.store",
            "sucursals.edit",
            "sucursals.show",
            "sucursals.update",
            "sucursals.destroy",

            "clientes.paginado",
            "clientes.index",
            "clientes.listado",
            "clientes.byCi",
            "clientes.create",
            "clientes.store",
            "clientes.nuevo",
            "clientes.edit",
            "clientes.show",
            "clientes.update",
            "clientes.destroy",

            "tipo_certificados.paginado",
            "tipo_certificados.index",
            "tipo_certificados.listado",
            "tipo_certificados.create",
            "tipo_certificados.store",
            "tipo_certificados.edit",
            "tipo_certificados.show",
            "tipo_certificados.update",
            "tipo_certificados.destroy",

            "tipo_pagos.listado",

            "certificados.paginado",
            "certificados.index",
            "certificados.listado",
            // "certificados.create",
            // "certificados.store",
            "certificados.edit",
            "certificados.show",
            "certificados.update",
            "certificados.destroy",

            "certificado_emitidos.verificaCantidad",

            "configuracions.index",
            "configuracions.create",
            "configuracions.edit",
            "configuracions.update",
            "configuracions.destroy",

            // "reportes.usuarios",
            // "reportes.r_usuarios",
            "reportes.ventas",
            "reportes.r_ventas",

        ],
        "GERENTE" => [],
        "SECRETARIA" => [],
        "MÉDICO" => [
            "clientes.paginado",
            "clientes.index",
            "clientes.listado",
            "clientes.byCi",
            "clientes.create",
            "clientes.store",
            "clientes.nuevo",
            "clientes.edit",
            "clientes.show",
            "clientes.update",
            // "clientes.destroy",

            "tipo_pagos.listado",

            "sucursals.listado",

            "login_users.verificaSucursal",
            "login_users.asignaSucursal",

            "tipo_certificados.listado",

            "certificados.paginado",
            "certificados.index",
            "certificados.listado",
            "certificados.create",
            "certificados.store",
            "certificados.edit",
            "certificados.show",
            "certificados.update",
            "certificados.destroy",

            "certificado_emitidos.verificaCantidad",
        ],
    ];



    public function getTiposUsuarios()
    {
        return array_keys($this->arrayPermisos);
    }

    /**
     * Obtener permisos de usuario logeado
     *
     * @return array
     */
    public function getPermisosUser(): array|string
    {
        $user = Auth::user();
        $permisos = [];
        if ($user) {
            return $this->arrayPermisos[$user->tipo];
        }

        return $permisos;
    }
}
