<script setup>
import MiModal from "@/Components/MiModal.vue";
import { useForm, usePage } from "@inertiajs/vue3";
import { useTramitadors } from "@/composables/tramitadors/useTramitadors";
import { watch, ref, computed, onMounted, nextTick } from "vue";
const props = defineProps({
    muestra_formulario: {
        type: Boolean,
        default: false,
    },
    accion_formulario: {
        type: Number,
        default: 0,
    },
    metodo: {
        type: String,
        default: "inertia",
    },
    ci: {
        type: String,
        default: "",
    },
});

const { oTramitador, limpiarTramitador } = useTramitadors();
const accion_form = ref(props.accion_formulario);
const muestra_form = ref(props.muestra_formulario);
const enviando = ref(false);
let form = useForm(oTramitador.value);
watch(
    () => props.muestra_formulario,
    (newValue) => {
        muestra_form.value = newValue;
        if (muestra_form.value) {
            document
                .getElementsByTagName("body")[0]
                .classList.add("modal-open");
            form = useForm(oTramitador.value);
            if (form.id == 0) {
                form.ci = props.ci ?? "";
            }
        } else {
            document
                .getElementsByTagName("body")[0]
                .classList.remove("modal-open");
        }
    },
);
watch(
    () => props.accion_formulario,
    (newValue) => {
        accion_form.value = newValue;
        if (accion_form.value == 0) {
            form["_method"] = "POST";
        }
    },
);

watch(
    () => props.ci,
    (newValue) => {
        form["ci"] = newValue;
    },
);

const { flash } = usePage().props;

function cargaArchivo(e, key) {
    form[key] = null;
    form[key] = e.target.files[0];
}

const tituloDialog = computed(() => {
    return accion_form.value == 0
        ? `<i class="fa fa-plus"></i> Nuevo Tramitador`
        : `<i class="fa fa-edit"></i> Editar Tramitador`;
});

const textBtn = computed(() => {
    if (enviando.value) {
        return `<i class="fa fa-spin fa-spinner"></i> Enviando...`;
    }
    if (accion_form.value == 0) {
        return `<i class="fa fa-save"></i> Guardar`;
    }
    return `<i class="fa fa-edit"></i> Actualizar`;
});

const enviarFormulario = () => {
    enviando.value = true;
    let url =
        accion_form.value == 0
            ? route("tramitadors.store")
            : route("tramitadors.update", form.id);
    if (props.metodo == "inertia") {
        form.post(url, {
            preserveScroll: true,
            forceFormData: true,
            onSuccess: (response) => {
                console.log("correcto");
                const success =
                    response.props.flash.success ??
                    "Proceso realizado con éxito";
                Swal.fire({
                    icon: "success",
                    title: "Correcto",
                    html: `<strong>${success}</strong>`,
                    confirmButtonText: `Aceptar`,
                    customClass: {
                        confirmButton: "btn-alert-success",
                    },
                });
                form.reset();
                limpiarTramitador();
                emits("envio-formulario");
            },
            onError: (err, code) => {
                console.log(code ?? "");
                console.log(form.errors);
                if (form.errors) {
                    const error =
                        "Existen errores en el formulario, por favor verifique";
                    Swal.fire({
                        icon: "info",
                        title: "Error",
                        html: `<strong>${error}</strong>`,
                        confirmButtonText: `Aceptar`,
                        customClass: {
                            confirmButton: "btn-error",
                        },
                    });
                } else {
                    const error =
                        "Ocurrió un error inesperado contactese con el Administrador";
                    Swal.fire({
                        icon: "info",
                        title: "Error",
                        html: `<strong>${error}</strong>`,
                        confirmButtonText: `Aceptar`,
                        customClass: {
                            confirmButton: "btn-error",
                        },
                    });
                }
                console.log("error: " + err.error);
            },
            onFinish: () => {
                enviando.value = false;
            },
        });
    } else {
        // enviar por axios el formulario
        enviando.value = true;
        let url = route("tramitadors.nuevo");
        axios
            .post(url, form.data()) // importante usar form.data()
            .then((response) => {
                manejarExito(response);
            })
            .catch((error) => {
                manejarError(error);
            })
            .finally(() => {
                enviando.value = false;
            });
    }
};

const manejarExito = (response) => {
    console.log("correcto");

    const success =
        response?.props?.flash?.success ??
        response?.data?.message ??
        "Proceso realizado con éxito";

    Swal.fire({
        icon: "success",
        title: "Correcto",
        html: `<strong>${success}</strong>`,
        confirmButtonText: `Aceptar`,
        customClass: {
            confirmButton: "btn-alert-success",
        },
    });

    form.reset();
    limpiarTramitador();
    emits("envio-formulario", response.data.tramitador);
};
const manejarError = (error) => {
    let errores = null;

    // Axios
    if (error?.response?.data?.errors) {
        errores = Object.fromEntries(
            Object.entries(error.response.data.errors).map(([key, value]) => [
                key,
                value[0],
            ]),
        );
    }

    // Inertia (ya viene plano normalmente)
    else if (typeof error === "object") {
        errores = error;
    }

    if (errores && Object.keys(errores).length > 0) {
        form.errors = errores;

        Swal.fire({
            icon: "info",
            title: "Error",
            html: `<strong>Existen errores en el formulario</strong>`,
            confirmButtonText: `Aceptar`,
            customClass: {
                confirmButton: "btn-error",
            },
        });
    }
};

const listExpedido = [
    { value: "LP", label: "La Paz" },
    { value: "CB", label: "Cochabamba" },
    { value: "SC", label: "Santa Cruz" },
    { value: "CH", label: "Chuquisaca" },
    { value: "OR", label: "Oruro" },
    { value: "PT", label: "Potosi" },
    { value: "TJ", label: "Tarija" },
    { value: "PD", label: "Pando" },
    { value: "BN", label: "Beni" },
];

const emits = defineEmits(["cerrar-formulario", "envio-formulario"]);

watch(muestra_form, (newVal) => {
    if (!newVal) {
        emits("cerrar-formulario");
    }
});

const archivo = ref(null);
const cargarArchivo = (e, key) => {
    form[key] = null;
    const file = e.target.files[0];
    if (file) {
        form[key] = e.target.files[0];
    }
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
        :footer-class="'justify-content-end'"
    >
        <template #header>
            <h4 class="modal-title text-white" v-html="tituloDialog"></h4>
            <button
                type="button"
                class="close"
                @click.prevent="cerrarFormulario()"
            >
                <span aria-hidden="true">×</span>
            </button>
        </template>

        <template #body>
            <form @submit.prevent="enviarFormulario()">
                <p class="text-muted text-xs mb-0">
                    Todos los campos con
                    <span class="text-danger">(*)</span> son obligatorios.
                </p>
                <div class="row">
                    <div class="col-md-4 mt-2">
                        <label class="required">Nombre Completo</label>
                        <el-input
                            type="text"
                            :class="{
                                'parsley-error': form.errors?.nombre,
                            }"
                            v-model="form.nombre"
                            autosize
                        ></el-input>
                        <ul
                            v-if="form.errors?.nombre"
                            class="d-block text-danger list-unstyled"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.nombre }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label class="required">Nro. de C.I.</label>
                        <el-input
                            type="text"
                            :class="{
                                'parsley-error': form.errors?.ci,
                            }"
                            v-model="form.ci"
                            autosize
                        ></el-input>
                        <ul
                            v-if="form.errors?.ci"
                            class="d-block text-danger list-unstyled"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.ci }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label class="required">Expedido</label>
                        <select
                            class="form-control"
                            :class="{
                                'parsley-error': form.errors?.ci_exp,
                            }"
                            v-model="form.ci_exp"
                        >
                            <option value="">- Seleccione -</option>
                            <option
                                v-for="item in listExpedido"
                                :value="item.value"
                            >
                                {{ item.label }}
                            </option>
                        </select>
                        <ul
                            v-if="form.errors?.ci_exp"
                            class="d-block text-danger list-unstyled"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.ci_exp }}
                            </li>
                        </ul>
                    </div>
                    <div class="col-md-4 mt-2">
                        <label class="required">Teléfono/Celular</label>
                        <el-input
                            type="text"
                            :class="{
                                'parsley-error': form.errors?.cel,
                            }"
                            v-model="form.cel"
                            autosize
                        ></el-input>
                        <ul
                            v-if="form.errors?.cel"
                            class="d-block text-danger list-unstyled"
                        >
                            <li class="parsley-required">
                                {{ form.errors?.cel }}
                            </li>
                        </ul>
                    </div>
                </div>
            </form>
        </template>
        <template #footer>
            <button
                type="button"
                class="btn btn-default"
                @click.prevent="cerrarFormulario()"
            >
                Cerrar
            </button>
            <button
                type="button"
                class="btn btn-primary"
                :disabled="enviando"
                @click.prevent="enviarFormulario"
                v-html="textBtn"
            ></button>
        </template>
    </MiModal>
</template>
