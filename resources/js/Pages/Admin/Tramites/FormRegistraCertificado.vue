<script setup>
import MiModal from "@/Components/MiModal.vue";
import { useForm, usePage } from "@inertiajs/vue3";
import { watch, ref, computed, onMounted, nextTick, reactive } from "vue";
import { useCertificados } from "@/composables/certificados/useCertificados";
import { useLoginUserStore } from "@/stores/login_users/loginUserStore";
const { props: propsPage } = usePage();
const loginUserStore = useLoginUserStore();
const { oCertificado, limpiarCertificado } = useCertificados();
const props = defineProps({
    muestra_formulario: {
        type: Boolean,
        default: false,
    },
    accion_formulario: {
        type: Number,
        default: 0,
    },
    cliente_tramite: {
        type: Object,
        default: null,
    },
});

const accion_form = ref(props.accion_formulario);
const oClienteTramite = ref(props.cliente_tramite);
const oCliente = ref(null);
const muestra_form = ref(props.muestra_formulario);
const enviando = ref(false);
let form = reactive(oCertificado.value);
watch(
    () => props.muestra_formulario,
    (newValue) => {
        muestra_form.value = newValue;
        if (muestra_form.value) {
            cargarTipoCertificados();
            cargarTipoPagos();
            form = reactive(oCertificado.value);
            agregarCertificado();
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
    () => props.cliente_tramite,
    (newValue) => {
        oClienteTramite.value = newValue;
        oCliente.value = newValue.cliente;
    },
);

const tituloDialog = computed(() => {
    return accion_form.value == 0
        ? `<i class="fa fa-clipboard-alt"></i> Registrar Certificado`
        : `<i class="fa fa-edit"></i> Editar Cliente`;
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
    let url = route(
        "tramite_clientes.registrarCertificado",
        oClienteTramite.value.id,
    );

    const formData = new FormData();
    formData.append("cliente_id", oClienteTramite.value.cliente_id);
    formData.append("total", form.total);
    formData.append("cancelado", form.cancelado);
    formData.append("saldo", form.saldo);
    formData.append("tipo_pago", form.tipo_pago);
    formData.append("tipo", "TRAMITE");
    if (propsPage.auth.user.tipo == "MÉDICO") {
        formData.append("sucursal_id", loginUserStore.getLoginUser.sucursal_id);
    } else {
        formData.append("sucursal_id", propsPage.auth.user.sucursal_id);
    }

    form.certificado_detalles.forEach((elem, index) => {
        formData.append(`certificado_detalles[${index}][precio]`, elem.precio);
        formData.append(
            `certificado_detalles[${index}][tipo_certificado_id]`,
            elem.tipo_certificado_id,
        );
        formData.append(
            `certificado_detalles[${index}][archivo]`,
            elem.archivo,
        );
        // etc...
    });

    axios
        .post(url, formData, {
            headers: {
                "Content-Type": "multipart/form-data",
            },
        }) // importante usar form.data()
        .then((response) => {
            manejarExito(response);
        })
        .catch((error) => {
            manejarError(error);
        })
        .finally(() => {
            enviando.value = false;
        });
};

const manejarExito = (response) => {
    console.log("correcto");

    const success =
        response?.props?.flash?.success ??
        response?.data?.message ??
        "Proceso realizado con éxito";

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
};
const manejarError = (error) => {
    let errores = null;

    // Axios
    if (error?.response?.data?.errors) {
        errores = Object.fromEntries(
            Object.entries(error.response.data.errors).map(([key, value]) => [
                key,
                value[0],
            ]),
        );
    }

    // Inertia (ya viene plano normalmente)
    else if (typeof error === "object") {
        errores = error;
    }

    if (errores && Object.keys(errores).length > 0) {
        form.errors = errores;

        Swal.fire({
            icon: "info",
            title: "Error",
            html: `<strong>Existen errores en el formulario</strong>`,
            confirmButtonText: `Aceptar`,
            customClass: {
                confirmButton: "btn-error",
            },
        });
    }
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

const cargarArchivo = (e, key, index) => {
    form[key] = null;
    const file = e.target.files[0];
    if (file) {
        form.certificado_detalles[index][key] = file;
    }
};

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

const listTipoCertificados = ref([]);
const cargarTipoCertificados = () => {
    axios.get(route("tipo_certificados.listado")).then((response) => {
        listTipoCertificados.value = response.data.tipo_certificados;
    });
};

const nroTipoCertificadoDia = ref(0);
const detectarTipoCertificado = (value, index) => {
    if (!value) {
        return;
    }

    const item = listTipoCertificados.value.filter(
        (item) => item.id == value,
    )[0];
    if (item.id) {
        axios
            .get(route("certificado_emitidos.verificaCantidad"), {
                params: {
                    tipo_certificado_id: item.id,
                },
            })
            .then((response) => {
                nroTipoCertificadoDia.value = response.data.conteo_siguiente;
                if (nroTipoCertificadoDia.value % 10 === 0) {
                    // form.certificado_detalles[index].precio = 0;
                    // form.certificado_detalles[index].muestra_conteo = true;
                } else {
                    // form.certificado_detalles[index].muestra_conteo = false;
                    // form.certificado_detalles[index].precio = item.precio;
                }
            })
            .finally(() => {
                nroTipoCertificadoDia.value = 0;
            });
    }
};

const agregarCertificado = () => {
    form.certificado_detalles.push({
        id: 0,
        certificado_id: "",
        precio: "",
        cancelado: "",
        saldo: "",
        tipo_certificado_id: "",
        archivo: null,
        muestra_conteo: false,
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
    const total = form.certificado_detalles.reduce((total, item) => {
        const subtotal = parseFloat(
            item.precio && item.precio != 0 ? item.precio : 0,
        );
        if (subtotal !== null && subtotal !== undefined && subtotal !== "") {
            return total + Number(subtotal);
        }

        return total;
    }, 0);

    form.total = total;

    return total ? total.toFixed(2) : "0.00";
});

const recalcularSaldoTotal = () => {
    let total_costo = 0;
    form.certificado_detalles.forEach((elem) => {
        console.log(elem);
        total_costo += parseFloat(elem.precio ?? 0);
    });
    form.saldo = parseFloat(total_costo) - parseFloat(form.cancelado);
    form.saldo = form.saldo.toFixed(2);
};

const calculaSaldo = (e, index) => {
    const value = e.target.value;
    form.saldo = form.total;
    if (value.trim() != "") {
        form.saldo = parseFloat(form.total) - parseFloat(value);
        form.saldo = form.saldo.toFixed(2);
    }
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
            <form @submit.prevent="enviarFormulario()" v-if="form">
                <div class="row">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">
                                    <i class="fa fa-user"></i> Datos del
                                    Paciente
                                </h4>
                            </div>
                            <div class="card-body pt-0" v-if="oCliente">
                                <div class="row">
                                    <div class="row mt-1">
                                        <div class="col-12">
                                            <h5 class="text-md">
                                                {{ oCliente.nombre }}
                                                {{ oCliente.paterno }}
                                                {{ oCliente.materno }}
                                                <span
                                                    class="check_cliente text-success"
                                                >
                                                    <i
                                                        class="fa fa-check-circle fa-lg"
                                                    ></i>
                                                </span>
                                            </h5>
                                            <p class="mb-0 text-sm">
                                                <strong>C.I.:</strong>
                                                {{ oCliente.ci }}
                                                {{ oCliente.complemento }}
                                                {{ oCliente.ci_exp }}
                                            </p>
                                            <p class="mb-0 text-sm">
                                                <strong>F. nacimiento:</strong>
                                                {{
                                                    oCliente.fecha_nac_t ?? "-"
                                                }}
                                            </p>
                                            <p class="mb-0 text-sm">
                                                <strong>Edad:</strong>
                                                {{ oCliente.edad ?? "-" }}
                                            </p>
                                            <p class="mb-0 text-sm">
                                                <strong>Celular:</strong>
                                                {{ oCliente.cel ?? "-" }}
                                            </p>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header">
                                <h4 class="card-title">
                                    <i class="fa fa-clipboard-list"></i> Datos
                                    Certificado(s)
                                </h4>
                            </div>
                            <div class="card-body pt-0">
                                <div
                                    class="row"
                                    v-for="(
                                        certificado_detalle, index
                                    ) in form.certificado_detalles"
                                >
                                    <div
                                        class="col-12 border-bottom pt-0 pb-3 mt-2"
                                    >
                                        <button
                                            type="button"
                                            class="btn btn-sm text-xs quitar"
                                            v-if="index > 0"
                                            @click.prevent="
                                                quitarCertificado(index)
                                            "
                                        >
                                            X
                                        </button>
                                        <div class="row">
                                            <div class="col-md-12 mt-1">
                                                <label
                                                    :for="`file${index}`"
                                                    class="contenedorFile"
                                                    :class="
                                                        certificado_detalle.archivo
                                                            ? 'cargado'
                                                            : 'sinCargar'
                                                    "
                                                >
                                                    <div class="principal">
                                                        <div
                                                            class="icon icon-pdf"
                                                        >
                                                            <i
                                                                class="fa fa-file-alt"
                                                            ></i>
                                                        </div>
                                                        <div class="contInfo">
                                                            <div class="title">
                                                                Certificado
                                                            </div>
                                                            <el-tooltip
                                                                class="box-item"
                                                                effect="dark"
                                                                content="Certificado"
                                                                placement="top"
                                                            >
                                                                <div
                                                                    class="descripcion"
                                                                    v-text="
                                                                        certificado_detalle.archivo
                                                                            ? certificado_detalle
                                                                                  .archivo
                                                                                  .name
                                                                            : 'Ningún archivo seleccionado'
                                                                    "
                                                                ></div>
                                                            </el-tooltip>
                                                        </div>
                                                        <div
                                                            class="icon icon-loaded"
                                                        >
                                                            <i
                                                                class="fa"
                                                                :class="[
                                                                    certificado_detalle.archivo
                                                                        ? 'fa-check-circle'
                                                                        : 'fa-upload',
                                                                ]"
                                                            ></i>
                                                        </div>
                                                    </div>
                                                    <input
                                                        type="file"
                                                        :name="`file${index}`"
                                                        :id="`file${index}`"
                                                        @change="
                                                            cargarArchivo(
                                                                $event,
                                                                'archivo',
                                                                index,
                                                            )
                                                        "
                                                    />
                                                </label>
                                            </div>
                                            <div class="col-md-6 mt-1">
                                                <label class=""
                                                    >Tipo de Certificado</label
                                                >
                                                <el-select
                                                    v-model="
                                                        certificado_detalle.tipo_certificado_id
                                                    "
                                                    placeholder="- Seleccione -"
                                                    no-data-text="Sin datos"
                                                    no-match-text="No se entrarón coincidencias"
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
                                            <div class="col-md-6 mt-1">
                                                <label class=""
                                                    >Costo Bs.</label
                                                >
                                                <el-input
                                                    type="text"
                                                    v-model="
                                                        certificado_detalle.precio
                                                    "
                                                    @keyup="
                                                        recalcularSaldoTotal
                                                    "
                                                    @change="
                                                        recalcularSaldoTotal
                                                    "
                                                    autosize
                                                ></el-input>
                                                <small
                                                    class="text-xs text-success"
                                                    v-if="
                                                        certificado_detalle.muestra_conteo
                                                    "
                                                    >(Certificado
                                                    gratuito)</small
                                                >
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-12">
                                        <ul
                                            v-if="
                                                form.errors
                                                    ?.certificado_detalles
                                            "
                                            class="d-block text-danger list-unstyled"
                                        >
                                            <li class="parsley-required">
                                                {{
                                                    form.errors
                                                        ?.certificado_detalles
                                                }}
                                            </li>
                                        </ul>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-12 p-0 mt-2">
                                        <button
                                            type="button"
                                            class="btn w-100 btn-agregar btn-sm text-sm"
                                            @click.prevent="
                                                agregarCertificado()
                                            "
                                        >
                                            <i class="fa fa-plus"></i> Agregar
                                        </button>
                                    </div>
                                </div>

                                <div class="row border-top mt-3">
                                    <div class="col-12 text-center mt-2">
                                        <label class="">Total Bs.</label>
                                        <input
                                            type="number"
                                            class="form-control text-center"
                                            :value="total ?? '0.00'"
                                            readonly=""
                                        />
                                        <ul
                                            v-if="form.errors?.total"
                                            class="d-block text-danger list-unstyled"
                                        >
                                            <li class="parsley-required">
                                                {{ form.errors?.total }}
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="col-12 mt-2 text-center">
                                        <label class="">Cancelado Bs.</label>
                                        <input
                                            type="number"
                                            class="form-control text-center"
                                            v-model="form.cancelado"
                                            @keyup="calculaSaldo($event, index)"
                                        />
                                        <ul
                                            v-if="form.errors?.cancelado"
                                            class="d-block text-danger list-unstyled"
                                        >
                                            <li class="parsley-required">
                                                {{ form.errors?.cancelado }}
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="col-12 mt-2 text-center">
                                        <label class="">Saldo Bs.</label>
                                        <input
                                            type="number"
                                            class="form-control text-center"
                                            v-model="form.saldo"
                                            readonly=""
                                        />
                                        <ul
                                            v-if="form.errors?.saldo"
                                            class="d-block text-danger list-unstyled"
                                        >
                                            <li class="parsley-required">
                                                {{ form.errors?.saldo }}
                                            </li>
                                        </ul>
                                    </div>
                                    <div class="col-12 text-center">
                                        <label class="">Tipo de Pago </label>
                                        <el-radio-group
                                            v-model="form.tipo_pago"
                                        >
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
                        </div>
                        <div class="row">
                            <div
                                class="col-md-12"
                                v-if="oCliente && form.cliente_id"
                            >
                                <button
                                    type="button"
                                    class="btn btn-primary w-100"
                                    :disabled="enviando"
                                    @click.prevent="enviarFormulario"
                                    v-html="textBtn"
                                ></button>
                            </div>
                        </div>
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
