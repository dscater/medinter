<script setup>
import Content from "@/Components/Content.vue";
import { Head, Link, router, usePage } from "@inertiajs/vue3";
import { ref, onMounted, onBeforeMount, computed } from "vue";
import { useAppStore } from "@/stores/aplicacion/appStore";
// TOAST
import { toast } from "vue3-toastify";
import "vue3-toastify/dist/index.css";
const props = defineProps({
    pagos: {
        type: Array,
        default: [],
    },
});
const { props: props_page } = usePage();
const appStore = useAppStore();
onBeforeMount(() => {
    appStore.startLoading();
});

onMounted(() => {
    appStore.stopLoading();
});

const goBack = () => {
    if (window.history.length > 1) {
        window.history.back();
    } else {
        router.visit(route("inicio"));
    }
};

const filtros = ref({
    codigo: "",
});
const totalVerificado = computed(() => {
    const total = props.pagos
        .filter((p) => p.verificado)
        .reduce((sum, p) => sum + Number(p.monto), 0);

    return total.toFixed(2);
});

const total = computed(() => {
    const total = props.pagos
        .filter((p) => !p.verificado) // SOLO los no verificados
        .reduce((sum, p) => sum + Number(p.monto), 0);

    return total.toFixed(2);
});

const registrarPagos = () => {
    if (parseFloat(totalVerificado.value) <= 0) {
        toast.info("Debes marcar al menos 1 pago");
        return;
    }

    Swal.fire({
        title: "¿Registrar el monto?",
        html: `<strong>Monto: </strong> ${totalVerificado.value}`,
        showCancelButton: true,
        confirmButtonText: "Si, registrar",
        cancelButtonText: "No, cancelar",
        customClass: {
            confirmButton: "btn-success",
        },
    }).then(async (result) => {
        if (result.isConfirmed) {
            const ids = props.pagos
                .filter((p) => p.verificado == 1)
                .map((p) => p.id);
            try {
                await axios.post(route("pagos.registrarPagos"), {
                    ids: ids,
                });
                toast.success("Pagos registrados correctamente");
                router.reload({ only: ["pagos"] });
            } catch (error) {
                console.error(error);
                toast.error("Error al registrar pagos");
            }
        }
    });
};
const checkAll = ref(false);
const toggleAll = () => {
    checkAll.value = !checkAll.value;
    props.pagos.forEach((p) => {
        p.verificado = checkAll.value ? 1 : 0;
    });
};

onBeforeMount(() => {});
</script>
<template>
    <Head title="Recepción de Pagos"></Head>
    <Content>
        <template #header>
            <div class="row">
                <div class="col-sm-6">
                    <h1 class="m-0">
                        <i class="fa fa-clipboard-check"></i> Recepción de Pagos
                    </h1>
                </div>
                <!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item">
                            <Link :href="route('inicio')">Inicio</Link>
                        </li>
                        <li class="breadcrumb-item active">
                            Recepción de Pagos
                        </li>
                    </ol>
                </div>
                <!-- /.col -->
            </div>
            <!-- /.row -->
        </template>
        <div class="row pb-5">
            <!-- <div class="col-md-12">
                <div class="row mt-1">
                    <div class="col-12">
                        <label class="mb-0">Buscar</label>
                    </div>
                    <div class="col-md-3">
                        <div class="input-group">
                            <div class="input-group-prepend">
                                <span class="input-group-text bg-white"
                                    ><i class="fa fa-folder"></i
                                ></span>
                            </div>
                            <input
                                type="text"
                                class="form-control"
                                placeholder="Código Trámite"
                                v-model="filtros.codigo"
                            />
                        </div>
                    </div>
                </div>
            </div> -->
            <div class="col-12 overflow-auto" v-if="pagos.length > 0">
                <h4 class="text-lg">{{ pagos.length }} Pagos sin verificar</h4>
                <table class="table table-bordered table-hover bg-white">
                    <thead>
                        <tr class="bg-principal">
                            <th width="5%">Fecha</th>
                            <th>Sucursal</th>
                            <th>Descripción</th>
                            <th>Usuario</th>
                            <th>Tipo de Pago</th>
                            <th class="text-right">Monto Bs.</th>
                            <th>
                                <input
                                    class="checkboxTable"
                                    type="checkbox"
                                    :checked="checkAll"
                                    @click="toggleAll"
                                />
                            </th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr v-for="item in pagos" class="text-xs">
                            <td>{{ item.fecha_t }}<br />{{ item.hora }}</td>
                            <td>{{ item.sucursal?.nombre }}</td>
                            <td>{{ item.descripcion }}</td>
                            <td>
                                {{ item.user?.nombre }} {{ item.user?.paterno }}
                                {{ item.user?.materno }}
                            </td>
                            <td class="">{{ item.tipo_pago }}</td>
                            <td class="text-right">{{ item.monto }}</td>
                            <td>
                                <input
                                    class="checkboxTable"
                                    type="checkbox"
                                    :true-value="1"
                                    :false-value="0"
                                    v-model="item.verificado"
                                />
                            </td>
                        </tr>
                        <tr class="bgVerificado">
                            <td
                                class="text-lg font-weight-bold text-right"
                                colspan="5"
                            >
                                TOTAL VERIFICADO Bs.
                            </td>
                            <td class="text-lg font-weight-bold text-right">
                                {{ totalVerificado }}
                            </td>
                            <td></td>
                        </tr>
                        <tr class="bg-principal">
                            <td
                                class="text-lg font-weight-bold text-right"
                                colspan="5"
                            >
                                TOTAL SIN VERIFICAR Bs.
                            </td>
                            <td class="text-lg font-weight-bold text-right">
                                {{ total }}
                            </td>
                            <td></td>
                        </tr>
                    </tbody>
                </table>
                <div class="row">
                    <div class="col-md-4 offset-md-8 text-right">
                        <button
                            class="btn btn-primary w-100"
                            @click="registrarPagos"
                        >
                            <i class="fa fa-save"></i> Registrar Pagos
                        </button>
                    </div>
                </div>
            </div>
            <div class="col-12 mt-2" v-else>
                <h4 class="text-muted">
                    No se encontrarón pagos sin verificar
                </h4>
            </div>
        </div>
    </Content>
</template>
