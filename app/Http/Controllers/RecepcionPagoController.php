<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Inertia\Inertia;

class RecepcionPagoController extends Controller
{
    public function index()
    {
        return Inertia::render("Admin/RecepcionPagos/Index");
    }
}
