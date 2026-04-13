<script setup>
import Content from "@/Components/Content.vue";
import { Head, Link, router, usePage } from "@inertiajs/vue3";
import { ref, onMounted, onBeforeMount } from "vue";
import { useAppStore } from "@/stores/aplicacion/appStore";
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

onBeforeMount(() => {});
</script>
<template>
    <Head title="Recepción de Pagos"></Head>
    <Content>
        <template #header>
            <div class="row">
                <div class="col-sm-6">
                    <h1 class="m-0">
                        <i class="fa fa-cash-register"></i> Recepción de Pagos
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
        <div class="row">
            <div class="col-md-12">
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
            </div>
            <div class="col-12"></div>
        </div>
    </Content>
</template>
