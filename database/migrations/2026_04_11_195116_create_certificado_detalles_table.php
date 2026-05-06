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
        Schema::create('certificado_detalles', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("certificado_id");
            $table->string("categoria");
            $table->decimal("precio", 24, 2);
            $table->decimal("cancelado", 24, 2)->nullable();
            $table->decimal("saldo", 24, 2)->nullable();
            $table->unsignedBigInteger("tipo_certificado_id");
            $table->unsignedBigInteger("sucursal_id")->nullable();
            $table->unsignedBigInteger("user_id")->nullable();
            $table->date("fecha_inicio")->nullable();
            $table->time("hora_inicio")->nullable();
            $table->date("fecha_fin")->nullable();
            $table->time("hora_fin")->nullable();
            $table->integer("estado")->default(0);
            $table->string("archivo", 255)->nullable();
            $table->timestamps();

            $table->foreign("certificado_id")->on("certificados")->references("id");
            $table->foreign("tipo_certificado_id")->on("tipo_certificados")->references("id");
            $table->foreign("user_id")->on("users")->references("id");
            $table->foreign("sucursal_id")->on("sucursals")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('certificado_detalles');
    }
};
