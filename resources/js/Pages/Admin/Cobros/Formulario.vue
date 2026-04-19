<script setup>
import MiModal from "@/Components/MiModal.vue";
import { useForm, usePage } from "@inertiajs/vue3";
import { watch, ref, computed, defineEmits, onMounted, nextTick } from "vue";
// TOAST
import { toast } from "vue3-toastify";
import "vue3-toastify/dist/index.css";
const props = defineProps({
    muestra_formulario: {
        type: Boolean,
        default: false,
    },
    accion_formulario: {
        type: Number,
        default: 0,
    },
    certificado: {
        type: Object,
        default: null,
    },
});

const accion_form = ref(props.accion_formulario);
const muestra_form = ref(props.muestra_formulario);
const oCertificado = ref(props.certificado);
const saldo_aux = ref(props.certificado?.saldo);
const enviando = ref(false);
const form = useForm({
    monto: 0,
    tipo_pago: "",
});
watch(
    () => props.muestra_formulario,
    (newValue) => {
        muestra_form.value = newValue;
        if (muestra_form.value) {
            cargarTipoPagos();
            document
                .getElementsByTagName("body")[0]
                .classList.add("modal-open");
            form.monto = 0;
            form.tipo_pago = "";
        } else {
            document
                .getElementsByTagName("body")[0]
                .classList.remove("modal-open");
        }
    },
);
watch(
    () => props.accion_formulario,
    (newValue) => {
        accion_form.value = newValue;
        if (accion_form.value == 0) {
            form["_method"] = "POST";
        }
    },
);
watch(
    () => props.certificado,
    (newValue) => {
        oCertificado.value = newValue;
        saldo_aux.value = oCertificado.value.saldo;
    },
);

const tituloDialog = computed(() => {
    return accion_form.value == 0
        ? `<i class="fa fa-holding-usd"></i> Nuevo Pago`
        : `<i class="fa fa-holding-usd"></i> Nuevo Pago`;
});

const textBtn = computed(() => {
    if (enviando.value) {
        return `<i class="fa fa-spin fa-spinner"></i> Enviando...`;
    }
    if (accion_form.value == 0) {
        return `<i class="fa fa-save"></i> Guardar`;
    }
    return `<i class="fa fa-edit"></i> Actualizar`;
});
const enviarFormulario = () => {
    enviando.value = true;
    let url = route("cobros.registrarPago", oCertificado.value.id);
    form.post(url, {
        preserveScroll: true,
        forceFormData: true,
        onSuccess: (response) => {
            console.log("correcto");
            const success =
                response.props.flash.success ?? "Proceso realizado con éxito";
            Swal.fire({
                icon: "success",
                title: "Correcto",
                html: `<strong>${success}</strong>`,
                confirmButtonText: `Aceptar`,
                customClass: {
                    confirmButton: "btn-alert-success",
                },
            });
            emits("envio-formulario");
        },
        onError: (err, code) => {
            console.log(code ?? "");
            console.log(form.errors);
            if (form.errors) {
                const error =
                    "Existen errores en el formulario, por favor verifique";
                Swal.fire({
                    icon: "info",
                    title: "Error",
                    html: `<strong>${error}</strong>`,
                    confirmButtonText: `Aceptar`,
                    customClass: {
                        confirmButton: "btn-error",
                    },
                });
            } else {
                const error =
                    "Ocurrió un error inesperado contactese con el Administrador";
                Swal.fire({
                    icon: "info",
                    title: "Error",
                    html: `<strong>${error}</strong>`,
                    confirmButtonText: `Aceptar`,
                    customClass: {
                        confirmButton: "btn-error",
                    },
                });
            }
            console.log("error: " + err.error);
        },
        onFinish: () => {
            enviando.value = false;
        },
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
const listTipoPagos = ref([]);
const cargarTipoPagos = () => {
    axios.get(route("tipo_pagos.listado")).then((response) => {
        listTipoPagos.value = response.data;
    });
};

const ocultarBoton = ref(false);
const recalcularSaldo = () => {
    if (parseFloat(form.monto) < 1) {
        ocultarBoton.value = true;
        toast.error("El monto no puede ser menor a 1");
        return;
    }
    if (parseFloat(form.monto) > parseFloat(saldo_aux.value)) {
        ocultarBoton.value = true;
        toast.error("El monto no puede ser mayor al saldo");
        return;
    }
    ocultarBoton.value = false;

    oCertificado.value.saldo =
        parseFloat(oCertificado.value.total) -
        (parseFloat(oCertificado.value.cancelado) +
            parseFloat(form.monto ?? 0));
};

const cargarListas = () => {};
onMounted(() => {
    cargarListas();
});
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
                <div class="row" v-if="oCertificado">
                    <div class="col-12">
                        <div class="row">
                            <div class="col-4 text-right">
                                <strong>Nombre: </strong>
                            </div>
                            <div class="col-8">
                                {{ oCertificado.cliente.nombre }}
                                {{ oCertificado.cliente.paterno }}
                                {{ oCertificado.cliente.materno }}
                            </div>
                        </div>
                    </div>
                    <div class="col-12">
                        <div class="row">
                            <div class="col-4 text-right">
                                <strong>C.I.: </strong>
                            </div>
                            <div class="col-8">
                                {{ oCertificado.cliente.ci }}
                                {{ oCertificado.cliente.complemento }}
                                {{ oCertificado.cliente.ci_exp }}
                            </div>
                        </div>
                    </div>
                    <div class="col-12">
                        <div class="row">
                            <div class="col-4 text-right">
                                <strong>Certificados: </strong>
                            </div>
                            <div class="col-8">
                                <ul class="pl-3 mb-1">
                                    <li
                                        v-for="item in oCertificado.certificado_detalles"
                                    >
                                        {{ item.tipo_certificado.nombre }}
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                    <div class="col-12">
                        <div class="row">
                            <div class="col-4 text-right">
                                <strong>Total Bs.: </strong>
                            </div>
                            <div class="col-8">
                                {{ oCertificado.total }}
                            </div>
                        </div>
                    </div>
                    <div class="col-12">
                        <div class="row">
                            <div class="col-4 text-right">
                                <strong>Cancelado Bs.: </strong>
                            </div>
                            <div class="col-8">
                                {{ oCertificado.cancelado }}
                            </div>
                        </div>
                    </div>
                    <div class="col-12">
                        <div class="row">
                            <div class="col-4 text-right">
                                <strong>Saldo Bs.: </strong>
                            </div>
                            <div class="col-8">
                                {{ oCertificado.saldo }}
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row border-top mt-2">
                    <div class="col-md-4 mt-2 offset-md-4">
                        <label class="text-center w-100">Monto</label>
                        <input
                            type="number"
                            class="form-control"
                            v-model="form.monto"
                            @keyup="recalcularSaldo"
                        />
                        <ul
                            v-if="form.errors?.monto"
                            class="list-unstyled text-danger"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.monto }}
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-4 offset-md-4 text-center">
                        <el-radio-group v-model="form.tipo_pago">
                            <el-radio
                                v-for="item in listTipoPagos"
                                :value="item.value"
                                size="large"
                                ><i :class="item.icon"></i>
                                {{ item.label }}</el-radio
                            >
                        </el-radio-group>
                        <ul
                            v-if="form.errors?.tipo_pago"
                            class="d-block text-danger list-unstyled"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.tipo_pago }}
                            </li>
                        </ul>
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
                v-if="!ocultarBoton"
                type="button"
                class="btn btn-primary"
                :disabled="enviando"
                @click.prevent="enviarFormulario"
                v-html="textBtn"
            ></button>
        </template>
    </MiModal>
</template>
