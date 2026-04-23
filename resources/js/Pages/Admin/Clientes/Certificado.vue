<script setup>
import MiModal from "@/Components/MiModal.vue";
import { Form, useForm, usePage } from "@inertiajs/vue3";
import { useClientes } from "@/composables/clientes/useClientes";
import { watch, ref, computed, onMounted, nextTick } from "vue";
const props = defineProps({
    muestra_formulario: {
        type: Boolean,
        default: false,
    },
    accion_formulario: {
        type: Number,
        default: 0,
    },
    metodo: {
        type: String,
        default: "inertia",
    },
    ci: {
        type: String,
        default: "",
    },
});

const { oCliente, limpiarCliente } = useClientes();
const accion_form = ref(props.accion_formulario);
const muestra_form = ref(props.muestra_formulario);
const enviando = ref(false);
const form = useForm(oCliente.value);
watch(
    () => props.muestra_formulario,
    (newValue) => {
        muestra_form.value = newValue;
        if (muestra_form.value) {
            form.clearErrors();
            document
                .getElementsByTagName("body")[0]
                .classList.add("modal-open");

            form.id = oCliente.value.id;
            form.nombre = oCliente.value.nombre;
            form.paterno = oCliente.value.paterno;
            form.materno = oCliente.value.materno;
            form.ci = oCliente.value.ci;
            form.ci_exp = oCliente.value.ci_exp;
            form.complemento = oCliente.value.complemento;
            form.fecha_nac = oCliente.value.fecha_nac;
            form.edad = oCliente.value.edad;
            form.cel = oCliente.value.cel;
            form.respuesta = oCliente.value.respuesta;
            form._method = oCliente.value._method;

            // PAGO
            form.con_certificado = oCliente.value.con_certificado;
            form.tipo = oCliente.value.tipo;
            form.tramitador_id = oCliente.value.tramitador_id;
            form.certificado_detalles = oCliente.value.certificado_detalles;
            form.total = oCliente.value.total;
            form.cancelado = oCliente.value.cancelado;
            form.saldo = oCliente.value.saldo;
            cargarListas();
            agregarCertificado();
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
    () => props.ci,
    (newValue) => {
        form["ci"] = newValue;
    },
);

const { flash } = usePage().props;

function cargaArchivo(e, key) {
    form[key] = null;
    form[key] = e.target.files[0];
}

const tituloDialog = computed(() => {
    return accion_form.value == 0
        ? `<i class="fa fa-plus"></i> Nuevo Cliente`
        : `<i class="fa fa-clipboard-list"></i> Iniciar Certificado`;
});

const textBtn = computed(() => {
    if (enviando.value) {
        return `<i class="fa fa-spin fa-spinner"></i> Enviando...`;
    }
    if (accion_form.value == 0) {
        return `<i class="fa fa-save"></i> Guardar`;
    }
    return `<i class="fa fa-save"></i> Registrar Certificado`;
});

const enviarFormulario = () => {
    enviando.value = true;
    form._method = "POST";
    let url = route("certificados.registroCliente", form.id);
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
            form.reset();
            limpiarCliente();
            document
                .getElementsByTagName("body")[0]
                .classList.remove("modal-open");
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

const listExpedido = [
    { value: "LP", label: "La Paz" },
    { value: "CB", label: "Cochabamba" },
    { value: "SC", label: "Santa Cruz" },
    { value: "CH", label: "Chuquisaca" },
    { value: "OR", label: "Oruro" },
    { value: "PT", label: "Potosi" },
    { value: "TJ", label: "Tarija" },
    { value: "PD", label: "Pando" },
    { value: "BN", label: "Beni" },
];

const emits = defineEmits(["cerrar-formulario", "envio-formulario"]);

watch(muestra_form, (newVal) => {
    if (!newVal) {
        emits("cerrar-formulario");
    }
});

const archivo = ref(null);
const cargarArchivo = (e, key) => {
    form[key] = null;
    const file = e.target.files[0];
    if (file) {
        form[key] = e.target.files[0];
    }
};

const cerrarFormulario = () => {
    muestra_form.value = false;
    document.getElementsByTagName("body")[0].classList.remove("modal-open");
};

const calcularEdad = () => {
    if (!form.fecha_nac) return null;

    const hoy = new Date();
    const fecha = new Date(form.fecha_nac);

    let edad = hoy.getFullYear() - fecha.getFullYear();

    const mesActual = hoy.getMonth();
    const mesNacimiento = fecha.getMonth();

    // Ajustar si aún no cumplió años este año
    if (
        mesActual < mesNacimiento ||
        (mesActual === mesNacimiento && hoy.getDate() < fecha.getDate())
    ) {
        edad--;
    }
    form.edad = edad;
};

const listTramitadors = ref([]);
const cargarTramitadors = () => {
    axios.get(route("tramitadors.listado")).then((response) => {
        listTramitadors.value = response.data.tramitadors;
    });
};

const listTipoCertificados = ref([]);
const cargarTipoCertificados = () => {
    axios.get(route("tipo_certificados.listado")).then((response) => {
        listTipoCertificados.value = response.data.tipo_certificados;
    });
};

const listTipoPagos = ref([]);
const cargarTipoPagos = () => {
    axios.get(route("tipo_pagos.listado")).then((response) => {
        listTipoPagos.value = response.data;
    });
};

const detectarTipoCertificado = (value, index) => {
    form.certificado_detalles[index].precio = "";
    if (!value) {
        return;
    }
    const item = listTipoCertificados.value.filter(
        (item) => item.id == value,
    )[0];
    if (!item) return;
    form.certificado_detalles[index].tipo_certificado = item;
    form.certificado_detalles[index].precio = item.precio;
    form.certificado_detalles[index].saldo = item.precio;
    form.certificado_detalles[index].cancelado = 0;
    form.certificado_detalles[index].con_saldo = false;
};

const agregarCertificado = () => {
    form.certificado_detalles.push({
        id: 0,
        certificado_id: "",
        categoria: "",
        precio: "",
        cancelado: "",
        saldo: "",
        tipo_certificado_id: "",
        archivo: null,
        con_saldo: false,
        tipo_certificado: null,
    });
};

const quitarCertificado = (index) => {
    const item = form.certificado_detalles[index];
    if (item.id != 0) {
        form.eliminados.push(item.id);
    }
    form.certificado_detalles.splice(index, 1);
};
const total = computed(() => {
    return form.certificado_detalles.reduce((acc, item) => {
        return acc + parseFloat(item.precio || 0);
    }, 0);
});

const cancelado = computed(() => {
    return form.certificado_detalles.reduce((acc, item) => {
        return item.con_saldo ? acc + parseFloat(item.precio || 0) : acc;
    }, 0);
});

const saldo = computed(() => {
    return total.value - cancelado.value;
});

watch([total, cancelado, saldo], () => {
    form.total = total.value.toFixed(2);
    form.cancelado = cancelado.value.toFixed(2);
    form.saldo = saldo.value.toFixed(2);
});

const cargarListas = () => {
    cargarTramitadors();
    cargarTipoCertificados();
    cargarTipoPagos();
};

onMounted(() => {});
</script>

<template>
    <MiModal
        :open_modal="muestra_form"
        @close="cerrarFormulario"
        :size="'modal-xl'"
        :header-class="'bg-principal'"
        :body-class="'pt-1'"
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
                <p class="text-muted text-xs mb-0">
                    Todos los campos con
                    <span class="text-danger">(*)</span> son obligatorios.
                </p>
                <div class="row mt-2">
                    <div class="col-12">
                        <h4 class="card-title text-md">
                            <i class="fa fa-id-card"></i> Datos cliente
                        </h4>
                    </div>
                    <div class="col-md-12 mt-2">
                        <h4 class="card-title">
                            {{ form.nombre }} {{ form.paterno }}
                        </h4>
                    </div>
                    <div class="col-md-12 mt-2">
                        <div class="text-md">
                            {{ form.ci }} {{ form.complemento }}
                            {{ form.ci_exp }}
                        </div>
                    </div>
                </div>
                <template v-if="form.id != 0">
                    <div class="row border-top mt-3 pt-2">
                        <div class="col-12">
                            <h4 class="card-title text-md">
                                <i class="fa fa-list"></i> Información del
                                trámite
                            </h4>
                        </div>
                        <div class="col-md-4 mt-2" v-if="form.con_certificado">
                            <label class="required">Tipo</label>
                            <el-radio-group v-model="form.tipo">
                                <el-radio value="NORMAL">NORMAL</el-radio>
                                <el-radio value="TRAMITE">TRAMITE</el-radio>
                            </el-radio-group>
                            <ul
                                v-if="form.errors?.tipo"
                                class="d-block text-danger list-unstyled"
                            >
                                <li class="parsley-required">
                                    {{ form.errors?.tipo }}
                                </li>
                            </ul>
                        </div>
                        <div
                            class="col-md-4 mt-2"
                            v-if="
                                form.tipo == 'TRAMITE' && form.con_certificado
                            "
                        >
                            <label class="required">Tramitador</label>
                            <el-select
                                v-model="form.tramitador_id"
                                placeholder="- Seleccione -"
                                filterable
                                no-data-text="Sin datos"
                                no-match-text="Sin resultados"
                            >
                                <el-option
                                    v-for="item in listTramitadors"
                                    :key="item.id"
                                    :value="item.id"
                                    :label="item.nombre"
                                ></el-option>
                            </el-select>
                            <ul
                                v-if="form.errors?.tramitador_id"
                                class="d-block text-danger list-unstyled"
                            >
                                <li class="parsley-required">
                                    {{ form.errors?.tramitador_id }}
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div
                        class="row border-top mt-3 pt-2"
                        v-if="form.con_certificado"
                    >
                        <div class="col-12">
                            <h4 class="card-title text-md">
                                <i class="fa fa-clipboard-list"></i>
                                Certificado(s) y Pago
                            </h4>
                            <button
                                type="button"
                                class="btn w-100 btn-agregar btn-xs text-xs"
                                @click.prevent="agregarCertificado()"
                            >
                                <i class="fa fa-plus"></i> Agregar
                            </button>
                        </div>
                        <div class="col-12 mt-1 cliente-pago">
                            <div
                                class="row fila_cliente_cetificado"
                                v-for="(
                                    item, index
                                ) in form.certificado_detalles"
                            >
                                <div class="col-6">
                                    <div class="input-group">
                                        <div class="input-group-append">
                                            <button
                                                type="button"
                                                class="btn btn-danger"
                                                v-if="index > 0"
                                                @click="
                                                    quitarCertificado(index)
                                                "
                                            >
                                                <i class="fa fa-times"></i>
                                            </button>
                                            <span
                                                class="input-group-text"
                                                v-else
                                            >
                                                <i
                                                    class="fa fa-times text-muted"
                                                ></i
                                            ></span>
                                        </div>
                                        <div class="form-control border-0 p-0">
                                            <el-select
                                                v-model="
                                                    item.tipo_certificado_id
                                                "
                                                class="el-select-input-group-right"
                                                placeholder="- Seleccione -"
                                                no-data-text="Sin datos"
                                                no-match-text="No se entrarón coincidencias"
                                                size="small"
                                                filterable
                                                @change="
                                                    detectarTipoCertificado(
                                                        $event,
                                                        index,
                                                    )
                                                "
                                            >
                                                <el-option
                                                    v-for="item in listTipoCertificados"
                                                    :key="item.id"
                                                    :value="item.id"
                                                    :label="item.nombre"
                                                ></el-option>
                                            </el-select>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-6">
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <div class="input-group-text">
                                                Bs.
                                            </div>
                                        </div>
                                        <input
                                            type="number"
                                            step="0.1"
                                            :id="`item${index}`"
                                            class="form-control"
                                            v-model="item.precio"
                                        />
                                        <div class="input-group-append">
                                            <div
                                                class="input-group-text bg-white"
                                            >
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
                            <div class="col-12 mt-2 text-center">
                                <div class="row cancelado">
                                    <div
                                        class="col-6 text-right font-weight-bold d-flex justify-content-end align-items-center"
                                    >
                                        Cancelado
                                    </div>
                                    <div class="col-6">
                                        <div class="input-group">
                                            <div class="input-group-prepned">
                                                <div class="input-group-text">
                                                    Bs.
                                                </div>
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
                                                <div class="input-group-text">
                                                    Bs.
                                                </div>
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
                                                <div class="input-group-text">
                                                    Bs.
                                                </div>
                                            </div>
                                            <input
                                                type="number"
                                                v-model="form.total"
                                                class="form-control"
                                                readonly=""
                                            />
                                        </div>
                                    </div>
                                </div>

                                <ul
                                    v-if="form.errors?.cancelado"
                                    class="d-block text-danger list-unstyled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.cancelado }}
                                    </li>
                                </ul>
                                <ul
                                    v-if="form.errors?.saldo"
                                    class="d-block text-danger list-unstyled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.saldo }}
                                    </li>
                                </ul>
                                <ul
                                    v-if="form.errors?.total"
                                    class="d-block text-danger list-unstyled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.total }}
                                    </li>
                                </ul>
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
                    </div>
                </template>
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
