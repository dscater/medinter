<?php

use App\Http\Controllers\CertificadoController;
use App\Http\Controllers\CertificadoEmitidoController;
use App\Http\Controllers\ClienteController;
use App\Http\Controllers\ConfiguracionController;
use App\Http\Controllers\InicioController;
use App\Http\Controllers\LoginUserController;
use App\Http\Controllers\ProfileController;
use App\Http\Controllers\ReporteController;
use App\Http\Controllers\SucursalController;
use App\Http\Controllers\TipoCertificadoController;
use App\Http\Controllers\TipoPagoController;
use App\Http\Controllers\TipoUsuarioController;
use App\Http\Controllers\TramitadorController;
use App\Http\Controllers\TramiteController;
use App\Http\Controllers\UserController;
use App\Http\Controllers\UsuarioController;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;
use Inertia\Inertia;

Route::get('/', function () {
    if (Auth::check()) {
        return redirect()->route('inicio');
    }
    return Inertia::render('Auth/Login');
});

Route::get('/login', function () {
    if (Auth::check()) {
        return redirect()->route('inicio');
    }
    return Inertia::render('Auth/Login');
})->name("login");

Route::get("configuracions/getConfiguracion", [ConfiguracionController::class, 'getConfiguracion'])->name("configuracions.getConfiguracion");

Route::get('/clear-cache', function () {
    Artisan::call('config:cache');
    Artisan::call('config:clear');
    Artisan::call('optimize');
    return 'Cache eliminado <a href="/">Ir al inicio</a>';
})->name('clear.cache');

// ADMINISTRACION
Route::middleware(['auth', 'permisoUsuario'])->prefix("admin")->group(function () {
    // INICIO
    Route::get('/inicio', [InicioController::class, 'inicio'])->name('inicio');
    Route::get('/certificadosEmitidosLinea', [InicioController::class, 'certificadosEmitidosLinea'])->name('certificadosEmitidosLinea');

    // CONFIGURACION
    Route::resource("configuracions", ConfiguracionController::class)->only(
        ["index", "show", "update"]
    );

    // USUARIO
    Route::get('profile', [ProfileController::class, 'edit'])->name('profile.edit');
    Route::patch('profile', [ProfileController::class, 'update'])->name('profile.update');
    Route::patch('profile/update_foto', [ProfileController::class, 'update_foto'])->name('profile.update_foto');
    Route::delete('profile', [ProfileController::class, 'destroy'])->name('profile.destroy');
    Route::get("getUser", [UserController::class, 'getUser'])->name('users.getUser');
    Route::get("permisosUsuario", [UserController::class, 'permisosUsuario']);

    // USUARIOS
    Route::put("usuarios/password/{user}", [UsuarioController::class, 'actualizaPassword'])->name("usuarios.password");
    Route::get("usuarios/paginado", [UsuarioController::class, 'paginado'])->name("usuarios.paginado");
    Route::get("usuarios/listado", [UsuarioController::class, 'listado'])->name("usuarios.listado");
    Route::get("usuarios/listado/byTipo", [UsuarioController::class, 'byTipo'])->name("usuarios.byTipo");
    Route::get("usuarios/show/{user}", [UsuarioController::class, 'show'])->name("usuarios.show");
    Route::put("usuarios/update/{user}", [UsuarioController::class, 'update'])->name("usuarios.update");
    Route::delete("usuarios/{user}", [UsuarioController::class, 'destroy'])->name("usuarios.destroy");
    Route::resource("usuarios", UsuarioController::class)->only(
        ["index", "store"]
    );

    // LOGIN USER
    Route::get("login_users/verificaSucursal", [LoginUserController::class, 'verificaSucursal'])->name("login_users.verificaSucursal");
    Route::post("login_users/asignaSucursal", [LoginUserController::class, 'asignaSucursal'])->name("login_users.asignaSucursal");

    // TIPO USUARIOS
    Route::get("tipo_usuarios/listado", [TipoUsuarioController::class, 'listado'])->name("tipo_usuarios.listado");

    // SUCURSALES
    Route::get("sucursals/paginado", [SucursalController::class, 'paginado'])->name("sucursals.paginado");
    Route::get("sucursals/listado", [SucursalController::class, 'listado'])->name("sucursals.listado");
    Route::resource("sucursals", SucursalController::class)->only(
        ["index", "store", "edit", "show", "update", "destroy"]
    );

    // CLIENTES
    Route::post("clientes/nuevo", [ClienteController::class, 'nuevo'])->name("clientes.nuevo");
    Route::get("clientes/paginado", [ClienteController::class, 'paginado'])->name("clientes.paginado");
    Route::get("clientes/listado", [ClienteController::class, 'listado'])->name("clientes.listado");
    Route::get("clientes/byCi", [ClienteController::class, 'byCi'])->name("clientes.byCi");
    Route::resource("clientes", ClienteController::class)->only(
        ["index", "store", "edit", "show", "update", "destroy"]
    );

    // TRAMITADORES
    Route::post("tramitadors/nuevo", [TramitadorController::class, 'nuevo'])->name("tramitadors.nuevo");
    Route::get("tramitadors/paginado", [TramitadorController::class, 'paginado'])->name("tramitadors.paginado");
    Route::get("tramitadors/listado", [TramitadorController::class, 'listado'])->name("tramitadors.listado");
    Route::get("tramitadors/byCi", [TramitadorController::class, 'byCi'])->name("tramitadors.byCi");
    Route::resource("tramitadors", TramitadorController::class)->only(
        ["index", "store", "edit", "show", "update", "destroy"]
    );

    // TIPO CERTIFICADOS
    Route::get("tipo_certificados/paginado", [TipoCertificadoController::class, 'paginado'])->name("tipo_certificados.paginado");
    Route::get("tipo_certificados/listado", [TipoCertificadoController::class, 'listado'])->name("tipo_certificados.listado");
    Route::resource("tipo_certificados", TipoCertificadoController::class)->only(
        ["index", "store", "edit", "show", "update", "destroy"]
    );

    // CERTIFICADOS
    Route::get("certificados/paginado", [CertificadoController::class, 'paginado'])->name("certificados.paginado");
    Route::get("certificados/listado", [CertificadoController::class, 'listado'])->name("certificados.listado");
    Route::resource("certificados", CertificadoController::class)->only(
        ["index", "store", "create", "edit", "show", "update", "destroy"]
    );

    // CERTIFICADOS EMITIDOS
    Route::get("certificado_emitidos/verificaCantidad", [CertificadoEmitidoController::class, 'verificaCantidad'])->name("certificado_emitidos.verificaCantidad");

    // TIPO PAGO
    Route::get("tipo_pagos/listado", [TipoPagoController::class, 'listado'])->name("tipo_pagos.listado");

    // TRAMITES
    Route::post("tramites/nuevo", [TramiteController::class, 'nuevo'])->name("tramites.nuevo");
    Route::get("tramites/paginado", [TramiteController::class, 'paginado'])->name("tramites.paginado");
    Route::get("tramites/listado", [TramiteController::class, 'listado'])->name("tramites.listado");
    Route::get("tramites/byCi", [TramiteController::class, 'byCi'])->name("tramites.byCi");
    Route::resource("tramites", TramiteController::class)->only(
        ["index", "create", "store", "edit", "show", "update", "destroy"]
    );

    // REPORTES
    Route::get('reportes/usuarios', [ReporteController::class, 'usuarios'])->name("reportes.usuarios");
    Route::get('reportes/r_usuarios', [ReporteController::class, 'r_usuarios'])->name("reportes.r_usuarios");

    Route::get('reportes/clientes', [ReporteController::class, 'clientes'])->name("reportes.clientes");
    Route::get('reportes/r_clientes', [ReporteController::class, 'r_clientes'])->name("reportes.r_clientes");

    Route::get('reportes/certificados', [ReporteController::class, 'certificados'])->name("reportes.certificados");
    Route::get('reportes/r_certificados', [ReporteController::class, 'r_certificados'])->name("reportes.r_certificados");

    Route::get('reportes/gcemitidos', [ReporteController::class, 'gcemitidos'])->name("reportes.gcemitidos");
    Route::get('reportes/r_gcemitidos', [ReporteController::class, 'r_gcemitidos'])->name("reportes.r_gcemitidos");

    Route::get('reportes/gmemitidos', [ReporteController::class, 'gmemitidos'])->name("reportes.gmemitidos");
    Route::get('reportes/r_gmemitidos', [ReporteController::class, 'r_gmemitidos'])->name("reportes.r_gmemitidos");

    Route::get('reportes/historial_accions', [ReporteController::class, 'historial_accions'])->name("reportes.historial_accions");
    Route::get('reportes/r_historial_accions', [ReporteController::class, 'r_historial_accions'])->name("reportes.r_historial_accions");
});
require __DIR__ . '/auth.php';
