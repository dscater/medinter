<script setup>
import Content from "@/Components/Content.vue";
import MiTableSkeleton from "@/Components/MiTableSkeleton.vue";
import MiTable from "@/Components/MiTable.vue";
import { Head, Link, router, usePage } from "@inertiajs/vue3";
import { useClientes } from "@/composables/clientes/useClientes";
import { useAxios } from "@/composables/axios/useAxios";
import { ref } from "vue";
import Formulario from "./Formulario.vue";
import Certificado from "./Certificado.vue";
const { props: props_page } = usePage();

const { setCliente, limpiarCliente, form } = useClientes();
const { axiosDelete } = useAxios();

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

const obtenerFechaLocal = (fecha = new Date()) => {
    const anio = fecha.getFullYear();
    const mes = String(fecha.getMonth() + 1).padStart(2, "0");
    const dia = String(fecha.getDate()).padStart(2, "0");

    return `${anio}-${mes}-${dia}`;
};

const hoy = new Date();

const fechaInicio = new Date(hoy);
fechaInicio.setDate(fechaInicio.getDate() - 6);

const multiSearch = ref({
    cliente: "",
    ci: "",
    fecha_ini: obtenerFechaLocal(fechaInicio),
    fecha_fin: obtenerFechaLocal(hoy),
    filtro: [],
});

const muestra_formulario = ref(false);
const muestra_form_certificado = ref(false);

const agregarRegistro = () => {
    limpiarCliente();
    muestra_formulario.value = true;
};

const updateDatatable = async () => {
    if (miTable.value) {
        await miTable.value.cargarDatos();
        limpiarCliente();
        muestra_formulario.value = false;
    }
};

const eliminarCliente = (item) => {
    Swal.fire({
        title: "¿Quierés eliminar este registro?",
        html: `<strong>${item.nombre} ${item.paterno} ${item.materno}</strong>`,
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
                route("clientes.destroy", item.id),
            );
            if (respuesta && respuesta.sw) {
                updateDatatable();
            }
        }
    });
};

const tablaLista = ref(false);
const tablaError = ref(false);

function tablaPreparada() {
    tablaLista.value = true;
    tablaError.value = false;
}

function tablaConError() {
    tablaError.value = true;
}
</script>
<template>
    <Head title="Clientes"></Head>
    <Content>
        <template #header>
            <div class="row">
                <div class="col-sm-6">
                    <h1 class="m-0">
                        <i class="fa fa-user-friends"></i> Clientes
                    </h1>
                </div>
                <!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item">
                            <Link :href="route('inicio')">Inicio</Link>
                        </li>
                        <li class="breadcrumb-item active">Clientes</li>
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
                        <button
                            v-if="
                                props_page.auth?.user.permisos == '*' ||
                                props_page.auth?.user.permisos.includes(
                                    'clientes.create',
                                )
                            "
                            type="button"
                            class="btn btn-primary text-sm"
                            @click="agregarRegistro"
                        >
                            <i class="fa fa-plus"></i> Nuevo Cliente
                        </button>
                        <Link
                            v-if="
                                props_page.auth?.user.permisos == '*' ||
                                props_page.auth?.user.permisos.includes(
                                    'clientes.eliminados',
                                )
                            "
                            class="btn btn-outline-danger text-sm ml-1"
                            :href="route('clientes.eliminados')"
                        >
                            <i class="fa fa-trash"></i> Eliminados
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
                            <div class="col-md-4">
                                <div class="row">
                                    <div class="col-6">
                                        <small class="text-muted text-xs"
                                            >Desde</small
                                        >
                                        <input
                                            type="date"
                                            class="form-control"
                                            v-model="multiSearch.fecha_ini"
                                        />
                                    </div>
                                    <div class="col-6">
                                        <small class="text-muted text-xs"
                                            >Hasta</small
                                        >
                                        <input
                                            type="date"
                                            class="form-control"
                                            v-model="multiSearch.fecha_fin"
                                        />
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <div
                            v-if="!tablaLista && !tablaError"
                            class="table-loading-overlay"
                        >
                            <MiTableSkeleton
                                theme="light"
                                :rows="8"
                                :columns="headers.length || 5"
                                :show-toolbar="true"
                                :show-pagination="true"
                            />
                        </div>

                        <div v-if="tablaError" class="table-error-message">
                            No se pudieron cargar los registros.
                        </div>
                        <MiTable
                            v-show="tablaLista"
                            :tableClass="'bg-white mitabla'"
                            ref="miTable"
                            :cols="headers"
                            :api="true"
                            :url="route('clientes.paginado')"
                            :numPages="5"
                            :multiSearch="multiSearch"
                            :syncOrderBy="'id'"
                            :syncOrderAsc="'DESC'"
                            table-responsive
                            :header-class="'bg__primary'"
                            fixed-header
                            @ready="tablaPreparada"
                            @load-error="tablaConError"
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
                                            'certificados.registroCliente',
                                        )
                                    "
                                >
                                    <el-tooltip
                                        class="box-item"
                                        effect="dark"
                                        content="Certificado"
                                        placement="left-start"
                                    >
                                        <button
                                            class="btn btn-primary"
                                            @click="
                                                setCliente(item);
                                                muestra_form_certificado = true;
                                            "
                                        >
                                            <i
                                                class="fa fa-clipboard-list"
                                            ></i></button
                                    ></el-tooltip>
                                </template>
                                <template
                                    v-if="
                                        props_page.auth?.user.permisos == '*' ||
                                        props_page.auth?.user.permisos.includes(
                                            'clientes.edit',
                                        )
                                    "
                                >
                                    <el-tooltip
                                        class="box-item"
                                        effect="dark"
                                        content="Editar"
                                        placement="left-start"
                                    >
                                        <button
                                            class="btn btn-warning"
                                            @click="
                                                setCliente(item);
                                                muestra_formulario = true;
                                            "
                                        >
                                            <i class="fa fa-pen"></i></button
                                    ></el-tooltip>
                                </template>

                                <template
                                    v-if="
                                        props_page.auth?.user.permisos == '*' ||
                                        props_page.auth?.user.permisos.includes(
                                            'clientes.destroy',
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
