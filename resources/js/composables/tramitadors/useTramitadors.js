import { onMounted, ref } from "vue";

const oTramitador = ref({
    id: 0,
    nombre: "",
    ci: "",
    ci_exp: "",
    cel: "",
    _method: "POST",
});

export const useTramitadors = () => {
    const setTramitador = (item = null) => {
        if (item) {
            oTramitador.value.id = item.id;
            oTramitador.value.nombre = item.nombre;
            oTramitador.value.ci = item.ci;
            oTramitador.value.ci_exp = item.ci_exp;
            oTramitador.value.cel = item.cel;
            oTramitador.value._method = "PUT";
            return oTramitador;
        }
        return false;
    };

    const limpiarTramitador = () => {
        oTramitador.value.id = 0;
        oTramitador.value.nombre = "";
        oTramitador.value.ci = "";
        oTramitador.value.ci_exp = "";
        oTramitador.value.cel = "";
        oTramitador.value.respuesta = "clientes";
    };

    onMounted(() => {});

    return {
        oTramitador,
        setTramitador,
        limpiarTramitador,
    };
};
