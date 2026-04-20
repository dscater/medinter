import { onMounted, ref } from "vue";

const oCertificado = ref({
    id: 0,
    cliente_id: "",
    cliente: "",
    total: "",
    cancelado: "",
    saldo: "",
    tipo_pago: "EFECTIVO",
    tipo: "NORMAL",
    tramitador_id: "",
    user_id: "",
    sucursal_id: "",
    fecha_inicio: "",
    hora_inicio: "",
    fecha_fin: "",
    hora_fin: "",
    estado: "",
    certificado_detalles: [],
    eliminados: [],
    _method: "POST",
});

export const useCertificados = () => {
    const setCertificado = (item = null) => {
        if (item) {
            oCertificado.value.id = item.id;
            oCertificado.value.cliente_id = item.cliente_id;
            oCertificado.value.cliente = item.cliente;
            oCertificado.value.total = item.total;
            oCertificado.value.cancelado = item.cancelado;
            oCertificado.value.saldo = item.saldo;
            oCertificado.value.tipo = item.tipo;
            oCertificado.value.tipo_pago = item.tipo_pago;
            oCertificado.value.user_id = item.user_id;
            oCertificado.value.sucursal_id = item.sucursal_id;
            oCertificado.value.fecha_inicio = item.fecha_inicio;
            oCertificado.value.hora_inicio = item.hora_inicio;
            oCertificado.value.fecha_fin = item.fecha_fin;
            oCertificado.value.hora_fin = item.hora_fin;
            oCertificado.value.estado = item.estado;
            oCertificado.value.certificado_detalles = item.certificado_detalles;
            oCertificado.value.eliminados = [];
            oCertificado.value._method = "PUT";
            return oCertificado;
        }
        return false;
    };

    const limpiarCertificado = () => {
        oCertificado.value.id = 0;
        oCertificado.value.cliente_id = "";
        oCertificado.value.cliente = "";
        oCertificado.value.total = "";
        oCertificado.value.cancelado = 0;
        oCertificado.value.saldo = 0;
        oCertificado.value.tipo_pago = "EFECTIVO";
        oCertificado.value.tipo = "NORMAL";
        oCertificado.value.user_id = "";
        oCertificado.value.sucursal_id = "";
        oCertificado.value.fecha_inicio = "";
        oCertificado.value.hora_inicio = "";
        oCertificado.value.fecha_fin = "";
        oCertificado.value.hora_fin = "";
        oCertificado.value.estado = "";
        oCertificado.value.certificado_detalles = [];
        oCertificado.value.eliminados = [];
        oCertificado.value._method = "POST";
    };

    onMounted(() => {});

    return {
        oCertificado,
        setCertificado,
        limpiarCertificado,
    };
};
