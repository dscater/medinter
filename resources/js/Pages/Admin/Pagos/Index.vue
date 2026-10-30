<script setup>
import Content from "@/Components/Content.vue";
import { Head, Link, router, usePage } from "@inertiajs/vue3";
import MiTable from "@/Components/MiTable.vue";

import {
    ref,
    onMounted,
    onBeforeUnmount,
    computed,
    nextTick,
    watch,
} from "vue";

import { useLoginUserStore } from "@/stores/login_users/loginUserStore";

import { toast } from "vue3-toastify";
import "vue3-toastify/dist/index.css";

const loginUserStore = useLoginUserStore();
const { props: props_page } = usePage();

const props = defineProps({
    tipo_pagos: {
        type: Array,
        default: () => [],
    },
    sucursals: {
        type: Array,
        default: () => [],
    },
    usuarios: {
        type: Array,
        default: () => [],
    },
    medicos: {
        type: Array,
        default: () => [],
    },
});

// =====================================================
// NAVEGACIÓN
// =====================================================

const goBack = () => {
    if (window.history.length > 1) {
        window.history.back();
    } else {
        router.visit(route("inicio"));
    }
};

// =====================================================
// REFERENCIAS DE TABLAS
// =====================================================

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

const colsIniciado = ref(false);

// =====================================================
// DATOS
// =====================================================

const listPagosVerificados = ref([]);
const listPagosSinVerificar = ref([]);

const sumaPorTipos = ref({});
const sumaPorTiposSinVerificar = ref({});

// Los totales generales se construyen en Vue.
// Ya no necesitamos un tercer endpoint de sumas.

const suma_total_tipos = computed(() => {
    const resultado = {};

    Object.entries(sumaPorTipos.value || {}).forEach(([tipo, monto]) => {
        resultado[tipo] = Number(monto || 0);
    });

    Object.entries(sumaPorTiposSinVerificar.value || {}).forEach(
        ([tipo, monto]) => {
            resultado[tipo] = (resultado[tipo] || 0) + Number(monto || 0);
        },
    );

    return resultado;
});

// =====================================================
// ESTADOS DE CARGA INDEPENDIENTES
// =====================================================

const loadingVerificados = ref(false);
const loadingSinVerificar = ref(false);

const errorVerificados = ref(false);
const errorSinVerificar = ref(false);

const loadingPagos = computed(() => {
    return loadingVerificados.value || loadingSinVerificar.value;
});

// =====================================================
// PAGINACIÓN
// =====================================================

const paginacionVerificados = ref({
    current_page: 1,
    last_page: 1,
    per_page: 20,
    total: 0,
    from: null,
    to: null,
});

const paginacionSinVerificar = ref({
    current_page: 1,
    last_page: 1,
    per_page: 20,
    total: 0,
    from: null,
    to: null,
});

const paginaVerificados = ref(1);
const paginaSinVerificar = ref(1);

const rangoVerificados = computed(() => {
    const p = paginacionVerificados.value;

    return p.total > 0 ? `${p.from}–${p.to} de ${p.total}` : "0 de 0";
});

const rangoSinVerificar = computed(() => {
    const p = paginacionSinVerificar.value;

    return p.total > 0 ? `${p.from}–${p.to} de ${p.total}` : "0 de 0";
});

// =====================================================
// FILTROS
// =====================================================

const obtenerFechaActual = () => {
    const fecha = new Date();

    const anio = fecha.getFullYear();
    const mes = String(fecha.getMonth() + 1).padStart(2, "0");
    const dia = String(fecha.getDate()).padStart(2, "0");

    return `${anio}-${mes}-${dia}`;
};

const filtros = ref({
    fecha_ini: obtenerFechaActual(),
    fecha_fin: obtenerFechaActual(),
    sucursal_id: "",
    medico_id: "",
    user_id: "",
});

const parametrosFiltros = () => ({
    fecha_ini: filtros.value.fecha_ini,
    fecha_fin: filtros.value.fecha_fin,
    sucursal_id: filtros.value.sucursal_id,
    medico_id: filtros.value.medico_id,
    user_id: filtros.value.user_id,
});

// =====================================================
// CONTROL DE PETICIONES
// =====================================================

let peticionVerificados = null;
let peticionSinVerificar = null;
let timerCargaPagos = null;

// =====================================================
// CARGAR PAGOS VERIFICADOS
// =====================================================

const cargarPagosVerificados = async () => {
    if (!filtros.value.fecha_ini || !filtros.value.fecha_fin) {
        return;
    }

    if (peticionVerificados) {
        peticionVerificados.abort();
    }

    const controller = new AbortController();
    peticionVerificados = controller;

    loadingVerificados.value = true;
    errorVerificados.value = false;

    try {
        const response = await axios.get(route("pagos.verificados"), {
            params: {
                ...parametrosFiltros(),
                pagina_verificados: paginaVerificados.value,
            },
            signal: controller.signal,
        });

        const data = response.data;

        listPagosVerificados.value = data.pagos.data;

        sumaPorTipos.value = data.suma_tipos || {};

        paginacionVerificados.value = {
            current_page: data.pagos.current_page,
            last_page: data.pagos.last_page,
            per_page: data.pagos.per_page,
            total: data.pagos.total,
            from: data.pagos.from,
            to: data.pagos.to,
        };
    } catch (error) {
        if (error.code !== "ERR_CANCELED") {
            console.error("Error cargando pagos verificados:", error);

            errorVerificados.value = true;

            toast.error("No se pudieron cargar los pagos verificados");
        }
    } finally {
        if (peticionVerificados === controller) {
            loadingVerificados.value = false;
            peticionVerificados = null;
        }
    }
};

// =====================================================
// CARGAR PAGOS SIN VERIFICAR
// =====================================================

const cargarPagosSinVerificar = async () => {
    if (!filtros.value.fecha_ini || !filtros.value.fecha_fin) {
        return;
    }

    if (peticionSinVerificar) {
        peticionSinVerificar.abort();
    }

    const controller = new AbortController();
    peticionSinVerificar = controller;

    loadingSinVerificar.value = true;
    errorSinVerificar.value = false;

    try {
        const response = await axios.get(route("pagos.noVerificados"), {
            params: {
                ...parametrosFiltros(),
                pagina_sin_verificar: paginaSinVerificar.value,
            },
            signal: controller.signal,
        });

        const data = response.data;

        listPagosSinVerificar.value = data.pagos.data;

        sumaPorTiposSinVerificar.value = data.suma_tipos_sin_verificar || {};

        paginacionSinVerificar.value = {
            current_page: data.pagos.current_page,
            last_page: data.pagos.last_page,
            per_page: data.pagos.per_page,
            total: data.pagos.total,
            from: data.pagos.from,
            to: data.pagos.to,
        };
    } catch (error) {
        if (error.code !== "ERR_CANCELED") {
            console.error("Error cargando pagos sin verificar:", error);

            errorSinVerificar.value = true;

            toast.error("No se pudieron cargar los pagos pendientes");
        }
    } finally {
        if (peticionSinVerificar === controller) {
            loadingSinVerificar.value = false;
            peticionSinVerificar = null;
        }
    }
};

// =====================================================
// CARGAR AMBAS TABLAS
// =====================================================

const cargarTodo = () => {
    cargarPagosVerificados();
    cargarPagosSinVerificar();
};

// Aplicar filtros: volver a la primera página
// y cargar ambas tablas.

const aplicarFiltros = () => {
    paginaVerificados.value = 1;
    paginaSinVerificar.value = 1;

    cargarTodo();
};

// Debounce para los filtros y botones de búsqueda.

const cargarRegistrosPagos = () => {
    clearTimeout(timerCargaPagos);

    timerCargaPagos = setTimeout(() => {
        aplicarFiltros();
    }, 350);
};

// =====================================================
// CAMBIAR PÁGINAS
// =====================================================

const cambiarPaginaVerificados = (pagina) => {
    if (pagina < 1 || pagina > paginacionVerificados.value.last_page) {
        return;
    }

    paginaVerificados.value = pagina;

    // Solo consulta pagos verificados.
    cargarPagosVerificados();
};

const cambiarPaginaSinVerificar = (pagina) => {
    if (pagina < 1 || pagina > paginacionSinVerificar.value.last_page) {
        return;
    }

    paginaSinVerificar.value = pagina;

    // Solo consulta pagos pendientes.
    cargarPagosSinVerificar();
};

// =====================================================
// TOTALES
// =====================================================

const total = computed(() => {
    return Object.values(suma_total_tipos.value)
        .reduce((sum, monto) => sum + Number(monto || 0), 0)
        .toFixed(2);
});

const totalSinVerificar = computed(() => {
    return Object.values(sumaPorTiposSinVerificar.value)
        .reduce((sum, monto) => sum + Number(monto || 0), 0)
        .toFixed(2);
});

const totalGeneral = computed(() => {
    return Object.values(suma_total_tipos.value)
        .reduce((sum, monto) => sum + Number(monto || 0), 0)
        .toFixed(2);
});

// =====================================================
// USUARIO RECEPCIONISTA
// =====================================================

const txtUsuarioRecepcion = computed(() => {
    if (!filtros.value.user_id) {
        return "";
    }

    const user = props.usuarios.find(
        (u) => String(u.id) === String(filtros.value.user_id),
    );

    return user
        ? `Pagos recepcionados por ${user.nombre} ${user.paterno} ${user.materno} - ${user.tipo}`
        : "";
});

// =====================================================
// COLUMNAS DINÁMICAS
// =====================================================

const cargarTablasPorPagos = async () => {
    if (!colsIniciado.value) {
        const columnasDinamicas = props.tipo_pagos.map((elem) => ({
            label: elem.value,
            key: "monto",
            fixed: "right",
            sortable: true,
            classTd: () => "justify-content-end",
            width: "100px",

            render: (item) => {
                if (item.tipo_pago !== elem.value) {
                    return "-";
                }

                return item.monto || "";
            },
        }));

        headers1.value = [...headers1.value, ...columnasDinamicas];

        colsIniciado.value = true;
    }

    await nextTick();

    if (miTable1.value) {
        miTable1.value.cargarDatos();
    }

    if (miTable2.value) {
        miTable2.value.cargarDatos();
    }
};

// =====================================================
// EXPORTAR
// =====================================================

const generando = ref(false);

const exportar = (formato) => {
    generando.value = true;

    const url = route("reportes.exportarCaja", {
        fecha_ini: filtros.value.fecha_ini,
        fecha_fin: filtros.value.fecha_fin,
        sucursal_id: filtros.value.sucursal_id,
        medico_id: filtros.value.medico_id,
        user_id: filtros.value.user_id,
        formato,
    });

    window.open(url, "_blank");

    setTimeout(() => {
        generando.value = false;
    }, 500);
};

// =====================================================
// INICIALIZACIÓN
// =====================================================

watch(
    () => loginUserStore.login_user,
    (newVal) => {
        if (!newVal) return;

        filtros.value.sucursal_id =
            props_page.auth.user.tipo === "ADMINISTRADOR" ||
            props_page.auth.user.tipo === "GERENTE"
                ? "todos"
                : newVal.sucursal_id;

        cargarRegistrosPagos();
    },
    { immediate: true },
);

onMounted(async () => {
    await cargarTablasPorPagos();
});

onBeforeUnmount(() => {
    clearTimeout(timerCargaPagos);

    if (peticionVerificados) {
        peticionVerificados.abort();
    }

    if (peticionSinVerificar) {
        peticionSinVerificar.abort();
    }
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
                                        @input="cargarRegistrosPagos"
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
                                        @input="cargarRegistrosPagos"
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
                            @change="cargarRegistrosPagos"
                        >
                            <el-option value="todos" label="Todos" />
                            <el-option
                                v-for="item in sucursals"
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
                            placeholder="Todos"
                            size="large"
                            clearable
                            @change="cargarRegistrosPagos"
                        >
                            <el-option value="" label="Todos" />
                            <el-option
                                v-for="item in medicos"
                                :key="item.id"
                                :value="item.id"
                                :label="`${item.nombre} ${item.paterno} ${item.materno}`"
                            >
                            </el-option>
                        </el-select>
                    </div>
                </div>
                <div class="row mt-1">
                    <div
                        class="col-md-3"
                        v-if="
                            props_page.auth.user.tipo == 'ADMINISTRADOR' ||
                            props_page.auth.user.tipo == 'GERENTE'
                        "
                    >
                        <label class="mb-0 text-xs text-muted"
                            >Usuario Recepción de Pago</label
                        >
                        <el-select
                            v-model="filtros.user_id"
                            filterable
                            placeholder="Todos"
                            size="large"
                            clearable
                            @change="cargarRegistrosPagos"
                        >
                            <el-option value="" label="Todos" />
                            <el-option
                                v-for="item in usuarios"
                                :key="item.id"
                                :value="item.id"
                                :label="`${item.nombre} ${item.paterno} ${item.materno} - ${item.tipo}`"
                            >
                            </el-option>
                        </el-select>
                    </div>
                </div>
                <div class="row mb-1">
                    <div class="col-md-9 d-flex align-items-end">
                        <span class="text-primary">
                            <i class="fas fa-list mr-1"></i>
                            {{ paginacionVerificados.total }} registros
                            verificados
                            <small>({{ rangoVerificados }})</small>
                        </span>

                        <span
                            v-if="paginacionSinVerificar.total > 0"
                            class="text-danger font-weight-600"
                        >
                            | {{ paginacionSinVerificar.total }} sin verificar
                            <small>({{ rangoSinVerificar }})</small>
                        </span>
                    </div>
                    <div class="col-12" v-if="txtUsuarioRecepcion">
                        <h5 class="text-info font-weight-bold">
                            {{ txtUsuarioRecepcion }}
                        </h5>
                    </div>
                    <div class="col-md-3">
                        <div class="row mt-1">
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
                    <!-- Paginador de pagos verificados -->
                    <div class="col-12 mt-3">
                        <div
                            class="d-flex justify-content-between align-items-center flex-wrap"
                        >
                            <small class="text-muted">
                                Verificados: página
                                {{ paginacionVerificados.current_page }}
                                de {{ paginacionVerificados.last_page }}
                            </small>

                            <div class="btn-group">
                                <button
                                    type="button"
                                    class="btn btn-outline-primary btn-sm"
                                    :disabled="
                                        paginacionVerificados.current_page <= 1
                                    "
                                    @click="
                                        cambiarPaginaVerificados(
                                            paginacionVerificados.current_page -
                                                1,
                                        )
                                    "
                                >
                                    <i class="fas fa-chevron-left"></i>
                                    Anterior
                                </button>

                                <button
                                    type="button"
                                    class="btn btn-outline-primary btn-sm"
                                    :disabled="
                                        paginacionVerificados.current_page >=
                                        paginacionVerificados.last_page
                                    "
                                    @click="
                                        cambiarPaginaVerificados(
                                            paginacionVerificados.current_page +
                                                1,
                                        )
                                    "
                                >
                                    Siguiente
                                    <i class="fas fa-chevron-right"></i>
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
                :loading="loadingPagos"
            >
                <template #fecha_verificado="{ item }">
                    <span>{{ item.fecha_verificado_t }} {{ item.hora }}</span>
                </template>
                <template #cliente="{ item }">
                    <span
                        >{{ item.cliente.nombre }} {{ item.cliente.paterno }}
                        {{ item.cliente.materno }}</span
                    >
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
                            class="bg-principal p-3 text-md font-weight-bold"
                            colspan="6"
                        >
                            TOTALES
                        </td>
                        <template v-for="(tipo_pago, index) in tipo_pagos">
                            <td
                                class="bg-principal p-3 text-right text-md font-weight-bold fixed-column-ext-right"
                            >
                                {{ sumaPorTipos[tipo_pago.value] }}
                            </td>
                        </template>
                    </tr>
                    <tr class="">
                        <td
                            class="bg-principal p-3 text-lg font-weight-bold"
                            colspan="6"
                        >
                            TOTAL FINAL
                        </td>
                        <td
                            class="bg-principal p-3 text-center text-lg font-weight-bold fixed-column-ext-right"
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
                <div class="row">
                    <div class="col-12">
                        <div
                            class="d-flex justify-content-between align-items-center flex-wrap"
                        >
                            <small class="text-muted">
                                Sin verificar: página
                                {{ paginacionSinVerificar.current_page }}
                                de {{ paginacionSinVerificar.last_page }}
                            </small>

                            <div class="btn-group">
                                <button
                                    type="button"
                                    class="btn btn-outline-danger btn-sm"
                                    :disabled="
                                        paginacionSinVerificar.current_page <= 1
                                    "
                                    @click="
                                        cambiarPaginaSinVerificar(
                                            paginacionSinVerificar.current_page -
                                                1,
                                        )
                                    "
                                >
                                    <i class="fas fa-chevron-left"></i>
                                    Anterior
                                </button>

                                <button
                                    type="button"
                                    class="btn btn-outline-danger btn-sm"
                                    :disabled="
                                        paginacionSinVerificar.current_page >=
                                        paginacionSinVerificar.last_page
                                    "
                                    @click="
                                        cambiarPaginaSinVerificar(
                                            paginacionSinVerificar.current_page +
                                                1,
                                        )
                                    "
                                >
                                    Siguiente
                                    <i class="fas fa-chevron-right"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-12">
                    <h4 class="h5 font-weight-bold text-center w-100">
                        {{
                            props_page.auth?.user.tipo == "MÉDICO"
                                ? "PAGOS SIN ENTREGAR"
                                : "PAGOS SIN RECEPCIÓN"
                        }}
                    </h4>
                </div>
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
                    :loading="loadingPagos"
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
                                class="bg-danger p-3 text-md font-weight-bold fixed-column-ext"
                                colspan="6"
                            >
                                TOTALES
                            </td>
                            <template v-for="(tipo_pago, index) in tipo_pagos">
                                <td
                                    class="bg-danger p-3 text-right text-md font-weight-bold fixed-column-ext-right"
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
                                class="bg-danger p-3 text-lg font-weight-bold fixed-column-ext"
                                colspan="6"
                            >
                                TOTAL FINAL
                            </td>
                            <td
                                class="bg-danger p-3 text-center text-lg font-weight-bold fixed-column-ext-right"
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
                                    v-for="tipo_pago in tipo_pagos"
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
