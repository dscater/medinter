import { onMounted, ref } from "vue";

const oTramite = ref({
    id: 0,
    nro: "",
    codigo: "",
    tramitador_id: "",
    fecha: "",
    hora: "",
    sucursal_id: "",
    user_id: "",
    tramite_clientes: [],
    eliminados: [],
    _method: "POST",
});

export const useTramites = () => {
    const setTramite = (item = null) => {
        if (item) {
            oTramite.value.id = item.id;
            oTramite.value.nro = item.nro;
            oTramite.value.codigo = item.codigo;
            oTramite.value.tramitador_id = item.tramitador_id;
            oTramite.value.fecha = item.fecha;
            oTramite.value.hora = item.hora;
            oTramite.value.sucursal_id = item.sucursal_id;
            oTramite.value.user_id = item.user_id;
            oTramite.value.tramite_clientes = item.tramite_clientes;
            oTramite.value.eliminados = [];
            oTramite.value._method = "PUT";
            return oTramite;
        }
        return false;
    };

    const limpiarTramite = () => {
        oTramite.value.id = 0;
        oTramite.value.nro = "";
        oTramite.value.codigo = "";
        oTramite.value.tramitador_id = "";
        oTramite.value.fecha = "";
        oTramite.value.hora = "";
        oTramite.value.sucursal_id = "";
        oTramite.value.user_id = "";
        oTramite.value.tramite_clientes = [];
        oTramite.value.eliminados = [];
        oTramite.value._method = "POST";
    };

    onMounted(() => {});

    return {
        oTramite,
        setTramite,
        limpiarTramite,
    };
};
