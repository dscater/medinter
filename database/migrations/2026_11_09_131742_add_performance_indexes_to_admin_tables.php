<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        /*
         * CLIENTES
         *
         * Se utilizan para:
         * where('status', 1)
         * búsquedas por nombre, apellido y CI
         */
        $this->addIndexIfMissing(
            'clientes',
            ['status', 'nombre'],
            'clientes_status_nombre_index'
        );

        $this->addIndexIfMissing(
            'clientes',
            ['status', 'paterno'],
            'clientes_status_paterno_index'
        );

        $this->addIndexIfMissing(
            'clientes',
            ['status', 'materno'],
            'clientes_status_materno_index'
        );

        $this->addIndexIfMissing(
            'clientes',
            ['status', 'ci'],
            'clientes_status_ci_index'
        );

        /*
         * Solo es necesario si clientes.user_id no está indexado.
         */
        $this->addIndexIfMissing(
            'clientes',
            ['user_id'],
            'clientes_user_id_index'
        );

        /*
         * CERTIFICADOS
         *
         * Ya tienes índices individuales para:
         * cliente_id
         * user_id
         * sucursal_id
         * tramitador_id
         * inicio_id
         *
         * Por eso solo agregamos los compuestos.
         */
        $this->addIndexIfMissing(
            'certificados',
            ['status', 'fecha_registro'],
            'certificados_status_fecha_registro_index'
        );

        $this->addIndexIfMissing(
            'certificados',
            ['status', 'cliente_id'],
            'certificados_status_cliente_id_index'
        );

        /*
         * Úsalos solamente si filtras frecuentemente
         * certificados por sucursal, usuario o tramitador.
         */
        $this->addIndexIfMissing(
            'certificados',
            ['status', 'sucursal_id'],
            'certificados_status_sucursal_id_index'
        );

        $this->addIndexIfMissing(
            'certificados',
            ['status', 'user_id'],
            'certificados_status_user_id_index'
        );

        $this->addIndexIfMissing(
            'certificados',
            ['status', 'tramitador_id'],
            'certificados_status_tramitador_id_index'
        );

        /*
         * CERTIFICADO_DETALLES
         *
         * Según los índices que mostraste, no hace falta crear nada aquí.
         *
         * Ya existen:
         * certificado_id
         * tipo_certificado_id
         * user_id
         * sucursal_id
         */

        /*
         * USERS
         *
         * Se utilizan en listadoByTipo('MÉDICO', ...).
         * No agregamos status porque no confirmaste que esa columna
         * exista en users.
         */
        $this->addIndexIfMissing(
            'users',
            ['tipo', 'nombre'],
            'users_tipo_nombre_index'
        );

        $this->addIndexIfMissing(
            'users',
            ['tipo', 'paterno'],
            'users_tipo_paterno_index'
        );

        $this->addIndexIfMissing(
            'users',
            ['tipo', 'materno'],
            'users_tipo_materno_index'
        );
    }

    public function down(): void
    {
        $this->dropIndexIfExists(
            'clientes',
            'clientes_status_nombre_index'
        );

        $this->dropIndexIfExists(
            'clientes',
            'clientes_status_paterno_index'
        );

        $this->dropIndexIfExists(
            'clientes',
            'clientes_status_materno_index'
        );

        $this->dropIndexIfExists(
            'clientes',
            'clientes_status_ci_index'
        );

        $this->dropIndexIfExists(
            'clientes',
            'clientes_user_id_index'
        );

        $this->dropIndexIfExists(
            'certificados',
            'certificados_status_fecha_registro_index'
        );

        $this->dropIndexIfExists(
            'certificados',
            'certificados_status_cliente_id_index'
        );

        $this->dropIndexIfExists(
            'certificados',
            'certificados_status_sucursal_id_index'
        );

        $this->dropIndexIfExists(
            'certificados',
            'certificados_status_user_id_index'
        );

        $this->dropIndexIfExists(
            'certificados',
            'certificados_status_tramitador_id_index'
        );

        $this->dropIndexIfExists(
            'users',
            'users_tipo_nombre_index'
        );

        $this->dropIndexIfExists(
            'users',
            'users_tipo_paterno_index'
        );

        $this->dropIndexIfExists(
            'users',
            'users_tipo_materno_index'
        );
    }

    private function addIndexIfMissing(
        string $tableName,
        array $columns,
        string $indexName
    ): void {
        if ($this->indexExists($tableName, $indexName)) {
            return;
        }

        Schema::table($tableName, function (Blueprint $table) use (
            $columns,
            $indexName
        ) {
            $table->index($columns, $indexName);
        });
    }

    private function dropIndexIfExists(
        string $tableName,
        string $indexName
    ): void {
        if (! $this->indexExists($tableName, $indexName)) {
            return;
        }

        Schema::table($tableName, function (Blueprint $table) use (
            $indexName
        ) {
            $table->dropIndex($indexName);
        });
    }

    private function indexExists(
        string $tableName,
        string $indexName
    ): bool {
        $indexes = DB::select("SHOW INDEX FROM `{$tableName}`");

        foreach ($indexes as $index) {
            if ($index->Key_name === $indexName) {
                return true;
            }
        }

        return false;
    }
};
