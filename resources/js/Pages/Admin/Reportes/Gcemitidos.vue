<script setup>
import Content from "@/Components/Content.vue";
import { computed, nextTick, ref } from "vue";
import { Head, Link } from "@inertiajs/vue3";
import Highcharts from "highcharts";
import "highcharts/modules/exporting";
import "highcharts/modules/accessibility";
// exporting(Highcharts);
// accessibility(Highcharts);
Highcharts.setOptions({
    lang: {
        downloadPNG: "Descargar PNG",
        downloadJPEG: "Descargar JPEG",
        downloadPDF: "Descargar PDF",
        downloadSVG: "Descargar SVG",
        printChart: "Imprimir gráfico",
        contextButtonTitle: "Menú de exportación",
        viewFullscreen: "Pantalla completa",
        exitFullscreen: "Salir de pantalla completa",
    },
});

const props = defineProps({
    sucursals: {
        type: Array,
        default: () => [],
    },
    medicos: {
        type: Array,
        default: () => [],
    },
    tipo_certificados: {
        type: Array,
        default: () => [],
    },
});

const obtenerFechaActual = () => {
    const fecha = new Date();
    const anio = fecha.getFullYear();
    const mes = String(fecha.getMonth() + 1).padStart(2, "0"); // Mes empieza desde 0
    const dia = String(fecha.getDate()).padStart(2, "0"); // Día del mes
    return `${anio}-${mes}-${dia}`;
};

const form = ref({
    cliente_id: "todos",
    sucursal_id: "todos",
    user_id: "todos",
    tipo_pago: "todos",
    tipo_certificado_id: "todos",
    fecha_ini: obtenerFechaActual(),
    fecha_fin: obtenerFechaActual(),
});

const generando = ref(false);
const txtBtn = computed(() => {
    if (generando.value) {
        return "Generando Reporte...";
    }
    return "Generar Gráfico";
});

const generarReporte = () => {
    generando.value = true;
    axios
        .get(route("reportes.r_gcemitidos"), {
            params: form.value,
        })
        .then((response) => {
            nextTick(() => {
                const containerId = `container`;
                const container = document.getElementById(containerId);
                // Verificar que el contenedor exista y tenga un tamaño válido
                if (container) {
                    renderChart(
                        containerId,
                        response.data.categories,
                        response.data.total_final,
                        response.data.data,
                    );
                } else {
                    console.error(`Contenedor ${containerId} no válido.`);
                }
            });
            // Create the chart
            generando.value = false;
        });
};

const renderChart = (containerId, categories, total_final, data) => {
    const rowHeight = 80;
    const minHeight = 200;
    const calculatedHeight = Math.max(minHeight, categories.length * rowHeight);
    Highcharts.chart(containerId, {
        chart: {
            type: "column",
        },
        title: {
            align: "center",
            text: `CANTIDAD DE CERTIFICADOS EMITIDOS POR MÉDICO`,
        },
        subtitle: {
            align: "center",
            text: `Total emitidos: ${total_final}`,
        },
        accessibility: {
            announceNewData: {
                enabled: true,
            },
        },
        xAxis: {
            categories: categories,
        },
        yAxis: {
            title: {
                text: "TOTAL",
            },
        },
        legend: {
            enabled: true,
        },
        plotOptions: {
            series: {
                depth: 100,
                borderWidth: 0,
                dataLabels: {
                    enabled: true,
                    // format: "{point.y}",
                    style: {
                        fontSize: "11px",
                        fontWeight: "bold",
                    },
                },
            },
        },
        tooltip: {
            useHTML: true,
            formatter: function () {
                return `
                    <div style="text-align:center;">
                        <div style="display:inline-block; width:12px; height:12px; background:${this.point.color}; border-radius:50%; margin-right:5px;"></div>
                        <strong style="color:${this.point.color};">${this.point.series.name}</strong>
                        <br>
                        <span class="text-md"><strong>Total:</strong> ${this.point.y}</span>
                    </div>
                    `;
            },
        },

        series: data,
    });
};
</script>
<template>
    <Head title="Reporte Gráfico Certificados Emitidos por Médico"></Head>
    <Content>
        <template #header>
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0">Gráfico Certificados Emitidos</h1>
                </div>
                <!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item">
                            <Link :href="route('inicio')">Inicio</Link>
                        </li>
                        <li class="breadcrumb-item active">
                            Reportes > Gráfico Certificados Emitidos
                        </li>
                    </ol>
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->
        </template>
        <!-- END page-header -->
        <div class="row">
            <div class="col-md-6 mx-auto">
                <div class="card">
                    <div class="card-body">
                        <form @submit.prevent="generarReporte">
                            <div class="row">
                                <!-- <div class="col-md-12">
                                    <label>Seleccionar Cliente*</label>
                                    <el-select
                                        v-model="form.cliente_id"
                                        filterable
                                    >
                                        <el-option
                                            v-for="item in listClientes"
                                            :key="item.id"
                                            :value="item.id"
                                            :label="`${item.full_name} ${item.full_ci ? ' - ' + item.full_ci : ''}`"
                                        >
                                        </el-option>
                                    </el-select>
                                </div> -->
                                <div class="col-md-12">
                                    <label>Sucursal*</label>
                                    <el-select
                                        v-model="form.sucursal_id"
                                        filterable
                                        placeholder="TODOS"
                                    >
                                        <el-option
                                            value="todos"
                                            label="TODOS"
                                        />
                                        <el-option
                                            v-for="item in sucursals"
                                            :key="item.id"
                                            :value="item.id"
                                            :label="item.nombre"
                                        >
                                        </el-option>
                                    </el-select>
                                </div>
                                <div class="col-md-12">
                                    <label>Seleccionar Médico*</label>
                                    <el-select
                                        v-model="form.user_id"
                                        filterable
                                        placeholder="TODOS"
                                    >
                                        <el-option
                                            value="todos"
                                            label="TODOS"
                                        />
                                        <el-option
                                            v-for="item in medicos"
                                            :key="item.id"
                                            :value="item.id"
                                            :label="item.full_name"
                                        >
                                        </el-option>
                                    </el-select>
                                </div>
                                <!-- <div class="col-md-12">
                                    <label>Seleccionar Tipo de Pago*</label>
                                    <el-select
                                        v-model="form.tipo_pago"
                                        filterable
                                    >
                                        <el-option
                                            v-for="item in listTipoPagos"
                                            :key="item.value"
                                            :value="item.value"
                                            :label="item.label"
                                        >
                                        </el-option>
                                    </el-select>
                                </div> -->
                                <div class="col-md-12">
                                    <label>Tipo de Certificado*</label>
                                    <el-select
                                        v-model="form.tipo_certificado_id"
                                        filterable
                                        placeholder="TODOS"
                                    >
                                        <el-option
                                            value="todos"
                                            label="TODOS"
                                        />
                                        <el-option
                                            v-for="item in tipo_certificados"
                                            :key="item.id"
                                            :value="item.id"
                                            :label="item.nombre"
                                        >
                                        </el-option>
                                    </el-select>
                                </div>
                                <div class="col-12 mt-3">
                                    <label>Rango de Fechas</label>
                                    <div class="row">
                                        <div class="col-md-6">
                                            <input
                                                type="date"
                                                class="form-control"
                                                v-model="form.fecha_ini"
                                            />
                                        </div>
                                        <div class="col-md-6">
                                            <input
                                                type="date"
                                                class="form-control"
                                                v-model="form.fecha_fin"
                                            />
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-12 text-center mt-3">
                                    <button
                                        class="btn btn-primary"
                                        block
                                        @click="generarReporte"
                                        :disabled="generando"
                                        v-text="txtBtn"
                                    ></button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <div class="row overflow-auto pb-4" style="max-height: 600px">
            <div class="col-12 mt-3" id="container"></div>
        </div>
    </Content>
</template>
