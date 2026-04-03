import { onMounted, ref } from "vue";

const oSucursal = ref({
    id: 0,
    nombre: "",
    descripcion: "",
    _method: "POST",
});

export const useSucursals = () => {
    const setSucursal = (item = null) => {
        if (item) {
            oSucursal.value.id = item.id;
            oSucursal.value.nombre = item.nombre;
            oSucursal.value.descripcion = item.descripcion;
            oSucursal.value._method = "PUT";
            return oSucursal;
        }
        return false;
    };

    const limpiarSucursal = () => {
        oSucursal.value.id = 0;
        oSucursal.value.nombre = "";
        oSucursal.value.descripcion = "";
        oSucursal.value._method = "POST";
    };

    onMounted(() => {});

    return {
        oSucursal,
        setSucursal,
        limpiarSucursal,
    };
};
