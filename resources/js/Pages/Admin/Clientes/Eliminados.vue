<script setup>
import Content from "@/Components/Content.vue";
import MiTable from "@/Components/MiTable.vue";
import { Head, Link, router, usePage } from "@inertiajs/vue3";
import { useClientes } from "@/composables/clientes/useClientes";
import { useAxios } from "@/composables/axios/useAxios";
import { ref, onMounted, onBeforeMount } from "vue";
import { useAppStore } from "@/stores/aplicacion/appStore";
import Formulario from "./Formulario.vue";
import Certificado from "./Certificado.vue";
const { props: props_page } = usePage();
const appStore = useAppStore();
onBeforeMount(() => {
    appStore.startLoading();
});

onMounted(() => {
    appStore.stopLoading();
});

const { setCliente, limpiarCliente, form } = useClientes();
const { axiosDelete, axiosPost } = useAxios();

const miTable = ref(null);
const headers =
    props_page.auth?.user.tipo == "ADMINISTRADOR" ||
    props_page.auth?.user.tipo == "GERENTE"
        ? [
              {
                  label: "NRO.",
                  key: "id",
                  sortable: true,
                  width: "4%",
              },
              {
                  label: "NOMBRE",
                  key: "nombre",
                  sortable: true,
              },
              {
                  label: "AP. PATERNO",
                  key: "paterno",
                  sortable: true,
              },
              {
                  label: "AP. MATERNO",
                  key: "materno",
                  sortable: true,
              },
              {
                  label: "C.I.",
                  key: "full_ci",
                  sortable: true,
              },
              {
                  label: "FECHA NACIMIENTO",
                  key: "fecha_nac_t",
                  sortable: true,
              },
              {
                  label: "EDAD",
                  key: "edad",
                  sortable: true,
              },
              {
                  label: "TELÉFONO/CELULAR",
                  key: "cel",
                  sortable: true,
              },
              {
                  label: "REGISTRADO POR",
                  key: "user",
                  keySortable: "user_id",
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
          ]
        : [
              {
                  label: "NRO.",
                  key: "id",
                  sortable: true,
                  width: "4%",
              },
              {
                  label: "NOMBRE",
                  key: "nombre",
                  sortable: true,
              },
              {
                  label: "AP. PATERNO",
                  key: "paterno",
                  sortable: true,
              },
              {
                  label: "AP. MATERNO",
                  key: "materno",
                  sortable: true,
              },
              {
                  label: "C.I.",
                  key: "full_ci",
                  sortable: true,
              },
              {
                  label: "FECHA NACIMIENTO",
                  key: "fecha_nac_t",
                  sortable: true,
              },
              {
                  label: "EDAD",
                  key: "edad",
                  sortable: true,
              },
              {
                  label: "TELÉFONO/CELULAR",
                  key: "cel",
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
    search: "",
    filtro: [],
});

const muestra_formulario = ref(false);
const muestra_form_certificado = ref(false);

const updateDatatable = async () => {
    if (miTable.value) {
        await miTable.value.cargarDatos();
        limpiarCliente();
        muestra_formulario.value = false;
    }
};

const restaurar = (item) => {
    Swal.fire({
        title: "¿Quierés restaurar este registro?",
        html: `<strong>${item.nombre} ${item.paterno} ${item.materno}</strong>`,
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
                route("clientes.restaurar", item.id),
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

const eliminarCliente = (item) => {
    Swal.fire({
        title: "¿Quierés eliminar de forma permanente este registro?",
        html: `<strong>${item.nombre} ${item.paterno} ${item.materno}</strong><h4>Esta acción no se podra deshacer!!!</h4>`,
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
                route("clientes.eliminacionPermanente", item.id),
            );
            if (respuesta && respuesta.sw) {
                updateDatatable();
            }
        }
    });
};
</script>
<template>
    <Head title="Clientes Eliminados"></Head>
    <Content>
        <template #header>
            <div class="row">
                <div class="col-sm-6">
                    <h1 class="m-0">
                        <i class="fa fa-user-friends"></i> Clientes Eliminados
                    </h1>
                </div>
                <!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item">
                            <Link :href="route('inicio')">Inicio</Link>
                        </li>
                        <li class="breadcrumb-item">
                            <Link :href="route('clientes.index')"
                                >Clientes</Link
                            >
                        </li>
                        <li class="breadcrumb-item active">Eliminados</li>
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
                                    'clientes.index',
                                )
                            "
                            class="btn btn-default text-sm"
                            :href="route('clientes.index')"
                        >
                            <i class="fa fa-arrow-left"></i> Volver
                        </Link>
                    </div>
                    <div class="col-md-8 my-1">
                        <div class="row justify-content-end">
                            <div class="col-md-5">
                                <div
                                    class="input-group"
                                    style="align-items: end"
                                >
                                    <input
                                        v-model="multiSearch.search"
                                        placeholder="Buscar"
                                        class="form-control border-1 border-right-0"
                                    />
                                    <div class="input-append">
                                        <button
                                            class="btn btn-default rounded-0 border-left-0"
                                            @click="updateDatos"
                                        >
                                            <i class="fa fa-search"></i>
                                        </button>
                                    </div>
                                </div>
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
                            :url="route('clientes.paginadoEliminados')"
                            :numPages="5"
                            :multiSearch="multiSearch"
                            :syncOrderBy="'id'"
                            :syncOrderAsc="'DESC'"
                            table-responsive
                            :header-class="'bg__primary'"
                            fixed-header
                        >
                            <template #user="{ item }">
                                <span
                                    >{{ item.user.nombre }}
                                    {{ item.user.paterno }}
                                    {{ item.user.materno }}</span
                                >
                            </template>
                            <template #accion="{ item }">
                                <template
                                    v-if="
                                        props_page.auth?.user.permisos == '*' ||
                                        props_page.auth?.user.permisos.includes(
                                            'clientes.restaurar',
                                        )
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
                                        props_page.auth?.user.permisos == '*' ||
                                        props_page.auth?.user.permisos.includes(
                                            'clientes.eliminacionPermanente',
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
                                            @click="eliminarCliente(item)"
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
        <Formulario
            v-if="muestra_formulario"
            :form="form"
            :muestra_formulario="muestra_formulario"
            @envio-formulario="updateDatatable"
            @cerrar-formulario="muestra_formulario = false"
        ></Formulario>
        <Certificado
            v-if="muestra_form_certificado"
            :form="form"
            :muestra_formulario="muestra_form_certificado"
            @envio-formulario="muestra_form_certificado = false"
            @cerrar-formulario="muestra_form_certificado = false"
        ></Certificado>
    </Content>
</template>
