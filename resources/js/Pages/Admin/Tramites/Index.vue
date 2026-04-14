<script setup>
import Content from "@/Components/Content.vue";
import MiTable from "@/Components/MiTable.vue";
import { Head, Link, router, usePage } from "@inertiajs/vue3";
import { useTramites } from "@/composables/tramites/useTramites";
import { useAxios } from "@/composables/axios/useAxios";
import { ref, onMounted, onBeforeMount } from "vue";
import { useAppStore } from "@/stores/aplicacion/appStore";
const { props: props_page } = usePage();
const appStore = useAppStore();
onBeforeMount(() => {
    appStore.startLoading();
});

const listTipoTramites = ref([]);
const listTipoPagos = ref([]);
const listSucursals = ref([]);
const cargarTipoTramites = () => {
    axios.get(route("tipo_certificados.listado")).then((response) => {
        listTipoTramites.value = response.data.tipo_certificados;
        // listTipoTramites.value.unshift({
        //     id: "todos",
        //     nombre: "TODOS",
        // });
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
    cargarTipoTramites();
    cargarTipoPagos();
    cargarSucursals();
    appStore.stopLoading();
});

const { setTramite, limpiarTramite } = useTramites();
const { axiosDelete } = useAxios();

const miTable = ref(null);
const headers = [
    {
        label: "CÓDIGO",
        key: "codigo",
        sortable: true,
        width: "4%",
    },
    {
        label: "TRAMITADOR",
        key: "tramitador.nombre",
        sortable: true,
    },
    {
        label: "NRO. REGISTROS",
        key: "tramite_clientes_count",
        sortable: true,
    },
    {
        label: "USUARIO",
        key: "user",
        sortable: true,
    },
    {
        label: "FECHA REGISTRO",
        key: "fecha_registro",
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
    tramitador: "",
    tipo_certificado_id: [],
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

const eliminarTramite = (item) => {
    Swal.fire({
        title: "¿Quierés eliminar este registro?",
        html: `<strong>Código: ${item.codigo}</strong>`,
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
                route("tramites.destroy", item.id),
            );
            if (respuesta && respuesta.sw) {
                updateDatatable();
            }
        }
    });
};
</script>
<template>
    <Head title="Trámites"></Head>
    <Content>
        <template #header>
            <div class="row">
                <div class="col-sm-6">
                    <h1 class="m-0"><i class="fa fa-folder"></i> Trámites</h1>
                </div>
                <!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item">
                            <Link :href="route('inicio')">Inicio</Link>
                        </li>
                        <li class="breadcrumb-item active">Trámites</li>
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
                                    'tramites.create',
                                )
                            "
                            class="btn btn-primary text-sm"
                            :href="route('tramites.create')"
                        >
                            <i class="fa fa-plus"></i> Nuevo Tramite
                        </Link>
                    </div>
                    <div class="col-md-12 my-1">
                        <div class="row">
                            <div class="col-md-2">
                                <small class="text-muted text-xs"
                                    >Tramitador</small
                                >
                                <input
                                    type="search"
                                    v-model="multiSearch.tramitador"
                                    placeholder="Tramitador"
                                    class="form-control border-1 border-right-0"
                                />
                            </div>
                            <!-- <div class="col-md-2">
                                <small class="text-muted text-xs"
                                    >Tipo de Tramite</small
                                >
                                <el-select
                                    type="search"
                                    v-model="multiSearch.tipo_certificado_id"
                                    placeholder="Tipo de Tramite"
                                    size="large"
                                    multiple
                                    filterable
                                >
                                    <el-option
                                        v-for="item in listTipoTramites"
                                        :key="item.id"
                                        :value="item.id"
                                        :label="item.nombre"
                                    ></el-option>
                                </el-select>
                            </div> -->
                            <!-- <div class="col-md-2">
                                <small class="text-muted text-xs"
                                    >Tipo de Pago</small
                                >
                                <el-select
                                    type="search"
                                    v-model="multiSearch.tipo_pago"
                                    placeholder="Tipo de Tramite"
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
                            </div> -->
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
                                    placeholder="Tipo de Tramite"
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
                                <small class="text-muted text-xs"
                                    >Usuario</small
                                >
                                <input
                                    type="search"
                                    v-model="multiSearch.medico"
                                    placeholder="Usuario"
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
                            :url="route('tramites.paginado')"
                            :numPages="5"
                            :multiSearch="multiSearch"
                            :syncOrderBy="'id'"
                            :syncOrderAsc="'DESC'"
                            table-responsive
                            :header-class="'bg__primary'"
                            fixed-header
                        >
                            <template #fecha_registro="{ item }">
                                <span>{{ item.fecha_t }} {{ item.hora }}</span>
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
                                            'tramites.edit',
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
                                                route('tramites.edit', item.id)
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
                                            'tramites.destroy',
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
                                            @click="eliminarTramite(item)"
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
