import { onMounted, ref } from "vue";

const oCliente = ref({
    id: 0,
    nombre: "",
    paterno: "",
    materno: "",
    ci: "",
    ci_exp: "",
    complemento: "",
    fecha_nac: "",
    cel: "",
    respuesta: "clientes",
    _method: "POST",
});

export const useClientes = () => {
    const setCliente = (item = null) => {
        if (item) {
            oCliente.value.id = item.id;
            oCliente.value.nombre = item.nombre;
            oCliente.value.paterno = item.paterno;
            oCliente.value.materno = item.materno;
            oCliente.value.ci = item.ci;
            oCliente.value.ci_exp = item.ci_exp;
            oCliente.value.complemento = item.complemento;
            oCliente.value.fecha_nac = item.fecha_nac;
            oCliente.value.cel = item.cel;
            oCliente.value._method = "PUT";
            return oCliente;
        }
        return false;
    };

    const limpiarCliente = () => {
        oCliente.value.id = 0;
        oCliente.value.nombre = "";
        oCliente.value.paterno = "";
        oCliente.value.materno = "";
        oCliente.value.ci = "";
        oCliente.value.ci_exp = "";
        oCliente.value.complemento = "";
        oCliente.value.fecha_nac = "";
        oCliente.value.cel = "";
        oCliente.value.respuesta = "clientes";
        oCliente.value._method = "POST";
    };

    onMounted(() => {});

    return {
        oCliente,
        setCliente,
        limpiarCliente,
    };
};
