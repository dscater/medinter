<script setup>
import { computed, ref } from "vue";
import Content from "@/Components/Content.vue";
import axios from "axios";

const loading = ref(false);

const ultimoIdInicio = ref(
    Number(localStorage.getItem("certificados_reorganizacion_ultimo_id") ?? 0),
);

const limite = 500;

const mensaje = ref("");

const resumen = ref({
    procesados: 0,
    movidos: 0,
    ya_organizados: 0,
    no_encontrados: 0,
    conflictos: 0,
    errores: 0,
});

const txtBtn = computed(() => {
    return loading.value ? "Procesando..." : "Reorganizar archivos";
});

const esperar = (milisegundos) => {
    return new Promise((resolve) => {
        setTimeout(resolve, milisegundos);
    });
};

const reorganizarArchivos = async () => {
    if (loading.value) {
        return;
    }

    let cursor = Number(ultimoIdInicio.value || 0);

    loading.value = true;
    mensaje.value = "Iniciando reorganización...";

    resumen.value = {
        procesados: 0,
        movidos: 0,
        ya_organizados: 0,
        no_encontrados: 0,
        conflictos: 0,
        errores: 0,
    };

    try {
        while (true) {
            mensaje.value = `Procesando desde el ID ${cursor}...`;

            const response = await axios.post(
                route("admin.archivos-directorios"),
                {
                    ultimo_id: cursor,
                    limite,
                },
            );

            const resultado = response.data;

            resumen.value.procesados += Number(resultado.procesados ?? 0);

            resumen.value.movidos += Number(resultado.movidos ?? 0);

            resumen.value.ya_organizados += Number(
                resultado.ya_organizados ?? 0,
            );

            resumen.value.no_encontrados += Number(
                resultado.no_encontrados ?? 0,
            );

            resumen.value.conflictos += Number(resultado.conflictos ?? 0);

            resumen.value.errores += Number(resultado.errores ?? 0);

            const siguienteId = Number(resultado.siguiente_id ?? cursor);

            /*
             * Protección contra un ciclo infinito.
             */
            if (resultado.hay_mas && siguienteId <= cursor) {
                throw new Error(
                    "El servidor no devolvió un ID siguiente válido.",
                );
            }

            cursor = siguienteId;

            /*
             * Guardamos el progreso. Si el navegador se cierra,
             * el siguiente intento puede continuar desde aquí.
             */
            ultimoIdInicio.value = cursor;

            localStorage.setItem(
                "certificados_reorganizacion_ultimo_id",
                String(cursor),
            );

            if (!resultado.hay_mas) {
                mensaje.value = "Reorganización finalizada correctamente.";

                break;
            }

            /*
             * Pausa breve para no generar carga continua.
             */
            await esperar(400);
        }
    } catch (error) {
        console.error(error);

        mensaje.value =
            "El proceso se detuvo. Puedes continuar desde el ID mostrado.";

        /*
         * El campo queda con el último ID procesado
         * correctamente.
         */
        ultimoIdInicio.value = cursor;
    } finally {
        loading.value = false;
    }
};
</script>

<template>
    <Content>
        <template #header>
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0">Inicio</h1>
                </div>
                <!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item active">Inicio</li>
                    </ol>
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->
        </template>
        <div class="content">
            <label for="ultimo-id"> Comenzar desde el ID </label>

            <input
                id="ultimo-id"
                v-model.number="ultimoIdInicio"
                type="number"
                min="0"
                :disabled="loading"
            />

            <button
                type="button"
                :disabled="loading"
                @click="reorganizarArchivos"
            >
                {{ txtBtn }}
            </button>

            <p v-if="mensaje">
                {{ mensaje }}
            </p>

            <div v-if="resumen.procesados">
                <p>
                    Procesados:
                    {{ resumen.procesados }}
                </p>

                <p>
                    Movidos:
                    {{ resumen.movidos }}
                </p>

                <p>
                    Ya organizados:
                    {{ resumen.ya_organizados }}
                </p>

                <p>
                    No encontrados:
                    {{ resumen.no_encontrados }}
                </p>

                <p>
                    Conflictos:
                    {{ resumen.conflictos }}
                </p>

                <p>
                    Errores:
                    {{ resumen.errores }}
                </p>
            </div>
        </div>
    </Content>
</template>
