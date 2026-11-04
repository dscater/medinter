<script setup>
import Content from "@/Components/Content.vue";
import { Head, Link, router, usePage } from "@inertiajs/vue3";
import { useCertificados } from "@/composables/certificados/useCertificados";
import { ref, onBeforeMount } from "vue";
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
    tipo_pagos: {
        type: Array,
        default: [],
    },
    tipo_certificados: {
        type: Array,
        default: [],
    },
    tramitadors: {
        type: Array,
        default: [],
    },
});
const { props: props_page } = usePage();

const { form, setCertificado } = useCertificados();

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
                            :form="form"
                            :tipo_certificados="tipo_certificados"
                            :tipo_pagos="tipo_pagos"
                            :tramitadors="tramitadors"
                            :cliente="cliente"
                            :setCertificado="setCertificado"
                        ></Formulario>
                    </div>
                </div>
            </div>
        </div>
    </Content>
</template>
