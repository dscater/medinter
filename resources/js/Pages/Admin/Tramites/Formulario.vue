<script setup>
import { useForm, usePage } from "@inertiajs/vue3";
import { useTramites } from "@/composables/tramites/useTramites";
import { watch, ref, computed, onMounted, nextTick, onBeforeMount } from "vue";
import Formulario from "../Clientes/Formulario.vue";
import { useLoginUserStore } from "@/stores/login_users/loginUserStore";
import ClientesExistentes from "./ClientesExistentes.vue";
import axios from "axios";
const { props: propsPage } = usePage();
const loginUserStore = useLoginUserStore();
const props = defineProps({
    tramite: {
        type: Object,
        default: { id: 0 },
    },
});

const { oTramite, limpiarTramite } = useTramites();
const enviando = ref(false);
let form = useForm(props.tramite);
watch(
    () => props.tramite,
    (newValue) => {
        form = useForm(newValue);
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
            ? route("tramites.store")
            : route("tramites.update", form.id);

    if (propsPage.auth.user.tipo == "MÉDICO") {
        form["sucursal_id"] = loginUserStore.getLoginUser.sucursal_id;
    } else {
        form["sucursal_id"] = propsPage.auth.user.sucursal_id;
    }
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
            limpiarTramite();
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
const cargarArchivo = (e, key, index) => {
    form[key] = null;
    const file = e.target.files[0];
    if (file) {
        form.tramite_clientes[index][key] = e.target.files[0];
    }
};

const listTramitadors = ref([]);
const cargarTramitadors = () => {
    axios.get(route("tramitadors.listado")).then((response) => {
        listTramitadors.value = response.data.tramitadors;
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

const agregarTramiteCliente = () => {
    form.tramite_clientes.push({
        id: 0,
        tramite_id: "",
        cliente_id: "",
        certificado_id: "",
        estado: "",
        cliente: {
            nombre: "",
            paterno: "",
            materno: "",
            ci: "",
            ci_exp: "",
            complemento: "",
            fecha_nac: "",
            edad: "",
            cel: "",
            fecha_registro: "",
            status: "",
        },
        existente: false,
    });
};

const quitarCliente = (index) => {
    const item = form.tramite_clientes[index];
    if (item.id != 0) {
        form.eliminados.push(item.id);
    }
    form.tramite_clientes.splice(index, 1);
};

const indexBusqueda = ref(-1);
const listClientesExistentes = ref([]);
const muestra_form_cexistentes = ref(false);

const intervalsBusquedaCliente = ref(null);
const verificaClienteExistente = (e, index) => {
    limpiaBusqueda();
    limpiarFormCliente(index);
    const value = e.target.value;
    clearInterval(intervalsBusquedaCliente.value);

    if (value.trim() == "") return;

    intervalsBusquedaCliente.value = setTimeout(() => {
        buscarClienteByCi(value, index);
    });
};

const buscarClienteByCi = (ci, index) => {
    axios
        .get(route("clientes.byCi"), {
            params: {
                ci,
            },
        })
        .then((response) => {
            if (response.data.length > 0) {
                indexBusqueda.value = index;
                muestra_form_cexistentes.value = true;
                listClientesExistentes.value = response.data;
            } else {
                limpiarFormCliente(index);
            }
        });
};

const asignarCliente = (item, index) => {
    form.tramite_clientes[index].cliente = item;
    form.tramite_clientes[index].cliente_id = item.id;
    form.tramite_clientes[index].existente = true;
    limpiaBusqueda();
};

const limpiarFormCliente = (index) => {
    form.tramite_clientes[index].cliente.id = 0;
    form.tramite_clientes[index].cliente.nombre = "";
    form.tramite_clientes[index].cliente.paterno = "";
    form.tramite_clientes[index].cliente.materno = "";
    form.tramite_clientes[index].cliente.ci_exp = "";
    form.tramite_clientes[index].cliente.complemento = "";
    form.tramite_clientes[index].cliente.complemento = "";
    form.tramite_clientes[index].cliente.cel = "";
    form.tramite_clientes[index].cliente.fecha_nac = "";
    form.tramite_clientes[index].cliente.edad = "";
    form.tramite_clientes[index].cliente_id = "";
    form.tramite_clientes[index].existente = false;
};

const limpiaBusqueda = () => {
    muestra_form_cexistentes.value = false;
    indexBusqueda.value = -1;
    listClientesExistentes.value = [];
};

onBeforeMount(() => {
    cargarTramitadors();
});

onMounted(() => {
    if (form.id == 0) {
        agregarTramiteCliente();
    }
});

onBeforeMount(() => {});
</script>

<template>
    <form @submit.prevent="enviarFormulario()">
        <div class="row" v-if="form">
            <div class="col-md-12">
                <div class="card">
                    <div class="card-body pt-0">
                        <div class="row">
                            <div class="col-md-12 mt-2">
                                <label class="required"
                                    >Seleccionar Tramitador</label
                                >
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text bg-white"
                                            ><i class="fa fa-address-book"></i
                                        ></span>
                                    </div>
                                    <div class="form-control p-0 border-0">
                                        <el-select
                                            class="el-select-input-group-right"
                                            size="large"
                                            v-model="form.tramitador_id"
                                            filterable
                                            placeholder="- Seleccione -"
                                            no-data-text="Sin resultados"
                                            no-data-match="Sin conicidencias"
                                        >
                                            <el-option
                                                v-for="item in listTramitadors"
                                                :key="item.id"
                                                :value="item.id"
                                                :label="item.nombre"
                                            ></el-option
                                        ></el-select>
                                    </div>
                                </div>
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
            <div class="col-md-12">
                <ClientesExistentes
                    :index="indexBusqueda"
                    :list_clientes="listClientesExistentes"
                    :muestra_formulario="muestra_form_cexistentes"
                    @envio-formulario="asignarCliente"
                ></ClientesExistentes>
                <div class="card">
                    <div class="card-header">
                        <h4 class="card-title">
                            <i class="fa fa-clipboard-list"></i> Datos Trámite
                        </h4>
                    </div>
                    <div class="card-body pt-0">
                        <div
                            class="row"
                            v-for="(
                                tramite_cliente, index
                            ) in form.tramite_clientes"
                        >
                            <div
                                class="col-12 border pt-0 pb-1 mt-2 elevation-1"
                                :class="{
                                    'bg-light': tramite_cliente.existente,
                                    'bg-light':
                                        tramite_cliente.cliente_id != '',
                                }"
                            >
                                <button
                                    type="button"
                                    class="btn btn-sm text-xs quitar"
                                    v-if="
                                        index > 0 &&
                                        !tramite_cliente.certificado_id
                                    "
                                    @click.prevent="quitarCliente(index)"
                                >
                                    X
                                </button>
                                <div
                                    class="row"
                                    v-if="
                                        tramite_cliente &&
                                        tramite_cliente.cliente
                                    "
                                >
                                    <div class="col-12 mt-2">
                                        <h5 class="text-md">
                                            <i class="fa fa-user"></i> Datos
                                            Paciente {{ index + 1 }}
                                        </h5>
                                    </div>
                                    <div class="col-lg-3 col-md-4 mt-2">
                                        <label class="required"
                                            >Nro. de C.I.</label
                                        >
                                        <el-input
                                            type="text"
                                            v-model="tramite_cliente.cliente.ci"
                                            @keyup="
                                                verificaClienteExistente(
                                                    $event,
                                                    index,
                                                )
                                            "
                                            :disabled="
                                                form.id != 0 &&
                                                tramite_cliente.id != 0
                                            "
                                        ></el-input>
                                        <small
                                            class="text-xs text-success font-weight-400"
                                            v-if="tramite_cliente.existente"
                                            ><i class="fa fa-database"></i>
                                            Cargado automaticamente</small
                                        >
                                    </div>
                                    <div class="col-lg-3 col-md-4 mt-2">
                                        <label class="required">Expedido</label>
                                        <el-select
                                            v-model="
                                                tramite_cliente.cliente.ci_exp
                                            "
                                            :disabled="
                                                tramite_cliente.existente ||
                                                (form.id != 0 &&
                                                    tramite_cliente.id != 0)
                                            "
                                            placeholder="- Seleccione -"
                                        >
                                            <el-option
                                                v-for="item in listExpedido"
                                                :key="item.value"
                                                :value="item.value"
                                                :label="item.label"
                                            >
                                            </el-option>
                                        </el-select>
                                    </div>
                                    <div class="col-lg-3 col-md-4 mt-2">
                                        <label class="required"
                                            >Nombre(s)</label
                                        >
                                        <el-input
                                            type="text"
                                            v-model="
                                                tramite_cliente.cliente.nombre
                                            "
                                            :readonly="
                                                tramite_cliente.existente ||
                                                (form.id != 0 &&
                                                    tramite_cliente.id != 0)
                                            "
                                        ></el-input>
                                    </div>
                                    <div class="col-lg-3 col-md-4 mt-2">
                                        <label class="required"
                                            >Ap. Paterno</label
                                        >
                                        <el-input
                                            type="text"
                                            v-model="
                                                tramite_cliente.cliente.paterno
                                            "
                                            :readonly="
                                                tramite_cliente.existente ||
                                                (form.id != 0 &&
                                                    tramite_cliente.id != 0)
                                            "
                                        ></el-input>
                                    </div>
                                    <div class="col-lg-3 col-md-4 mt-2">
                                        <label class="">Ap. Materno</label>
                                        <el-input
                                            type="text"
                                            v-model="
                                                tramite_cliente.cliente.materno
                                            "
                                            :readonly="
                                                tramite_cliente.existente ||
                                                (form.id != 0 &&
                                                    tramite_cliente.id != 0)
                                            "
                                        ></el-input>
                                    </div>
                                    <div class="col-lg-3 col-md-4 mt-2">
                                        <label class="">Complemento</label>
                                        <el-input
                                            type="text"
                                            v-model="
                                                tramite_cliente.cliente
                                                    .complemento
                                            "
                                            :readonly="
                                                tramite_cliente.existente ||
                                                (form.id != 0 &&
                                                    tramite_cliente.id != 0)
                                            "
                                        ></el-input>
                                    </div>
                                    <div class="col-lg-3 col-md-4 mt-2">
                                        <label class="required"
                                            >Fecha de Nacimiento</label
                                        >
                                        <input
                                            type="date"
                                            class="form-control"
                                            v-model="
                                                tramite_cliente.cliente
                                                    .fecha_nac
                                            "
                                            :readonly="
                                                tramite_cliente.existente ||
                                                (form.id != 0 &&
                                                    tramite_cliente.id != 0)
                                            "
                                        />
                                    </div>
                                    <div class="col-lg-3 col-md-4 mt-2">
                                        <label class="">Teléfono/Celular</label>
                                        <el-input
                                            type="text"
                                            v-model="
                                                tramite_cliente.cliente.cel
                                            "
                                        ></el-input>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="row mt-2">
                            <div class="col-12">
                                <ul
                                    v-if="form.errors?.tramite_clientes"
                                    class="d-block text-danger list-unstyled"
                                >
                                    <li class="parsley-required">
                                        {{ form.errors?.tramite_clientes }}
                                    </li>
                                </ul>
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

                        <div class="row">
                            <div class="col-12 p-0 mt-2">
                                <button
                                    type="button"
                                    class="btn w-100 btn-agregar btn-sm text-sm"
                                    @click.prevent="agregarTramiteCliente()"
                                >
                                    <i class="fa fa-plus"></i> Agregar
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12">
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

.quitar {
    position: absolute;
    right: 0;
    top: -5px;
    background-color: var(--danger);
    color: white;
    border: none;
    border-radius: 12px;
    font-size: 1em;
    cursor: pointer;
    z-index: 10;
}
</style>
