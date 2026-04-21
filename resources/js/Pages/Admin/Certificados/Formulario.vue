<script setup>
import { useForm, usePage } from "@inertiajs/vue3";
import { useCertificados } from "@/composables/certificados/useCertificados";
import { watch, ref, computed, onMounted, nextTick, onBeforeMount } from "vue";
import Formulario from "../Clientes/Formulario.vue";
import { useLoginUserStore } from "@/stores/login_users/loginUserStore";
import axios from "axios";
const { props: propsPage } = usePage();
const loginUserStore = useLoginUserStore();
const props = defineProps({
    certificado: {
        type: Object,
        default: { id: 0, errors: null },
    },
    cliente: {
        type: Object,
        default: { id: 0, ci: "" },
    },
});

const { oCertificado, limpiarCertificado } = useCertificados();
const enviando = ref(false);
const certificadoPendiente = ref(null);
const form = useForm(props.certificado);
watch(
    () => props.certificado,
    (newValue) => {
        asignaDatosFormulario(newValue);
    },
);

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

const asignaDatosFormulario = (item) => {
    console.log("TRAMITADOR", item.tramitador_id);
    form.id = item.id;
    form.cliente_id = item.cliente_id;
    form.total = item.total;
    form.cancelado = item.cancelado;
    form.saldo = item.saldo;
    form.tipo_pago = item.tipo_pago;
    form.tipo = item.tipo;
    form.tramitador_id = item.tramitador_id;
    form.user_id = item.user_id;
    form.sucursal_id = item.sucursal_id;
    form.fecha_inicio = item.fecha_inicio;
    form.hora_inicio = item.hora_inicio;
    form.fecha_fin = item.fecha_fin;
    form.hora_fin = item.hora_fin;
    form.estado = item.estado;
    form.certificado_detalles = item.certificado_detalles;
    form.eliminados = item.eliminados ?? [];
    if (item._method) {
        form._method = item._method;
    } else {
        form._method = form.id == 0 ? "POST" : "PUT";
    }
};

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
            limpiarCertificado();
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

const accion_form_cliente = ref(0);
const muestra_form_cliente = ref(false);

const agregarCliente = () => {
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
    verificaPendiente(oCliente.value.id);
};

const seleccionaCliente = (cliente) => {
    certificadoPendiente.value = null;
    oCliente.value = cliente;
    // buscar certificado pendiente
    verificaPendiente(cliente.id);
};

const verificaPendiente = (cliente_id) => {
    axios
        .get(route("certificados.verificaPendienteCliente", cliente_id))
        .then((response) => {
            if (response.data.existe) {
                certificadoPendiente.value = response.data.certificado;
            }
            if (certificadoPendiente.value) {
                asignaDatosFormulario(certificadoPendiente.value);
            }
            form.cliente_id = cliente_id;
            clienteSeleccionado.value = true;

            // una vez seleccionado asignar la fecha y hora
            iniciarFechaHoraInicio();
        });
};

const quitarSeleccionCliente = () => {
    clienteSeleccionado.value = false;
    oCliente.value = null;
    limpiarCertificado();
    asignaDatosFormulario(oCertificado.value);
    agregarCertificado();
    form.fecha_inicio = "";
    form.hora_inicio = "";
    fechaHoraTexto.value = "";
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
    // if (item.id) {
    //     axios
    //         .get(route("certificado_emitidos.verificaCantidad"), {
    //             params: {
    //                 tipo_certificado_id: item.id,
    //             },
    //         })
    //         .then((response) => {
    //             nroTipoCertificadoDia.value = response.data.conteo_siguiente;
    //             if (nroTipoCertificadoDia.value % 10 === 0) {
    //                 form.certificado_detalles[index].precio = 0;
    //                 form.certificado_detalles[index].muestra_conteo = true;
    //             } else {
    //                 form.certificado_detalles[index].muestra_conteo = false;
    //                 form.certificado_detalles[index].precio = item.precio;
    //             }
    //         })
    //         .finally(() => {
    //             nroTipoCertificadoDia.value = 0;
    //         });
    // }
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
    if (form.id == 0) {
        agregarCertificado();
    }

    if (form.id && form.id != 0) {
        txtCi.value = props.cliente.ci;
        buscarClienteByCi();
        seleccionaCliente(props.cliente);
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
                            <div class="card-body pt-0">
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
                                            :accion_formulario="
                                                accion_form_cliente
                                            "
                                            :muestra_formulario="
                                                muestra_form_cliente
                                            "
                                            :ci="txtCi"
                                            :metodo="'axios'"
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
                                                    <div class="card-body">
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
                                                            v-if="form.id == 0"
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
                            <i class="fa fa-clipboard-list"></i> Certificado(s)
                        </h4>
                    </div>
                    <div class="col-12">
                        <div
                            class="card mb-2"
                            v-for="(
                                certificado_detalle, index
                            ) in form.certificado_detalles"
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
                                                    :disabled="form.id != 0"
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
                                                        :disabled="form.id != 0"
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
                                                                    form.id != 0
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
                            v-if="form.id == 0 && certificadoPendiente"
                            type="button"
                            class="btn w-100 btn-agregar btn-sm text-sm mb-2"
                            @click.prevent="agregarCertificado()"
                        >
                            <i class="fa fa-plus"></i> Agregar
                        </button>
                        <div class="card">
                            <div class="card-body pb-0">
                                <div class="row">
                                    <div class="col-12 text-center">
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
                                                    :value="total ?? '0.00'"
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
                                            :disabled="form.id != 0"
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
                    </div>
                </div>
                <div class="row">
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
<style scoped></style>
