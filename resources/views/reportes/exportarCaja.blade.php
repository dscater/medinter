<!DOCTYPE html>
<html lang="es">

<head>
    <meta charset="UTF-8">
    <title>Caja</title>
    <style type="text/css">
        * {
            font-family: sans-serif;
        }

        @page {
            margin-top: 1cm;
            margin-bottom: 1cm;
            margin-left: 1.5cm;
            margin-right: 1cm;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            table-layout: fixed;
            page-break-before: avoid;
        }

        table thead tr th,
        tbody tr td {
            padding: 3px;
            word-wrap: break-word;
        }

        table thead tr th {
            font-size: 9pt;
        }

        table tbody tr td {
            font-size: 8pt;
        }


        .encabezado {
            width: 100%;
        }

        .logo img {
            position: absolute;
            height: 90px;
            top: -20px;
            left: 0px;
        }

        h2.titulo {
            width: 450px;
            margin: auto;
            margin-top: 0PX;
            text-align: center;
            font-size: 14pt;
        }

        .texto {
            width: 250px;
            text-align: center;
            margin: auto;
            font-weight: bold;
            font-size: 1.1em;
        }

        .fecha {
            width: 250px;
            text-align: center;
            margin: auto;
            font-weight: normal;
            font-size: 0.85em;
        }

        .total {
            text-align: right;
            padding-right: 15px;
            font-weight: bold;
        }

        table {
            width: 100%;
        }

        table thead {
            background: rgb(236, 236, 236)
        }

        tr {
            page-break-inside: avoid !important;
        }

        .centreado {
            padding-left: 0px;
            text-align: center;
        }

        .datos {
            margin-left: 15px;
            border-top: solid 1px;
            border-collapse: collapse;
            width: 250px;
        }

        .txt {
            font-weight: bold;
            text-align: right;
            padding-right: 5px;
        }

        .txt_center {
            font-weight: bold;
            text-align: center;
        }

        .b_top {
            border-top: solid 1px black;
        }

        .gray {
            background: rgb(202, 202, 202);
        }

        .bg-principal {
            background: #153f59;
            color: white;
        }

        .img_celda img {
            width: 45px;
        }

        .text-right {
            text-align: right;
        }

        .bold {
            font-weight: bold;
        }

        .text-md {
            font-size: 10pt;
        }

        .text-lg {
            font-size: 12pt;
        }

        .derecha {
            text-align: right;
        }

        .fecha_caja {
            margin-top: 20px;
            font-size: 10pt;
            text-align: left;
            margin-bottom: 2px;
        }
    </style>
</head>

<body>
    @inject('configuracion', 'App\Models\Configuracion')
    <div class="encabezado">
        <div class="logo">
            <img src="{{ $configuracion->first()->logo_b64 }}">
        </div>
        <h2 class="titulo">
            {{ $configuracion->first()->razon_social }}
        </h2>
        <h4 class="texto">ARQUEO DE CAJA</h4>
        <h4 class="fecha">Expedido: {{ date('d/m/Y') }}</h4>
    </div>

    <div class="fecha_caja centreado">
        Del {{ date('d/m/Y', strtotime($fecha_ini)) }} al {{ date('d/m/Y', strtotime($fecha_fin)) }}
    </div>
    <table border="1">
        <thead class="bg-principal">
            <tr>
                <th width="5%">N°</th>
                <th width="12%">FECHA</th>
                <th width="14%">SUCURSAL</th>
                <th>PACIENTE</th>
                <th>DESCRIPCIÓN</th>
                <th>MÉDICO</th>
                @foreach ($tipo_pagos as $item)
                    <th>
                        {{ $item['value'] }} Bs.
                    </th>
                @endforeach
            </tr>
        </thead>
        <tbody>
            @php
                $cont = 1;
            @endphp
            @foreach ($pagos as $item)
                <tr>
                    <td class="centreado">{{ $cont++ }}</td>
                    <td class="">{{ $item->fecha_verificado_t }} <br />{{ $item->hora_verificado }}</td>
                    <td class="">{{ $item->sucursal->nombre }}</td>
                    <td class="">{{ $item->cliente->nombre }} {{ $item->cliente->paterno }}
                        {{ $item->cliente->materno }} <br />{{ $item->cliente->ci }}
                        {{ $item->cliente->complemento ? ' - ' . $item->cliente->complemento : '' }}
                        {{ $item->cliente->ci_exp }}
                    </td>
                    <td>
                        {{ $item->certificado_detalle->tipo_certificado->nombre }}
                        <br />
                        <small>({{ $item->certificado_detalle->certificado->tipo }}
                            @if ($item->certificado_detalle->certificado->tramitador)
                                - {{ $item->certificado_detalle->certificado->tramitador->nombre }}

                                <span></span>
                            @endif
                            )
                        </small>
                    </td>
                    <td>
                        @if ($item->medico)
                            {{ $item->medico->nombre }}
                            {{ $item->medico->paterno }}{{ $item->medico->materno }}
                        @endif
                    </td>
                    @foreach ($tipo_pagos as $tipo_pago)
                        @if ($item->tipo_pago == $tipo_pago['value'])
                            <td class="derecha">{{ $item->monto }}</td>
                        @else
                            <td class=""></td>
                        @endif
                    @endforeach
                </tr>
            @endforeach
            @php
                $suma_total = 0;
            @endphp
            <tr>
                <td class="text-md text-right bold bg-principal" colspan="6">
                    TOTAL BS.
                </td>
                @foreach ($tipo_pagos as $tipo_pago)
                    @php
                        $suma_total += (float) $suma_tipos[$tipo_pago['value']];
                    @endphp
                    <td class="text-md text-right bold bg-principal">
                        {{ number_format($suma_tipos[$tipo_pago['value']], 2, '.', '') }}
                    </td>
                @endforeach

            </tr>
            <tr>
                <td class="text-md text-right bold bg-principal" colspan="6">
                    TOTAL FINAL BS.
                </td>
                <td class="text-lg text-right bold bg-principal" colspan="2">
                    {{ number_format($suma_total, 2, '.', '') }}
                </td>

            </tr>
        </tbody>
    </table>
</body>

</html>
