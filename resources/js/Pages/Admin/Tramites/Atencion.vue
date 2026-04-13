<script setup>
import Content from "@/Components/Content.vue";
import { Head, Link, router, usePage } from "@inertiajs/vue3";
import { ref, onMounted, onBeforeMount } from "vue";
import { useAppStore } from "@/stores/aplicacion/appStore";
import FormRegistraCertificado from "./FormRegistraCertificado.vue";
import { useCertificados } from "@/composables/certificados/useCertificados";
const { oCertificado, limpiarCertificado } = useCertificados();
const { props: props_page } = usePage();
const appStore = useAppStore();
onBeforeMount(() => {
    appStore.startLoading();
});

onMounted(() => {
    appStore.stopLoading();
});

const goBack = () => {
    if (window.history.length > 1) {
        window.history.back();
    } else {
        router.visit(route("inicio"));
    }
};
const filtros = ref({
    codigo: "",
    fecha: "",
});

const intervalBusqueda = ref(null);
const buscando = ref(false);
const detectarBusqueda = () => {
    clearInterval(intervalBusqueda.value);

    buscando.value = true;
    intervalBusqueda.value = setTimeout(() => {
        cargarTramites();
    }, 320);
};

const listTramites = ref([]);
const cargarTramites = () => {
    listTramites.value = [];
    axios
        .get(route("tramites.listadoExacto"), {
            params: filtros.value,
        })
        .then((response) => {
            listTramites.value = response.data.tramites;
        })
        .finally(() => {
            buscando.value = false;
        });
};

const listTramitesClientes = ref([]);
const oTramite = ref(null);
const obtenerTramiteClientes = (item) => {
    listTramitesClientes.value = [];
    oTramite.value = null;
    axios
        .get(route("tramite_clientes.byTramite"), {
            params: {
                tramite_id: item.id,
            },
        })
        .then((response) => {
            listTramitesClientes.value = response.data.tramite_clientes;
            oTramite.value = item;
        });
};

const muestra_form_certificado = ref(false);
const oClienteTramite = ref(null);

const registrarCertificado = (item) => {
    limpiarCertificado();
    oClienteTramite.value = item;
    muestra_form_certificado.value = true;
};

const cancelarTramiteSeleccionado = () => {
    oTramite.value = null;
};

const certificadoRegistrado = () => {
    muestra_form_certificado.value = false;
    obtenerTramiteClientes(oTramite.value);
};

onBeforeMount(() => {});
</script>
<template>
    <Head title="Trámites"></Head>
    <Content>
        <template #header>
            <div class="row">
                <div class="col-sm-6">
                    <h1 class="m-0">
                        <i class="fa fa-folder-open"></i> Atención de Trámites
                    </h1>
                </div>
                <!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item">
                            <Link :href="route('inicio')">Inicio</Link>
                        </li>
                        <li class="breadcrumb-item active">
                            Atención de Trámites
                        </li>
                    </ol>
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->
        </template>
        <div class="row">
            <div class="col-md-12">
                <div class="row mt-1">
                    <div class="col-12">
                        <label class="mb-0">Buscar Trámite</label>
                    </div>
                    <div class="col-md-3">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text bg-white"
                                    ><i class="fa fa-folder"></i
                                ></span>
                            </div>
                            <input
                                type="text"
                                class="form-control"
                                placeholder="Código Trámite"
                                v-model="filtros.codigo"
                                @keyup="detectarBusqueda"
                            />
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text bg-white"
                                    ><i class="fa fa-calendar-alt"></i
                                ></span>
                            </div>
                            <input
                                type="date"
                                class="form-control"
                                placeholder="Fecha"
                                v-model="filtros.fecha"
                                @keyup="detectarBusqueda"
                                @change="detectarBusqueda"
                            />
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="row" v-if="buscando">
            <div class="col-12 mt-2">
                <h4 class="text-muted text-md">Buscando...</h4>
            </div>
        </div>
        <div
            class="row mt-2"
            v-if="!buscando && listTramites.length > 0 && !oTramite"
        >
            <div
                class="col-lg-3 col-md-4 col-sm-6 cliente_listado"
                v-for="item in listTramites"
                @click="obtenerTramiteClientes(item)"
            >
                <div class="card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-12">
                                <h4
                                    class="text-md font-weight-bold text-center"
                                >
                                    {{ item.codigo }}
                                </h4>
                            </div>
                            <div class="col-md-12">
                                <div class="row">
                                    <div class="col-12">
                                        <div class="row">
                                            <div class="col-4 text-right">
                                                <span class="text-sm"
                                                    >Nro. Registros:</span
                                                >
                                            </div>
                                            <div class="col-8">
                                                {{
                                                    item.tramite_clientes_count
                                                }}
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <div class="row">
                                            <div class="col-4 text-right">
                                                <span class="text-sm"
                                                    >Fecha:</span
                                                >
                                            </div>
                                            <div class="col-8">
                                                {{ item.fecha_t }}
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-12">
                                        <div class="row">
                                            <div class="col-4 text-right">
                                                <span class="text-sm"
                                                    >Tramitador:</span
                                                >
                                            </div>
                                            <div class="col-8">
                                                {{ item.tramitador.nombre }}
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
        <div
            class="row"
            v-if="
                !buscando &&
                listTramites.length == 0 &&
                (filtros.codigo != '' || filtros.fecha != '')
            "
        >
            <div class="col-12 mt-2">
                <h4 class="text-muted text-lg">Sin resultados</h4>
            </div>
        </div>

        <div
            class="row mt-2"
            v-if="oTramite && listTramitesClientes.length > 0"
        >
            <div class="col-12">
                <strong>Código de Tramite: </strong>{{ oTramite.codigo }}
                <el-tooltip
                    class="box-item"
                    effect="dark"
                    content="Cancelar"
                    placement="left-start"
                >
                    <button
                        class="btn btn-danger btn-xs text-xs"
                        @click="cancelarTramiteSeleccionado"
                    >
                        <i class="fa fa-times"></i>
                    </button>
                </el-tooltip>
            </div>
            <div class="col-12">
                <strong>Fecha: </strong>{{ oTramite.fecha_t }}
            </div>
            <div class="col-12">
                <strong>Tramitador: </strong>{{ oTramite.tramitador.nombre }}
            </div>
            <div class="col-12">
                <strong>Total Registros: </strong
                >{{ oTramite.tramite_clientes_count }}
            </div>
            <div class="col-12">
                <FormRegistraCertificado
                    :muestra_formulario="muestra_form_certificado"
                    :accion_formulario="0"
                    :cliente_tramite="oClienteTramite"
                    @cerrar-formulario="muestra_form_certificado = false"
                    @envio-formulario="certificadoRegistrado"
                ></FormRegistraCertificado>
                <table class="table table-bordered table-hover bg-white">
                    <thead>
                        <tr class="bg-principal">
                            <th width="3%">Nro.</th>
                            <th>Paciente</th>
                            <th>C.I.</th>
                            <th>Estado</th>
                            <th width="3%">Acción</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="(item, index) in listTramitesClientes">
                            <td>{{ index + 1 }}</td>
                            <td>
                                {{ item.cliente.nombre }}
                                {{ item.cliente.paterno }}
                                {{ item.cliente.materno }}
                            </td>
                            <td>
                                {{ item.cliente.ci }}
                                {{ item.cliente.complemento ?? "" }}
                                {{ item.cliente.ci_exp }}
                            </td>
                            <td>
                                <span
                                    class="badge text-sm"
                                    :class="{
                                        'badge-success': item.estado == 1,
                                        'badge-warning': item.estado == 0,
                                    }"
                                    >{{
                                        item.estado == 1
                                            ? "ATENDIDO"
                                            : "PENDIENTE"
                                    }}</span
                                >
                            </td>
                            <td>
                                <template v-if="item.estado == 0">
                                    <el-tooltip
                                        class="box-item"
                                        effect="dark"
                                        content="Registrar Certificado"
                                        placement="left-start"
                                    >
                                        <button
                                            class="btn btn-primary"
                                            @click="registrarCertificado(item)"
                                        >
                                            <i class="fa fa-clipboard-list"></i>
                                        </button>
                                    </el-tooltip>
                                </template>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
        </div>
    </Content>
</template>
