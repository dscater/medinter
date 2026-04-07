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
        default: { id: 0 },
    },
    cliente: {
        type: Object,
        default: { id: 0 },
    },
});

const { oCertificado, limpiarCertificado } = useCertificados();
const enviando = ref(false);
let form = useForm(props.certificado);
watch(
    () => props.certificado,
    (newValue) => {
        form = useForm(newValue);
    },
);

const tituloDialog = computed(() => {
    return form.id == 0
        ? `<i class="fa fa-plus"></i> Nuevo Tipo de Certificado`
        : `<i class="fa fa-edit"></i> Editar Tipo de Certificado`;
});

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

    if (propsPage.auth.user.tipo == "MÉDICO")
        form["sucursal_id"] = loginUserStore.getLoginUser.sucursal_id;
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

const archivo1 = ref(null);
const archivo2 = ref(null);
const cargarArchivo = (e, key) => {
    form[key] = null;
    const file = e.target.files[0];
    if (file) {
        form[key] = e.target.files[0];
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
const muestraMensajeConteo = ref(false);
const detectarTipoCertificado = () => {
    muestraMensajeConteo.value = false;
    const item = listTipoCertificados.value.filter(
        (item) => item.id === form.tipo_certificado_id,
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
                    form.precio = 0;
                    muestraMensajeConteo.value = true;
                } else {
                    form.precio = item.precio;
                }
            });
    }
};

onMounted(() => {
    form = useForm(oCertificado.value);
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
        <p class="text-muted text-xs mb-0 mt-0">
            Todos los campos con
            <span class="text-danger">(*)</span> son obligatorios.
        </p>
        <div class="row">
            <div class="col-md-5">
                <div class="row">
                    <div class="col-md-12 mt-2">
                        <label class="required">Ingresar Nro. C.I.</label>
                        <input
                            type="search"
                            class="form-control"
                            :class="{
                                'parsley-error': form.errors?.cliente_id,
                            }"
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
                    <div class="col-12" v-if="buscandoCliente">Buscando...</div>
                    <div
                        class="col-12 mt-2"
                        v-if="listClientes.length > 0 && !clienteSeleccionado"
                    >
                        <div class="row">
                            <div class="col-12">
                                {{ listClientes.length }} resultados encontrados
                            </div>
                            <div
                                class="col-12 cliente_listado"
                                v-for="item in listClientes"
                                @click="seleccionaCliente(item)"
                            >
                                <div class="callout callout-info">
                                    <h5>
                                        {{ item.nombre }} {{ item.paterno }}
                                        {{ item.materno }}
                                    </h5>
                                    <p>{{ item.full_ci }}</p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div
                        class="col-12 text-center"
                        v-if="listClientes.length == 0 && txtCi.trim() != ''"
                    >
                        <span class="h6">Sin resultados...</span>
                    </div>
                    <div
                        class="col-12"
                        v-if="txtCi.trim() != '' && !clienteSeleccionado"
                    >
                        <button
                            type="button"
                            class="btn btn-outline-info w-100"
                            @click.prevent="agregarCliente"
                        >
                            <i class="fa fa-plus"></i> Agregar Nuevo Cliente
                        </button>
                        <Formulario
                            :accion_formulario="accion_form_cliente"
                            :muestra_formulario="muestra_form_cliente"
                            :ci="txtCi"
                            :metodo="'axios'"
                            @cerrar-formulario="cierraFormularioCliente()"
                            @envio-formulario="clienteAgregado"
                        ></Formulario>
                    </div>
                    <div class="col-12" v-if="clienteSeleccionado">
                        <div class="row">
                            <div class="col-12">
                                <div class="card mb-2">
                                    <div class="card-body card-widget shadow">
                                        <h5>
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
                                        <p>
                                            {{ oCliente.ci }}
                                            {{ oCliente.complemento }}
                                            {{ oCliente.ci_exp }}
                                        </p>
                                        <p>
                                            <strong>F. nacimiento:</strong>
                                            {{ oCliente.fecha_nac_t ?? "-" }}
                                        </p>
                                        <p>
                                            <strong>Celular:</strong>
                                            {{ oCliente.cel ?? "-" }}
                                        </p>
                                        <button
                                            type="button"
                                            class="btn btn-outline-danger w-100"
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
            <div class="col-md-7">
                <div class="row">
                    <div class="col-md-12 mt-2">
                        <label class="required">Tipo de Certificado</label>
                        <el-select
                            :class="{
                                'parsley-error':
                                    form.errors?.tipo_certificado_id,
                            }"
                            v-model="form.tipo_certificado_id"
                            placeholder="- Seleccione -"
                            no-data-text="Sin datos"
                            no-match-text="No se entrarón coincidencias"
                            filterable
                            @change="detectarTipoCertificado"
                        >
                            <el-option
                                v-for="item in listTipoCertificados"
                                :key="item.id"
                                :value="item.id"
                                :label="item.nombre"
                            ></el-option>
                        </el-select>
                        <ul
                            v-if="form.errors?.tipo_certificado_id"
                            class="d-block text-danger list-unstyled"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.tipo_certificado_id }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-6 mt-2">
                        <label class="required">Costo Bs.</label>
                        <el-input
                            type="text"
                            :class="{
                                'parsley-error': form.errors?.precio,
                            }"
                            v-model="form.precio"
                            autosize
                        ></el-input>
                        <small
                            class="text-xs text-success"
                            v-if="muestraMensajeConteo"
                            >(Certificado gratuito)</small
                        >
                        <ul
                            v-if="form.errors?.precio"
                            class="d-block text-danger list-unstyled"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.precio }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-6 mt-2">
                        <label class="required">Tipo de Pago </label>
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
                    <div class="col-12">
                        <div class="row">
                            <div class="col-md-6 mt-2">
                                <label class=""
                                    >Cargar Archivo 1
                                    <a
                                        v-if="form.url_archivo1"
                                        href=""
                                        class="btn btn-sm btn-outline-primary"
                                        ><i class="fa fa-download"></i></a
                                ></label>
                                <input
                                    type="file"
                                    class="form-control"
                                    :class="{
                                        'parsley-error': form.errors?.archivo1,
                                    }"
                                    ref="archivo1"
                                    @change="cargarArchivo($event, 'archivo1')"
                                />
                                <ul
                                    v-if="form.errors?.archivo1"
                                    class="d-block text-danger list-unstyled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.archivo1 }}
                                    </li>
                                </ul>
                            </div>
                            <div class="col-md-6 mt-2">
                                <label class=""
                                    >Cargar Archivo 2
                                    <a
                                        v-if="form.url_archivo1"
                                        href=""
                                        class="btn btn-sm btn-outline-primary"
                                        ><i class="fa fa-download"></i></a
                                ></label>
                                <input
                                    type="file"
                                    class="form-control"
                                    :class="{
                                        'parsley-error': form.errors?.archivo2,
                                    }"
                                    @change="cargarArchivo($event, 'archivo2')"
                                    ref="archivo2"
                                />
                                <ul
                                    v-if="form.errors?.archivo2"
                                    class="d-block text-danger list-unstyled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.archivo2 }}
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-12 mt-3">
                <div class="row">
                    <div
                        class="col-12 text-center"
                        v-if="!oCliente || !form.cliente_id"
                    >
                        <span class="font-weight-bold h5 text-danger"
                            >Debes seleccionar un Cliente</span
                        >
                    </div>
                    <div
                        class="col-md-3 offset-md-5"
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
<style scoped>
.cliente_listado {
    cursor: pointer;
}

.cliente_listado:hover .callout {
    background-color: var(--bg4);
}
</style>
