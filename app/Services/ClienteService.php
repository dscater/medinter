<?php

namespace App\Services;

use App\Services\HistorialAccionService;
use App\Models\Cliente;
use App\Models\User;
use DateTime;
use Illuminate\Http\UploadedFile;
use Exception;
use Illuminate\Container\Attributes\Auth;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Pagination\LengthAwarePaginator;
use Illuminate\Validation\ValidationException;

class ClienteService
{
    private $modulo = "CLIENTES";

    public function __construct(private  CargarArchivoService $cargarArchivoService, private HistorialAccionService $historialAccionService) {}

    public function listado(): Collection
    {
        $clientes = Cliente::select("clientes.*")->where("status", 1)->get();
        return $clientes;
    }
    /**
     * Lista de clientes paginado con filtros
     *
     * @param integer $length
     * @param integer $page
     * @param string $search
     * @param array $columnsSerachLike
     * @param array $columnsFilter
     * @return LengthAwarePaginator
     */
    public function listadoPaginado(int $length, int $page, string $search, array $columnsSerachLike = [], array $columnsFilter = [], array $columnsBetweenFilter = [], array $orderBy = []): LengthAwarePaginator
    {
        $clientes = Cliente::select("clientes.*");

        $clientes->buscarNombre($search);

        // Ordenamiento
        foreach ($orderBy as $value) {
            if (isset($value[0], $value[1])) {
                $clientes->orderBy($value[0], $value[1]);
            }
        }

        $clientes = $clientes->paginate($length, ['*'], 'page', $page);
        return $clientes;
    }

    /**
     * Crear cliente
     *
     * @param array $datos
     * @return Cliente
     */
    public function crear(array $datos): Cliente
    {
        $cliente = Cliente::create([
            "nombre" => mb_strtoupper($datos['nombre']),
            "paterno" => mb_strtoupper($datos['paterno']),
            "materno" => mb_strtoupper($datos['materno']),
            "ci" => mb_strtoupper($datos['ci']),
            "ci_exp" => mb_strtoupper($datos['ci_exp']),
            "complemento" => mb_strtoupper($datos['complemento']),
            "fecha_nac" => $datos['fecha_nac'],
            "edad" => $datos['edad'] ? $datos["edad"] : $this->calcularEdad($datos["fecha_nac"]),
            "cel" => $datos['cel'],
            "fecha_registro" => date("Y-m-d")
        ]);

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "CREACIÓN", "REGISTRO UN CLIENTE", $cliente);

        return $cliente;
    }

    /**
     * Actualizar cliente
     *
     * @param array $datos
     * @param Cliente $cliente
     * @return Cliente
     */
    public function actualizar(array $datos, Cliente $cliente): Cliente
    {
        $old_cliente = clone $cliente;

        $cliente->update([
            "nombre" => mb_strtoupper($datos['nombre']),
            "paterno" => mb_strtoupper($datos['paterno']),
            "materno" => mb_strtoupper($datos['materno']),
            "ci" => mb_strtoupper($datos['ci']),
            "ci_exp" => mb_strtoupper($datos['ci_exp']),
            "complemento" => mb_strtoupper($datos['complemento']),
            "edad" => $datos['edad'] ? $datos["edad"] : $this->calcularEdad($datos["fecha_nac"]),
            "cel" => $datos['cel'],
        ]);

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "MODIFICACIÓN", "ACTUALIZÓ UN CLIENTE", $old_cliente, $cliente->withoutRelations());

        return $cliente;
    }

    /**
     * Eliminar cliente
     *
     * @param Cliente $cliente
     * @return boolean
     */
    public function eliminar(Cliente $cliente): bool|Exception
    {
        $old_cliente = clone $cliente;
        $cliente->status = 0;
        $cliente->save();

        // registrar accion
        $this->historialAccionService->registrarAccion($this->modulo, "ELIMINACIÓN", "ELIMINÓ UN CLIENTE", $old_cliente, $cliente);

        return true;
    }

    public function calcularEdad($fechaNacimiento)
    {
        if (!$fechaNacimiento) return null;

        $fechaNac = new DateTime($fechaNacimiento);
        $hoy = new DateTime();

        $edad = $hoy->diff($fechaNac);

        return $edad->y; // años
    }
}
