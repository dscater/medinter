<script setup>
import Content from "@/Components/Content.vue";
import { Head, Link, router, usePage } from "@inertiajs/vue3";
import { ref, onMounted, onBeforeMount, computed } from "vue";
import { useAppStore } from "@/stores/aplicacion/appStore";
// TOAST
import { toast } from "vue3-toastify";
import "vue3-toastify/dist/index.css";
const { props: props_page } = usePage();
const appStore = useAppStore();
onBeforeMount(() => {
    appStore.startLoading();
});

onMounted(() => {
    cargarPagosVerificados();
    appStore.stopLoading();
});

const goBack = () => {
    if (window.history.length > 1) {
        window.history.back();
    } else {
        router.visit(route("inicio"));
    }
};

const listPagosVerificados = ref([]);

const cargarPagosVerificados = () => {
    if (!filtros.value.fecha) {
        return;
    }
    axios
        .get(route("pagos.verificados"), {
            params: {
                fecha: filtros.value.fecha,
            },
        })
        .then((response) => {
            listPagosVerificados.value = response.data;
        });
};

const obtenerFechaActual = () => {
    const fecha = new Date();
    const anio = fecha.getFullYear();
    const mes = String(fecha.getMonth() + 1).padStart(2, "0"); // Mes empieza desde 0
    const dia = String(fecha.getDate()).padStart(2, "0"); // Día del mes
    return `${anio}-${mes}-${dia}`;
};

const filtros = ref({
    fecha: obtenerFechaActual(),
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
        fecha: filtros.value.fecha,
        formato,
    });
    window.open(url, "_blank");
    setTimeout(() => {
        generando.value = false;
    }, 500);
};

onBeforeMount(() => {});
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
                    <div class="col-md-3">
                        <label class="mb-0 text-xs text-muted">Fecha</label>
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
                                v-model="filtros.fecha"
                                @change="cargarPagosVerificados"
                                @keyup="cargarPagosVerificados"
                            />
                        </div>
                    </div>
                    <div class="col-md-5">
                        <div class="row mt-4">
                            <div class="col-md-6">
                                <button
                                    class="btn btn-danger w-100"
                                    @click="exportar('pdf')"
                                    :disabled="generando"
                                >
                                    Exportar <i class="fa fa-file-pdf"></i>
                                </button>
                            </div>
                            <div class="col-md-6">
                                <button
                                    class="btn btn-success w-100"
                                    @click="exportar('excel')"
                                    :disabled="generando"
                                >
                                    Exportar <i class="fa fa-file-excel"></i>
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-12" v-if="listPagosVerificados.length > 0">
                <table class="table table-bordered bg-white">
                    <thead>
                        <tr class="bg-principal">
                            <th width="5%">Nro.</th>
                            <th width="5%">Fecha</th>
                            <th>Sucursal</th>
                            <th>Descripción</th>
                            <th>Tipo de Pago</th>
                            <th class="text-right">Monto Bs.</th>
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
                            <td>
                                {{ item.descripcion }}
                            </td>
                            <td class="">{{ item.tipo_pago }}</td>
                            <td class="text-right">{{ item.monto }}</td>
                        </tr>
                        <tr class="bg-principal">
                            <td
                                class="text-lg font-weight-bold text-right"
                                colspan="5"
                            >
                                TOTAL Bs.
                            </td>
                            <td class="text-lg font-weight-bold text-right">
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
