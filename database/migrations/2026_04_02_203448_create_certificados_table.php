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
            $table->decimal("precio", 24, 2);
            $table->unsignedBigInteger("tipo_certificado_id");
            $table->string("tipo_pago");
            $table->string("archivo1", 255)->nullable();
            $table->string("archivo2", 255)->nullable();
            $table->unsignedBigInteger("user_id");
            $table->unsignedBigInteger("sucursal_id");
            $table->timestamps();

            $table->foreign("cliente_id")->on("clientes")->references("id");
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
        Schema::dropIfExists('certificados');
    }
};
