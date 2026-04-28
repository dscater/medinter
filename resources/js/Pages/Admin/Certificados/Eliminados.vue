<script setup>
import Content from "@/Components/Content.vue";
import MiTable from "@/Components/MiTable.vue";
import { Head, Link, router, usePage } from "@inertiajs/vue3";
import { useCertificados } from "@/composables/certificados/useCertificados";
import { useAxios } from "@/composables/axios/useAxios";
import { ref, onMounted, onBeforeMount } from "vue";
import { useAppStore } from "@/stores/aplicacion/appStore";
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
        // listTipoCertificados.value.unshift({
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
    cargarTipoCertificados();
    cargarTipoPagos();
    cargarSucursals();
    appStore.stopLoading();
});

const { setCertificado, limpiarCertificado, form } = useCertificados();
const { axiosDelete, axiosPost } = useAxios();

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
        label: "INICIADO",
        key: "inicio",
        sortable: true,
        keySortable: "inicio_id",
    },
    {
        label: "ATENDIDO",
        key: "user",
        sortable: true,
        keySortable: "user_id",
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
    // tipo_certificado_id: [],
    // tipo_pago: "todos",
    // sucursal_id: "todos",
    // medico: "",
    // fecha: "",
    filtro: [],
});

const updateDatatable = async () => {
    if (miTable.value) {
        muestra_formulario.value = false;
        limpiarCertificado();
        await miTable.value.cargarDatos();
    }
};

const restaurar = (item) => {
    Swal.fire({
        title: "¿Quierés restaurar este registro?",
        html: `<strong>Nro. de registro: ${item.id}</strong>`,
        showCancelButton: true,
        confirmButtonText: "Si, restaurar",
        cancelButtonText: "No, cancelar",
        denyButtonText: `No, cancelar`,
        customClass: {
            confirmButton: "btn-success",
        },
    }).then(async (result) => {
        /* Read more about isConfirmed, isDenied below */
        if (result.isConfirmed) {
            let respuesta = await axiosPost(
                route("certificados.restaurar", item.id),
                {
                    _method: "PATCH",
                },
            );
            if (respuesta && respuesta.sw) {
                updateDatatable();
            }
        }
    });
};

const eliminarCertificado = (item) => {
    Swal.fire({
        title: "¿Quierés eliminar este registro?",
        html: `<strong>Nro. de registro: ${item.id}</strong><h4>Esta acción no se podra deshacer!!!</h4>`,
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
                route("certificados.eliminacionPermanente", item.id),
            );
            if (respuesta && respuesta.sw) {
                updateDatatable();
            }
        }
    });
};

const muestra_reporte = ref(false);
const muestra_formulario = ref(false);
const editarDetalle = (item) => {
    limpiarCertificado();
    setCertificado({ ...item });
    muestra_formulario.value = true;
};
</script>
<template>
    <Head title="Certificados Eliminados"></Head>
    <Content>
        <template #header>
            <div class="row">
                <div class="col-sm-6">
                    <h1 class="m-0">
                        <i class="fa fa-clipboard-list"></i> Certificados
                        Eliminados
                    </h1>
                </div>
                <!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item">
                            <Link :href="route('inicio')">Inicio</Link>
                        </li>
                        <li class="breadcrumb-item active">
                            Certificados Eliminados
                        </li>
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
                                    'certificados.index',
                                )
                            "
                            class="btn btn-default text-sm"
                            :href="route('certificados.index')"
                        >
                            <i class="fa fa-arrow-left"></i> Volver
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
                                    >Nro. de C.I.</small
                                >
                                <input
                                    type="search"
                                    v-model="multiSearch.ci"
                                    placeholder="Nro. de C.I."
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
                            :url="route('certificados.paginadoEliminados')"
                            :numPages="5"
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
                                        <li
                                            v-for="d in item.certificado_detalles"
                                        >
                                            {{ d.tipo_certificado?.nombre }}

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
                            <template #total="{ item }">
                                <span
                                    :class="{
                                        'badge badge-danger text-sm':
                                            item.saldo > 0,
                                    }"
                                >
                                    {{ item.total }}
                                </span>
                            </template>
                            <template #tipo="{ item }">
                                <span>{{ item.tipo }} </span>
                                <span v-if="item.tramitador">
                                    - {{ item.tramitador.nombre }}
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

                            <template #inicio="{ item }">
                                <span
                                    >{{ item.inicio.nombre }}
                                    {{ item.inicio.paterno }}
                                    {{ item.inicio.materno }}
                                </span>
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
                                        (props_page.auth?.user.id ==
                                            item.user_id ||
                                            props_page.auth?.user.id ==
                                                item.inicio_id ||
                                            props_page.auth?.user.tipo ==
                                                'ADMINISTRADOR' ||
                                            props_page.auth?.user.tipo ==
                                                'GERENTE') &&
                                        (props_page.auth?.user.permisos ==
                                            '*' ||
                                            props_page.auth?.user.permisos.includes(
                                                'certificados.restaurar',
                                            ))
                                    "
                                >
                                    <el-tooltip
                                        class="box-item"
                                        effect="dark"
                                        content="Restaurar"
                                        placement="left-start"
                                    >
                                        <button
                                            class="btn btn-success"
                                            @click="restaurar(item)"
                                        >
                                            <i class="fa fa-sync"></i></button
                                    ></el-tooltip>
                                </template>

                                <template
                                    v-if="
                                        (props_page.auth?.user.id ==
                                            item.user_id ||
                                            props_page.auth?.user.id ==
                                                item.inicio_id ||
                                            props_page.auth?.user.tipo ==
                                                'ADMINISTRADOR' ||
                                            props_page.auth?.user.tipo ==
                                                'GERENTE') &&
                                        (props_page.auth?.user.permisos ==
                                            '*' ||
                                            props_page.auth?.user.permisos.includes(
                                                'certificados.destroy',
                                            ))
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
