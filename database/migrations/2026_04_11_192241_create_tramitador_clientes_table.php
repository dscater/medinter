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
        Schema::create('tramitador_clientes', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger("tramite_id");
            $table->unsignedBigInteger("cliente_id");
            $table->unsignedBigInteger("certificado_id")->nullable();
            $table->integer("estado"); //PENDIENTE, ATENDIDO
            $table->timestamps();

            $table->foreign("tramite_id")->on("tramites")->references("id");
            $table->foreign("cliente_id")->on("clientes")->references("id");
            $table->foreign("certificado_id")->on("certificados")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('tramitador_clientes');
    }
};
