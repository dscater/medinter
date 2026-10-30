<script setup>
import axios from "axios";
import MiPaginacion from "@/Components/MiPaginacion.vue";
import { ref, computed, onMounted, onUnmounted, watch, nextTick } from "vue";
const props = defineProps({
    cols: {
        type: Array,
        default: () => [],
    },
    data: {
        type: Array,
        default: () => [],
    },
    conPaginacion: {
        type: Boolean,
        default: true,
    },
    api: {
        type: Boolean,
        default: false,
    },
    url: {
        type: String,
        default: "",
    },
    sinRegistros: {
        type: String,
        default: "No se encontrarón registros",
    },
    tableResponsive: {
        type: Boolean,
        default: false,
    },
    tableHeight: {
        type: [String, Number],
        default: null,
    },
    tableWidth: {
        type: [String, Number],
        default: null,
    },
    fixedHeader: {
        type: Boolean,
        default: false,
    },
    tableClass: {
        type: String,
        default: "",
    },
    headerClass: {
        type: String,
        default: "",
    },
    bodyClass: {
        type: String,
        default: "",
    },
    footerClass: {
        type: String,
        default: "",
    },
    paginationClass: {
        type: String,
        default: "",
    },
    perPage: {
        type: Number,
        default: 5,
    },
    filterPage: {
        type: Array,
        default: () => [5, 10, 20, 30, 50, 100],
    },
    syncOrderBy: {
        default: null,
    },
    syncOrderAsc: {
        default: null,
    },
    search: {
        type: String,
        default: "",
    },
    multiSearch: {
        type: Object,
        default: null,
    },
    numPages: {
        type: Number,
        default: 7,
    },
    loading: {
        type: Boolean,
        default: false,
    },
    textCargando: {
        type: String,
        default: "Cargando...",
    },
    delaySearch: {
        type: Number,
        default: 300,
    },
    // para listar los registros por cards - PENDIENTE
    card: {
        type: Boolean,
        default: false,
    },
});

// Se mantienen copias locales para no mutar directamente las props.
const listCols = ref([...props.cols]);
const listData = ref([...props.data]);
const listItems = ref([]);
const textSinRegistros = ref(props.sinRegistros);
const error = ref(false);
const mensajeError = ref("");
const per_page = ref(props.perPage);
const orderBy = ref(props.syncOrderBy);
const orderAsc = ref(
    props.syncOrderAsc ? props.syncOrderAsc.toLowerCase() : null,
);
const total = ref(listData.value.length);
const currentPage = ref(1);
const filter_page = ref(props.filterPage);
const tSearch = ref(props.search);
const oMultiSearch = ref(props.multiSearch);
const aPaginas = ref([]);
const cDeRegistros = ref(1);
const cARegistros = ref(per_page.value);
const totalPages = ref(0);
const pLoading = ref(false);
const intervalSearch = ref(null);
const requestController = ref(null);
let requestSequence = 0;

watch(
    () => props.syncOrderBy,
    (newVal) => {
        orderBy.value = newVal;
        // console.log("watch 1");
        cargarDatos();
    },
);

watch(
    () => props.syncOrderAsc,
    (newVal) => {
        orderAsc.value = newVal ? newVal.toLowerCase() : null;
        // console.log("watch 2");
        cargarDatos();
    },
);

// Mantener las columnas sincronizadas cuando el padre las reemplaza o modifica.
watch(
    () => props.cols,
    async (newCols) => {
        listCols.value = [...(newCols ?? [])];
        await nextTick();
        if (miTable.value) {
            widthMiTable.value = miTable.value.offsetWidth || 0;
            ajustarAnchoColumnas();
        }
    },
    { deep: true },
);

watch(
    () => props.sinRegistros,
    (value) => (textSinRegistros.value = value),
);

watch(
    () => props.loading,
    (newVal) => {
        // console.log("watch 3");
        pLoading.value = newVal;
    },
);

watch(
    () => props.multiSearch,
    (newVal) => {
        // console.log("watch 4");
        setLoading(true);
        clearTimeout(intervalSearch.value);
        intervalSearch.value = setTimeout(() => {
            currentPage.value = 1;
            oMultiSearch.value = newVal;
            cargarDatos();
        }, props.delaySearch);
    },
    { deep: true },
);

watch(
    () => props.search,
    (newVal) => {
        // console.log("watch 5");
        setLoading(true);
        tSearch.value = newVal;
        clearTimeout(intervalSearch.value);
        intervalSearch.value = setTimeout(() => {
            currentPage.value = 1;
            cargarDatos();
        }, props.delaySearch);
    },
);

watch(per_page, (newValue, oldValue) => {
    // console.log("watch 6");
    cambiaPerPage();
});

watch(
    () => props.data,
    (newVal) => {
        // console.log("watch 7");
        listData.value = newVal;
        total.value = listData.value.length;
        cargarDatos();
    },
);

watch(
    () => listItems.value,
    async (newVal) => {
        if (newVal.length > 0) {
            // alto del contenedor
            nextTick(() => {
                establecerAltoContenedor();
            });
        }
    },
);

// funcion para determinar si se cargaron todos los elementos
const esperarCargaElementos = () => {
    return new Promise((r) => window.requestAnimationFrame(r));
};

/**
 * *****************************************
 *  FUNCIONES PARA LA CARGA DE DATOS
 */

// Carga centralizada. Evita que una respuesta antigua sobrescriba una nueva.
const cargarDatos = async () => {
    const currentRequest = ++requestSequence;
    setLoading(true);
    error.value = false;

    try {
        if (props.api) {
            if (!props.url)
                throw new Error(
                    "La propiedad url es obligatoria cuando api=true.",
                );

            if (requestController.value) requestController.value.abort();
            requestController.value = new AbortController();

            const resp = await apiRegistros(requestController.value.signal);
            if (currentRequest !== requestSequence || !resp) return;

            total.value = Number(resp.total ?? 0);
            listItems.value = Array.isArray(resp.data) ? resp.data : [];
            totalPages.value = Number(resp.lastPage ?? resp.last_page ?? 0);
        } else {
            const result = generarDatosPorLista();
            if (currentRequest !== requestSequence) return;
            total.value = result.total;
            totalPages.value = result.lastPage;
            listItems.value = result.data;
        }

        muestraCantidadRegistros();
        await nextTick();
        establecerAltoContenedor();
    } catch (err) {
        if (err?.name !== "AbortError" && err?.code !== "ERR_CANCELED") {
            error.value = true;
            console.error("Error al cargar MiTable:", err);
        }
    } finally {
        if (currentRequest === requestSequence) setLoading(false);
    }
};

// Obtiene registros del backend. La paginación, búsqueda y ordenamiento
// deben ejecutarse en Laravel cuando el volumen de datos sea grande.
const apiRegistros = async (signal) => {
    const dataParams = {
        page: currentPage.value,
        currentPage: currentPage.value,
        perPage: per_page.value,
        search: tSearch.value,
        orderBy: orderBy.value,
        orderAsc: orderAsc.value,
        ...(oMultiSearch.value ?? {}),
    };

    const response = await axios(props.url, { params: dataParams, signal });
    return response.data ?? { data: [], total: 0, lastPage: 0 };
};

// Convierte valores a texto sin fallar ante null, objetos o arreglos.
const normalizarTextoBusqueda = (value) => {
    if (value == null) return "";
    if (
        typeof value === "string" ||
        typeof value === "number" ||
        typeof value === "boolean"
    ) {
        return String(value).toLocaleLowerCase();
    }
    if (Array.isArray(value))
        return value.map(normalizarTextoBusqueda).join(" ");
    if (typeof value === "object")
        return Object.values(value).map(normalizarTextoBusqueda).join(" ");
    return "";
};

// Filtrado y ordenamiento local para listas pequeñas o medianas.
// Se evita envolver operaciones síncronas en Promise y buscar la columna
// dentro de cada comparación del sort.
const generarDatosPorLista = () => {
    const search = String(tSearch.value ?? "")
        .trim()
        .toLocaleLowerCase();
    let filtered = listData.value;

    if (search) {
        filtered = filtered.filter((item) =>
            normalizarTextoBusqueda(item).includes(search),
        );
    }

    if (orderAsc.value && orderBy.value) {
        const columnConfig = listCols.value.find(
            (col) => col.key === orderBy.value,
        );
        if (columnConfig) {
            const direction = orderAsc.value === "desc" ? -1 : 1;
            const type = String(columnConfig.type ?? "").toLowerCase();
            filtered = [...filtered].sort((a, b) => {
                let valA = getColumnValue(a, orderBy.value) ?? "";
                let valB = getColumnValue(b, orderBy.value) ?? "";

                if (type === "number") {
                    valA = Number.parseFloat(valA) || 0;
                    valB = Number.parseFloat(valB) || 0;
                } else if (type === "date") {
                    valA = isValidDate(formatDateToISO(valA))
                        ? new Date(formatDateToISO(valA)).getTime()
                        : 0;
                    valB = isValidDate(formatDateToISO(valB))
                        ? new Date(formatDateToISO(valB)).getTime()
                        : 0;
                } else {
                    valA = String(valA).toLocaleLowerCase();
                    valB = String(valB).toLocaleLowerCase();
                }

                if (valA < valB) return -1 * direction;
                if (valA > valB) return 1 * direction;
                return 0;
            });
        }
    }

    const resultTotal = filtered.length;
    const pageSize = Math.max(1, Number(per_page.value) || 1);
    const lastPage = Math.ceil(resultTotal / pageSize);
    const startIndex =
        (Math.max(1, Number(currentPage.value) || 1) - 1) * pageSize;
    const data = props.conPaginacion
        ? filtered.slice(startIndex, startIndex + pageSize)
        : filtered;

    return { data, total: resultTotal, lastPage };
};

// Función para validar formatos de fecha
function isValidDate(dateString) {
    const date = new Date(dateString);
    return !isNaN(date.getTime());
}
// Función para convertir fechas de DD/MM/YYYY a YYYY-MM-DD
function formatDateToISO(dateString) {
    if (/\d{2}\/\d{2}\/\d{4}/.test(dateString)) {
        const [day, month, year] = dateString.split("/");
        return `${year}-${month}-${day}`;
    }
    return dateString; // Si ya está en formato ISO, devolverlo tal cual
}

// detectar el cambio de cantidad de registros por pagina
const cambiaPerPage = async () => {
    currentPage.value = 1;
    cargarDatos();
};

// detectar cambio del orden
const changeOrderBy = async (orderCol) => {
    let oldOrderBy = orderBy.value;
    orderBy.value = orderCol;
    if (oldOrderBy != orderBy.value) {
        orderAsc.value = "asc";
    } else {
        switch (orderAsc.value) {
            case "asc":
                orderAsc.value = "desc";
                break;
            case "desc":
                orderAsc.value = null;
                orderBy.value = null;
                break;
            case null:
                orderAsc.value = "asc";
                break;
        }
    }
    cargarDatos();
};

// detectar cambio de pagina
const cambioDePagina = async (value) => {
    currentPage.value = value;
    cargarDatos();
};

// Mostrar la cantidad de registgros encontrados
// segun la página y total
const muestraCantidadRegistros = () => {
    const startIndex =
        (Math.max(1, Number(currentPage.value) || 1) - 1) * per_page.value;
    cDeRegistros.value = listItems.value.length ? startIndex + 1 : 0;
    cARegistros.value = listItems.value.length
        ? startIndex + listItems.value.length
        : 0;
};

// obtener el valor anidado de la lista de items ej.: ["cliente.nombre"]
function getColumnValue(obj, key) {
    if (!key) return undefined;
    return String(key)
        .split(".")
        .reduce((acc, part) => (acc == null ? undefined : acc[part]), obj);
}

// usar la funcion getRowClass enviado desde la lista de columnas
function getRowClass(item) {
    const classes = [];
    for (const column of listCols.value) {
        if (typeof column.classRow === "function") {
            const className = column.classRow(item);
            if (className) classes.push(className);
        }
    }
    return classes.join(" ");
}

// verificar la opcion activa de ordenacion en el header
function getClassActiveSort(item) {
    if (props.api) {
        return (
            orderBy.value == (item.keySortable ? item.keySortable : item.key)
        );
    }
    return orderBy.value == item.key;
}

// setear el estado de loading del contenido de la tabla
const setLoading = (value) => {
    pLoading.value = value;
};
/**
 * FIN FUNCIONES CARGA DE DATOS
 * ******************************************************
 */

/********************************************************
 * ******************************************************
 *  FUNCIONES Y VARIABLES DE RENDERIZACIÓN DE TABLA
 */
const miTable = ref(null);
const miContentHeaderRef = ref(null);
const miTableHeaderRef = ref(null);
const miContentScrollRef = ref(null);
const miContentTableRef = ref(null);
const miTableFooterRef = ref(null);
const miContentFooter = ref(null);
const miTableRef = ref(null);
const listAnchoColumnas = ref([]);
const widthMiTable = ref(
    miTable.value ? parseInt(miTable.value.offsetWidth) : 0,
);
const widthColFirstDefault = ref(40);
const widthColsDefault = ref(40);

// Determinar el ancho de columnas
const ajustarAnchoColumnas = async () => {
    const tamanio_cols = listCols.value.length;
    if (!tamanio_cols || !miTable.value) return;
    const residuo = widthMiTable.value % tamanio_cols;
    let widthCol = Math.floor(widthMiTable.value / tamanio_cols);
    nextTick(async () => {
        if (miContentHeaderRef.value && miContentTableRef.value) {
            widthParamContent.value = miContentTableRef.value.offsetWidth;
            // obtener la lista de columnas
            const listThHeader =
                miContentHeaderRef.value.querySelectorAll("th");
            const colsColgroupHeader =
                miContentHeaderRef.value.querySelectorAll("col");
            const colsColgroupContent =
                miContentTableRef.value.querySelectorAll("col");

            const colsColgroupFooter = miTableFooterRef.value
                ? miTableFooterRef.value.querySelectorAll("col")
                : [];

            // recorrer las columnas listThHeader
            listThHeader.forEach((elemCol, indexCol) => {
                const width = parseInt(elemCol.offsetWidth);
                const iheader = elemCol.querySelector(".iheader");
                const label = elemCol.querySelector(".label");
                const widthContent = (label?.offsetWidth ?? 0) + 30; // padding incluido

                let widthDefinido = widthCol;
                if (listCols.value[indexCol].width) {
                    widthDefinido = getCalculoAnchoPVW(
                        listCols.value[indexCol].width,
                    );
                    if (widthContent > widthDefinido) {
                        widthDefinido = widthContent;
                    }
                } else {
                    if (residuo != 0 && indexCol == 0) {
                        widthDefinido = widthCol * (tamanio_cols - 1);
                        widthDefinido = widthMiTable.value - widthDefinido;
                    } else {
                        if (widthContent > widthDefinido) {
                            widthDefinido = widthContent;
                        }
                    }
                }

                if (colsColgroupHeader[indexCol])
                    colsColgroupHeader[indexCol].style.width =
                        widthDefinido + "px";
                if (colsColgroupContent[indexCol])
                    colsColgroupContent[indexCol].style.width =
                        widthDefinido + "px";
                listAnchoColumnas.value[indexCol] = widthDefinido;
                if (colsColgroupFooter.length > 0) {
                    colsColgroupFooter[indexCol].style.width =
                        widthDefinido + "px";
                }
            });
        }

        await establecerColumnasFixedSlot();
        establecerAltoContenedor();
    });
};

// Funcion del :style en th y td
// obtiene el estilo de position right|left si el elemento es fixed
const widthParamContent = ref(0);

// Los offsets de columnas fijas se calculan una sola vez por cambio de columnas/ancho,
// no una vez por cada celda renderizada.
const fixedColumnMeta = computed(() => {
    const cols = listCols.value;
    const widths = listAnchoColumnas.value;
    const leftOffsets = {};
    const rightOffsets = {};
    let left = 0;
    let right = 0;
    let leftCount = 0;
    let rightCount = 0;

    cols.forEach((col, index) => {
        if (col.fixed === true) {
            leftOffsets[index] = left;
            left += Number(widths[index] ?? 0);
            leftCount++;
        }
    });

    for (let index = cols.length - 1; index >= 0; index--) {
        if (cols[index].fixed === "right") {
            rightOffsets[index] = right;
            right += Number(widths[index] ?? 0);
            rightCount++;
        }
    }

    return { leftOffsets, rightOffsets, leftCount, rightCount };
});

const getStyleColRenderizado = (indexCol) => {
    const column = listCols.value[indexCol];
    if (!column?.fixed || !miContentTableRef.value || !miTableRef.value)
        return "";
    if (window.innerWidth <= 790 && props.tableResponsive) return "";

    if (column.fixed === "right") {
        return {
            right: `${fixedColumnMeta.value.rightOffsets[indexCol] ?? 0}px`,
        };
    }
    return { left: `${fixedColumnMeta.value.leftOffsets[indexCol] ?? 0}px` };
};

// Funcion para el :class e th y td
// para sombrear lo 1ros y ultimos de las columnas
const getClassShadow = (item, indexCol) => {
    if (!item?.fixed || !miContentTableRef.value || !miTableRef.value)
        return "";
    if (miTableRef.value.offsetWidth <= miContentTableRef.value.offsetWidth)
        return "";

    const meta = fixedColumnMeta.value;
    if (
        item.fixed === "right" &&
        indexCol === listCols.value.length - meta.rightCount
    ) {
        return "fixed-shadow-right";
    }
    if (item.fixed === true && indexCol === meta.leftCount - 1) {
        return "fixed-shadow-left";
    }
    return "";
};

// Fijar el alto que tendra el contenedor segun la propiedad tableHeight
const establecerAltoContenedor = () => {
    if (miContentTableRef.value) {
        miContentTableRef.value.style.minHeight = "";
        if (props.tableHeight) {
            miContentTableRef.value.style.height = `${props.tableHeight}`;
            miContentTableRef.value.style.minHeight = `${props.tableHeight}`;
        } else {
            miContentTableRef.value.style.minHeight = `${
                listItems.value.length * 53
            }px`;
        }
    }

    // resetPositionScroll();
    setTimeout(() => {
        updateScrollbars();
    }, 300);
};

// Obtener la distancia right|left del array stylesRenderizados
// para cada nueva carga de datos
const getDistanciaEstablecida = (indexCol) => {
    let styles = {};
    if (stylesRenderizados.value && stylesRenderizados.value.length > 0) {
        if (stylesRenderizados.value[indexCol]) {
            styles = stylesRenderizados.value[indexCol];
        }
    }
    return styles;
};

// funcion para calcular la distancia derecha|izquierda del elemento
const calcularDistanciaPosicionRL = (indexCol, rl, listaActualizada) => {
    // console.log(listaActualizada);
    let inicio = 0;
    let fin = indexCol > 0 ? indexCol : 0;
    let tamanio_cols = listCols.value.length;
    let distancia = 0;
    let width_elems = [];
    if (rl == "r") {
        inicio = indexCol + 1 < tamanio_cols ? indexCol + 1 : tamanio_cols;
        fin = tamanio_cols;
    }
    width_elems = listaActualizada.slice(inicio, fin);
    distancia = width_elems.reduce((a, b) => {
        return a + b;
    }, 0);

    return distancia + "px";
};

// renderizar columnas externas
const establecerColumnasFixedSlot = () => {
    return new Promise((resolve, reject) => {
        try {
            if (miTableFooterRef.value) {
                const table = miTableFooterRef.value;
                const listFilas = table.querySelectorAll("tr");
                listFilas.forEach((fila) => {
                    const listIzquierda =
                        fila.querySelectorAll(".fixed-column-ext");
                    const listDerechaIni = fila.querySelectorAll(
                        ".fixed-column-ext-right",
                    );
                    const listDerecha = [...listDerechaIni].reverse();
                    let distancia_acum = 0;
                    listIzquierda.forEach((elem) => {
                        elem.style.position = "sticky";
                        elem.style.left = distancia_acum + "px";
                        if (elem.classList.contains("footer-fixed")) {
                            elem.style.bottom = "1px";
                        }
                        elem.style.left = distancia_acum + "px";
                        distancia_acum += parseFloat(elem.offsetWidth);
                    });

                    distancia_acum = 0;
                    listDerecha.forEach((elem) => {
                        elem.style.position = "sticky";
                        elem.style.right = distancia_acum + "px";
                        if (elem.classList.contains("footer-fixed")) {
                            elem.style.bottom = "1px";
                        }
                        elem.style.right = distancia_acum + "px";
                        distancia_acum += parseFloat(elem.offsetWidth);
                    });
                });
            }
            resolve();
        } catch (error) {
            reject(error);
        }
    });
};

// calcular anchos % o vw
const getCalculoAnchoPVW = (width) => {
    const unidad_val = obtenerUnidadValor(width);
    let resultado = unidad_val[1];
    if (unidad_val[0] && unidad_val[0] != "px") {
        resultado = (resultado * widthMiTable.value) / 100;
    }
    return parseInt(resultado);
};
function obtenerUnidadValor(valor) {
    const texto = String(valor ?? "");
    const coincidencia = texto.match(/^(\d+(?:\.\d+)?)(px|%)$/);
    let unidad = null;
    let width = texto;
    if (coincidencia) {
        unidad = coincidencia[2] || null;
        width = coincidencia[1];
    }
    return [unidad, width];
}

/**
 * FIN FUNCIONES RENDER
 * ***********************************
 */

/************************************
 * **********************************
 * SCROLL
 **/
const scrollX = ref(null);
const scrollY = ref(null);
// Variables para el drag
const isDragging = ref(false);
const dragAxis = ref(null);
const startPos = ref(0);
const startScroll = ref(0);
const originalScrollYpx = ref(-1);
// resetear la posición de los scrollbars
const resetPositionScroll = () => {
    originalScrollYpx.value = -1;
    startPos.value = 0;
    if (miContentTableRef.value) {
        miContentTableRef.value.scrollLeft = 0;
        miContentTableRef.value.scrollTop = 0;
    }
    if (scrollX.value) {
        scrollX.value.style.left = 0 + "px";
    }
    if (scrollY.value) {
        scrollY.value.style.top = 0 + "px";
    }
};
// actualizar el tamaño del elemento de scroll (track)
const updateScrollbars = () => {
    if (miContentTableRef.value) {
        if (
            miContentTableRef.value.scrollWidth >
            miContentTableRef.value.offsetWidth
        ) {
            // El ancho de la barra de scroll visible en X
            let anchoScrollX =
                miContentTableRef.value.offsetWidth /
                miContentTableRef.value.scrollWidth;
            anchoScrollX *= 100;
            if (scrollX.value?.parentElement) {
                scrollX.value.style.width = anchoScrollX + "%";
                scrollX.value.parentElement.style.display = "block";
            }
        } else {
            if (scrollX.value?.parentElement)
                scrollX.value.parentElement.style.display = "none";
        }

        if (
            miContentTableRef.value.scrollHeight >
            miContentTableRef.value.offsetHeight
        ) {
            // El ancho de la barra de scroll visible en Y
            let altoScrollY =
                miContentTableRef.value.offsetHeight /
                miContentTableRef.value.scrollHeight;
            altoScrollY *= 100;
            if (scrollY.value?.parentElement) {
                scrollY.value.style.height = altoScrollY + "%";
                originalScrollYpx.value = scrollY.value.offsetHeight;
                if (
                    originalScrollYpx.value < 15 &&
                    originalScrollYpx.value > 0
                ) {
                    scrollY.value.style.height = "16px";
                }
                scrollY.value.parentElement.style.display = "block";
            }
        } else {
            if (scrollY.value?.parentElement)
                scrollY.value.parentElement.style.display = "none";
        }
        syncScrollBodyHeader();
    }
};

// sincronizar el scroll X del contenedor con el header
const syncScrollBodyHeader = () => {
    if (miContentTableRef.value) {
        miContentTableRef.value.removeEventListener(
            "scroll",
            scrollContentAHeader,
        );
        miContentTableRef.value.addEventListener(
            "scroll",
            scrollContentAHeader,
        );
    }
    if (miContentHeaderRef.value) {
        miContentHeaderRef.value.removeEventListener(
            "scroll",
            scrollHeaderAContent,
        );
        miContentHeaderRef.value.addEventListener(
            "scroll",
            scrollHeaderAContent,
        );
    }
};

// eventos de scroll content
const scrollContentAHeader = (e) => {
    // Verifica si el contenedor tiene un scroll horizontal
    if (e.target.scrollWidth > e.target.clientWidth) {
        // Solo sincroniza el scroll si el contenedor tiene desplazamiento
        miContentHeaderRef.value.scrollLeft = e.target.scrollLeft;
        let positionLeftScroll =
            e.target.scrollLeft / miContentTableRef.value.scrollWidth;
        scrollX.value.style.left =
            positionLeftScroll * (miContentTableRef.value.offsetWidth - 5) +
            "px";
    } else {
        miContentTableRef.value.removeEventListener(
            "scroll",
            syncScrollBodyHeader,
        );
    }

    // Verifica si el contenedor tiene un scroll vertical
    if (e.target.scrollHeight > e.target.clientHeight) {
        // Solo sincroniza el scroll si el contenedor tiene desplazamiento
        miContentHeaderRef.value.scrollTop = e.target.scrollTop;
        let positionTopScroll =
            e.target.scrollTop / miContentTableRef.value.scrollHeight;
        scrollY.value.style.top =
            positionTopScroll *
                (miContentTableRef.value.offsetHeight -
                    (originalScrollYpx.value > -1 ? 16 : 5)) +
            "px";
    } else {
        miContentTableRef.value.removeEventListener(
            "scroll",
            syncScrollBodyHeader,
        );
    }
};

// eventos de scroll header
const scrollHeaderAContent = (e) => {
    // Verifica si el contenedor tiene un scroll horizontal
    if (e.target.scrollWidth > e.target.clientWidth) {
        // Solo sincroniza el scroll si el contenedor tiene desplazamiento
        miContentTableRef.value.scrollLeft = e.target.scrollLeft;
        let positionLeftScroll =
            e.target.scrollLeft / miContentHeaderRef.value.scrollWidth;
        scrollX.value.style.left =
            positionLeftScroll * (miContentHeaderRef.value.offsetWidth - 5) +
            "px";
    } else {
        miContentHeaderRef.value.removeEventListener(
            "scroll",
            syncScrollBodyHeader,
        );
    }
};

// iniciar el drag del scroll
const startDrag = (axis, event) => {
    isDragging.value = true;
    dragAxis.value = axis;
    startPos.value = axis === "x" ? event.pageX : event.pageY;
    const container = miContentTableRef.value;
    startScroll.value =
        axis === "x" ? container.scrollLeft : container.scrollTop;

    document.body.classList.add("no-select");
    removerEventosScroll();
    document.addEventListener("mousemove", handleMouseMove);
    document.addEventListener("mouseup", stopDrag);
};

// detectar el movimiento del scroll
const handleMouseMove = (event) => {
    if (isDragging.value === true) {
        const mouseDifferential =
            (dragAxis.value === "x" ? event.pageX : event.pageY) -
            startPos.value;
        const container = miContentTableRef.value;

        let scrollEquivalent = 0;

        if (dragAxis.value === "x") {
            scrollEquivalent =
                mouseDifferential *
                (container.offsetWidth
                    ? container.scrollWidth / container.offsetWidth
                    : 1);
            container.scrollLeft = startScroll.value + scrollEquivalent;
        } else {
            scrollEquivalent =
                mouseDifferential *
                (container.offsetHeight
                    ? container.scrollHeight / container.offsetHeight
                    : 1);
            container.scrollTop = startScroll.value + scrollEquivalent;
        }
    }
};

// detener el scroll
const stopDrag = () => {
    // Habilitar la selección de texto nuevamente
    document.body.classList.remove("no-select");
    removerEventosScroll();
};

// remover los eventos de scroll
const removerEventosScroll = () => {
    document.removeEventListener("mousemove", handleMouseMove);
    document.removeEventListener("mouseup", stopDrag);
};

/**
 * FIN SCROLL
 ******************************************
 **/

const observerContentMiTable = ref(null);
const inertavalResizeContent = ref(null);

onMounted(async () => {
    // Inicializa también el modo local; antes solo se cargaba automáticamente api=true.
    await cargarDatos();
    await nextTick();

    if (!miTable.value) return;
    widthMiTable.value = miTable.value.offsetWidth || 0;
    syncScrollBodyHeader();
    ajustarAnchoColumnas();

    if (typeof ResizeObserver !== "undefined") {
        observerContentMiTable.value = new ResizeObserver((entries) => {
            clearTimeout(inertavalResizeContent.value);
            const entry = entries[entries.length - 1];
            if (!entry) return;

            const newWidth = Math.round(entry.contentRect.width);
            inertavalResizeContent.value = setTimeout(() => {
                if (widthMiTable.value !== newWidth) {
                    widthMiTable.value = newWidth;
                    ajustarAnchoColumnas();
                }
            }, 120);
        });
        observerContentMiTable.value.observe(miTable.value);
    }
});

onUnmounted(() => {
    clearTimeout(intervalSearch.value);
    clearTimeout(inertavalResizeContent.value);
    requestController.value?.abort();
    observerContentMiTable.value?.disconnect();
    observerContentMiTable.value = null;
    removerEventosScroll();
    document.body.classList.remove("no-select");
});

defineExpose({
    cargarDatos,
    setLoading,
});
</script>
<template>
    <div
        class="mi-table"
        :class="[$attrs.class, fixedHeader ? 'tablaFixeada' : '']"
        ref="miTable"
    >
        <div class="content-data">
            <div class="mi-content-header" ref="miContentHeaderRef">
                <table
                    class="table table-bordered"
                    :class="[
                        tableResponsive ? 'table-resposive' : '',
                        fixedHeader ? 'tablaFixeada' : '',
                    ]"
                    ref="miTableHeaderRef"
                >
                    <colgroup ref="tableHeaderGroup">
                        <col
                            v-for="(item, index) in listCols"
                            :key="item.key ?? item.label ?? index"
                        />
                    </colgroup>
                    <thead :class="[headerClass]">
                        <template v-if="$slots.tableHeader">
                            <slot name="tableHeader"></slot>
                        </template>
                        <template v-else>
                            <tr>
                                <th
                                    v-for="(item, index) in listCols"
                                    :colspan="`${item.colspan ? item.colspan : 1}`"
                                    :class="[
                                        item.fixed
                                            ? item.fixed == 'right'
                                                ? 'fixed-column-right'
                                                : 'fixed-column'
                                            : '',
                                        fixedHeader ? 'fixed-header' : '',
                                        getClassShadow(
                                            item,
                                            index,
                                            widthParamContent,
                                        ),
                                    ]"
                                    :data-width="item.width ? item.width : ''"
                                    :style="
                                        getStyleColRenderizado(
                                            index,
                                            widthParamContent,
                                        )
                                    "
                                >
                                    <div
                                        class="iheader sortable"
                                        v-if="item.sortable"
                                        @click="
                                            changeOrderBy(
                                                api
                                                    ? item.keySortable
                                                        ? item.keySortable
                                                        : item.key
                                                    : item.key,
                                            )
                                        "
                                    >
                                        <div class="label">
                                            {{ item.label }}
                                        </div>
                                        <div
                                            class="accion"
                                            :class="{
                                                active: getClassActiveSort(
                                                    item,
                                                ),
                                            }"
                                        >
                                            <i
                                                class="fa"
                                                :class="{
                                                    'fa-sort-amount-up-alt':
                                                        orderAsc == 'asc' &&
                                                        orderBy ==
                                                            (api
                                                                ? item.keySortable
                                                                    ? item.keySortable
                                                                    : item.key
                                                                : item.key),
                                                    'fa-sort-amount-down':
                                                        orderAsc == 'desc' &&
                                                        orderBy ==
                                                            (api
                                                                ? item.keySortable
                                                                    ? item.keySortable
                                                                    : item.key
                                                                : item.key),
                                                    'fa-sort':
                                                        !orderAsc ||
                                                        orderBy !=
                                                            (api
                                                                ? item.keySortable
                                                                    ? item.keySortable
                                                                    : item.key
                                                                : item.key),
                                                }"
                                            ></i>
                                        </div>
                                    </div>
                                    <div class="iheader" v-else>
                                        <div class="label">
                                            {{ item.label }}
                                        </div>
                                    </div>
                                </th>
                            </tr>
                        </template>
                    </thead>
                </table>
            </div>
            <div class="mi-content-scroll" ref="miContentScrollRef">
                <div
                    class="content-table"
                    :style="{
                        maxHeight: tableHeight ? tableHeight : '',
                        width: tableWidth ? tableWidth : '',
                    }"
                    ref="miContentTableRef"
                >
                    <div
                        class="mi-loading-table"
                        v-show="pLoading"
                        ref="miLoading"
                    >
                        <div>
                            <template v-if="$slots.loading">
                                <slot name="loading"></slot>
                            </template>
                            <template v-else> {{ textCargando }} </template>
                        </div>
                    </div>
                    <table
                        class="table table-bordered mb-0"
                        :class="[
                            tableClass,
                            tableResponsive ? 'table-resposive' : '',
                        ]"
                        ref="miTableRef"
                    >
                        <colgroup ref="tableContentGroup">
                            <col
                                v-for="(item, index) in listCols"
                                :key="item.key ?? item.label ?? index"
                            />
                        </colgroup>
                        <tbody
                            :class="[
                                bodyClass,
                                pLoading ? 'loading_active' : '',
                            ]"
                            ref="eTbody"
                        >
                            <template v-if="listItems.length > 0">
                                <tr
                                    v-for="(item, index_row) in listItems"
                                    :class="getRowClass(item)"
                                    :key="item.id ? item.id : index_row"
                                >
                                    <td
                                        v-for="(i_col, index_col) in listCols"
                                        :class="[
                                            i_col.fixed
                                                ? i_col.fixed == 'right'
                                                    ? 'fixed-column-right'
                                                    : 'fixed-column'
                                                : '',
                                            getClassShadow(
                                                i_col,
                                                index_col,
                                                widthParamContent,
                                            ),
                                        ]"
                                        :colspan="`${item.colspan ? item.colspan : 1}`"
                                        :style="
                                            getStyleColRenderizado(
                                                index_col,
                                                widthParamContent,
                                            )
                                        "
                                    >
                                        <div
                                            class="label-responsive"
                                            v-text="`${i_col.label}:`"
                                        ></div>
                                        <div
                                            class="mi-celda"
                                            :class="[
                                                i_col.classTd
                                                    ? i_col.classTd(item)
                                                    : '',
                                            ]"
                                        >
                                            <template v-if="$slots[i_col.key]">
                                                <slot
                                                    :name="i_col.key"
                                                    :item="item"
                                                    v-bind="$attrs"
                                                ></slot>
                                            </template>
                                            <template v-else>
                                                {{
                                                    i_col.isIndex
                                                        ? index_row + 1
                                                        : i_col.render
                                                          ? i_col.render(
                                                                item,
                                                                index_row,
                                                            )
                                                          : i_col.key
                                                            ? getColumnValue(
                                                                  item,
                                                                  i_col.key,
                                                              )
                                                            : ""
                                                }}
                                            </template>
                                        </div>
                                    </td>
                                </tr>
                            </template>
                            <template v-else>
                                <tr>
                                    <td
                                        :colspan="listCols.length"
                                        class="text-center py-2"
                                    >
                                        {{ textSinRegistros }}
                                    </td>
                                </tr>
                            </template>
                        </tbody>
                    </table>
                </div>
                <div class="content-scroll-x">
                    <div
                        class="mi-custom-scroll-x"
                        @mousedown="startDrag('x', $event)"
                        ref="scrollX"
                    ></div>
                </div>
                <div class="content-scroll-y">
                    <div
                        class="mi-custom-scroll-y"
                        @mousedown="startDrag('y', $event)"
                        ref="scrollY"
                    ></div>
                </div>
            </div>
            <div
                class="mi-content-footer"
                ref="miContentFooter"
                v-if="$slots.tableFooter"
            >
                <table class="table table-bordered" ref="miTableFooterRef">
                    <colgroup ref="tableFooterGroup">
                        <col
                            v-for="(item, index) in listCols"
                            :key="item.key ?? item.label ?? index"
                        />
                    </colgroup>
                    <tbody :class="[footerClass]">
                        <slot name="tableFooter"></slot>
                    </tbody>
                </table>
            </div>
        </div>

        <div class="content-foot" v-if="conPaginacion">
            <div class="row mt-1">
                <div class="my-1 col-md-3">
                    <select class="form-control rounded-0" v-model="per_page">
                        <option
                            v-for="item in filter_page"
                            :key="item"
                            :value="item"
                        >
                            Mostrar {{ item }} registros
                        </option>
                    </select>
                </div>
                <div class="my-1 col-md-6 d-flex justify-content-center">
                    <MiPaginacion
                        :current-page="currentPage"
                        :total-data="total"
                        :per-page="per_page"
                        @updatePage="cambioDePagina"
                    />
                </div>
                <div class="my-1 col-md-3 text-right">
                    Mostrando {{ cDeRegistros }} a {{ cARegistros }} registros -
                    Total {{ total }} registros
                </div>
            </div>
            <div v-if="error" class="alert alert-danger">
                Ocurrió un error al intentar obtener los registros
            </div>
        </div>
    </div>
</template>
<style scoped>
.mi-content-scroll {
    position: relative;
}

.content-scroll-x,
.content-scroll-y {
    opacity: 70%;
    position: absolute;
    background-color: transparent;
    z-index: 3;
}
.mi-table .mi-content-scroll:hover .content-scroll-x,
.mi-table .mi-content-scroll:hover .content-scroll-y {
    opacity: 100%;
}
.content-scroll-x {
    height: 10px;
    width: 100%;
    bottom: 0px;
}
.content-scroll-y {
    height: 100%;
    width: 10px;
    top: 0;
    right: 0;
}

.mi-custom-scroll-y,
.mi-custom-scroll-x {
    position: absolute;
    background: #cacaca;
    cursor: pointer;
    border-radius: 10px;
}

.mi-custom-scroll-y {
    margin-left: 2px;
    width: 8px;
    top: 0;
    right: 0px;
}

.mi-custom-scroll-x {
    margin-top: 2px;
    height: 8px;
    left: 0px;
}
</style>
