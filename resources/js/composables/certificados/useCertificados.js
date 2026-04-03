import { onMounted, ref } from "vue";

const oCertificado = ref({
    id: 0,
    cliente_id: "",
    precio: "",
    tipo_certificado_id: "",
    tipo_pago: "",
    archivo1: "",
    archivo2: "",
    user_id: "",
    sucursal_id: "",
    _method: "POST",
});

export const useCertificados = () => {
    const setCertificado = (item = null) => {
        if (item) {
            oCertificado.value.id = item.id;
            oCertificado.value.cliente_id = item.cliente_id;
            oCertificado.value.precio = item.precio;
            oCertificado.value.tipo_certificado_id = item.tipo_certificado_id;
            oCertificado.value.tipo_pago = item.tipo_pago;
            oCertificado.value.archivo1 = item.archivo1;
            oCertificado.value.archivo2 = item.archivo2;
            oCertificado.value.user_id = item.user_id;
            oCertificado.value.sucursal_id = item.sucursal_id;
            oCertificado.value._method = "PUT";
            return oCertificado;
        }
        return false;
    };

    const limpiarCertificado = () => {
        oCertificado.value.id = 0;
        oCertificado.value.cliente_id = "";
        oCertificado.value.precio = "";
        oCertificado.value.tipo_certificado_id = "";
        oCertificado.value.tipo_pago = "";
        oCertificado.value.archivo1 = "";
        oCertificado.value.archivo2 = "";
        oCertificado.value.user_id = "";
        oCertificado.value.sucursal_id = "";
        oCertificado.value._method = "POST";
    };

    onMounted(() => {});

    return {
        oCertificado,
        setCertificado,
        limpiarCertificado,
    };
};
