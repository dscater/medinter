<script setup>
import Content from "@/Components/Content.vue";
import { Head, Link, router, usePage } from "@inertiajs/vue3";
import MiTable from "@/Components/MiTable.vue";
import { ref, onMounted, onBeforeMount, computed, nextTick, watch } from "vue";
import { useAppStore } from "@/stores/aplicacion/appStore";
import { useLoginUserStore } from "@/stores/login_users/loginUserStore";
const loginUserStore = useLoginUserStore();

// TOAST
import { toast } from "vue3-toastify";
import "vue3-toastify/dist/index.css";
const { props: props_page } = usePage();
const appStore = useAppStore();
onBeforeMount(() => {
    appStore.startLoading();
});

const goBack = () => {
    if (window.history.length > 1) {
        window.history.back();
    } else {
        router.visit(route("inicio"));
    }
};

const miTable1 = ref(null);
const miTable2 = ref(null);
const headers1 = ref([
    {
        label: "Nro.",
        width: "2%",
        isIndex: true,
        key: "id",
        fixed: true,
    },
    {
        label: "Fecha",
        key: "fecha_verificado",
    },
    {
        label: "Sucursal",
        key: "sucursal.nombre",
    },
    {
        label: "Paciente",
        key: "cliente",
    },
    {
        label: "Descripción",
        key: "descripcion",
    },
    {
        label: "Médico",
        key: "medico",
    },
]);

const listPagosVerificados = ref([]);
const listPagosSinVerificar = ref([]);
const sumaPorTipos = ref([]);
const sumaPorTiposSinVerificar = ref([]);
const suma_total_tipos = ref([]);
const colsIniciado = ref(false);
const cargarPagosVerificados = async () => {
    if (!filtros.value.fecha_ini || !filtros.value.fecha_fin) {
        return;
    }
    axios
        .get(route("pagos.verificados"), {
            params: {
                fecha_ini: filtros.value.fecha_ini,
                fecha_fin: filtros.value.fecha_fin,
                sucursal_id: filtros.value.sucursal_id,
                medico_id: filtros.value.medico_id,
            },
        })
        .then(async (response) => {
            listPagosVerificados.value = response.data.pagos;
            sumaPorTipos.value = response.data.suma_tipos;
            listPagosSinVerificar.value = response.data.pagos_sin_verificar;
            sumaPorTiposSinVerificar.value =
                response.data.suma_tipos_sin_verificar;
            suma_total_tipos.value = response.data.suma_total_tipos;
            appStore.stopLoading();
        });
};

const obtenerFechaActual = () => {
    const fecha = new Date();
    const anio = fecha.getFullYear();
    const mes = String(fecha.getMonth() + 1).padStart(2, "0"); // Mes empieza desde 0
    const dia = String(fecha.getDate()).padStart(2, "0"); // Día del mes
    return `${anio}-${mes}-${dia}`;
};

const listSucursals = ref([]);
const cargarSucursals = () => {
    axios.get(route("sucursals.listado")).then((response) => {
        listSucursals.value = response.data.sucursals;
        listSucursals.value.unshift({
            id: "todos",
            nombre: "TODOS",
        });
    });
};

const listTipoPagos = ref([]);
const cargarTipoPagos = async () => {
    axios.get(route("tipo_pagos.listado")).then(async (response) => {
        listTipoPagos.value = response.data;
        // crear columnas dinamicas
        if (!colsIniciado.value)
            listTipoPagos.value.forEach((elem) => {
                headers1.value.push({
                    label: elem.value,
                    key: "monto",
                    fixed: "right",
                    sortable: true,
                    classTd: (item) => {
                        return "justify-content-end";
                    },
                    render: (item, index) => {
                        if (item.tipo_pago != elem.value) return "-";
                        // if (item.tipo !== elem.value) return "";
                        return item.monto || "";
                    },
                });
            });

        colsIniciado.value = true;

        await nextTick();
        if (miTable1.value) {
            miTable1.value.cargarDatos();
        }

        if (miTable2.value) {
            miTable2.value.cargarDatos();
        }
    });
};

const listMedicos = ref([]);
const cargarMedicos = () => {
    axios
        .get(route("usuarios.byTipo"), {
            params: {
                tipo: "MÉDICO",
            },
        })
        .then((response) => {
            listMedicos.value = response.data.usuarios;
        });
};

const filtros = ref({
    fecha_ini: obtenerFechaActual(),
    fecha_fin: obtenerFechaActual(),
    sucursal_id: "",
    medico_id: "",
});

const total = computed(() => {
    const total = listPagosVerificados.value.reduce(
        (sum, p) => sum + Number(p.monto),
        0,
    );

    return total.toFixed(2);
});

const totalSinVerificar = computed(() => {
    const total = listPagosSinVerificar.value.reduce(
        (sum, p) => sum + Number(p.monto),
        0,
    );

    return total.toFixed(2);
});

const totalGeneral = computed(() => {
    const total = Object.values(suma_total_tipos.value).reduce(
        (sum, value) => sum + Number(value || 0),
        0,
    );

    return total.toFixed(2);
});

const generando = ref(false);
const exportar = (formato) => {
    generando.value = true;
    const url = route("reportes.exportarCaja", {
        fecha_ini: filtros.value.fecha_ini,
        fecha_fin: filtros.value.fecha_fin,
        sucursal_id: filtros.value.sucursal_id,
        medico_id: filtros.value.medico_id,
        formato,
    });
    window.open(url, "_blank");
    setTimeout(() => {
        generando.value = false;
    }, 500);
};

watch(
    () => loginUserStore.login_user,
    (newVal) => {
        if (newVal) {
            filtros.value.sucursal_id =
                props_page.auth.user.tipo == "ADMINISTRADOR" ||
                props_page.auth.user.tipo == "GERENTE"
                    ? "todos"
                    : newVal.sucursal_id;
            cargarPagosVerificados();
        }
    },
    { immediate: true },
);

onMounted(() => {});

onBeforeMount(() => {
    cargarSucursals();
    cargarTipoPagos();
    cargarMedicos();
});
</script>
<template>
    <Head title="Arqueo de Caja"></Head>
    <Content>
        <template #header>
            <div class="row">
                <div class="col-sm-6">
                    <h1 class="m-0">
                        <i class="fa fa-cash-register"></i> Arqueo de Caja
                    </h1>
                </div>
                <!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item">
                            <Link :href="route('inicio')">Inicio</Link>
                        </li>
                        <li class="breadcrumb-item active">Arqueo de Caja</li>
                    </ol>
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->
        </template>
        <div class="row pb-5">
            <div class="col-md-12">
                <div class="row mt-1">
                    <div class="col-md-6">
                        <div class="row">
                            <div class="col-md-6">
                                <label class="mb-0 text-xs text-muted"
                                    >Fecha inicio</label
                                >
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text bg-white"
                                            ><i class="fa fa-calendar-alt"></i
                                        ></span>
                                    </div>
                                    <input
                                        type="date"
                                        class="form-control"
                                        placeholder="Código Trámite"
                                        v-model="filtros.fecha_ini"
                                        @change="cargarPagosVerificados"
                                        @keyup="cargarPagosVerificados"
                                    />
                                </div>
                            </div>
                            <div class="col-md-6">
                                <label class="mb-0 text-xs text-muted"
                                    >Fecha fin</label
                                >
                                <div class="input-group">
                                    <div class="input-group-prepend">
                                        <span class="input-group-text bg-white"
                                            ><i class="fa fa-calendar-alt"></i
                                        ></span>
                                    </div>
                                    <input
                                        type="date"
                                        class="form-control"
                                        placeholder="Código Trámite"
                                        v-model="filtros.fecha_fin"
                                        @change="cargarPagosVerificados"
                                        @keyup="cargarPagosVerificados"
                                    />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <label class="mb-0 text-xs text-muted">Sucursal</label>
                        <el-select
                            v-model="filtros.sucursal_id"
                            filterable
                            placeholder="- Seleccione -"
                            size="large"
                            @change="cargarPagosVerificados"
                        >
                            <el-option
                                v-for="item in listSucursals"
                                :key="item.id"
                                :value="item.id"
                                :label="item.nombre"
                            >
                            </el-option>
                        </el-select>
                    </div>
                    <div
                        class="col-md-3"
                        v-if="
                            props_page.auth.user.tipo == 'ADMINISTRADOR' ||
                            props_page.auth.user.tipo == 'GERENTE'
                        "
                    >
                        <label class="mb-0 text-xs text-muted">Médico</label>
                        <el-select
                            v-model="filtros.medico_id"
                            filterable
                            placeholder="- Seleccione -"
                            size="large"
                            clearable
                            @change="cargarPagosVerificados"
                        >
                            <el-option
                                v-for="item in listMedicos"
                                :key="item.id"
                                :value="item.id"
                                :label="`${item.nombre} ${item.paterno} ${item.materno}`"
                            >
                            </el-option>
                        </el-select>
                    </div>
                </div>
                <div class="row mb-1">
                    <div class="col-md-9 d-flex align-items-end">
                        <span class="text-primary">
                            {{ listPagosVerificados.length }}
                            Registros</span
                        >
                        <span
                            v-if="listPagosSinVerificar.length > 0"
                            class="text-danger font-weight-600"
                        >
                            | {{ listPagosSinVerificar.length }} sin
                            verificar</span
                        >
                    </div>
                    <div class="col-md-3">
                        <div class="row mt-4">
                            <div class="col-md-6">
                                <button
                                    class="btn btn-danger w-100"
                                    @click="exportar('pdf')"
                                    :disabled="generando"
                                >
                                    PDF <i class="fa fa-file-pdf"></i>
                                </button>
                            </div>
                            <div class="col-md-6">
                                <button
                                    class="btn btn-success w-100"
                                    @click="exportar('excel')"
                                    :disabled="generando"
                                >
                                    Excel <i class="fa fa-file-excel"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <MiTable
                v-show="listPagosVerificados.length > 0"
                ref="miTable1"
                :tableClass="'bg-white mitabla'"
                :header-class="'bg__primary'"
                :cols="headers1"
                :data="listPagosVerificados"
                :con-paginacion="false"
                fix-cols
                fixed-header
                table-height="40vh"
            >
                <template #fecha_verificado="{ item }">
                    <span>{{ item.fecha_verificado_t }} {{ item.hora }}</span>
                </template>
                <template #cliente="{ item }">
                    <span>{{ item.cliente.full_name }}</span>
                    <br />
                    <span>{{ item.cliente.full_ci }}</span>
                </template>

                <template #descripcion="{ item }">
                    {{ item.certificado_detalle.tipo_certificado.nombre }}
                    <br />
                    <small
                        >({{ item.certificado_detalle.certificado.tipo
                        }}<span
                            v-if="
                                item.certificado_detalle.certificado.tramitador
                            "
                        >
                            -
                            {{
                                item.certificado_detalle.certificado.tramitador
                                    .nombre
                            }} </span
                        >)</small
                    >
                </template>
                <template #medico="{ item }">
                    <span v-if="item.medico">
                        {{ item.medico.nombre }}
                        {{ item.medico.paterno }} {{ item.materno }}
                    </span>
                    <span v-else class="text-muted"> Pendiente </span>
                </template>
                <template #tableFooter>
                    <tr class="">
                        <td
                            class="bg-principal p-3 text-right text-md font-weight-bold"
                            colspan="6"
                        >
                            TOTALES
                        </td>
                        <template v-for="(tipo_pago, index) in listTipoPagos">
                            <td
                                class="bg-principal p-3 text-right text-md font-weight-bold"
                                style="
                                    min-width: 400px !important;
                                    width: inherit;
                                "
                            >
                                {{ sumaPorTipos[tipo_pago.value] }}
                            </td>
                        </template>
                    </tr>
                    <tr class="">
                        <td
                            class="bg-principal p-3 text-right text-lg font-weight-bold"
                            colspan="6"
                        >
                            TOTAL FINAL
                        </td>
                        <td
                            class="bg-principal p-3 text-center text-lg font-weight-bold"
                            style="min-width: 400px !important; width: inherit"
                            colspan="2"
                        >
                            {{ total }}
                        </td>
                    </tr>
                </template>
            </MiTable>
            <div class="col-12 mt-2" v-show="listPagosVerificados.length == 0">
                <h4 class="text-muted">No se encontrarón registros</h4>
            </div>
            <div
                class="col-12 overflow-auto mt-5"
                v-show="listPagosSinVerificar.length > 0"
            >
                <h4 class="h5 font-weight-bold text-center w-100">
                    {{
                        props_page.auth?.user.tipo == "MÉDICO"
                            ? "PAGOS SIN ENTREGAR"
                            : "PAGOS SIN RECEPCIÓN"
                    }}
                </h4>
                <MiTable
                    ref="miTable2"
                    :tableClass="'bg-white mitabla'"
                    :header-class="'bg__danger'"
                    :cols="headers1"
                    :data="listPagosSinVerificar"
                    :con-paginacion="false"
                    fix-cols
                    fixed-header
                    table-height="40vh"
                >
                    <template #fecha_verificado="{ item }">
                        <span
                            >{{ item.fecha_verificado_t }} {{ item.hora }}</span
                        >
                    </template>
                    <template #cliente="{ item }">
                        <span>{{ item.cliente.full_name }}</span>
                        <br />
                        <span>{{ item.cliente.full_ci }}</span>
                    </template>

                    <template #descripcion="{ item }">
                        {{ item.certificado_detalle.tipo_certificado.nombre }}
                        <br />
                        <small
                            >({{ item.certificado_detalle.certificado.tipo
                            }}<span
                                v-if="
                                    item.certificado_detalle.certificado
                                        .tramitador
                                "
                            >
                                -
                                {{
                                    item.certificado_detalle.certificado
                                        .tramitador.nombre
                                }} </span
                            >)</small
                        >
                    </template>
                    <template #medico="{ item }">
                        <span v-if="item.medico">
                            {{ item.medico.nombre }}
                            {{ item.medico.paterno }} {{ item.materno }}
                        </span>
                        <span v-else class="text-muted"> Pendiente </span>
                    </template>
                    <template #tableFooter>
                        <tr class="">
                            <td
                                class="bg-danger p-3 text-right text-md font-weight-bold"
                                colspan="6"
                            >
                                TOTALES
                            </td>
                            <template
                                v-for="(tipo_pago, index) in listTipoPagos"
                            >
                                <td
                                    class="bg-danger p-3 text-right text-md font-weight-bold"
                                    style="
                                        min-width: 400px !important;
                                        width: inherit;
                                    "
                                >
                                    {{
                                        sumaPorTiposSinVerificar[
                                            tipo_pago.value
                                        ]
                                    }}
                                </td>
                            </template>
                        </tr>
                        <tr class="">
                            <td
                                class="bg-danger p-3 text-right text-lg font-weight-bold"
                                colspan="6"
                            >
                                TOTAL FINAL
                            </td>
                            <td
                                class="bg-danger p-3 text-center text-lg font-weight-bold"
                                style="
                                    min-width: 400px !important;
                                    width: inherit;
                                "
                                colspan="2"
                            >
                                {{ totalSinVerificar }}
                            </td>
                        </tr>
                    </template>
                </MiTable>
                <div class="row mt-3">
                    <div class="col-md-4 offset-md-4">
                        <h4 class="h5 font-weight-bold text-center w-100">
                            RESUMEN GENERAL
                        </h4>
                        <table class="table table-bordered table-striped">
                            <thead class="bg-principal">
                                <tr>
                                    <th>Tipo de Pago</th>
                                    <th class="text-right">Monto Bs.</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr
                                    v-for="tipo_pago in listTipoPagos"
                                    :key="tipo_pago.value"
                                >
                                    <td class="font-weight-bold">
                                        {{ tipo_pago.value }}
                                    </td>
                                    <td class="text-right">
                                        {{
                                            suma_total_tipos[
                                                tipo_pago.value
                                            ]?.toFixed(2)
                                        }}
                                    </td>
                                </tr>
                                <tr>
                                    <td
                                        class="text-right font-weight-bold bg-principal"
                                    >
                                        TOTAL
                                    </td>
                                    <td
                                        class="text-right font-weight-bold bg-principal"
                                    >
                                        {{ totalGeneral }}
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </Content>
</template>
