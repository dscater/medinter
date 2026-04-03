<script setup>
import Content from "@/Components/Content.vue";
import { Head, Link, router, usePage } from "@inertiajs/vue3";
import { useCertificados } from "@/composables/certificados/useCertificados";
import { ref, onMounted, onBeforeMount } from "vue";
import { useAppStore } from "@/stores/aplicacion/appStore";
import Formulario from "./Formulario.vue";
const { props: props_page } = usePage();
const appStore = useAppStore();
onBeforeMount(() => {
    appStore.startLoading();
});

const { setCertificado, limpiarCertificado, oCertificado } = useCertificados();
onMounted(() => {
    appStore.stopLoading();
    limpiarCertificado();
});
</script>
<template>
    <Head title="Certificados"></Head>
    <Content>
        <template #header>
            <div class="row mb-2">
                <div class="col-sm-6">
                    <h1 class="m-0">Certificados > Nuevo</h1>
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
                        <li class="breadcrumb-item active">Nuevo</li>
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
                                    'certificados.index',
                                )
                            "
                            :href="route('certificados.index')"
                            class="btn btn-secondary"
                        >
                            <i class="fa fa-arrow-left"></i> Volver a
                            Certificados
                        </Link>
                    </div>
                </div>
                <div class="row mt-1">
                    <div class="col-12">
                        <div class="card">
                            <div class="card-header">
                                <i class="fa fa-plus"></i> Nuevo Certificado
                            </div>
                            <div class="card-body pt-1">
                                <Formulario
                                    :certificado="oCertificado"
                                ></Formulario>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </Content>
</template>
