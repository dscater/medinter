<script setup>
import Content from "@/Components/Content.vue";
import { Head, Link, router, usePage } from "@inertiajs/vue3";
import { useCertificados } from "@/composables/certificados/useCertificados";
import { ref, onMounted, onBeforeMount } from "vue";
import { useAppStore } from "@/stores/aplicacion/appStore";
import Formulario from "./Formulario.vue";
const props = defineProps({
    certificado: {
        type: Object,
        default: {},
        required: true,
    },
    cliente: {
        type: Object,
        default: {},
    },
});
const { props: props_page } = usePage();
const appStore = useAppStore();
onBeforeMount(() => {
    appStore.startLoading();
});

const { setCertificado, limpiarCertificado, oCertificado } = useCertificados();
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

onBeforeMount(() => {
    setCertificado(props.certificado);
});
</script>
<template>
    <Head title="Certificados"></Head>
    <Content>
        <template #header>
            <div class="row">
                <div class="col-sm-6">
                    <h1 class="m-0">
                        <i class="fa fa-edit"></i> Editar Certificado
                    </h1>
                </div>
                <!-- /.col -->
                <div class="col-sm-6">
                    <ol class="breadcrumb float-sm-right">
                        <li class="breadcrumb-item">
                            <Link :href="route('inicio')">Inicio</Link>
                        </li>
                        <li class="breadcrumb-item">
                            <Link :href="route('certificados.index')"
                                >Certificados</Link
                            >
                        </li>
                        <li class="breadcrumb-item active">Editar</li>
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
                            href="#"
                            @click.prevent="goBack"
                            class="btn btn-default"
                        >
                            <i class="fa fa-arrow-left"></i> Volver
                        </Link>
                    </div>
                </div>
                <div class="row mt-1">
                    <div class="col-12">
                        <Formulario
                            :certificado="oCertificado"
                            :cliente="cliente"
                        ></Formulario>
                    </div>
                </div>
            </div>
        </div>
    </Content>
</template>
