<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('certificado_pagos', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("certificado_id");
            $table->decimal("monto", 24, 2);
            $table->string("tipo_pago");
            $table->date("fecha");
            $table->time("hora");
            $table->integer("verificado")->default(0);
            $table->timestamps();

            $table->foreign("certificado_id")->on("certificados")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('certificado_pagos');
    }
};
