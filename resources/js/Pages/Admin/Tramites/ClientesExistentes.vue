<script setup>
import MiModal from "@/Components/MiModal.vue";
import { useForm, usePage } from "@inertiajs/vue3";
import { watch, ref, computed, onMounted, nextTick } from "vue";
const props = defineProps({
    muestra_formulario: {
        type: Boolean,
        default: false,
    },
    list_clientes: {
        type: Array,
        default: [],
    },
    index: {
        type: Number,
        default: 0,
    },
});

const listClientes = ref(props.list_clientes);
const indexFila = ref(props.index);
const muestra_form = ref(props.muestra_formulario);
watch(
    () => props.muestra_formulario,
    (newValue) => {
        muestra_form.value = newValue;
        if (muestra_form.value) {
            document
                .getElementsByTagName("body")[0]
                .classList.add("modal-open");
        } else {
            document
                .getElementsByTagName("body")[0]
                .classList.remove("modal-open");
        }
    },
);
watch(
    () => props.list_clientes,
    (newValue) => {
        listClientes.value = newValue;
    },
);
watch(
    () => props.index,
    (newValue) => {
        indexFila.value = newValue;
    },
);

const emits = defineEmits(["cerrar-formulario", "envio-formulario"]);

watch(muestra_form, (newVal) => {
    if (!newVal) {
        emits("cerrar-formulario");
    }
});

const seleccionaCliente = (item) => {
    emits("envio-formulario", item, indexFila.value);
};

const cerrarFormulario = () => {
    muestra_form.value = false;
    document.getElementsByTagName("body")[0].classList.remove("modal-open");
};

onMounted(() => {});
</script>

<template>
    <MiModal
        :open_modal="muestra_form"
        @close="cerrarFormulario"
        :size="'modal-xl'"
        :header-class="'bg-principal'"
        :footer="false"
    >
        <template #header>
            <h4 class="modal-title text-white">
                <i class="fa fa-list"></i> Asignar Cliente
            </h4>
            <button
                type="button"
                class="close"
                @click.prevent="cerrarFormulario()"
            >
                <span aria-hidden="true">×</span>
            </button>
        </template>

        <template #body>
            <div class="row">
                <div class="col-12 mb-1">
                    Paciente ya registrado por favor seleccione:
                </div>
                <div
                    class="col-12 cliente_listado"
                    v-for="item in listClientes"
                    @click="seleccionaCliente(item)"
                >
                    <div class="callout callout-info">
                        <h5 class="text-md font-weight-bold">
                            {{ item.nombre }}
                            {{ item.paterno }}
                            {{ item.materno }}
                        </h5>
                        <p class="text-sm">
                            {{ item.full_ci }}
                        </p>
                    </div>
                </div>
            </div>
        </template>
    </MiModal>
</template>
