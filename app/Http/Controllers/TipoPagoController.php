<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

class TipoPagoController extends Controller
{
    public function listado()
    {
        return response()->JSON(
            [
                [
                    "value" => "EFECTIVO",
                    "label" => "EFECTIVO",
                    "icon" => "fa fa-money-bill",

                ],
                [
                    "value" => "QR",
                    "label" => "QR",
                    "icon" => "fa fa-qrcode",

                ]
            ]
        );
    }
}
