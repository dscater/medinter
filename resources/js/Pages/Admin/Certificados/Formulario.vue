<script setup>
import { useForm, usePage } from "@inertiajs/vue3";
import { useCertificados } from "@/composables/certificados/useCertificados";
import { watch, ref, computed, onMounted, nextTick, onBeforeMount } from "vue";
import Formulario from "../Clientes/Formulario.vue";
import { useLoginUserStore } from "@/stores/login_users/loginUserStore";
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
const form = useForm(props.certificado);
watch(
    () => props.certificado,
    (newValue) => {
        form.id = newValue.id;
        form.cliente_id = newValue.cliente_id;
        form.total = newValue.total;
        form.cancelado = newValue.cancelado;
        form.saldo = newValue.saldo;
        form.tipo_pago = newValue.tipo_pago;
        form.tipo = newValue.tipo;
        form.user_id = newValue.user_id;
        form.sucursal_id = newValue.sucursal_id;
        form.fecha_inicio = newValue.fecha_inicio;
        form.hora_inicio = newValue.hora_inicio;
        form.fecha_fin = newValue.fecha_fin;
        form.hora_fin = newValue.hora_fin;
        form.estado = newValue.estado;
        form.certificado_detalles = newValue.certificado_detalles;
        form.eliminados = newValue.eliminados;
        form._method = newValue._method;
    },
);

const textBtn = computed(() => {
    if (enviando.value) {
        return `<i class="fa fa-spin fa-spinner"></i> Enviando...`;
    }
    if (form.id == 0) {
        return `<i class="fa fa-save"></i> Guardar`;
    }
    return `<i class="fa fa-edit"></i> Actualizar`;
});

const enviarFormulario = () => {
    enviando.value = true;
    let url =
        form.id == 0
            ? route("certificados.store")
            : route("certificados.update", form.id);

    if (propsPage.auth.user.tipo == "MÉDICO") {
        form["sucursal_id"] = loginUserStore.getLoginUser.sucursal_id;
    } else {
        form["sucursal_id"] = propsPage.auth.user.sucursal_id;
    }
    form.tipo = "NORMAL";
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
};

const seleccionaCliente = (cliente) => {
    oCliente.value = cliente;
    clienteSeleccionado.value = true;
    form.cliente_id = oCliente.value.id;
};

const quitarSeleccionCliente = () => {
    clienteSeleccionado.value = false;
    oCliente.value = null;
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
    form.certificado_detalles[index].precio = item.precio;
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
    const total = form.certificado_detalles.reduce((total, item) => {
        const subtotal = parseFloat(
            item.precio && item.precio != 0 ? item.precio : 0,
        );
        if (subtotal !== null && subtotal !== undefined && subtotal !== "") {
            return total + Number(subtotal);
        }

        return total;
    }, 0);

    form.cancelado = total;
    form.saldo = 0;
    form.total = total;

    return total ? total.toFixed(2) : "0.00";
});

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
});
</script>

<template>
    <form @submit.prevent="enviarFormulario()">
        <div class="row" v-if="form">
            <div class="col-md-5">
                <div class="card">
                    <div class="card-header">
                        <h4 class="card-title">
                            <i class="fa fa-user"></i> Datos del Paciente
                        </h4>
                    </div>
                    <div class="card-body pt-0">
                        <div class="row">
                            <div class="col-md-12 mt-2">
                                <label class="">Ingresar Nro. C.I.</label>
                                <input
                                    type="search"
                                    class="form-control"
                                    @search="listClientes = []"
                                    v-model="txtCi"
                                    @keyup.prevent="detectarBusquedaCliente()"
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
                                class="col-12 text-center"
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
                                    <div class="col-12 text-center text-sm">
                                        {{ listClientes.length }} resultado(s)
                                        encontrado(s)
                                    </div>
                                    <div
                                        class="col-12 cliente_listado"
                                        v-for="item in listClientes"
                                        @click="seleccionaCliente(item)"
                                    >
                                        <div class="callout callout-info">
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
                                    txtCi.trim() != ''
                                "
                            >
                                <span class="h6">Sin resultados...</span>
                            </div>
                            <div
                                class="col-12"
                                v-if="
                                    txtCi.trim() != '' && !clienteSeleccionado
                                "
                            >
                                <button
                                    type="button"
                                    class="btn btn-outline-info w-100 text-sm btn-sm"
                                    @click.prevent="agregarCliente"
                                >
                                    <i class="fa fa-plus"></i> Agregar Nuevo
                                    Cliente
                                </button>
                                <Formulario
                                    :accion_formulario="accion_form_cliente"
                                    :muestra_formulario="muestra_form_cliente"
                                    :ci="txtCi"
                                    :metodo="'axios'"
                                    @cerrar-formulario="
                                        cierraFormularioCliente()
                                    "
                                    @envio-formulario="clienteAgregado"
                                ></Formulario>
                            </div>
                            <div class="col-12" v-if="clienteSeleccionado">
                                <div class="row mt-1">
                                    <div class="col-12">
                                        <div class="card mb-0 border-success">
                                            <div class="card-body">
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
                                                    <strong
                                                        >F. nacimiento:</strong
                                                    >
                                                    {{
                                                        oCliente.fecha_nac_t ??
                                                        "-"
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
                                                <button
                                                    type="button"
                                                    class="mt-2 btn btn-outline-danger btn-sm w-100 text-sm"
                                                    @click.prevent="
                                                        quitarSeleccionCliente
                                                    "
                                                >
                                                    <i class="fa fa-times"></i>
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
            <div class="col-md-7">
                <div class="card">
                    <div class="card-header">
                        <h4 class="card-title">
                            <i class="fa fa-clipboard-list"></i> Datos
                            Certificado(s)
                        </h4>
                    </div>
                    <div class="card-body pt-0">
                        <div
                            class="row border-bottom pb-1"
                            v-for="(
                                certificado_detalle, index
                            ) in form.certificado_detalles"
                        >
                            <div class="col-12 pt-0 pb-3 mt-2 mb-0">
                                <button
                                    type="button"
                                    class="btn btn-sm text-xs quitar"
                                    v-if="index > 0"
                                    @click.prevent="quitarCertificado(index)"
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
                                                <div class="icon icon-pdf">
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
                                                <div class="icon icon-loaded">
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
                                        <label class="">Costo Bs.</label>
                                        <el-input
                                            type="text"
                                            v-model="certificado_detalle.precio"
                                            autosize
                                        ></el-input>
                                    </div>
                                    <div class="col-md-6 mt-1">
                                        <label class="">Categoría</label>
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

                        <div class="row">
                            <div class="col-12 p-0 mt-2">
                                <button
                                    type="button"
                                    class="btn w-100 btn-agregar btn-sm text-sm"
                                    @click.prevent="agregarCertificado()"
                                >
                                    <i class="fa fa-plus"></i> Agregar
                                </button>
                            </div>
                        </div>

                        <div class="row mt-3 border-top">
                            <div class="col-12 mt-2 text-center">
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
                            <div class="col-12 text-center">
                                <label class="">Tipo de Pago </label>
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
