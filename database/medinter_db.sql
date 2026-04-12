-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 12-04-2026 a las 19:16:41
-- Versión del servidor: 8.0.30
-- Versión de PHP: 8.2.22

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `medinter_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `certificados`
--

CREATE TABLE `certificados` (
  `id` bigint UNSIGNED NOT NULL,
  `cliente_id` bigint UNSIGNED NOT NULL,
  `total` decimal(24,2) NOT NULL,
  `cancelado` decimal(24,2) DEFAULT NULL,
  `saldo` decimal(24,2) DEFAULT NULL,
  `tipo_pago` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `sucursal_id` bigint UNSIGNED NOT NULL,
  `tipo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'NORMAL',
  `fecha_inicio` date DEFAULT NULL,
  `hora_inicio` time DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `hora_fin` time DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL,
  `hora_registro` time DEFAULT NULL,
  `verificado` int NOT NULL DEFAULT '0',
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `certificados`
--

INSERT INTO `certificados` (`id`, `cliente_id`, `total`, `cancelado`, `saldo`, `tipo_pago`, `user_id`, `sucursal_id`, `tipo`, `fecha_inicio`, `hora_inicio`, `fecha_fin`, `hora_fin`, `fecha_registro`, `hora_registro`, `verificado`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 110.00, 110.00, 0.00, 'EFECTIVO', 1, 1, 'NORMAL', NULL, NULL, NULL, NULL, '2026-04-11', '20:22:08', 0, 1, '2026-04-12 00:22:08', '2026-04-12 00:22:08');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `certificado_detalles`
--

CREATE TABLE `certificado_detalles` (
  `id` bigint UNSIGNED NOT NULL,
  `certificado_id` bigint UNSIGNED NOT NULL,
  `precio` decimal(24,2) NOT NULL,
  `cancelado` decimal(24,2) DEFAULT NULL,
  `saldo` decimal(24,2) DEFAULT NULL,
  `tipo_certificado_id` bigint UNSIGNED NOT NULL,
  `archivo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `certificado_detalles`
--

INSERT INTO `certificado_detalles` (`id`, `certificado_id`, `precio`, `cancelado`, `saldo`, `tipo_certificado_id`, `archivo`, `created_at`, `updated_at`) VALUES
(1, 1, 50.00, 50.00, 0.00, 1, '011775953329.pdf', '2026-04-12 00:22:08', '2026-04-12 00:22:09'),
(2, 1, 60.00, 60.00, 0.00, 3, '121775953329.pdf', '2026-04-12 00:22:09', '2026-04-12 00:22:09');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `certificado_emitidos`
--

CREATE TABLE `certificado_emitidos` (
  `id` bigint UNSIGNED NOT NULL,
  `fecha` date NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `tipo_certificado_id` bigint UNSIGNED NOT NULL,
  `conteo` int NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `certificado_emitidos`
--

INSERT INTO `certificado_emitidos` (`id`, `fecha`, `user_id`, `tipo_certificado_id`, `conteo`, `created_at`, `updated_at`) VALUES
(1, '2026-04-11', 1, 1, 1, '2026-04-11 23:13:47', '2026-04-12 00:22:08'),
(2, '2026-04-11', 1, 2, 0, '2026-04-11 23:13:48', '2026-04-12 00:20:58'),
(3, '2026-04-11', 1, 3, 1, '2026-04-11 23:14:53', '2026-04-12 00:22:09');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `paterno` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `materno` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ci` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ci_exp` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `complemento` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_nac` date DEFAULT NULL,
  `edad` int NOT NULL,
  `cel` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id`, `nombre`, `paterno`, `materno`, `ci`, `ci_exp`, `complemento`, `fecha_nac`, `edad`, `cel`, `fecha_registro`, `status`, `created_at`, `updated_at`) VALUES
(1, 'JUAN', 'PERES', 'MAMANI', '123456', 'LP', '', '2000-01-01', 26, '67676767', '2026-04-11', 1, '2026-04-11 20:24:24', '2026-04-11 20:24:24'),
(2, 'CARLOS', 'MARTINEZ', '', '123456', 'LP', 'CP', '1999-01-01', 27, NULL, '2026-04-12', 1, '2026-04-12 16:19:55', '2026-04-12 16:20:05'),
(3, 'MARIA', 'SOLIZ', '', '45454545', 'CB', '', '2003-01-01', 23, NULL, '2026-04-12', 1, '2026-04-12 16:20:24', '2026-04-12 16:20:24'),
(4, 'ERIC', 'GONZALES', 'APAZA', '56565656', 'LP', '', '2003-02-02', 23, NULL, '2026-04-12', 1, '2026-04-12 18:57:02', '2026-04-12 18:57:02'),
(5, 'ALEX', 'CONDORI', 'SOLIZ', '54454545', 'LP', '', '2005-02-02', 21, NULL, '2026-04-12', 1, '2026-04-12 18:57:02', '2026-04-12 18:57:02'),
(6, 'JUAN', 'CASTRO', 'GONZALES', '2342342', 'OR', '', '2000-01-01', 26, '67676767', '2026-04-12', 1, '2026-04-12 19:10:30', '2026-04-12 19:10:30'),
(7, 'ALVARO', 'CALCINA', 'CARVAJAL', '4534535', 'CB', '', '2006-02-02', 20, NULL, '2026-04-12', 1, '2026-04-12 19:11:36', '2026-04-12 19:11:36'),
(8, 'JUAN JOSE', 'CALLE', 'CALLE', '332232', 'LP', '', '2000-01-01', 26, NULL, '2026-04-12', 1, '2026-04-12 19:13:26', '2026-04-12 19:13:26'),
(9, 'ALEX', 'CASTRO', 'GONZALES', '34232332', 'LP', '', '2000-01-01', 26, NULL, '2026-04-12', 1, '2026-04-12 19:13:26', '2026-04-12 19:13:26'),
(10, 'SANDRA', 'CONDORI', 'CONDORI', '23723737', 'LP', '', '2000-02-02', 26, NULL, '2026-04-12', 1, '2026-04-12 19:14:44', '2026-04-12 19:14:44'),
(11, 'GROVER', 'CHOQUE', '', '2323232', 'LP', '', '1999-02-02', 27, NULL, '2026-04-12', 1, '2026-04-12 19:14:44', '2026-04-12 19:14:44'),
(12, 'FRANCISCA', 'MALDONADO', '', '34343434', 'LP', '', '2000-02-02', 26, NULL, '2026-04-12', 1, '2026-04-12 19:14:44', '2026-04-12 19:14:44'),
(13, 'JOSE', 'CALCINA', 'GONZALES', '2222332', 'CH', '', '1994-01-01', 32, NULL, '2026-04-12', 1, '2026-04-12 19:14:44', '2026-04-12 19:14:44');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracions`
--

CREATE TABLE `configuracions` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre_sistema` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `alias` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `razon_social` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nit` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dir` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fono` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `actividad` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `correo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `configuracions`
--

INSERT INTO `configuracions` (`id`, `nombre_sistema`, `alias`, `razon_social`, `nit`, `dir`, `fono`, `actividad`, `correo`, `logo`, `created_at`, `updated_at`) VALUES
(1, 'MEDINTER', 'MD', 'MEDINTER S.A.', '1111111111', 'LOS OLIVOS #111', '67676767', 'ACTIVIDAD', 'correo@gmail.com', 'logo.jpeg', '2026-02-16 22:21:27', '2026-04-07 00:26:24');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_accions`
--

CREATE TABLE `historial_accions` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `accion` varchar(155) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `datos_original` json DEFAULT NULL,
  `datos_nuevo` json DEFAULT NULL,
  `modulo` varchar(155) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `historial_accions`
--

INSERT INTO `historial_accions` (`id`, `user_id`, `accion`, `descripcion`, `datos_original`, `datos_nuevo`, `modulo`, `fecha`, `hora`, `created_at`, `updated_at`) VALUES
(1, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN TRAMITADOR', '{\"ci\": \"123456\", \"id\": 1, \"cel\": \"65756755\", \"ci_exp\": \"LP\", \"nombre\": \"EDUARDO GONZALES\", \"created_at\": \"2026-04-11T20:16:25.000000Z\", \"updated_at\": \"2026-04-11T20:16:25.000000Z\", \"fecha_registro\": \"2026-04-11\"}', NULL, 'TRAMITADORES', '2026-04-11', '16:16:25', '2026-04-11 20:16:25', '2026-04-11 20:16:25'),
(2, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": \"123456\", \"id\": 1, \"cel\": \"67676767\", \"edad\": \"26\", \"ci_exp\": \"LP\", \"nombre\": \"JUAN\", \"materno\": \"MAMANI\", \"paterno\": \"PERES\", \"fecha_nac\": \"2000-01-01\", \"created_at\": \"2026-04-11T20:24:24.000000Z\", \"updated_at\": \"2026-04-11T20:24:24.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-11\"}', NULL, 'CLIENTES', '2026-04-11', '16:24:24', '2026-04-11 20:24:24', '2026-04-11 20:24:24'),
(3, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN TRAMITADOR', '{\"ci\": \"123456\", \"id\": 1, \"cel\": \"65756755\", \"ci_exp\": \"LP\", \"nombre\": \"EDUARDO GONZALES\", \"created_at\": \"2026-04-11T20:16:25.000000Z\", \"updated_at\": \"2026-04-11T20:16:25.000000Z\", \"fecha_registro\": \"2026-04-11\"}', '{\"ci\": \"123456\", \"id\": 1, \"cel\": \"65756755\", \"ci_exp\": \"SC\", \"nombre\": \"EDUARDO GONZALES\", \"created_at\": \"2026-04-11T20:16:25.000000Z\", \"updated_at\": \"2026-04-11T20:25:57.000000Z\", \"fecha_registro\": \"2026-04-11\"}', 'TRAMITADORES', '2026-04-11', '16:25:57', '2026-04-11 20:25:57', '2026-04-11 20:25:57'),
(4, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN TRAMITADOR', '{\"ci\": \"32423423\", \"id\": 1, \"cel\": \"67676767\", \"ci_exp\": \"LP\", \"nombre\": \"EDUARDO GONZALES\", \"created_at\": \"2026-04-11T20:28:02.000000Z\", \"updated_at\": \"2026-04-11T20:28:02.000000Z\", \"fecha_registro\": \"2026-04-11\"}', NULL, 'TRAMITADORES', '2026-04-11', '16:28:02', '2026-04-11 20:28:02', '2026-04-11 20:28:02'),
(5, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CERTIFICADO', '{\"id\": 2, \"saldo\": 0, \"total\": \"140\", \"user_id\": 1, \"cancelado\": \"140\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"1\", \"created_at\": \"2026-04-12T00:10:38.000000Z\", \"updated_at\": \"2026-04-12T00:10:38.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"20:10:38\", \"fecha_registro\": \"2026-04-11\", \"certificado_detalles\": [{\"id\": 3, \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": \"031775952638.pdf\", \"cancelado\": \"50.00\", \"created_at\": \"2026-04-12T00:10:38.000000Z\", \"updated_at\": \"2026-04-12T00:10:38.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/031775952638.pdf\", \"certificado_id\": 2, \"muestra_conteo\": false, \"tipo_certificado_id\": 1}, {\"id\": 4, \"saldo\": \"0.00\", \"precio\": \"90.00\", \"archivo\": \"141775952638.pdf\", \"cancelado\": \"90.00\", \"created_at\": \"2026-04-12T00:10:38.000000Z\", \"updated_at\": \"2026-04-12T00:10:38.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/141775952638.pdf\", \"certificado_id\": 2, \"muestra_conteo\": false, \"tipo_certificado_id\": 2}]}', NULL, 'CERTIFICADOS', '2026-04-11', '20:10:38', '2026-04-12 00:10:38', '2026-04-12 00:10:38'),
(6, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN CERTIFICADO', '{\"id\": 2, \"tipo\": \"NORMAL\", \"saldo\": \"0.00\", \"total\": \"140.00\", \"status\": 1, \"user_id\": 1, \"hora_fin\": null, \"cancelado\": \"140.00\", \"fecha_fin\": null, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": 1, \"created_at\": \"2026-04-12T00:10:38.000000Z\", \"updated_at\": \"2026-04-12T00:10:38.000000Z\", \"verificado\": 0, \"hora_inicio\": null, \"sucursal_id\": 1, \"fecha_inicio\": null, \"hora_registro\": \"20:10:38\", \"fecha_registro\": \"2026-04-11\", \"certificado_detalles\": [{\"id\": 3, \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": \"031775952638.pdf\", \"cancelado\": \"50.00\", \"created_at\": \"2026-04-12T00:10:38.000000Z\", \"updated_at\": \"2026-04-12T00:17:22.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/031775952638.pdf\", \"certificado_id\": 2, \"muestra_conteo\": false, \"tipo_certificado_id\": 1}]}', '{\"id\": 2, \"tipo\": \"NORMAL\", \"saldo\": 0, \"total\": \"50\", \"status\": 1, \"user_id\": 1, \"hora_fin\": null, \"cancelado\": \"50\", \"fecha_fin\": null, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"1\", \"created_at\": \"2026-04-12T00:10:38.000000Z\", \"updated_at\": \"2026-04-12T00:17:22.000000Z\", \"verificado\": 0, \"hora_inicio\": null, \"sucursal_id\": \"1\", \"fecha_inicio\": null, \"hora_registro\": \"20:10:38\", \"fecha_registro\": \"2026-04-11\", \"certificado_detalles\": [{\"id\": 3, \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": \"031775952638.pdf\", \"cancelado\": \"50.00\", \"created_at\": \"2026-04-12T00:10:38.000000Z\", \"updated_at\": \"2026-04-12T00:17:22.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/031775952638.pdf\", \"certificado_id\": 2, \"muestra_conteo\": false, \"tipo_certificado_id\": 1}]}', 'CERTIFICADOS', '2026-04-11', '20:17:22', '2026-04-12 00:17:22', '2026-04-12 00:17:22'),
(7, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN CERTIFICADO', '{\"id\": 2, \"tipo\": \"NORMAL\", \"saldo\": \"0.00\", \"total\": \"50.00\", \"status\": 1, \"user_id\": 1, \"hora_fin\": null, \"cancelado\": \"50.00\", \"fecha_fin\": null, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": 1, \"created_at\": \"2026-04-12T00:10:38.000000Z\", \"updated_at\": \"2026-04-12T00:17:22.000000Z\", \"verificado\": 0, \"hora_inicio\": null, \"sucursal_id\": 1, \"fecha_inicio\": null, \"hora_registro\": \"20:10:38\", \"fecha_registro\": \"2026-04-11\", \"certificado_detalles\": [{\"id\": 3, \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": \"031775952638.pdf\", \"cancelado\": \"50.00\", \"created_at\": \"2026-04-12T00:10:38.000000Z\", \"updated_at\": \"2026-04-12T00:20:49.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/031775952638.pdf\", \"certificado_id\": 2, \"muestra_conteo\": false, \"tipo_certificado_id\": 1}, {\"id\": 5, \"saldo\": \"0.00\", \"precio\": \"90.00\", \"archivo\": \"151775953249.pdf\", \"cancelado\": null, \"created_at\": \"2026-04-12T00:20:49.000000Z\", \"updated_at\": \"2026-04-12T00:20:49.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/151775953249.pdf\", \"certificado_id\": 2, \"muestra_conteo\": false, \"tipo_certificado_id\": 2}]}', '{\"id\": 2, \"tipo\": \"NORMAL\", \"saldo\": 0, \"total\": \"140\", \"status\": 1, \"user_id\": 1, \"hora_fin\": null, \"cancelado\": \"140\", \"fecha_fin\": null, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"1\", \"created_at\": \"2026-04-12T00:10:38.000000Z\", \"updated_at\": \"2026-04-12T00:20:49.000000Z\", \"verificado\": 0, \"hora_inicio\": null, \"sucursal_id\": \"1\", \"fecha_inicio\": null, \"hora_registro\": \"20:10:38\", \"fecha_registro\": \"2026-04-11\", \"certificado_detalles\": [{\"id\": 3, \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": \"031775952638.pdf\", \"cancelado\": \"50.00\", \"created_at\": \"2026-04-12T00:10:38.000000Z\", \"updated_at\": \"2026-04-12T00:20:49.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/031775952638.pdf\", \"certificado_id\": 2, \"muestra_conteo\": false, \"tipo_certificado_id\": 1}, {\"id\": 5, \"saldo\": \"0.00\", \"precio\": \"90.00\", \"archivo\": \"151775953249.pdf\", \"cancelado\": null, \"created_at\": \"2026-04-12T00:20:49.000000Z\", \"updated_at\": \"2026-04-12T00:20:49.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/151775953249.pdf\", \"certificado_id\": 2, \"muestra_conteo\": false, \"tipo_certificado_id\": 2}]}', 'CERTIFICADOS', '2026-04-11', '20:20:49', '2026-04-12 00:20:49', '2026-04-12 00:20:49'),
(8, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN CERTIFICADO', '{\"id\": 2, \"tipo\": \"NORMAL\", \"saldo\": \"0.00\", \"total\": \"140.00\", \"status\": 1, \"user_id\": 1, \"hora_fin\": null, \"cancelado\": \"140.00\", \"fecha_fin\": null, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": 1, \"created_at\": \"2026-04-12T00:10:38.000000Z\", \"updated_at\": \"2026-04-12T00:20:49.000000Z\", \"verificado\": 0, \"hora_inicio\": null, \"sucursal_id\": 1, \"fecha_inicio\": null, \"hora_registro\": \"20:10:38\", \"fecha_registro\": \"2026-04-11\", \"certificado_detalles\": [{\"id\": 3, \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": \"031775952638.pdf\", \"cancelado\": \"50.00\", \"created_at\": \"2026-04-12T00:10:38.000000Z\", \"updated_at\": \"2026-04-12T00:20:58.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/031775952638.pdf\", \"certificado_id\": 2, \"muestra_conteo\": false, \"tipo_certificado_id\": 1}]}', '{\"id\": 2, \"tipo\": \"NORMAL\", \"saldo\": 0, \"total\": \"50\", \"status\": 1, \"user_id\": 1, \"hora_fin\": null, \"cancelado\": \"50\", \"fecha_fin\": null, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"1\", \"created_at\": \"2026-04-12T00:10:38.000000Z\", \"updated_at\": \"2026-04-12T00:20:58.000000Z\", \"verificado\": 0, \"hora_inicio\": null, \"sucursal_id\": \"1\", \"fecha_inicio\": null, \"hora_registro\": \"20:10:38\", \"fecha_registro\": \"2026-04-11\", \"certificado_detalles\": [{\"id\": 3, \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": \"031775952638.pdf\", \"cancelado\": \"50.00\", \"created_at\": \"2026-04-12T00:10:38.000000Z\", \"updated_at\": \"2026-04-12T00:20:58.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/031775952638.pdf\", \"certificado_id\": 2, \"muestra_conteo\": false, \"tipo_certificado_id\": 1}]}', 'CERTIFICADOS', '2026-04-11', '20:20:58', '2026-04-12 00:20:58', '2026-04-12 00:20:58'),
(9, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UN CERTIFICADO', '{\"id\": 2, \"tipo\": \"NORMAL\", \"saldo\": \"0.00\", \"total\": \"50.00\", \"status\": 1, \"user_id\": 1, \"hora_fin\": null, \"cancelado\": \"50.00\", \"fecha_fin\": null, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": 1, \"created_at\": \"2026-04-12T00:10:38.000000Z\", \"updated_at\": \"2026-04-12T00:20:58.000000Z\", \"verificado\": 0, \"hora_inicio\": null, \"sucursal_id\": 1, \"fecha_inicio\": null, \"hora_registro\": \"20:10:38\", \"fecha_registro\": \"2026-04-11\"}', '{\"id\": 2, \"tipo\": \"NORMAL\", \"saldo\": \"0.00\", \"total\": \"50.00\", \"status\": 0, \"user_id\": 1, \"hora_fin\": null, \"cancelado\": \"50.00\", \"fecha_fin\": null, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": 1, \"created_at\": \"2026-04-12T00:10:38.000000Z\", \"updated_at\": \"2026-04-12T00:21:30.000000Z\", \"verificado\": 0, \"hora_inicio\": null, \"sucursal_id\": 1, \"fecha_inicio\": null, \"hora_registro\": \"20:10:38\", \"fecha_registro\": \"2026-04-11\", \"certificado_detalles\": [{\"id\": 3, \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": \"031775952638.pdf\", \"cancelado\": \"50.00\", \"created_at\": \"2026-04-12T00:10:38.000000Z\", \"updated_at\": \"2026-04-12T00:20:58.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/031775952638.pdf\", \"certificado_id\": 2, \"muestra_conteo\": false, \"tipo_certificado_id\": 1}]}', 'CERTIFICADOS', '2026-04-11', '20:21:30', '2026-04-12 00:21:30', '2026-04-12 00:21:30'),
(10, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CERTIFICADO', '{\"id\": 1, \"saldo\": 0, \"total\": \"110\", \"user_id\": 1, \"cancelado\": \"110\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"1\", \"created_at\": \"2026-04-12T00:22:08.000000Z\", \"updated_at\": \"2026-04-12T00:22:08.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"20:22:08\", \"fecha_registro\": \"2026-04-11\", \"certificado_detalles\": [{\"id\": 1, \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": \"011775953329.pdf\", \"cancelado\": \"50.00\", \"created_at\": \"2026-04-12T00:22:08.000000Z\", \"updated_at\": \"2026-04-12T00:22:09.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/011775953329.pdf\", \"certificado_id\": 1, \"muestra_conteo\": false, \"tipo_certificado_id\": 1}, {\"id\": 2, \"saldo\": \"0.00\", \"precio\": \"60.00\", \"archivo\": \"121775953329.pdf\", \"cancelado\": \"60.00\", \"created_at\": \"2026-04-12T00:22:09.000000Z\", \"updated_at\": \"2026-04-12T00:22:09.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/121775953329.pdf\", \"certificado_id\": 1, \"muestra_conteo\": false, \"tipo_certificado_id\": 3}]}', NULL, 'CERTIFICADOS', '2026-04-11', '20:22:09', '2026-04-12 00:22:09', '2026-04-12 00:22:09'),
(11, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN TRAMITADOR', '{\"ci\": \"34343434\", \"id\": 2, \"cel\": \"67676767\", \"ci_exp\": \"LP\", \"nombre\": \"MARIA MAMANI\", \"created_at\": \"2026-04-12T15:58:07.000000Z\", \"updated_at\": \"2026-04-12T15:58:07.000000Z\", \"fecha_registro\": \"2026-04-12\"}', NULL, 'TRAMITADORES', '2026-04-12', '11:58:07', '2026-04-12 15:58:07', '2026-04-12 15:58:07'),
(12, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": \"123456\", \"id\": 2, \"cel\": null, \"edad\": \"27\", \"ci_exp\": \"LP\", \"nombre\": \"JUAN\", \"materno\": \"\", \"paterno\": \"MARTINEZ\", \"fecha_nac\": \"1999-01-01\", \"created_at\": \"2026-04-12T16:19:55.000000Z\", \"updated_at\": \"2026-04-12T16:19:55.000000Z\", \"complemento\": \"CP\", \"fecha_registro\": \"2026-04-12\"}', NULL, 'CLIENTES', '2026-04-12', '12:19:55', '2026-04-12 16:19:55', '2026-04-12 16:19:55'),
(13, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN CLIENTE', '{\"ci\": \"123456\", \"id\": 2, \"cel\": null, \"edad\": 27, \"ci_exp\": \"LP\", \"nombre\": \"JUAN\", \"status\": 1, \"materno\": \"\", \"paterno\": \"MARTINEZ\", \"fecha_nac\": \"1999-01-01\", \"created_at\": \"2026-04-12T16:19:55.000000Z\", \"updated_at\": \"2026-04-12T16:19:55.000000Z\", \"complemento\": \"CP\", \"fecha_registro\": \"2026-04-12\"}', '{\"ci\": \"123456\", \"id\": 2, \"cel\": null, \"edad\": \"27\", \"ci_exp\": \"LP\", \"nombre\": \"CARLOS\", \"status\": 1, \"materno\": \"\", \"paterno\": \"MARTINEZ\", \"fecha_nac\": \"1999-01-01\", \"created_at\": \"2026-04-12T16:19:55.000000Z\", \"updated_at\": \"2026-04-12T16:20:05.000000Z\", \"complemento\": \"CP\", \"fecha_registro\": \"2026-04-12\"}', 'CLIENTES', '2026-04-12', '12:20:05', '2026-04-12 16:20:05', '2026-04-12 16:20:05'),
(14, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": \"45454545\", \"id\": 3, \"cel\": null, \"edad\": \"23\", \"ci_exp\": \"CB\", \"nombre\": \"MARIA\", \"materno\": \"\", \"paterno\": \"SOLIZ\", \"fecha_nac\": \"2003-01-01\", \"created_at\": \"2026-04-12T16:20:24.000000Z\", \"updated_at\": \"2026-04-12T16:20:24.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-12\"}', NULL, 'CLIENTES', '2026-04-12', '12:20:24', '2026-04-12 16:20:24', '2026-04-12 16:20:24'),
(15, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": \"56565656\", \"id\": 4, \"cel\": null, \"edad\": 23, \"ci_exp\": \"LP\", \"nombre\": \"ERIC\", \"materno\": \"APAZA\", \"paterno\": \"GONZALES\", \"fecha_nac\": \"2003-02-02\", \"created_at\": \"2026-04-12T18:57:02.000000Z\", \"updated_at\": \"2026-04-12T18:57:02.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-12\"}', NULL, 'CLIENTES', '2026-04-12', '14:57:02', '2026-04-12 18:57:02', '2026-04-12 18:57:02'),
(16, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTEadmin REGISTRO UN CLIENTE', '{\"ci\": \"54454545\", \"id\": 5, \"cel\": null, \"edad\": 21, \"ci_exp\": \"LP\", \"nombre\": \"ALEX\", \"materno\": \"SOLIZ\", \"paterno\": \"CONDORI\", \"fecha_nac\": \"2005-02-02\", \"created_at\": \"2026-04-12T18:57:02.000000Z\", \"updated_at\": \"2026-04-12T18:57:02.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-12\"}', NULL, 'CLIENTES', '2026-04-12', '14:57:02', '2026-04-12 18:57:02', '2026-04-12 18:57:02'),
(17, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN TRAMITE', '{\"id\": 4, \"nro\": 1, \"hora\": \"14:57:02\", \"fecha\": \"2026-04-12\", \"codigo\": \"T1\", \"user_id\": 1, \"created_at\": \"2026-04-12T18:57:02.000000Z\", \"updated_at\": \"2026-04-12T18:57:02.000000Z\", \"sucursal_id\": \"1\", \"tramitador_id\": \"1\", \"tramite_clientes\": [{\"id\": 4, \"estado\": 0, \"existente\": 1, \"cliente_id\": 1, \"created_at\": \"2026-04-12T18:57:02.000000Z\", \"tramite_id\": 4, \"updated_at\": \"2026-04-12T18:57:02.000000Z\", \"certificado_id\": null}, {\"id\": 5, \"estado\": 0, \"existente\": 0, \"cliente_id\": 4, \"created_at\": \"2026-04-12T18:57:02.000000Z\", \"tramite_id\": 4, \"updated_at\": \"2026-04-12T18:57:02.000000Z\", \"certificado_id\": null}, {\"id\": 6, \"estado\": 0, \"existente\": 0, \"cliente_id\": 5, \"created_at\": \"2026-04-12T18:57:02.000000Z\", \"tramite_id\": 4, \"updated_at\": \"2026-04-12T18:57:02.000000Z\", \"certificado_id\": null}]}', NULL, 'TRAMITES', '2026-04-12', '14:57:02', '2026-04-12 18:57:02', '2026-04-12 18:57:02'),
(18, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": \"2342342\", \"id\": 6, \"cel\": \"67676767\", \"edad\": 26, \"ci_exp\": \"OR\", \"nombre\": \"JUAN\", \"materno\": \"GONZALES\", \"paterno\": \"CASTRO\", \"fecha_nac\": \"2000-01-01\", \"created_at\": \"2026-04-12T19:10:30.000000Z\", \"updated_at\": \"2026-04-12T19:10:30.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-12\"}', NULL, 'CLIENTES', '2026-04-12', '15:10:30', '2026-04-12 19:10:30', '2026-04-12 19:10:30'),
(19, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": \"4534535\", \"id\": 7, \"cel\": null, \"edad\": 20, \"ci_exp\": \"CB\", \"nombre\": \"ALVARO\", \"materno\": \"CARVAJAL\", \"paterno\": \"CALCINA\", \"fecha_nac\": \"2006-02-02\", \"created_at\": \"2026-04-12T19:11:36.000000Z\", \"updated_at\": \"2026-04-12T19:11:36.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-12\"}', NULL, 'CLIENTES', '2026-04-12', '15:11:36', '2026-04-12 19:11:36', '2026-04-12 19:11:36'),
(20, 1, 'ELIMINACIÓN', 'EL USUARIO admin ELIMINÓ UN TRAMITE', '{\"id\": 4, \"nro\": 1, \"hora\": \"14:57:02\", \"fecha\": \"2026-04-12\", \"codigo\": \"T1\", \"user_id\": 1, \"created_at\": \"2026-04-12T18:57:02.000000Z\", \"updated_at\": \"2026-04-12T18:57:02.000000Z\", \"sucursal_id\": 1, \"tramitador_id\": 1, \"tramite_clientes\": []}', '{\"id\": 4, \"nro\": 1, \"hora\": \"14:57:02\", \"fecha\": \"2026-04-12\", \"codigo\": \"T1\", \"user_id\": 1, \"created_at\": \"2026-04-12T18:57:02.000000Z\", \"updated_at\": \"2026-04-12T18:57:02.000000Z\", \"sucursal_id\": 1, \"tramitador_id\": 1, \"tramite_clientes\": [{\"id\": 4, \"estado\": 0, \"existente\": true, \"cliente_id\": 1, \"created_at\": \"2026-04-12T18:57:02.000000Z\", \"tramite_id\": 4, \"updated_at\": \"2026-04-12T18:57:02.000000Z\", \"certificado_id\": null}, {\"id\": 5, \"estado\": 0, \"existente\": false, \"cliente_id\": 4, \"created_at\": \"2026-04-12T18:57:02.000000Z\", \"tramite_id\": 4, \"updated_at\": \"2026-04-12T18:57:02.000000Z\", \"certificado_id\": null}, {\"id\": 7, \"estado\": 0, \"existente\": false, \"cliente_id\": 6, \"created_at\": \"2026-04-12T19:10:30.000000Z\", \"tramite_id\": 4, \"updated_at\": \"2026-04-12T19:10:30.000000Z\", \"certificado_id\": null}, {\"id\": 8, \"estado\": 0, \"existente\": false, \"cliente_id\": 7, \"created_at\": \"2026-04-12T19:11:36.000000Z\", \"tramite_id\": 4, \"updated_at\": \"2026-04-12T19:11:36.000000Z\", \"certificado_id\": null}]}', 'TRAMITES', '2026-04-12', '15:12:22', '2026-04-12 19:12:22', '2026-04-12 19:12:22'),
(21, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": \"332232\", \"id\": 8, \"cel\": null, \"edad\": 26, \"ci_exp\": \"LP\", \"nombre\": \"JUAN JOSE\", \"materno\": \"CALLE\", \"paterno\": \"CALLE\", \"fecha_nac\": \"2000-01-01\", \"created_at\": \"2026-04-12T19:13:26.000000Z\", \"updated_at\": \"2026-04-12T19:13:26.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-12\"}', NULL, 'CLIENTES', '2026-04-12', '15:13:26', '2026-04-12 19:13:26', '2026-04-12 19:13:26'),
(22, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTEadmin REGISTRO UN CLIENTE', '{\"ci\": \"34232332\", \"id\": 9, \"cel\": null, \"edad\": 26, \"ci_exp\": \"LP\", \"nombre\": \"ALEX\", \"materno\": \"GONZALES\", \"paterno\": \"CASTRO\", \"fecha_nac\": \"2000-01-01\", \"created_at\": \"2026-04-12T19:13:26.000000Z\", \"updated_at\": \"2026-04-12T19:13:26.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-12\"}', NULL, 'CLIENTES', '2026-04-12', '15:13:26', '2026-04-12 19:13:26', '2026-04-12 19:13:26'),
(23, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN TRAMITE', '{\"id\": 1, \"nro\": 1, \"hora\": \"15:13:26\", \"fecha\": \"2026-04-12\", \"codigo\": \"T1\", \"user_id\": 1, \"created_at\": \"2026-04-12T19:13:26.000000Z\", \"updated_at\": \"2026-04-12T19:13:26.000000Z\", \"sucursal_id\": \"1\", \"tramitador_id\": \"1\", \"tramite_clientes\": [{\"id\": 1, \"estado\": 0, \"existente\": true, \"cliente_id\": 3, \"created_at\": \"2026-04-12T19:13:26.000000Z\", \"tramite_id\": 1, \"updated_at\": \"2026-04-12T19:13:26.000000Z\", \"certificado_id\": null}, {\"id\": 2, \"estado\": 0, \"existente\": false, \"cliente_id\": 8, \"created_at\": \"2026-04-12T19:13:26.000000Z\", \"tramite_id\": 1, \"updated_at\": \"2026-04-12T19:13:26.000000Z\", \"certificado_id\": null}, {\"id\": 3, \"estado\": 0, \"existente\": false, \"cliente_id\": 9, \"created_at\": \"2026-04-12T19:13:26.000000Z\", \"tramite_id\": 1, \"updated_at\": \"2026-04-12T19:13:26.000000Z\", \"certificado_id\": null}]}', NULL, 'TRAMITES', '2026-04-12', '15:13:26', '2026-04-12 19:13:26', '2026-04-12 19:13:26'),
(24, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": \"23723737\", \"id\": 10, \"cel\": null, \"edad\": 26, \"ci_exp\": \"LP\", \"nombre\": \"SANDRA\", \"materno\": \"CONDORI\", \"paterno\": \"CONDORI\", \"fecha_nac\": \"2000-02-02\", \"created_at\": \"2026-04-12T19:14:44.000000Z\", \"updated_at\": \"2026-04-12T19:14:44.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-12\"}', NULL, 'CLIENTES', '2026-04-12', '15:14:44', '2026-04-12 19:14:44', '2026-04-12 19:14:44'),
(25, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTEadmin REGISTRO UN CLIENTE', '{\"ci\": \"2323232\", \"id\": 11, \"cel\": null, \"edad\": 27, \"ci_exp\": \"LP\", \"nombre\": \"GROVER\", \"materno\": \"\", \"paterno\": \"CHOQUE\", \"fecha_nac\": \"1999-02-02\", \"created_at\": \"2026-04-12T19:14:44.000000Z\", \"updated_at\": \"2026-04-12T19:14:44.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-12\"}', NULL, 'CLIENTES', '2026-04-12', '15:14:44', '2026-04-12 19:14:44', '2026-04-12 19:14:44'),
(26, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTEadmin REGISTRO UN CLIENTEadmin REGISTRO UN CLIENTE', '{\"ci\": \"34343434\", \"id\": 12, \"cel\": null, \"edad\": 26, \"ci_exp\": \"LP\", \"nombre\": \"FRANCISCA\", \"materno\": \"\", \"paterno\": \"MALDONADO\", \"fecha_nac\": \"2000-02-02\", \"created_at\": \"2026-04-12T19:14:44.000000Z\", \"updated_at\": \"2026-04-12T19:14:44.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-12\"}', NULL, 'CLIENTES', '2026-04-12', '15:14:44', '2026-04-12 19:14:44', '2026-04-12 19:14:44'),
(27, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTEadmin REGISTRO UN CLIENTEadmin REGISTRO UN CLIENTEadmin REGISTRO UN CLIENTE', '{\"ci\": \"2222332\", \"id\": 13, \"cel\": null, \"edad\": 32, \"ci_exp\": \"CH\", \"nombre\": \"JOSE\", \"materno\": \"GONZALES\", \"paterno\": \"CALCINA\", \"fecha_nac\": \"1994-01-01\", \"created_at\": \"2026-04-12T19:14:44.000000Z\", \"updated_at\": \"2026-04-12T19:14:44.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-12\"}', NULL, 'CLIENTES', '2026-04-12', '15:14:44', '2026-04-12 19:14:44', '2026-04-12 19:14:44'),
(28, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN TRAMITE', '{\"id\": 2, \"nro\": 2, \"hora\": \"15:14:44\", \"fecha\": \"2026-04-12\", \"codigo\": \"T2\", \"user_id\": 1, \"created_at\": \"2026-04-12T19:14:44.000000Z\", \"updated_at\": \"2026-04-12T19:14:44.000000Z\", \"sucursal_id\": \"1\", \"tramitador_id\": \"2\", \"tramite_clientes\": [{\"id\": 4, \"estado\": 0, \"existente\": false, \"cliente_id\": 10, \"created_at\": \"2026-04-12T19:14:44.000000Z\", \"tramite_id\": 2, \"updated_at\": \"2026-04-12T19:14:44.000000Z\", \"certificado_id\": null}, {\"id\": 5, \"estado\": 0, \"existente\": false, \"cliente_id\": 11, \"created_at\": \"2026-04-12T19:14:44.000000Z\", \"tramite_id\": 2, \"updated_at\": \"2026-04-12T19:14:44.000000Z\", \"certificado_id\": null}, {\"id\": 6, \"estado\": 0, \"existente\": false, \"cliente_id\": 12, \"created_at\": \"2026-04-12T19:14:44.000000Z\", \"tramite_id\": 2, \"updated_at\": \"2026-04-12T19:14:44.000000Z\", \"certificado_id\": null}, {\"id\": 7, \"estado\": 0, \"existente\": false, \"cliente_id\": 13, \"created_at\": \"2026-04-12T19:14:44.000000Z\", \"tramite_id\": 2, \"updated_at\": \"2026-04-12T19:14:44.000000Z\", \"certificado_id\": null}]}', NULL, 'TRAMITES', '2026-04-12', '15:14:44', '2026-04-12 19:14:44', '2026-04-12 19:14:44');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `login_users`
--

CREATE TABLE `login_users` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `sucursal_id` bigint UNSIGNED NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `migrations`
--

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(1, '2024_01_31_165641_create_configuracions_table', 1),
(2, '2024_11_02_153317_create_users_table', 1),
(3, '2024_11_02_153318_create_historial_accions_table', 1),
(4, '2024_1_02_153316_create_sucursals_table', 2),
(5, '2026_04_02_203435_create_clientes_table', 2),
(6, '2026_04_02_203441_create_tipo_certificados_table', 2),
(7, '2026_04_02_203448_create_certificados_table', 2),
(8, '2026_04_02_203452_create_certificado_emitidos_table', 2),
(9, '2026_04_03_195001_create_login_users_table', 3),
(10, '2026_04_11_192234_create_tramitadors_table', 4),
(11, '2026_04_11_192238_create_tramites_table', 4),
(13, '2026_04_11_195116_create_certificado_detalles_table', 5),
(14, '2026_04_12_111900_create_tramite_clientes_table', 6);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sucursals`
--

CREATE TABLE `sucursals` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(900) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `sucursals`
--

INSERT INTO `sucursals` (`id`, `nombre`, `descripcion`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 'SUCURSAL 1', 'SUCURSAL 1', '2026-04-03', '2026-04-03 23:28:07', '2026-04-03 23:28:07'),
(2, 'SUCURSAL 2', '', '2026-04-03', '2026-04-03 23:28:14', '2026-04-03 23:28:14');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_certificados`
--

CREATE TABLE `tipo_certificados` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `precio` decimal(24,2) NOT NULL,
  `descripcion` varchar(1200) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tipo_certificados`
--

INSERT INTO `tipo_certificados` (`id`, `nombre`, `precio`, `descripcion`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 'CERTIFICADO MÉDICO', 50.00, 'DESC TIPO 1', '2026-04-03', '2026-04-03 23:45:20', '2026-04-08 04:03:55'),
(2, 'CERTIFICADO PSICOLOGICO MENOR', 90.00, '', '2026-04-03', '2026-04-03 23:47:30', '2026-04-08 04:04:10'),
(3, 'CERTIFICADO PSICOLOGICO MAYOR', 60.00, '', '2026-04-03', '2026-04-03 23:47:44', '2026-04-08 04:04:17');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tramitadors`
--

CREATE TABLE `tramitadors` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ci` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ci_exp` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cel` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_registro` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tramitadors`
--

INSERT INTO `tramitadors` (`id`, `nombre`, `ci`, `ci_exp`, `cel`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 'EDUARDO GONZALES', '32423423', 'LP', '67676767', '2026-04-11', '2026-04-11 20:28:02', '2026-04-11 20:28:02'),
(2, 'MARIA MAMANI', '34343434', 'LP', '67676767', '2026-04-12', '2026-04-12 15:58:07', '2026-04-12 15:58:07');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tramites`
--

CREATE TABLE `tramites` (
  `id` bigint UNSIGNED NOT NULL,
  `nro` bigint NOT NULL,
  `codigo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tramitador_id` bigint UNSIGNED NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `sucursal_id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tramites`
--

INSERT INTO `tramites` (`id`, `nro`, `codigo`, `tramitador_id`, `fecha`, `hora`, `sucursal_id`, `user_id`, `created_at`, `updated_at`) VALUES
(1, 1, 'T1', 1, '2026-04-12', '15:13:26', 1, 1, '2026-04-12 19:13:26', '2026-04-12 19:13:26'),
(2, 2, 'T2', 2, '2026-04-12', '15:14:44', 1, 1, '2026-04-12 19:14:44', '2026-04-12 19:14:44');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tramite_clientes`
--

CREATE TABLE `tramite_clientes` (
  `id` bigint UNSIGNED NOT NULL,
  `tramite_id` bigint UNSIGNED NOT NULL,
  `cliente_id` bigint UNSIGNED NOT NULL,
  `certificado_id` bigint UNSIGNED DEFAULT NULL,
  `estado` int NOT NULL DEFAULT '0',
  `existente` tinyint(1) NOT NULL DEFAULT '0',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tramite_clientes`
--

INSERT INTO `tramite_clientes` (`id`, `tramite_id`, `cliente_id`, `certificado_id`, `estado`, `existente`, `created_at`, `updated_at`) VALUES
(1, 1, 3, NULL, 0, 1, '2026-04-12 19:13:26', '2026-04-12 19:13:26'),
(2, 1, 8, NULL, 0, 0, '2026-04-12 19:13:26', '2026-04-12 19:13:26'),
(3, 1, 9, NULL, 0, 0, '2026-04-12 19:13:26', '2026-04-12 19:13:26'),
(4, 2, 10, NULL, 0, 0, '2026-04-12 19:14:44', '2026-04-12 19:14:44'),
(5, 2, 11, NULL, 0, 0, '2026-04-12 19:14:44', '2026-04-12 19:14:44'),
(6, 2, 12, NULL, 0, 0, '2026-04-12 19:14:44', '2026-04-12 19:14:44'),
(7, 2, 13, NULL, 0, 0, '2026-04-12 19:14:44', '2026-04-12 19:14:44');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `usuario` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `paterno` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `materno` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ci` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ci_exp` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `dir` varchar(600) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `correo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fono` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `acceso` int NOT NULL,
  `tipo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `foto` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sucursal_id` bigint DEFAULT NULL,
  `fecha_registro` date NOT NULL,
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `usuario`, `nombre`, `paterno`, `materno`, `ci`, `ci_exp`, `dir`, `correo`, `fono`, `password`, `acceso`, `tipo`, `foto`, `sucursal_id`, `fecha_registro`, `status`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'admin', 'admin', '', '0', '', '', '', '', '$2y$12$65d4fgZsvBV5Lc/AxNKh4eoUdbGyaczQ4sSco20feSQANshNLuxSC', 1, 'ADMINISTRADOR', NULL, 1, '2025-10-01', 1, '2026-02-17 22:21:27', '2026-02-17 22:21:27'),
(2, 'JPERES', 'JUAN', 'PERES', 'MAMANI', '123456', 'LP', 'LOS PEDREGALES', 'juan@gmail.com', '67676767', '$2y$12$NAk3MUCLFIo9isfVaA/Cbe5K8IYui6VwjyVSCkQtxegaMM3/Q4R3y', 1, 'MÉDICO', '21775258381.jpg', 2, '2026-04-03', 1, '2026-04-04 03:19:41', '2026-04-11 23:35:55'),
(3, 'MGONZALES', 'MARIA', 'GONZALES', '', '1234567', 'LP', '', NULL, '6767676', '$2y$12$okLv9H49WTpjRipKuglJO.iS4QPMl62lvwhtbJGG/EtQ5aJaLJ3bi', 1, 'SECRETARIA', '31775258613.jpg', 1, '2026-04-03', 1, '2026-04-04 03:23:20', '2026-04-11 23:35:46'),
(4, 'GMARTINEZ', 'GEOVANA', 'MARTINEZ', 'MARTINEZ', '32234234', 'CB', '', NULL, '67676767', '$2y$12$hqaROKdsJFiFWcbuTXm7tugbl1s3LR6Rt3hA4JZ2JTdr/dJGIa0Ou', 1, 'MÉDICO', '41775258996.jpg', 2, '2026-04-03', 1, '2026-04-04 03:29:56', '2026-04-11 23:35:41'),
(5, 'SMARTINEZ', 'SANDRA', 'MARTINEZ', '', '56445645', 'LP', '', NULL, '67676767', '$2y$12$BOrmYu5SAJSSdxrpToSux.PR4DRFWiN6YMFsvBUDmyJBUTO52cFQi', 1, 'GERENTE', NULL, 1, '2026-04-07', 1, '2026-04-07 17:27:08', '2026-04-11 23:34:50');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `certificados`
--
ALTER TABLE `certificados`
  ADD PRIMARY KEY (`id`),
  ADD KEY `certificados_cliente_id_foreign` (`cliente_id`),
  ADD KEY `certificados_user_id_foreign` (`user_id`),
  ADD KEY `certificados_sucursal_id_foreign` (`sucursal_id`);

--
-- Indices de la tabla `certificado_detalles`
--
ALTER TABLE `certificado_detalles`
  ADD PRIMARY KEY (`id`),
  ADD KEY `certificado_detalles_certificado_id_foreign` (`certificado_id`),
  ADD KEY `certificado_detalles_tipo_certificado_id_foreign` (`tipo_certificado_id`);

--
-- Indices de la tabla `certificado_emitidos`
--
ALTER TABLE `certificado_emitidos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `certificado_emitidos_user_id_foreign` (`user_id`),
  ADD KEY `certificado_emitidos_tipo_certificado_id_foreign` (`tipo_certificado_id`);

--
-- Indices de la tabla `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `configuracions`
--
ALTER TABLE `configuracions`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `historial_accions`
--
ALTER TABLE `historial_accions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `historial_accions_user_id_foreign` (`user_id`);

--
-- Indices de la tabla `login_users`
--
ALTER TABLE `login_users`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `sucursals`
--
ALTER TABLE `sucursals`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `sucursals_nombre_unique` (`nombre`);

--
-- Indices de la tabla `tipo_certificados`
--
ALTER TABLE `tipo_certificados`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tramitadors`
--
ALTER TABLE `tramitadors`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `tramites`
--
ALTER TABLE `tramites`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `tramites_codigo_unique` (`codigo`),
  ADD KEY `tramites_tramitador_id_foreign` (`tramitador_id`),
  ADD KEY `fk_user_id` (`user_id`),
  ADD KEY `fk_sucursal_id` (`sucursal_id`);

--
-- Indices de la tabla `tramite_clientes`
--
ALTER TABLE `tramite_clientes`
  ADD PRIMARY KEY (`id`),
  ADD KEY `tramite_clientes_tramite_id_foreign` (`tramite_id`),
  ADD KEY `tramite_clientes_cliente_id_foreign` (`cliente_id`),
  ADD KEY `tramite_clientes_certificado_id_foreign` (`certificado_id`);

--
-- Indices de la tabla `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `certificados`
--
ALTER TABLE `certificados`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `certificado_detalles`
--
ALTER TABLE `certificado_detalles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `certificado_emitidos`
--
ALTER TABLE `certificado_emitidos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `configuracions`
--
ALTER TABLE `configuracions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `historial_accions`
--
ALTER TABLE `historial_accions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT de la tabla `login_users`
--
ALTER TABLE `login_users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT de la tabla `sucursals`
--
ALTER TABLE `sucursals`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tipo_certificados`
--
ALTER TABLE `tipo_certificados`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `tramitadors`
--
ALTER TABLE `tramitadors`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tramites`
--
ALTER TABLE `tramites`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `tramite_clientes`
--
ALTER TABLE `tramite_clientes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `certificados`
--
ALTER TABLE `certificados`
  ADD CONSTRAINT `certificados_cliente_id_foreign` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`),
  ADD CONSTRAINT `certificados_sucursal_id_foreign` FOREIGN KEY (`sucursal_id`) REFERENCES `sucursals` (`id`),
  ADD CONSTRAINT `certificados_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `certificado_detalles`
--
ALTER TABLE `certificado_detalles`
  ADD CONSTRAINT `certificado_detalles_certificado_id_foreign` FOREIGN KEY (`certificado_id`) REFERENCES `certificados` (`id`),
  ADD CONSTRAINT `certificado_detalles_tipo_certificado_id_foreign` FOREIGN KEY (`tipo_certificado_id`) REFERENCES `tipo_certificados` (`id`);

--
-- Filtros para la tabla `certificado_emitidos`
--
ALTER TABLE `certificado_emitidos`
  ADD CONSTRAINT `certificado_emitidos_tipo_certificado_id_foreign` FOREIGN KEY (`tipo_certificado_id`) REFERENCES `tipo_certificados` (`id`),
  ADD CONSTRAINT `certificado_emitidos_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `historial_accions`
--
ALTER TABLE `historial_accions`
  ADD CONSTRAINT `historial_accions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Filtros para la tabla `tramites`
--
ALTER TABLE `tramites`
  ADD CONSTRAINT `fk_sucursal_id` FOREIGN KEY (`sucursal_id`) REFERENCES `sucursals` (`id`),
  ADD CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `tramites_tramitador_id_foreign` FOREIGN KEY (`tramitador_id`) REFERENCES `tramitadors` (`id`);

--
-- Filtros para la tabla `tramite_clientes`
--
ALTER TABLE `tramite_clientes`
  ADD CONSTRAINT `tramite_clientes_certificado_id_foreign` FOREIGN KEY (`certificado_id`) REFERENCES `certificados` (`id`),
  ADD CONSTRAINT `tramite_clientes_cliente_id_foreign` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`),
  ADD CONSTRAINT `tramite_clientes_tramite_id_foreign` FOREIGN KEY (`tramite_id`) REFERENCES `tramites` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
