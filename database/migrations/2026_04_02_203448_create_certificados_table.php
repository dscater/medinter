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
        Schema::create('certificados', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("cliente_id");
            $table->decimal("total", 24, 2);
            $table->decimal("cancelado", 24, 2)->nullable();
            $table->decimal("saldo", 24, 2)->nullable();
            $table->string("tipo_pago");
            $table->unsignedBigInteger("user_id");
            $table->unsignedBigInteger("sucursal_id");
            $table->string("tipo", 255)->default('NORMAL'); //NORMAL: registrado por medicto, TRAMITE: grupo
            $table->date("fecha_inicio")->nullable();
            $table->time("hora_inicio")->nullable();
            $table->date("fecha_fin")->nullable();
            $table->time("hora_fin")->nullable();
            $table->date("fecha_registro")->nullable();
            $table->time("hora_registro")->nullable();
            $table->integer("verificado")->default(0);
            $table->integer("status")->default(1);
            $table->timestamps();

            $table->foreign("cliente_id")->on("clientes")->references("id");
            $table->foreign("user_id")->on("users")->references("id");
            $table->foreign("sucursal_id")->on("sucursals")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('certificados');
    }
};
