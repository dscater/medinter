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
        Schema::create('certificado_emitidos', function (Blueprint $table) {
            $table->id();
            $table->date("fecha");
            $table->unsignedBigInteger("user_id");
            $table->unsignedBigInteger("tipo_certificado_id");
            $table->integer("conteo");
            $table->timestamps();

            $table->foreign("user_id")->on("users")->references("id");
            $table->foreign("tipo_certificado_id")->on("tipo_certificados")->references("id");
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('certificado_emitidos');
    }
};
