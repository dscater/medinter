import { onMounted, ref } from "vue";

const oTipoCertificado = ref({
    id: 0,
    nombre: "",
    precio: "",
    descripcion: "",
    _method: "POST",
});

export const useTipoCertificados = () => {
    const setTipoCertificado = (item = null) => {
        if (item) {
            oTipoCertificado.value.id = item.id;
            oTipoCertificado.value.nombre = item.nombre;
            oTipoCertificado.value.precio = item.precio;
            oTipoCertificado.value.descripcion = item.descripcion;
            oTipoCertificado.value._method = "PUT";
            return oTipoCertificado;
        }
        return false;
    };

    const limpiarTipoCertificado = () => {
        oTipoCertificado.value.id = 0;
        oTipoCertificado.value.nombre = "";
        oTipoCertificado.value.precio = "";
        oTipoCertificado.value.descripcion = "";
        oTipoCertificado.value._method = "POST";
    };

    onMounted(() => {});

    return {
        oTipoCertificado,
        setTipoCertificado,
        limpiarTipoCertificado,
    };
};
