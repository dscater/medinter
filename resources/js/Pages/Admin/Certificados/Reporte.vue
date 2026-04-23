<script setup>
import MiModal from "@/Components/MiModal.vue";
import { useForm, usePage } from "@inertiajs/vue3";
import { watch, ref, computed, onMounted, nextTick } from "vue";
const { props: props_page } = usePage();
const props = defineProps({
    muestra_formulario: {
        type: Boolean,
        default: false,
    },
});

const muestra_form = ref(props.muestra_formulario);
const enviando = ref(false);
watch(
    () => props.muestra_formulario,
    async (newValue) => {
        muestra_form.value = newValue;
        if (muestra_form.value) {
            await cargarListas();
            document
                .getElementsByTagName("body")[0]
                .classList.add("modal-open");
        } else {
            document
                .getElementsByTagName("body")[0]
                .classList.remove("modal-open");
        }
    },
);

const tituloDialog = computed(() => {
    return `<i class="fa fa-file-alt"></i> Reporte de Certificados`;
});

const textBtn = computed(() => {
    if (enviando.value) {
        return `<i class="fa fa-spin fa-spinner"></i> Generando...`;
    }
    return `<i class="fa fa-file-alt"></i> Generar Reporte`;
});
const obtenerFechaActual = () => {
    const fecha = new Date();
    const anio = fecha.getFullYear();
    const mes = String(fecha.getMonth() + 1).padStart(2, "0"); // Mes empieza desde 0
    const dia = String(fecha.getDate()).padStart(2, "0"); // Día del mes
    return `${anio}-${mes}-${dia}`;
};

const form = ref({
    sucursal_id: "todos",
    user_id: "todos",
    tipo_certificado_id: "todos",
    fecha_ini: obtenerFechaActual(),
    fecha_fin: obtenerFechaActual(),
    formato: "pdf",
});

const enviarFormulario = () => {
    enviando.value = true;
    const url = route("reportes.r_certificados_diario", form.value);
    window.open(url, "_blank");
    setTimeout(() => {
        enviando.value = false;
    }, 500);
};

const listFormatos = ref([
    {
        icon: "fa fa-file-pdf",
        value: "pdf",
        label: "PDF",
    },
    {
        icon: "fa fa-file-excel",
        value: "excel",
        label: "EXCEL",
    },
]);

const listClientes = ref([]);
const listSucursals = ref([]);
const listUsers = ref([]);
const listTipoPagos = ref([]);
const listTipoCertificados = ref([]);

const cargarListas = async () => {
    await Promise.all([
        cargarSucursals(),
        cargarUsers(),
        cargarTipoCertificados(),
    ]);
};

const cargarClientes = async () => {
    const response = await axios.get(route("clientes.listado"));
    listClientes.value = response.data.clientes;
    listClientes.value.unshift({
        id: "todos",
        full_name: "TODOS",
        full_ci: "",
    });
};

const cargarSucursals = async () => {
    const response = await axios.get(route("sucursals.listado"));
    listSucursals.value = response.data.sucursals;
    listSucursals.value.unshift({
        id: "todos",
        nombre: "TODOS",
    });
};
const cargarUsers = async () => {
    if (props_page.auth?.user.tipo === "MÉDICO") {
        form.value.user_id = props_page.auth?.user.id;
        return;
    }
    const response = await axios.get(route("usuarios.byTipo"), {
        params: {
            tipo: "MÉDICO",
        },
    });
    listUsers.value = response.data.usuarios;
    listUsers.value.unshift({
        id: "todos",
        full_name: "TODOS",
    });
};
const cargarTipoPagos = async () => {
    const response = await axios.get(route("tipo_pagos.listado"));
    listTipoPagos.value = response.data;
    listTipoPagos.value.unshift({
        value: "todos",
        label: "TODOS",
    });
};
const cargarTipoCertificados = async () => {
    const response = await axios.get(route("tipo_certificados.listado"));
    listTipoCertificados.value = response.data.tipo_certificados;
    listTipoCertificados.value.unshift({
        id: "todos",
        nombre: "TODOS",
    });
};

const emits = defineEmits(["cerrar-formulario", "envio-formulario"]);

watch(muestra_form, (newVal) => {
    if (!newVal) {
        emits("cerrar-formulario");
    }
});
const cerrarFormulario = () => {
    muestra_form.value = false;
    document.getElementsByTagName("body")[0].classList.remove("modal-open");
};

onMounted(() => {});
</script>

<template>
    <MiModal
        :open_modal="muestra_form"
        @close="cerrarFormulario"
        :size="'modal-xl'"
        :header-class="'bg-principal'"
        :footer-class="'justify-content-end'"
    >
        <template #header>
            <h4 class="modal-title text-white" v-html="tituloDialog"></h4>
            <button
                type="button"
                class="close"
                @click.prevent="cerrarFormulario()"
            >
                <span aria-hidden="true">×</span>
            </button>
        </template>

        <template #body>
            <form @submit.prevent="enviarFormulario()">
                <div class="row">
                    <div class="col-md-12">
                        <label>Sucursal*</label>
                        <el-select v-model="form.sucursal_id" filterable>
                            <el-option
                                v-for="item in listSucursals"
                                :key="item.id"
                                :value="item.id"
                                :label="item.nombre"
                            >
                            </el-option>
                        </el-select>
                    </div>
                    <div
                        class="col-md-12"
                        v-if="props_page.auth?.user.tipo != 'MÉDICO'"
                    >
                        <label>Seleccionar Médico*</label>
                        <el-select v-model="form.user_id" filterable>
                            <el-option
                                v-for="item in listUsers"
                                :key="item.id"
                                :value="item.id"
                                :label="item.full_name"
                            >
                            </el-option>
                        </el-select>
                    </div>

                    <div class="col-12 mt-1">
                        <label>Rango de Fechas</label>
                        <div class="row">
                            <div class="col-md-6">
                                <input
                                    type="date"
                                    class="form-control"
                                    v-model="form.fecha_ini"
                                />
                            </div>
                            <div class="col-md-6">
                                <input
                                    type="date"
                                    class="form-control"
                                    v-model="form.fecha_fin"
                                />
                            </div>
                        </div>
                    </div>

                    <div class="col-md-12 text-center mt-2">
                        <el-radio-group v-model="form.formato">
                            <el-radio
                                v-for="item in listFormatos"
                                :value="item.value"
                                size="large"
                                ><i :class="item.icon"></i>
                                {{ item.label }}</el-radio
                            >
                        </el-radio-group>
                    </div>
                </div>
            </form>
        </template>
        <template #footer>
            <button
                type="button"
                class="btn btn-default"
                @click.prevent="cerrarFormulario()"
            >
                Cerrar
            </button>
            <button
                type="button"
                class="btn btn-primary"
                :disabled="enviando"
                @click.prevent="enviarFormulario"
                v-html="textBtn"
            ></button>
        </template>
    </MiModal>
</template>
