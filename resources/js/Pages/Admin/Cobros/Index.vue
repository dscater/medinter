<script setup>
import Content from "@/Components/Content.vue";
import MiTable from "@/Components/MiTable.vue";
import { Head, Link, router, usePage } from "@inertiajs/vue3";
import { ref, onMounted, onBeforeMount } from "vue";
import { useAppStore } from "@/stores/aplicacion/appStore";
import { useCertificados } from "@/composables/certificados/useCertificados";
import Formulario from "./Formulario.vue";
const { props: props_page } = usePage();
const { setCertificado, limpiarCertificado, oCertificado } = useCertificados();
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
const miTable = ref(null);
const headers = [
    {
        label: "NRO.",
        key: "id",
        sortable: true,
        width: "4%",
    },
    {
        label: "CLIENTE",
        key: "cliente",
        sortable: true,
    },
    {
        label: "CERTIFICADO(S)",
        key: "certificados",
    },
    {
        label: "TOTAL BS.",
        key: "total",
        sortable: true,
    },
    {
        label: "CANCELADO",
        key: "cancelado",
        sortable: true,
    },
    {
        label: "SALDO",
        key: "saldo",
        sortable: true,
    },
    {
        label: "TIPO DE PAGO",
        key: "tipo_pago",
        sortable: true,
    },
    {
        label: "SUCURSAL",
        key: "sucursal.nombre",
        sortable: true,
    },
    {
        label: "TIPO",
        key: "tipo",
        sortable: true,
    },
    {
        label: "USUARIO",
        key: "user",
        sortable: true,
    },
    {
        label: "FECHA REGISTRO",
        key: "fecha_registro_t",
        sortable: true,
    },
    {
        label: "ACCIÓN",
        key: "accion",
        fixed: "right",
        width: "4%",
    },
];

const multiSearch = ref({
    cliente: "",
    ci: "",
    fecha: "",
    codigo: "",
    filtro: [],
});
const pagarSaldo = (item) => {
    limpiarCertificado();
    setCertificado(item);
    muestra_form.value = true;
};

const muestra_form = ref(false);

const detectaNuevoPago = () => {
    muestra_form.value = false;
    updateDatatable();
};

const updateDatatable = async () => {
    if (miTable.value) {
        await miTable.value.cargarDatos();
    }
};

onBeforeMount(() => {});
</script>
<template>
    <Head title="Cobros"></Head>
    <Content>
        <template #header>
            <div class="row">
                <div class="col-sm-6">
                    <h1 class="m-0">
                        <i class="fa fa-hand-holding-usd"></i> Cobros
                    </h1>
                </div>
                <!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item">
                            <Link :href="route('inicio')">Inicio</Link>
                        </li>
                        <li class="breadcrumb-item active">Cobros</li>
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
                        <label class="mb-0">Buscar</label>
                    </div>
                    <div class="col-md-3">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text bg-white"
                                    ><i class="fa fa-user"></i
                                ></span>
                            </div>
                            <input
                                type="text"
                                class="form-control"
                                placeholder="Paciente"
                                v-model="multiSearch.cliente"
                            />
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text bg-white"
                                    ><i class="fa fa-id-card"></i
                                ></span>
                            </div>
                            <input
                                type="text"
                                class="form-control"
                                placeholder="Nro. C.I."
                                v-model="multiSearch.ci"
                            />
                        </div>
                    </div>
                    <!-- <div class="col-md-3">
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
                                v-model="multiSearch.fecha"
                            />
                        </div>
                    </div> -->
                </div>
            </div>
            <div class="col-12 mt-1">
                <Formulario
                    :muestra_formulario="muestra_form"
                    :certificado="oCertificado"
                    :accion_formulario="0"
                    @cerrar-formulario="muestra_form = false"
                    @envio-formulario="detectaNuevoPago"
                ></Formulario>
                <MiTable
                    :tableClass="'bg-white mitabla'"
                    ref="miTable"
                    :cols="headers"
                    :api="true"
                    :url="route('certificados.listadoCobros')"
                    :numPages="5"
                    :per-page="10"
                    :multiSearch="multiSearch"
                    :syncOrderBy="'id'"
                    :syncOrderAsc="'DESC'"
                    table-responsive
                    :header-class="'bg__primary'"
                    fixed-header
                >
                    <template #certificados="{ item }">
                        <div>
                            <ul class="p-1">
                                <li v-for="d in item.certificado_detalles">
                                    {{ d.tipo_certificado.nombre }}

                                    <a
                                        v-if="item.estado == 1"
                                        :href="d.url_archivo"
                                        target="_blank"
                                        class="text-md"
                                        ><i class="fa fa-download"></i
                                    ></a>
                                </li>
                            </ul>
                        </div>
                    </template>

                    <template #tipo="{ item }">
                        <span>{{ item.tipo }} </span>
                        <span v-if="item.tramitador">
                            - {{ item.tramitador.nombre }}
                        </span>
                    </template>

                    <template #saldo="{ item }">
                        <span
                            :class="{
                                'badge badge-danger text-sm': item.saldo > 0,
                            }"
                        >
                            {{ item.saldo }}
                        </span>
                    </template>

                    <template #cliente="{ item }">
                        <span
                            >{{ item.cliente.nombre }}
                            {{ item.cliente.paterno }}
                            {{ item.cliente.materno }}
                        </span>
                        <br />
                        <span
                            >{{ item.cliente.ci }}
                            {{
                                item.cliente.complemento
                                    ? " - " + item.cliente.complemento
                                    : ""
                            }}
                            {{ item.cliente.ci_exp }}</span
                        >
                    </template>

                    <template #user="{ item }">
                        <span v-if="item.estado == 1 && item.user"
                            >{{ item.user.nombre }}
                            {{ item.user.paterno }}
                            {{ item.user.materno }}
                        </span>
                        <span
                            v-else
                            class="badge badge-warning text-md text-dark"
                            >PENDIENTE</span
                        >
                    </template>

                    <template #accion="{ item }">
                        <template
                            v-if="
                                props_page.auth?.user.permisos == '*' ||
                                props_page.auth?.user.permisos.includes(
                                    'cobros.registrarPago',
                                )
                            "
                        >
                            <el-tooltip
                                class="box-item"
                                effect="dark"
                                content="Pagar Saldo"
                                placement="left-start"
                            >
                                <button
                                    class="btn btn-primary"
                                    @click="pagarSaldo(item)"
                                >
                                    <i class="fa fa-pen"></i></button
                            ></el-tooltip>
                        </template>
                    </template>
                </MiTable>
            </div>
        </div>
    </Content>
</template>
