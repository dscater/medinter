<script setup>
import Content from "@/Components/Content.vue";
import { Head, Link, router, usePage } from "@inertiajs/vue3";
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

const listPagosVerificados = ref([]);
const sumaPorTipos = ref([]);

const cargarPagosVerificados = () => {
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
        .then((response) => {
            listPagosVerificados.value = response.data.pagos;
            sumaPorTipos.value = response.data.suma_tipos;
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
const cargarTipoPagos = () => {
    axios.get(route("tipo_pagos.listado")).then((response) => {
        listTipoPagos.value = response.data;
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

onMounted(() => {
    appStore.stopLoading();
});

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
                    <div
                        class="col-md-3"
                        v-if="
                            props_page.auth.user.tipo == 'ADMINISTRADOR' ||
                            props_page.auth.user.tipo == 'GERENTE'
                        "
                    >
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
                <div class="row">
                    <div class="col-md-3 offset-md-9">
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
            <div
                class="col-12 overflow-auto"
                v-if="listPagosVerificados.length > 0"
            >
                <table class="table table-bordered bg-white">
                    <thead>
                        <tr class="bg-principal">
                            <th width="5%">Nro.</th>
                            <th width="5%">Fecha</th>
                            <th>Sucursal</th>
                            <th>Paciente</th>
                            <th>Descripción</th>
                            <th>Médico</th>
                            <th v-for="item in listTipoPagos">
                                {{ item.value }} Bs.
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="(item, index) in listPagosVerificados">
                            <td>{{ index + 1 }}</td>
                            <td>
                                {{ item.fecha_verificado_t }}<br />{{
                                    item.hora
                                }}
                            </td>
                            <td>{{ item.sucursal?.nombre }}</td>
                            <td class="">
                                {{ item.cliente.nombre }}
                                {{ item.cliente.paterno }}
                                {{ item.cliente.materno }}
                                <br />
                                <small>
                                    {{ item.cliente.ci }}
                                    {{
                                        item.cliente.complemento
                                            ? " - " + item.cliente.complemento
                                            : ""
                                    }}
                                    {{ item.cliente.ci_exp }}</small
                                >
                            </td>
                            <td>
                                {{
                                    item.certificado_detalle.tipo_certificado
                                        .nombre
                                }}
                                <br />
                                <small
                                    >({{
                                        item.certificado_detalle.certificado
                                            .tipo
                                    }})</small
                                >
                            </td>
                            <td>
                                {{ item.medico.nombre }}
                                {{ item.medico.paterno }} {{ item.materno }}
                            </td>
                            <template v-for="tipo_pago in listTipoPagos">
                                <td
                                    v-if="item.tipo_pago == tipo_pago.value"
                                    class="text-right"
                                >
                                    {{ item.monto }}
                                </td>
                                <td v-else></td>
                            </template>
                        </tr>
                        <tr class="bg-principal">
                            <td
                                class="text-lg font-weight-bold text-right"
                                colspan="6"
                            >
                                TOTAL Bs.
                            </td>
                            <template v-for="tipo_pago in listTipoPagos">
                                <td class="text-lg font-weight-bold text-right">
                                    {{ sumaPorTipos[tipo_pago.value] }}
                                </td>
                            </template>
                        </tr>
                        <tr class="bg-principal">
                            <td
                                class="text-lg font-weight-bold text-right"
                                colspan="6"
                            >
                                TOTAL FINAL Bs.
                            </td>
                            <td
                                class="text-lg font-weight-bold text-right"
                                colspan="2"
                            >
                                {{ total }}
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <div class="col-12 mt-2" v-else>
                <h4 class="text-muted">
                    No se encontrarón pagos sin verificar
                </h4>
            </div>
        </div>
    </Content>
</template>
