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
        Schema::create('pagos', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("registro_id");
            $table->string("modulo", 255);
            $table->decimal("monto", 24, 2);
            $table->string("tipo_pago");
            $table->string("descripcion", 900);
            $table->date("fecha");
            $table->time("hora");
            $table->unsignedBigInteger("cliente_id")->nullable();
            $table->unsignedBigInteger("user_id");
            $table->unsignedBigInteger("medico_id")->nullable();
            $table->unsignedBigInteger("sucursal_id");
            $table->integer("verificado")->default(0);
            $table->date("fecha_verificado")->nullable();
            $table->time("hora_verificado")->nullable();
            $table->timestamps();

            $table->foreign("cliente_id")->on("clientes")->references("id");
            $table->foreign("user_id")->on("users")->references("id");
            $table->foreign("medico_id")->on("users")->references("id");
            $table->foreign("sucursal_id")->on("sucursals")->references("id");
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
