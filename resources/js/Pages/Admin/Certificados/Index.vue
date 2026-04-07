<script setup>
import Content from "@/Components/Content.vue";
import MiTable from "@/Components/MiTable.vue";
import { Head, Link, router, usePage } from "@inertiajs/vue3";
import { useCertificados } from "@/composables/certificados/useCertificados";
import { useAxios } from "@/composables/axios/useAxios";
import { ref, onMounted, onBeforeMount } from "vue";
import { useAppStore } from "@/stores/aplicacion/appStore";
// import { useMenu } from "@/composables/useMenu";
import Formulario from "./Formulario.vue";
import { buttonProps } from "element-plus";
// const { mobile, identificaDispositivo } = useMenu();
const { props: props_page } = usePage();
const appStore = useAppStore();
onBeforeMount(() => {
    appStore.startLoading();
});

const listTipoCertificados = ref([]);
const listTipoPagos = ref([]);
const listSucursals = ref([]);
const cargarTipoCertificados = () => {
    axios.get(route("tipo_certificados.listado")).then((response) => {
        listTipoCertificados.value = response.data.tipo_certificados;
        listTipoCertificados.value.unshift({
            id: "todos",
            nombre: "TODOS",
        });
    });
};

const cargarTipoPagos = () => {
    axios.get(route("tipo_pagos.listado")).then((response) => {
        listTipoPagos.value = response.data;
        listTipoPagos.value.unshift({
            value: "todos",
            label: "TODOS",
        });
    });
};

const cargarSucursals = () => {
    axios.get(route("sucursals.listado")).then((response) => {
        listSucursals.value = response.data.sucursals;
        listSucursals.value.unshift({
            id: "todos",
            nombre: "TODOS",
        });
    });
};

onMounted(() => {
    cargarTipoCertificados();
    cargarTipoPagos();
    cargarSucursals();
    appStore.stopLoading();
});

const { setCertificado, limpiarCertificado } = useCertificados();
const { axiosDelete } = useAxios();

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
        label: "TIPO DE CERTIFICADO",
        key: "tipo_certificado.nombre",
        sortable: true,
    },
    {
        label: "COSTO BS.",
        key: "precio",
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
        label: "MÉDICO",
        key: "user",
        sortable: true,
    },
    {
        label: "FECHA REGISTRO",
        key: "fecha_registro",
        sortable: true,
    },
    {
        label: "DESCARGAR",
        key: "descargar",
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
    tipo_certificado_id: "todos",
    tipo_pago: "todos",
    sucursal_id: "todos",
    medico: "",
    fecha: "",
    filtro: [],
});

const updateDatatable = async () => {
    if (miTable.value) {
        await miTable.value.cargarDatos();
    }
};

const eliminarCertificado = (item) => {
    Swal.fire({
        title: "¿Quierés eliminar este registro?",
        html: `<strong>Nro. de registro: ${item.id}</strong>`,
        showCancelButton: true,
        confirmButtonText: "Si, eliminar",
        cancelButtonText: "No, cancelar",
        denyButtonText: `No, cancelar`,
        customClass: {
            confirmButton: "btn-danger",
        },
    }).then(async (result) => {
        /* Read more about isConfirmed, isDenied below */
        if (result.isConfirmed) {
            let respuesta = await axiosDelete(
                route("certificados.destroy", item.id),
            );
            if (respuesta && respuesta.sw) {
                updateDatatable();
            }
        }
    });
};
</script>
<template>
    <Head title="Certificados"></Head>
    <Content>
        <template #header>
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0">Certificados</h1>
                </div>
                <!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item">
                            <Link :href="route('inicio')">Inicio</Link>
                        </li>
                        <li class="breadcrumb-item active">Certificados</li>
                    </ol>
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->
        </template>
        <div class="row">
            <div class="col-md-12">
                <div class="row">
                    <div class="col-md-4">
                        <Link
                            v-if="
                                props_page.auth?.user.permisos == '*' ||
                                props_page.auth?.user.permisos.includes(
                                    'certificados.create',
                                )
                            "
                            class="btn btn-primary"
                            :href="route('certificados.create')"
                        >
                            <i class="fa fa-plus"></i> Nuevo Certificado
                        </Link>
                    </div>
                    <div class="col-md-12 my-1">
                        <div class="row">
                            <div class="col-md-2">
                                <small class="text-muted text-xs"
                                    >Cliente</small
                                >
                                <input
                                    type="search"
                                    v-model="multiSearch.cliente"
                                    placeholder="Cliente"
                                    class="form-control border-1 border-right-0"
                                />
                            </div>
                            <div class="col-md-2">
                                <small class="text-muted text-xs"
                                    >Tipo de Certificado</small
                                >
                                <el-select
                                    type="search"
                                    v-model="multiSearch.tipo_certificado_id"
                                    placeholder="Tipo de Certificado"
                                    size="large"
                                    filterable
                                >
                                    <el-option
                                        v-for="item in listTipoCertificados"
                                        :key="item.id"
                                        :value="item.id"
                                        :label="item.nombre"
                                    ></el-option>
                                </el-select>
                            </div>
                            <div class="col-md-2">
                                <small class="text-muted text-xs"
                                    >Tipo de Pago</small
                                >
                                <el-select
                                    type="search"
                                    v-model="multiSearch.tipo_pago"
                                    placeholder="Tipo de Certificado"
                                    size="large"
                                    filterable
                                >
                                    <el-option
                                        v-for="item in listTipoPagos"
                                        :key="item.value"
                                        :value="item.value"
                                        :label="item.label"
                                    ></el-option>
                                </el-select>
                            </div>
                            <div
                                class="col-md-2"
                                v-if="props_page.auth.user.tipo != 'MÉDICO'"
                            >
                                <small class="text-muted text-xs"
                                    >Sucursal</small
                                >
                                <el-select
                                    type="search"
                                    v-model="multiSearch.sucursal_id"
                                    placeholder="Tipo de Certificado"
                                    size="large"
                                    filterable
                                >
                                    <el-option
                                        v-for="item in listSucursals"
                                        :key="item.id"
                                        :value="item.id"
                                        :label="item.nombre"
                                    ></el-option>
                                </el-select>
                            </div>
                            <div
                                class="col-md-2"
                                v-if="props_page.auth.user.tipo != 'MÉDICO'"
                            >
                                <small class="text-muted text-xs">Médico</small>
                                <input
                                    type="search"
                                    v-model="multiSearch.medico"
                                    placeholder="Médico"
                                    class="form-control border-1 border-right-0"
                                />
                            </div>
                            <div class="col-md-2">
                                <small class="text-muted text-xs">Fecha</small>
                                <input
                                    type="date"
                                    v-model="multiSearch.fecha"
                                    placeholder="Fecha"
                                    class="form-control border-1 border-right-0"
                                />
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <MiTable
                            :tableClass="'bg-white mitabla'"
                            ref="miTable"
                            :cols="headers"
                            :api="true"
                            :url="route('certificados.paginado')"
                            :numPages="5"
                            :multiSearch="multiSearch"
                            :syncOrderBy="'id'"
                            :syncOrderAsc="'DESC'"
                            table-responsive
                            :header-class="'bg__primary'"
                            fixed-header
                        >
                            <template #descargar="{ item }">
                                <a
                                    v-if="item.url_archivo1"
                                    :href="item.url_archivo1"
                                    class="btn btn-xs btn-outline-primary"
                                    target="_blank"
                                    ><i class="fa fa-download"></i> Archivo 1</a
                                >
                                <br />
                                <a
                                    v-if="item.url_archivo2"
                                    :href="item.url_archivo2"
                                    class="btn btn-xs btn-outline-primary"
                                    target="_blank"
                                    ><i class="fa fa-download"></i> Archivo 2</a
                                >
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
                                <span
                                    >{{ item.user.nombre }}
                                    {{ item.user.paterno }}
                                    {{ item.user.materno }}
                                </span>
                            </template>

                            <template #accion="{ item }">
                                <template
                                    v-if="
                                        props_page.auth?.user.permisos == '*' ||
                                        props_page.auth?.user.permisos.includes(
                                            'certificados.edit',
                                        )
                                    "
                                >
                                    <el-tooltip
                                        class="box-item"
                                        effect="dark"
                                        content="Editar"
                                        placement="left-start"
                                    >
                                        <Link
                                            :href="
                                                route(
                                                    'certificados.edit',
                                                    item.id,
                                                )
                                            "
                                            class="btn btn-warning"
                                        >
                                            <i class="fa fa-pen"></i></Link
                                    ></el-tooltip>
                                </template>

                                <template
                                    v-if="
                                        props_page.auth?.user.permisos == '*' ||
                                        props_page.auth?.user.permisos.includes(
                                            'certificados.destroy',
                                        )
                                    "
                                >
                                    <el-tooltip
                                        class="box-item"
                                        effect="dark"
                                        content="Eliminar"
                                        placement="left-start"
                                    >
                                        <button
                                            class="btn btn-danger"
                                            @click="eliminarCertificado(item)"
                                        >
                                            <i
                                                class="fa fa-trash-alt"
                                            ></i></button
                                    ></el-tooltip>
                                </template>
                            </template>
                        </MiTable>
                    </div>
                </div>
            </div>
        </div>
    </Content>
</template>
