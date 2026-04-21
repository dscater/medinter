<script setup>
import MiModal from "@/Components/MiModal.vue";
import { useForm, usePage } from "@inertiajs/vue3";
import { watch, ref, computed, defineEmits, onMounted, nextTick } from "vue";
import { useCertificados } from "@/composables/certificados/useCertificados";
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
const { setCertificado, limpiarCertificado, oCertificado } = useCertificados();

const accion_form = ref(props.accion_formulario);
const muestra_form = ref(props.muestra_formulario);
const saldo_aux = ref(props.certificado?.saldo);
const enviando = ref(false);
const form = useForm(oCertificado.value);
watch(
    () => props.muestra_formulario,
    (newValue) => {
        muestra_form.value = newValue;
        if (muestra_form.value) {
            cargarListas();
            document
                .getElementsByTagName("body")[0]
                .classList.add("modal-open");

            form.id = oCertificado.value.id;
            form.cliente_id = oCertificado.value.cliente_id;
            form.cliente = oCertificado.value.cliente;
            form.total = oCertificado.value.total;
            form.cancelado = oCertificado.value.cancelado;
            form.saldo = oCertificado.value.saldo;
            form.tipo_pago = oCertificado.value.tipo_pago;
            form.tipo = oCertificado.value.tipo;
            form.tramitador_id = oCertificado.value.tramitador_id;
            form.tramitador = oCertificado.value.tramitador;
            form.user_id = oCertificado.value.user_id;
            form.sucursal_id = oCertificado.value.sucursal_id;
            form.fecha_inicio = oCertificado.value.fecha_inicio;
            form.hora_inicio = oCertificado.value.hora_inicio;
            form.fecha_fin = oCertificado.value.fecha_fin;
            form.hora_fin = oCertificado.value.hora_fin;
            form.estado = oCertificado.value.estado;
            form.certificado_detalles = oCertificado.value.certificado_detalles;
            form.eliminados = oCertificado.value.eliminados;
            form._method = oCertificado.value._method;
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
        ? `<i class="fa fa-hand-holding-usd"></i> Registrar Cobro`
        : `<i class="fa fa-hand-holding-usd"></i> Registrar Cobro`;
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
    form._method = "POST";
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
watch(
    () => form.certificado_detalles,
    () => {
        calcularSaldo();
    },
    { deep: true },
);

const calcularSaldo = () => {
    let cancelado = 0;

    form.certificado_detalles.forEach((item) => {
        // SUMAR LOS QUE ESTÁN PAGADOS
        if (item.con_saldo === true) {
            cancelado += parseFloat(item.precio || 0);
        }
    });
    form.cancelado = cancelado.toFixed(2);

    const total = parseFloat(form.total || 0);
    form.saldo = (total - cancelado).toFixed(2);
};
const total = computed(() => {
    const total = form.certificado_detalles.reduce((total, item) => {
        const subtotal = parseFloat(
            item.precio && item.precio != 0 ? item.precio : 0,
        );
        if (subtotal !== null && subtotal !== undefined && subtotal !== "") {
            return total + Number(subtotal);
        }

        return total;
    }, 0);

    form.cancelado = 0;
    form.saldo = total;
    form.total = total;

    return total ? total.toFixed(2) : "0.00";
});
const cargarListas = () => {
    cargarTipoPagos();
};
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
                <div class="row" v-if="form.cliente">
                    <div class="col-12">
                        <div class="row">
                            <div class="col-4 text-right">
                                <strong>Paciente: </strong>
                            </div>
                            <div class="col-8">
                                {{ form.cliente.nombre }}
                                {{ form.cliente.paterno }}
                                {{ form.cliente.materno }}
                            </div>
                        </div>
                    </div>
                    <div class="col-12">
                        <div class="row">
                            <div class="col-4 text-right">
                                <strong>C.I.: </strong>
                            </div>
                            <div class="col-8">
                                {{ form.cliente.ci }}
                                {{ form.cliente.complemento }}
                                {{ form.cliente.ci_exp }}
                            </div>
                        </div>
                    </div>
                    <div class="col-12">
                        <div class="row">
                            <div class="col-4 text-right">
                                <strong>Tipo Trámite: </strong>
                            </div>
                            <div class="col-8">
                                {{ form.tipo }}
                            </div>
                        </div>
                    </div>
                    <div class="col-12" v-if="form.tipo == 'TRAMITE'">
                        <div class="row">
                            <div class="col-4 text-right">
                                <strong>Tramitador: </strong>
                            </div>
                            <div class="col-8">
                                {{ form.tramitador.nombre }}
                            </div>
                        </div>
                    </div>

                    <div class="col-12 mt-1 cliente-pago">
                        <div
                            class="row fila_cliente_cetificado"
                            v-for="(item, index) in form.certificado_detalles"
                        >
                            <div
                                class="col-6 text-xs d-flex justify-content-start align-items-center border-left border-top border-bottom"
                            >
                                {{ item.tipo_certificado.nombre }}
                            </div>
                            <div class="col-6">
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <div
                                            class="input-group-text border-left"
                                        >
                                            Bs.
                                        </div>
                                    </div>
                                    <div class="form-control">
                                        {{ item.precio }}
                                    </div>
                                    <div class="input-group-append">
                                        <div class="input-group-text bg-white">
                                            <input
                                                type="checkbox"
                                                class="checkboxTable form-control"
                                                v-model="item.con_saldo"
                                            />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="col-12">
                            <ul
                                v-if="form.errors?.certificado_detalles"
                                class="d-block text-danger list-unstyled"
                            >
                                <li class="parsley-required">
                                    {{ form.errors?.certificado_detalles }}
                                </li>
                            </ul>
                        </div>
                        <div class="row cancelado">
                            <div
                                class="col-6 text-right font-weight-bold d-flex justify-content-end align-items-center"
                            >
                                Cancelado
                            </div>
                            <div class="col-6">
                                <div class="input-group">
                                    <div class="input-group-prepned">
                                        <div class="input-group-text">Bs.</div>
                                    </div>
                                    <input
                                        type="number"
                                        v-model="form.cancelado"
                                        class="form-control"
                                        readonly=""
                                    />
                                </div>
                            </div>
                        </div>

                        <div class="row saldo">
                            <div
                                class="col-6 text-right font-weight-bold d-flex justify-content-end align-items-center"
                            >
                                Saldo
                            </div>
                            <div class="col-6">
                                <div class="input-group">
                                    <div class="input-group-prepned">
                                        <div class="input-group-text">Bs.</div>
                                    </div>
                                    <input
                                        type="number"
                                        v-model="form.saldo"
                                        class="form-control"
                                        readonly=""
                                    />
                                </div>
                            </div>
                        </div>
                        <div class="row total">
                            <div
                                class="col-6 text-right font-weight-bold d-flex justify-content-end align-items-center"
                            >
                                Total
                            </div>
                            <div class="col-6">
                                <div class="input-group">
                                    <div class="input-group-prepned">
                                        <div class="input-group-text">Bs.</div>
                                    </div>
                                    <input
                                        type="number"
                                        :value="total ?? '0.00'"
                                        class="form-control"
                                        readonly=""
                                    />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 text-center">
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
