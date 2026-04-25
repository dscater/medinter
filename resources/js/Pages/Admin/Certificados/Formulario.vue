<script setup>
import { useForm, usePage } from "@inertiajs/vue3";
import { watch, ref, computed, onMounted, nextTick, onBeforeMount } from "vue";
import { useClientes } from "@/composables/clientes/useClientes";
import Formulario from "../Clientes/Formulario.vue";
import { useLoginUserStore } from "@/stores/login_users/loginUserStore";
import axios from "axios";
import { useVerificaCertificados } from "@/composables/certificados/useVerificaPendientes";
const { props: propsPage } = usePage();
const loginUserStore = useLoginUserStore();
const { verificarPendiente } = useVerificaCertificados();
const props = defineProps({
    form: {
        type: Object,
    },
    cliente: {
        type: Object,
        default: { id: 0, ci: "" },
    },
    setCertificado: Function,
    limpiarCertificado: {
        type: Function,
        default: null,
    },
});

const enviando = ref(false);
const certificadoPendiente = ref(null);
const form = props.form;
const setCertificado = props.setCertificado;
const limpiarCertificado = props.limpiarCertificado;
const textBtn = computed(() => {
    if (enviando.value) {
        return `<i class="fa fa-spin fa-spinner"></i> Enviando...`;
    }
    if (form.id == 0) {
        return `<i class="fa fa-save"></i> Registrar Certificado`;
    }
    if (form.estado == 0) {
        return `<i class="fa fa-save"></i> Registrar Certificado`;
    }
    return `<i class="fa fa-edit"></i> Actualizar Certificado`;
});

const enviarFormulario = () => {
    enviando.value = true;
    let url =
        form.id == 0
            ? route("certificados.store")
            : route("certificados.update", form.id);

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

const emits = defineEmits(["envio-formulario"]);

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

const listTramitadors = ref([]);
const cargarTramitadors = () => {
    axios.get(route("tramitadors.listado")).then((response) => {
        listTramitadors.value = response.data.tramitadors;
    });
};

const cargarArchivo = (e, key, index) => {
    form[key] = null;
    const file = e.target.files[0];
    if (file) {
        form.certificado_detalles[index][key] = file;
        form.certificado_detalles[index]["name"] = file.name;
    }
};

const listClientes = ref([]);
const oCliente = ref(null);
const clienteSeleccionado = ref(false);
const txtCi = ref("");
const buscandoCliente = ref(false);
const intervalBusquedaCliente = ref(null);
const detectarBusquedaCliente = () => {
    buscandoCliente.value = true;
    clearInterval(intervalBusquedaCliente.value);
    intervalBusquedaCliente.value = setTimeout(() => {
        buscarClienteByCi();
    }, 270);
};
const buscarClienteByCi = () => {
    buscandoCliente.value = true;
    axios
        .get(route("clientes.byCi"), {
            params: {
                ci: txtCi.value,
            },
        })
        .then((response) => {
            listClientes.value = response.data;
        })
        .finally(() => {
            buscandoCliente.value = false;
        });
};

const { setCliente, limpiarCliente, form: FormCliente } = useClientes();
const muestra_form_cliente = ref(false);

const agregarCliente = () => {
    limpiarCliente();
    muestra_form_cliente.value = true;
};

const cierraFormularioCliente = () => {
    muestra_form_cliente.value = false;
};

const clienteAgregado = (cliente) => {
    oCliente.value = cliente;
    clienteSeleccionado.value = true;
    form.cliente_id = oCliente.value.id;
    listClientes.value = [];
    listClientes.value.push(cliente);
    muestra_form_cliente.value = false;
    // buscar certificado pendiente
    buscaPendienteCliente(oCliente.value);
};

const seleccionaCliente = (cliente) => {
    buscandoPendiente.value = true;
    certificadoPendiente.value = null;
    oCliente.value = cliente;
    // buscar certificado pendiente
    buscaPendienteCliente(cliente);
};

const buscandoPendiente = ref(false);
const buscaPendienteCliente = async (cliente) => {
    const pendiente = await verificarPendiente(cliente.id);

    if (pendiente) {
        certificadoPendiente.value = pendiente;
        setCertificado(pendiente);
    }

    if (pendiente || form.id == 0) {
        iniciarFechaHoraInicio();
    } else {
        fechaHoraTexto.value = form.fecha_inicio_t + " " + form.hora_inicio;
    }
    form.cliente_id = cliente.id;
    clienteSeleccionado.value = true;
    buscandoPendiente.value = false;
};
const quitarSeleccionCliente = () => {
    clienteSeleccionado.value = false;
    oCliente.value = null;
    certificadoPendiente.value = null;
    if (limpiarCertificado) {
        limpiarCertificado();
        form.fecha_inicio = "";
        form.hora_inicio = "";
        fechaHoraTexto.value = "";
        agregarCertificado();
    }
};

const nroTipoCertificadoDia = ref(0);
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

const detalleBase = {
    id: 0,
    certificado_id: "",
    categoria: "",
    precio: 0,
    cancelado: 0,
    saldo: 0,
    tipo_certificado_id: "",
    archivo: null,
    con_saldo: false,
};

const agregarCertificado = () => {
    form.certificado_detalles.push({ ...detalleBase });
};

const quitarCertificado = (index) => {
    const item = form.certificado_detalles[index];
    if (item.id != 0) {
        form.eliminados.push(item.id);
    }
    form.certificado_detalles.splice(index, 1);
};

const total = computed(() => {
    if (!form?.certificado_detalles) return 0;
    return form.certificado_detalles.reduce((acc, item) => {
        return acc + parseFloat(item.precio || 0);
    }, 0);
});

const cancelado = computed(() => {
    if (!form?.certificado_detalles) return 0;
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

const fechaHoraTexto = ref("");
const iniciarFechaHoraInicio = () => {
    const now = new Date();

    const pad = (n) => n.toString().padStart(2, "0");

    // Formato para guardar
    form.fecha_inicio = `${now.getFullYear()}-${pad(now.getMonth() + 1)}-${pad(now.getDate())}`;
    form.hora_inicio = `${pad(now.getHours())}:${pad(now.getMinutes())}:${pad(now.getSeconds())}`;

    // Formato para mostrar
    fechaHoraTexto.value = `${pad(now.getDate())}/${pad(now.getMonth() + 1)}/${now.getFullYear()} ${pad(now.getHours())}:${pad(now.getMinutes())}:${pad(now.getSeconds())}`;
};
onMounted(() => {
    if (form.id != 0) {
        txtCi.value = props.cliente.ci;
        buscarClienteByCi();
        seleccionaCliente(props.cliente);
    } else {
        agregarCertificado();
    }
});

onBeforeMount(() => {
    cargarTipoCertificados();
    cargarTipoPagos();
    cargarTramitadors();
});
</script>

<template>
    <form @submit.prevent="enviarFormulario()">
        <div class="row" v-if="form">
            <div class="col-md-5">
                <div class="row">
                    <div class="col-12 my-2">
                        <h4 class="card-title w-100 text-center">
                            <i class="fa fa-user"></i> Datos del Paciente
                        </h4>
                    </div>
                    <div class="col-12">
                        <div class="card">
                            <div class="card-body pt-3">
                                <div class="row">
                                    <div
                                        class="col-md-12 mt-2"
                                        v-if="form.id == 0"
                                    >
                                        <label class=""
                                            >Ingresar Nro. C.I.</label
                                        >
                                        <input
                                            type="search"
                                            class="form-control"
                                            @search="listClientes = []"
                                            v-model="txtCi"
                                            @keyup.prevent="
                                                detectarBusquedaCliente()
                                            "
                                        />
                                        <ul
                                            v-if="form.errors?.cliente_id"
                                            class="d-block text-danger list-unstyled"
                                        >
                                            <li class="parsley-required">
                                                {{ form.errors?.cliente_id }}
                                            </li>
                                        </ul>
                                    </div>
                                    <div
                                        class="col-12 text-center text-lg"
                                        v-if="buscandoCliente"
                                    >
                                        Buscando...
                                    </div>
                                    <div
                                        class="col-12 mt-2"
                                        v-if="
                                            listClientes.length > 0 &&
                                            !clienteSeleccionado
                                        "
                                    >
                                        <div class="row">
                                            <div
                                                class="col-12 text-center text-sm"
                                            >
                                                {{ listClientes.length }}
                                                resultado(s) encontrado(s)
                                            </div>
                                            <div
                                                class="col-12 cliente_listado"
                                                v-for="item in listClientes"
                                                @click="seleccionaCliente(item)"
                                            >
                                                <div
                                                    class="callout callout-info"
                                                >
                                                    <h5
                                                        class="text-md font-weight-bold"
                                                    >
                                                        {{ item.nombre }}
                                                        {{ item.paterno }}
                                                        {{ item.materno }}
                                                    </h5>
                                                    <p class="text-sm">
                                                        {{ item.full_ci }}
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div
                                        class="col-12 text-center"
                                        v-if="
                                            listClientes.length == 0 &&
                                            txtCi.trim() != '' &&
                                            !buscandoCliente
                                        "
                                    >
                                        <span class="h6"
                                            >Sin resultados...</span
                                        >
                                    </div>
                                    <div
                                        class="col-12"
                                        v-if="
                                            txtCi.trim() != '' &&
                                            !clienteSeleccionado
                                        "
                                    >
                                        <button
                                            type="button"
                                            class="btn btn-outline-info w-100 text-sm btn-sm"
                                            @click.prevent="agregarCliente"
                                        >
                                            <i class="fa fa-plus"></i> Agregar
                                            Nuevo Cliente
                                        </button>
                                        <Formulario
                                            v-if="muestra_form_cliente"
                                            :muestra_formulario="
                                                muestra_form_cliente
                                            "
                                            :ci="txtCi"
                                            :metodo="'axios'"
                                            :form="FormCliente"
                                            @cerrar-formulario="
                                                cierraFormularioCliente()
                                            "
                                            @envio-formulario="clienteAgregado"
                                        ></Formulario>
                                    </div>
                                    <div
                                        class="col-12"
                                        v-if="clienteSeleccionado"
                                    >
                                        <div class="row mt-1">
                                            <div class="col-12">
                                                <div
                                                    class="card mb-0 border-success"
                                                >
                                                    <div class="card-body pb-3">
                                                        <h5 class="text-md">
                                                            {{
                                                                oCliente.nombre
                                                            }}
                                                            {{
                                                                oCliente.paterno
                                                            }}
                                                            {{
                                                                oCliente.materno
                                                            }}
                                                            <span
                                                                class="check_cliente text-success"
                                                            >
                                                                <i
                                                                    class="fa fa-check-circle fa-lg"
                                                                ></i>
                                                            </span>
                                                        </h5>
                                                        <p class="mb-0 text-sm">
                                                            <strong
                                                                >C.I.:</strong
                                                            >
                                                            {{ oCliente.ci }}
                                                            {{
                                                                oCliente.complemento
                                                            }}
                                                            {{
                                                                oCliente.ci_exp
                                                            }}
                                                        </p>
                                                        <p class="mb-0 text-sm">
                                                            <strong
                                                                >F.
                                                                nacimiento:</strong
                                                            >
                                                            {{
                                                                oCliente.fecha_nac_t ??
                                                                "-"
                                                            }}
                                                        </p>
                                                        <p class="mb-0 text-sm">
                                                            <strong
                                                                >Edad:</strong
                                                            >
                                                            {{
                                                                oCliente.edad ??
                                                                "-"
                                                            }}
                                                        </p>
                                                        <p class="mb-0 text-sm">
                                                            <strong
                                                                >Celular:</strong
                                                            >
                                                            {{
                                                                oCliente.cel ??
                                                                "-"
                                                            }}
                                                        </p>
                                                        <button
                                                            v-if="
                                                                route().current() ==
                                                                'certificados.create'
                                                            "
                                                            type="button"
                                                            class="mt-2 btn btn-outline-danger btn-xs w-100 text-sm"
                                                            @click.prevent="
                                                                quitarSeleccionCliente
                                                            "
                                                        >
                                                            <i
                                                                class="fa fa-times"
                                                            ></i>
                                                            Reiniciar Selección
                                                        </button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12 my-2">
                        <h4 class="card-title w-100 text-center">
                            <i class="fa fa-list"></i> Información del trámite
                        </h4>
                    </div>
                    <div class="col-12">
                        <div class="card card-body">
                            <div class="row">
                                <div class="col-12">
                                    <p class="mb-0 text-sm">
                                        <strong>Inicio:</strong>
                                        {{ fechaHoraTexto }}
                                    </p>
                                </div>
                                <div class="col-md-6 mt-2">
                                    <label>Tipo trámite</label>
                                    <el-radio-group
                                        v-model="form.tipo"
                                        :disabled="form.id != 0"
                                    >
                                        <el-radio value="NORMAL"
                                            >NORMAL</el-radio
                                        >
                                        <el-radio value="TRAMITE"
                                            >TRAMITE</el-radio
                                        >
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
                                    class="col-md-6 mt-2"
                                    v-if="form.tipo == 'TRAMITE'"
                                >
                                    <label>Tramitador</label>
                                    <el-select
                                        v-model="form.tramitador_id"
                                        placeholder="- Seleccione -"
                                        filterable
                                        no-data-text="Sin datos"
                                        no-match-text="Sin resultados"
                                        :disabled="form.id != 0"
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
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-7">
                <div class="row">
                    <div class="col-12 my-2">
                        <h4 class="card-title w-100 text-center">
                            <i class="fa fa-clipboard-list"></i>
                            Certificado(s)
                            <template v-if="oCliente">
                                <span
                                    v-if="form.estado == 0"
                                    class="text-sm float-right"
                                    :class="{
                                        'text-precargado': certificadoPendiente,
                                        'text-primary': !certificadoPendiente,
                                    }"
                                >
                                    <i class="fa fa-circle"></i>
                                    {{
                                        certificadoPendiente
                                            ? "Pendiente"
                                            : "Nuevo"
                                    }}
                                </span>
                                <span
                                    v-if="form.estado == 1"
                                    class="text-sm float-right text-nuevo"
                                >
                                    <i class="fa fa-circle"></i>
                                    Registrado
                                </span>
                            </template>
                        </h4>
                    </div>
                    <div class="col-12 contenedor_certificados">
                        <div
                            class="loading_certificados"
                            v-if="buscandoPendiente"
                        >
                            <i class="fa fa-spin fa-spinner"></i>
                        </div>
                        <div
                            class="card mb-2"
                            :class="{
                                'card-outline card-success': form.estado == 1,
                                'card-outline card-primary':
                                    form.estado == 0 && !certificadoPendiente,
                                'card-outline card-warning':
                                    form.estado == 0 && certificadoPendiente,
                            }"
                            v-for="(
                                certificado_detalle, index
                            ) in form.certificado_detalles"
                            :key="index"
                        >
                            <div class="card-body pt-0 pb-2">
                                <button
                                    type="button"
                                    class="btn btn-sm text-xs quitar"
                                    v-if="index > 0 && !certificadoPendiente"
                                    @click.prevent="quitarCertificado(index)"
                                >
                                    X
                                </button>
                                <div class="row pb-1">
                                    <div class="col-12 pt-0mt-2 mb-0">
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
                                                                            ? certificado_detalle.name
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
                                                            <a
                                                                v-if="
                                                                    form.estado ==
                                                                        1 &&
                                                                    certificado_detalle.url_archivo
                                                                "
                                                                :href="
                                                                    certificado_detalle.url_archivo
                                                                "
                                                                target="_blank"
                                                            >
                                                                <i
                                                                    class="fa fa-download text-info"
                                                                ></i>
                                                            </a>
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
                                                    >Certificado</label
                                                >
                                                <el-select
                                                    v-model="
                                                        certificado_detalle.tipo_certificado_id
                                                    "
                                                    size="large"
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
                                                    :disabled="
                                                        certificado_detalle.pago &&
                                                        certificado_detalle.pago
                                                            .verificado == 1 &&
                                                        propsPage.auth?.user
                                                            .tipo == 'MÉDICO'
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
                                                <label>Costo Bs.</label>
                                                <div class="input-group">
                                                    <input
                                                        type="number"
                                                        step="0.1"
                                                        :id="`item${index}`"
                                                        class="form-control"
                                                        v-model="
                                                            certificado_detalle.precio
                                                        "
                                                        :disabled="
                                                            certificado_detalle.pago &&
                                                            certificado_detalle
                                                                .pago
                                                                .verificado ==
                                                                1 &&
                                                            propsPage.auth?.user
                                                                .tipo ==
                                                                'MÉDICO'
                                                        "
                                                    />
                                                    <div
                                                        class="input-group-append"
                                                    >
                                                        <div
                                                            class="input-group-text bg-white"
                                                        >
                                                            <input
                                                                type="checkbox"
                                                                class="checkboxTable form-control"
                                                                v-model="
                                                                    certificado_detalle.con_saldo
                                                                "
                                                                :disabled="
                                                                    certificado_detalle.pago &&
                                                                    certificado_detalle
                                                                        .pago
                                                                        .verificado ==
                                                                        1 &&
                                                                    propsPage
                                                                        .auth
                                                                        ?.user
                                                                        .tipo ==
                                                                        'MÉDICO'
                                                                "
                                                            />
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-6 mt-1">
                                                <label class=""
                                                    >Categoría</label
                                                >
                                                <el-input
                                                    type="text"
                                                    v-model="
                                                        certificado_detalle.categoria
                                                    "
                                                    autosize
                                                ></el-input>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="row">
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
                        </div>
                        <button
                            v-if="form.id == 0 && !certificadoPendiente"
                            type="button"
                            class="btn w-100 btn-agregar btn-sm text-sm mb-2"
                            @click.prevent="agregarCertificado()"
                        >
                            <i class="fa fa-plus"></i> Agregar
                        </button>
                        <div class="card">
                            <div class="card-body pb-0">
                                <div class="row">
                                    <div
                                        class="col-12 text-center cliente-pago"
                                    >
                                        <div class="row cancelado">
                                            <div
                                                class="col-5 text-right border-0 font-weight-bold"
                                            >
                                                Cancelado Bs.
                                            </div>
                                            <div class="col-7">
                                                <input
                                                    type="number"
                                                    class="form-control text-center"
                                                    :value="
                                                        form.cancelado ?? '0.00'
                                                    "
                                                    readonly=""
                                                />
                                            </div>
                                        </div>
                                        <div class="row saldo">
                                            <div
                                                class="col-5 text-right border-0 font-weight-bold"
                                            >
                                                Saldo Bs.
                                            </div>
                                            <div class="col-7">
                                                <input
                                                    type="number"
                                                    class="form-control text-center"
                                                    :value="
                                                        form.saldo ?? '0.00'
                                                    "
                                                    readonly=""
                                                />
                                            </div>
                                        </div>
                                        <div class="row total">
                                            <div
                                                class="col-5 text-right border-0 font-weight-bold"
                                            >
                                                Total Bs.
                                            </div>
                                            <div class="col-7">
                                                <input
                                                    type="number"
                                                    class="form-control text-center"
                                                    v-model="form.total"
                                                    readonly=""
                                                />
                                            </div>
                                        </div>
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
                                        <el-radio-group
                                            v-model="form.tipo_pago"
                                            :disabled="
                                                form.id != 0 &&
                                                propsPage.auth?.user.tipo ==
                                                    'MÉDICO'
                                            "
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
                    </div>
                </div>
                <div class="row mb-3">
                    <div
                        class="col-12 text-center"
                        v-if="!oCliente || !form.cliente_id"
                    >
                        <span class="font-weight-bold h5 text-danger"
                            >Debes seleccionar un Cliente</span
                        >
                    </div>
                    <div class="col-md-12" v-if="oCliente && form.cliente_id">
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
<style scoped>
.contenedor_certificados {
    position: relative;
}
.loading_certificados {
    position: absolute;
    top: 0;
    left: 0;
    height: 100%;
    width: 100%;
    background-color: rgba(255, 255, 255, 0.6);
    z-index: 2;
    display: flex;
    justify-content: center;
    align-items: center;
    font-size: 2em;
}

.loading_certificados::before {
    content: "";
    position: absolute;
    top: 0;
    left: 0;
    height: 100%;
    width: 100%;
    background-color: rgba(253, 253, 253, 0.808);
    filter: blur(10px);
}
</style>
