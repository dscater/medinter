-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 27-04-2026 a las 00:40:27
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
  `tipo_pago` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `inicio_id` bigint UNSIGNED NOT NULL,
  `sucursal_id` bigint UNSIGNED NOT NULL,
  `tipo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'NORMAL',
  `tramitador_id` bigint UNSIGNED DEFAULT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `hora_inicio` time DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `hora_fin` time DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL,
  `hora_registro` time DEFAULT NULL,
  `estado` int NOT NULL DEFAULT '0',
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `certificados`
--

INSERT INTO `certificados` (`id`, `cliente_id`, `total`, `cancelado`, `saldo`, `tipo_pago`, `user_id`, `inicio_id`, `sucursal_id`, `tipo`, `tramitador_id`, `fecha_inicio`, `hora_inicio`, `fecha_fin`, `hora_fin`, `fecha_registro`, `hora_registro`, `estado`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 50.00, 50.00, 0.00, 'EFECTIVO', 8, 5, 1, 'NORMAL', NULL, '2026-04-25', '16:32:48', '2026-04-25', '16:33:33', '2026-04-25', '16:32:28', 1, 1, '2026-04-25 20:32:28', '2026-04-25 21:24:46'),
(2, 2, 39.90, 39.90, 0.00, 'EFECTIVO', 8, 8, 1, 'NORMAL', NULL, '2026-04-25', '16:46:05', '2026-04-25', '16:46:11', '2026-04-25', '16:46:05', 1, 1, '2026-04-25 20:46:05', '2026-04-25 21:24:46'),
(3, 4, 50.00, 50.00, 0.00, 'EFECTIVO', NULL, 5, 1, 'NORMAL', NULL, NULL, NULL, NULL, NULL, '2026-04-25', '17:09:51', 0, 1, '2026-04-25 21:09:51', '2026-04-25 21:24:46'),
(4, 5, 50.00, 50.00, 0.00, 'QR', NULL, 8, 1, 'NORMAL', NULL, NULL, NULL, NULL, NULL, '2026-04-25', '17:10:14', 0, 1, '2026-04-25 21:10:14', '2026-04-27 00:39:32'),
(7, 8, 30.00, 30.00, 0.00, 'EFECTIVO', 8, 8, 1, 'TRAMITE', 1, '2026-04-25', '19:00:22', '2026-04-25', '19:00:37', '2026-04-25', '19:00:22', 1, 1, '2026-04-25 23:00:22', '2026-04-25 23:00:37'),
(8, 9, 50.00, 50.00, 0.00, 'EFECTIVO', 8, 8, 1, 'NORMAL', NULL, '2026-04-25', '19:02:28', '2026-04-25', '19:02:48', '2026-04-25', '19:02:48', 1, 1, '2026-04-25 23:02:48', '2026-04-25 23:02:48'),
(9, 10, 50.00, 50.00, 0.00, 'QR', 8, 8, 1, 'NORMAL', NULL, '2026-04-25', '19:03:28', '2026-04-25', '19:03:43', '2026-04-25', '19:03:28', 1, 1, '2026-04-25 23:03:28', '2026-04-25 23:03:43'),
(10, 11, 50.00, 50.00, 0.00, 'EFECTIVO', 8, 8, 1, 'NORMAL', NULL, '2026-04-25', '19:11:50', '2026-04-25', '19:12:02', '2026-04-25', '19:11:49', 1, 1, '2026-04-25 23:11:49', '2026-04-27 00:39:19'),
(11, 12, 50.00, 0.00, 50.00, 'EFECTIVO', NULL, 7, 2, 'NORMAL', NULL, NULL, NULL, NULL, NULL, '2026-04-26', '19:30:58', 0, 1, '2026-04-26 23:30:58', '2026-04-26 23:30:58'),
(12, 17, 35.00, 35.00, 0.00, 'EFECTIVO', 8, 8, 1, 'TRAMITE', 1, '2026-04-26', '20:14:02', '2026-04-26', '20:15:38', '2026-04-26', '20:14:02', 1, 1, '2026-04-27 00:14:02', '2026-04-27 00:15:38'),
(13, 18, 40.00, 40.00, 0.00, 'EFECTIVO', NULL, 6, 1, 'NORMAL', NULL, NULL, NULL, NULL, NULL, '2026-04-26', '20:16:01', 0, 1, '2026-04-27 00:16:01', '2026-04-27 00:16:01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `certificado_detalles`
--

CREATE TABLE `certificado_detalles` (
  `id` bigint UNSIGNED NOT NULL,
  `certificado_id` bigint UNSIGNED NOT NULL,
  `categoria` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
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

INSERT INTO `certificado_detalles` (`id`, `certificado_id`, `categoria`, `precio`, `cancelado`, `saldo`, `tipo_certificado_id`, `archivo`, `created_at`, `updated_at`) VALUES
(1, 1, 'A', 50.00, 50.00, 0.00, 1, '011777149213.docx', '2026-04-25 20:32:28', '2026-04-25 20:35:55'),
(2, 2, 'A', 39.90, 39.90, 0.00, 1, '021777149971.pdf', '2026-04-25 20:46:05', '2026-04-25 21:01:21'),
(3, 3, '', 50.00, 50.00, 0.00, 1, NULL, '2026-04-25 21:09:51', '2026-04-25 21:09:51'),
(4, 4, '', 50.00, 50.00, 0.00, 1, NULL, '2026-04-25 21:10:14', '2026-04-27 00:39:32'),
(5, 7, 'A', 30.00, 30.00, 0.00, 1, '051777158037.docx', '2026-04-25 23:00:22', '2026-04-25 23:00:37'),
(6, 8, 'p', 50.00, 50.00, 0.00, 1, '061777158168.docx', '2026-04-25 23:02:48', '2026-04-25 23:02:48'),
(7, 9, 'p', 50.00, 50.00, 0.00, 1, '071777158223.docx', '2026-04-25 23:03:28', '2026-04-25 23:12:11'),
(8, 10, 'P', 50.00, 50.00, 0.00, 1, '081777158722.docx', '2026-04-25 23:11:49', '2026-04-27 00:39:19'),
(9, 11, '', 50.00, 0.00, 50.00, 1, NULL, '2026-04-26 23:30:58', '2026-04-26 23:30:58'),
(10, 12, 'p', 35.00, 35.00, 0.00, 1, '0101777248938.docx', '2026-04-27 00:14:02', '2026-04-27 00:15:38'),
(11, 13, '', 40.00, 40.00, 0.00, 1, NULL, '2026-04-27 00:16:01', '2026-04-27 00:16:01');

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
(1, '2026-04-25', 8, 1, 9, '2026-04-25 20:12:43', '2026-04-25 23:12:02'),
(2, '2026-04-26', 8, 1, 1, '2026-04-27 00:15:38', '2026-04-27 00:15:38');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `clientes`
--

CREATE TABLE `clientes` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `paterno` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `materno` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ci` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ci_exp` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `complemento` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_nac` date DEFAULT NULL,
  `edad` int NOT NULL,
  `cel` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id`, `nombre`, `paterno`, `materno`, `ci`, `ci_exp`, `complemento`, `fecha_nac`, `edad`, `cel`, `fecha_registro`, `status`, `created_at`, `updated_at`) VALUES
(1, 'FRANCO', 'OLIVARES', '', '34234234', 'LP', '', '1999-01-01', 27, NULL, '2026-04-25', 1, '2026-04-25 20:32:28', '2026-04-25 20:32:28'),
(2, 'ALVARO', 'GONZALES', '', '1312321', 'CB', '', '2000-01-01', 26, NULL, '2026-04-25', 1, '2026-04-25 20:46:05', '2026-04-25 20:46:05'),
(4, 'ELVIRA', 'GONZALES', '', '1231313123', 'LP', '', '1999-01-01', 27, NULL, '2026-04-25', 1, '2026-04-25 21:09:51', '2026-04-25 21:09:51'),
(5, 'OLIVER', 'CARVAJAL', '', '3242424234', 'LP', '', '2000-02-02', 26, NULL, '2026-04-25', 1, '2026-04-25 21:10:14', '2026-04-25 21:10:14'),
(8, 'ALVARO', 'MARTINEZ', '', '2242343', 'CB', '', '2000-01-01', 26, NULL, '2026-04-25', 1, '2026-04-25 23:00:22', '2026-04-25 23:00:22'),
(9, 'OLIVIA', 'MARTINEZ', '', '435345345', 'LP', '', '2000-02-02', 26, NULL, '2026-04-25', 1, '2026-04-25 23:01:21', '2026-04-25 23:01:21'),
(10, 'EFRAIN', 'CONDORI', '', '456456456', 'CB', '', '1999-03-03', 27, NULL, '2026-04-25', 1, '2026-04-25 23:03:28', '2026-04-25 23:03:28'),
(11, 'CARLOS', 'SANZ', '', '435345322', 'CB', '', '2000-03-03', 26, NULL, '2026-04-25', 1, '2026-04-25 23:11:49', '2026-04-25 23:11:49'),
(12, 'ASDASDASD', 'ASDASDAS', '', '12313212', 'CB', '', '2000-01-01', 26, NULL, '2026-04-26', 1, '2026-04-26 23:30:58', '2026-04-26 23:30:58'),
(13, 'DSFDFDFFF', 'XXXXXX', '', '1231321', 'LP', '', '2022-01-01', 4, NULL, '2026-04-26', 1, '2026-04-26 23:45:32', '2026-04-26 23:45:32'),
(14, 'BBBB', 'BBB', '', '3234', 'LP', '', '1999-01-01', 27, NULL, '2026-04-26', 1, '2026-04-26 23:46:40', '2026-04-26 23:46:40'),
(15, 'RRRRR', 'RRRRR', '', '123123', 'LP', '', '1999-01-01', 27, NULL, '2026-04-26', 1, '2026-04-26 23:46:54', '2026-04-26 23:46:54'),
(16, 'TTT', 'TTT', '', '345345345', 'LP', '', '1999-03-03', 27, NULL, '2026-04-26', 1, '2026-04-26 23:47:08', '2026-04-26 23:47:08'),
(17, 'VVVVVV', 'VVVVVVV', '', '345345', 'LP', '', '1999-01-01', 27, NULL, '2026-04-26', 1, '2026-04-27 00:14:02', '2026-04-27 00:14:02'),
(18, 'NNNNNNN', 'NNNN', '', '4532435345', 'LP', '', '1999-01-01', 27, NULL, '2026-04-26', 1, '2026-04-27 00:16:01', '2026-04-27 00:16:01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `configuracions`
--

CREATE TABLE `configuracions` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre_sistema` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alias` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `razon_social` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nit` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `dir` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fono` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `actividad` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `correo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `configuracions`
--

INSERT INTO `configuracions` (`id`, `nombre_sistema`, `alias`, `razon_social`, `nit`, `dir`, `fono`, `actividad`, `correo`, `logo`, `created_at`, `updated_at`) VALUES
(1, 'MEDINTER', 'MD', 'MEDINTER S.A.', '1111111111', 'LOS OLIVOS #111', '67676767', 'ACTIVIDAD', 'correo@gmail.com', '11777135688.jpeg', '2026-02-16 22:21:27', '2026-04-25 16:48:08');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `historial_accions`
--

CREATE TABLE `historial_accions` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `accion` varchar(155) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `datos_original` json DEFAULT NULL,
  `datos_nuevo` json DEFAULT NULL,
  `modulo` varchar(155) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ;

--
-- Volcado de datos para la tabla `historial_accions`
--

INSERT INTO `historial_accions` (`id`, `user_id`, `accion`, `descripcion`, `datos_original`, `datos_nuevo`, `modulo`, `fecha`, `hora`, `created_at`, `updated_at`) VALUES
(1, 5, 'CREACIÓN', 'EL USUARIO JVILLCA REGISTRO EL PAGO DE UN CERTIFICADO', '{\"id\": 1, \"hora\": \"16:32:28\", \"fecha\": \"2026-04-25\", \"monto\": \"50.00\", \"modulo\": \"CertificadoDetalle\", \"user_id\": 5, \"medico_id\": null, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": 1, \"created_at\": \"2026-04-25T20:32:28.000000Z\", \"updated_at\": \"2026-04-25T20:32:28.000000Z\", \"verificado\": 1, \"descripcion\": \"PAGO POR CERTIFICADO\", \"registro_id\": 1, \"sucursal_id\": 1, \"hora_verificado\": \"16:32:28\", \"fecha_verificado\": \"2026-04-25\"}', NULL, 'PAGOS', '2026-04-25', '16:32:28', '2026-04-25 20:32:28', '2026-04-25 20:32:28'),
(2, 5, 'CREACIÓN', 'EL USUARIO JVILLCA INICIO UN CERTIFICADO', '{\"id\": 1, \"tipo\": \"NORMAL\", \"saldo\": \"0.00\", \"total\": \"50.00\", \"estado\": 0, \"user_id\": null, \"cancelado\": \"50.00\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": 1, \"created_at\": \"2026-04-25T20:32:28.000000Z\", \"updated_at\": \"2026-04-25T20:32:28.000000Z\", \"sucursal_id\": 1, \"hora_registro\": \"16:32:28\", \"tramitador_id\": null, \"fecha_registro\": \"2026-04-25\", \"certificado_detalles\": [{\"id\": 1, \"name\": null, \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": null, \"cancelado\": \"50.00\", \"categoria\": \"\", \"con_saldo\": true, \"created_at\": \"2026-04-25T20:32:28.000000Z\", \"updated_at\": \"2026-04-25T20:32:28.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados\", \"certificado_id\": 1, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-25', '16:32:28', '2026-04-25 20:32:28', '2026-04-25 20:32:28'),
(3, 5, 'CREACIÓN', 'EL USUARIO JVILLCA REGISTRO UN CLIENTE', '{\"ci\": \"34234234\", \"id\": 1, \"cel\": null, \"edad\": \"27\", \"ci_exp\": \"LP\", \"nombre\": \"FRANCO\", \"materno\": \"\", \"paterno\": \"OLIVARES\", \"fecha_nac\": \"1999-01-01\", \"created_at\": \"2026-04-25T20:32:28.000000Z\", \"updated_at\": \"2026-04-25T20:32:28.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-25\"}', NULL, 'CLIENTES', '2026-04-25', '16:32:28', '2026-04-25 20:32:28', '2026-04-25 20:32:28'),
(4, 8, 'CREACIÓN', 'EL USUARIO AGONZALES REGISTRO UN CERTIFICADO', '{\"id\": 1, \"tipo\": \"NORMAL\", \"saldo\": \"0.00\", \"total\": \"50.00\", \"estado\": 1, \"status\": 1, \"user_id\": null, \"hora_fin\": \"16:33:33\", \"cancelado\": \"50.00\", \"fecha_fin\": \"2026-04-25\", \"tipo_pago\": \"QR\", \"cliente_id\": \"1\", \"created_at\": \"2026-04-25T20:32:28.000000Z\", \"updated_at\": \"2026-04-25T20:33:33.000000Z\", \"hora_inicio\": \"16:32:48\", \"sucursal_id\": 1, \"fecha_inicio\": \"2026-04-25\", \"hora_registro\": \"16:32:28\", \"tramitador_id\": null, \"fecha_registro\": \"2026-04-25\", \"certificado_detalles\": [{\"id\": 1, \"name\": \"011777149213.docx\", \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": \"011777149213.docx\", \"cancelado\": \"50.00\", \"categoria\": \"A\", \"con_saldo\": true, \"created_at\": \"2026-04-25T20:32:28.000000Z\", \"updated_at\": \"2026-04-25T20:33:33.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/011777149213.docx\", \"certificado_id\": 1, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-25', '16:33:33', '2026-04-25 20:33:33', '2026-04-25 20:33:33'),
(5, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN CERTIFICADO', '{\"id\": 1, \"tipo\": \"NORMAL\", \"saldo\": \"0.00\", \"total\": \"50.00\", \"estado\": 1, \"status\": 1, \"user_id\": 8, \"hora_fin\": \"16:33:33\", \"cancelado\": \"50.00\", \"fecha_fin\": \"2026-04-25\", \"tipo_pago\": \"QR\", \"cliente_id\": 1, \"created_at\": \"2026-04-25T20:32:28.000000Z\", \"updated_at\": \"2026-04-25T20:33:33.000000Z\", \"hora_inicio\": \"16:32:48\", \"sucursal_id\": 1, \"fecha_inicio\": \"2026-04-25\", \"hora_registro\": \"16:32:28\", \"tramitador_id\": null, \"fecha_registro\": \"2026-04-25\", \"certificado_detalles\": [{\"id\": 1, \"name\": \"011777149213.docx\", \"saldo\": \"50.00\", \"precio\": \"50.00\", \"archivo\": \"011777149213.docx\", \"cancelado\": \"0.00\", \"categoria\": \"A\", \"con_saldo\": false, \"created_at\": \"2026-04-25T20:32:28.000000Z\", \"updated_at\": \"2026-04-25T20:35:28.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/011777149213.docx\", \"certificado_id\": 1, \"tipo_certificado_id\": 1}]}', '{\"id\": 1, \"tipo\": \"NORMAL\", \"saldo\": \"50.00\", \"total\": \"50.00\", \"estado\": 1, \"status\": 1, \"user_id\": 8, \"hora_fin\": \"16:33:33\", \"cancelado\": \"0.00\", \"fecha_fin\": \"2026-04-25\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"1\", \"created_at\": \"2026-04-25T20:32:28.000000Z\", \"updated_at\": \"2026-04-25T20:35:28.000000Z\", \"hora_inicio\": \"16:32:48\", \"sucursal_id\": 1, \"fecha_inicio\": \"2026-04-25\", \"hora_registro\": \"16:32:28\", \"tramitador_id\": null, \"fecha_registro\": \"2026-04-25\", \"certificado_detalles\": [{\"id\": 1, \"name\": \"011777149213.docx\", \"saldo\": \"50.00\", \"precio\": \"50.00\", \"archivo\": \"011777149213.docx\", \"cancelado\": \"0.00\", \"categoria\": \"A\", \"con_saldo\": false, \"created_at\": \"2026-04-25T20:32:28.000000Z\", \"updated_at\": \"2026-04-25T20:35:28.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/011777149213.docx\", \"certificado_id\": 1, \"tipo_certificado_id\": 1}]}', 'CERTIFICADOS', '2026-04-25', '16:35:28', '2026-04-25 20:35:28', '2026-04-25 20:35:28'),
(6, 8, 'MODIFICACIÓN', 'EL USUARIO AGONZALES ACTUALIZÓ UN CERTIFICADO', '{\"id\": 1, \"tipo\": \"NORMAL\", \"saldo\": \"50.00\", \"total\": \"50.00\", \"estado\": 1, \"status\": 1, \"user_id\": 8, \"hora_fin\": \"16:33:33\", \"cancelado\": \"0.00\", \"fecha_fin\": \"2026-04-25\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": 1, \"created_at\": \"2026-04-25T20:32:28.000000Z\", \"updated_at\": \"2026-04-25T20:35:28.000000Z\", \"hora_inicio\": \"16:32:48\", \"sucursal_id\": 1, \"fecha_inicio\": \"2026-04-25\", \"hora_registro\": \"16:32:28\", \"tramitador_id\": null, \"fecha_registro\": \"2026-04-25\", \"certificado_detalles\": [{\"id\": 1, \"name\": \"011777149213.docx\", \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": \"011777149213.docx\", \"cancelado\": \"50.00\", \"categoria\": \"A\", \"con_saldo\": true, \"created_at\": \"2026-04-25T20:32:28.000000Z\", \"updated_at\": \"2026-04-25T20:35:55.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/011777149213.docx\", \"certificado_id\": 1, \"tipo_certificado_id\": 1}]}', '{\"id\": 1, \"tipo\": \"NORMAL\", \"saldo\": \"0.00\", \"total\": \"50.00\", \"estado\": 1, \"status\": 1, \"user_id\": 8, \"hora_fin\": \"16:33:33\", \"cancelado\": \"50.00\", \"fecha_fin\": \"2026-04-25\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"1\", \"created_at\": \"2026-04-25T20:32:28.000000Z\", \"updated_at\": \"2026-04-25T20:35:55.000000Z\", \"hora_inicio\": \"16:32:48\", \"sucursal_id\": 1, \"fecha_inicio\": \"2026-04-25\", \"hora_registro\": \"16:32:28\", \"tramitador_id\": null, \"fecha_registro\": \"2026-04-25\", \"certificado_detalles\": [{\"id\": 1, \"name\": \"011777149213.docx\", \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": \"011777149213.docx\", \"cancelado\": \"50.00\", \"categoria\": \"A\", \"con_saldo\": true, \"created_at\": \"2026-04-25T20:32:28.000000Z\", \"updated_at\": \"2026-04-25T20:35:55.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/011777149213.docx\", \"certificado_id\": 1, \"tipo_certificado_id\": 1}]}', 'CERTIFICADOS', '2026-04-25', '16:35:55', '2026-04-25 20:35:55', '2026-04-25 20:35:55'),
(7, 8, 'CREACIÓN', 'EL USUARIO AGONZALES REGISTRO EL PAGO DE UN CERTIFICADO', '{\"id\": 2, \"hora\": \"16:46:05\", \"fecha\": \"2026-04-25\", \"monto\": \"50.00\", \"modulo\": \"CertificadoDetalle\", \"user_id\": 8, \"medico_id\": null, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": 2, \"created_at\": \"2026-04-25T20:46:05.000000Z\", \"updated_at\": \"2026-04-25T20:46:05.000000Z\", \"verificado\": 0, \"descripcion\": \"PAGO POR CERTIFICADO\", \"registro_id\": 2, \"sucursal_id\": 1, \"hora_verificado\": \"16:46:05\", \"fecha_verificado\": \"2026-04-25\"}', NULL, 'PAGOS', '2026-04-25', '16:46:05', '2026-04-25 20:46:05', '2026-04-25 20:46:05'),
(8, 8, 'CREACIÓN', 'EL USUARIO AGONZALES INICIO UN CERTIFICADO', '{\"id\": 2, \"tipo\": \"NORMAL\", \"saldo\": \"0.00\", \"total\": \"50.00\", \"estado\": 0, \"user_id\": null, \"cancelado\": \"50.00\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": 2, \"created_at\": \"2026-04-25T20:46:05.000000Z\", \"updated_at\": \"2026-04-25T20:46:05.000000Z\", \"sucursal_id\": 1, \"hora_registro\": \"16:46:05\", \"tramitador_id\": null, \"fecha_registro\": \"2026-04-25\", \"certificado_detalles\": [{\"id\": 2, \"name\": null, \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": null, \"cancelado\": \"50.00\", \"categoria\": \"\", \"con_saldo\": true, \"created_at\": \"2026-04-25T20:46:05.000000Z\", \"updated_at\": \"2026-04-25T20:46:05.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados\", \"certificado_id\": 2, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-25', '16:46:05', '2026-04-25 20:46:05', '2026-04-25 20:46:05'),
(9, 8, 'CREACIÓN', 'EL USUARIO AGONZALES REGISTRO UN CLIENTE', '{\"ci\": \"1312321\", \"id\": 2, \"cel\": null, \"edad\": 26, \"ci_exp\": \"CB\", \"nombre\": \"ALVARO\", \"materno\": \"\", \"paterno\": \"GONZALES\", \"fecha_nac\": \"2000-01-01\", \"created_at\": \"2026-04-25T20:46:05.000000Z\", \"updated_at\": \"2026-04-25T20:46:05.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-25\"}', NULL, 'CLIENTES', '2026-04-25', '16:46:05', '2026-04-25 20:46:05', '2026-04-25 20:46:05'),
(10, 8, 'CREACIÓN', 'EL USUARIO AGONZALES REGISTRO UN CERTIFICADO', '{\"id\": 2, \"tipo\": \"NORMAL\", \"saldo\": \"0.00\", \"total\": \"50.00\", \"estado\": 1, \"status\": 1, \"user_id\": 8, \"hora_fin\": \"16:46:11\", \"cancelado\": \"50.00\", \"fecha_fin\": \"2026-04-25\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"2\", \"created_at\": \"2026-04-25T20:46:05.000000Z\", \"updated_at\": \"2026-04-25T20:46:11.000000Z\", \"hora_inicio\": \"16:46:05\", \"sucursal_id\": 1, \"fecha_inicio\": \"2026-04-25\", \"hora_registro\": \"16:46:05\", \"tramitador_id\": null, \"fecha_registro\": \"2026-04-25\", \"certificado_detalles\": [{\"id\": 2, \"name\": \"021777149971.pdf\", \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": \"021777149971.pdf\", \"cancelado\": \"50.00\", \"categoria\": \"A\", \"con_saldo\": true, \"created_at\": \"2026-04-25T20:46:05.000000Z\", \"updated_at\": \"2026-04-25T20:46:11.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/021777149971.pdf\", \"certificado_id\": 2, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-25', '16:46:11', '2026-04-25 20:46:11', '2026-04-25 20:46:11'),
(11, 8, 'ACTUALIZACIÓN', 'EL USUARIO AGONZALES ACTUALIZÓ EL MONTO DEL PAGO DE UN CERTIFICADO DETALLE DE 50.00 A 40', '{\"id\": 2, \"hora\": \"16:46:05\", \"fecha\": \"2026-04-25\", \"monto\": \"40\", \"modulo\": \"CertificadoDetalle\", \"status\": 1, \"user_id\": 8, \"medico_id\": 8, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": 2, \"created_at\": \"2026-04-25T20:46:05.000000Z\", \"updated_at\": \"2026-04-25T20:46:32.000000Z\", \"verificado\": 0, \"descripcion\": \"PAGO POR CERTIFICADO\", \"registro_id\": 2, \"sucursal_id\": 1, \"hora_verificado\": \"16:46:11\", \"fecha_verificado\": \"2026-04-25\"}', NULL, 'PAGOS', '2026-04-25', '16:46:32', '2026-04-25 20:46:32', '2026-04-25 20:46:32'),
(12, 8, 'MODIFICACIÓN', 'EL USUARIO AGONZALES ACTUALIZÓ UN CERTIFICADO', '{\"id\": 2, \"tipo\": \"NORMAL\", \"saldo\": \"0.00\", \"total\": \"50.00\", \"estado\": 1, \"status\": 1, \"user_id\": 8, \"hora_fin\": \"16:46:11\", \"cancelado\": \"50.00\", \"fecha_fin\": \"2026-04-25\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": 2, \"created_at\": \"2026-04-25T20:46:05.000000Z\", \"updated_at\": \"2026-04-25T20:46:11.000000Z\", \"hora_inicio\": \"16:46:05\", \"sucursal_id\": 1, \"fecha_inicio\": \"2026-04-25\", \"hora_registro\": \"16:46:05\", \"tramitador_id\": null, \"fecha_registro\": \"2026-04-25\", \"certificado_detalles\": [{\"id\": 2, \"name\": \"021777149971.pdf\", \"saldo\": \"0.00\", \"precio\": \"40.00\", \"archivo\": \"021777149971.pdf\", \"cancelado\": \"40.00\", \"categoria\": \"A\", \"con_saldo\": true, \"created_at\": \"2026-04-25T20:46:05.000000Z\", \"updated_at\": \"2026-04-25T20:46:32.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/021777149971.pdf\", \"certificado_id\": 2, \"tipo_certificado_id\": 1}]}', '{\"id\": 2, \"tipo\": \"NORMAL\", \"saldo\": \"0.00\", \"total\": \"40.00\", \"estado\": 1, \"status\": 1, \"user_id\": 8, \"hora_fin\": \"16:46:11\", \"cancelado\": \"40.00\", \"fecha_fin\": \"2026-04-25\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"2\", \"created_at\": \"2026-04-25T20:46:05.000000Z\", \"updated_at\": \"2026-04-25T20:46:32.000000Z\", \"hora_inicio\": \"16:46:05\", \"sucursal_id\": 1, \"fecha_inicio\": \"2026-04-25\", \"hora_registro\": \"16:46:05\", \"tramitador_id\": null, \"fecha_registro\": \"2026-04-25\", \"certificado_detalles\": [{\"id\": 2, \"name\": \"021777149971.pdf\", \"saldo\": \"0.00\", \"precio\": \"40.00\", \"archivo\": \"021777149971.pdf\", \"cancelado\": \"40.00\", \"categoria\": \"A\", \"con_saldo\": true, \"created_at\": \"2026-04-25T20:46:05.000000Z\", \"updated_at\": \"2026-04-25T20:46:32.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/021777149971.pdf\", \"certificado_id\": 2, \"tipo_certificado_id\": 1}]}', 'CERTIFICADOS', '2026-04-25', '16:46:32', '2026-04-25 20:46:32', '2026-04-25 20:46:32'),
(13, 8, 'MODIFICACIÓN', 'EL USUARIO AGONZALES ACTUALIZÓ UN CERTIFICADO', '{\"id\": 2, \"tipo\": \"NORMAL\", \"saldo\": \"0.00\", \"total\": \"40.00\", \"estado\": 1, \"status\": 1, \"user_id\": 8, \"hora_fin\": \"16:46:11\", \"cancelado\": \"40.00\", \"fecha_fin\": \"2026-04-25\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": 2, \"created_at\": \"2026-04-25T20:46:05.000000Z\", \"updated_at\": \"2026-04-25T20:46:32.000000Z\", \"hora_inicio\": \"16:46:05\", \"sucursal_id\": 1, \"fecha_inicio\": \"2026-04-25\", \"hora_registro\": \"16:46:05\", \"tramitador_id\": null, \"fecha_registro\": \"2026-04-25\", \"certificado_detalles\": [{\"id\": 2, \"name\": \"021777149971.pdf\", \"saldo\": \"40.00\", \"precio\": \"40.00\", \"archivo\": \"021777149971.pdf\", \"cancelado\": \"0.00\", \"categoria\": \"A\", \"con_saldo\": false, \"created_at\": \"2026-04-25T20:46:05.000000Z\", \"updated_at\": \"2026-04-25T20:46:40.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/021777149971.pdf\", \"certificado_id\": 2, \"tipo_certificado_id\": 1}]}', '{\"id\": 2, \"tipo\": \"NORMAL\", \"saldo\": \"40.00\", \"total\": \"40.00\", \"estado\": 1, \"status\": 1, \"user_id\": 8, \"hora_fin\": \"16:46:11\", \"cancelado\": \"0.00\", \"fecha_fin\": \"2026-04-25\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"2\", \"created_at\": \"2026-04-25T20:46:05.000000Z\", \"updated_at\": \"2026-04-25T20:46:40.000000Z\", \"hora_inicio\": \"16:46:05\", \"sucursal_id\": 1, \"fecha_inicio\": \"2026-04-25\", \"hora_registro\": \"16:46:05\", \"tramitador_id\": null, \"fecha_registro\": \"2026-04-25\", \"certificado_detalles\": [{\"id\": 2, \"name\": \"021777149971.pdf\", \"saldo\": \"40.00\", \"precio\": \"40.00\", \"archivo\": \"021777149971.pdf\", \"cancelado\": \"0.00\", \"categoria\": \"A\", \"con_saldo\": false, \"created_at\": \"2026-04-25T20:46:05.000000Z\", \"updated_at\": \"2026-04-25T20:46:40.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/021777149971.pdf\", \"certificado_id\": 2, \"tipo_certificado_id\": 1}]}', 'CERTIFICADOS', '2026-04-25', '16:46:40', '2026-04-25 20:46:40', '2026-04-25 20:46:40'),
(14, 8, 'MODIFICACIÓN', 'EL USUARIO AGONZALES ACTUALIZÓ UN CERTIFICADO', '{\"id\": 2, \"tipo\": \"NORMAL\", \"saldo\": \"40.00\", \"total\": \"40.00\", \"estado\": 1, \"status\": 1, \"user_id\": 8, \"hora_fin\": \"16:46:11\", \"cancelado\": \"0.00\", \"fecha_fin\": \"2026-04-25\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": 2, \"created_at\": \"2026-04-25T20:46:05.000000Z\", \"updated_at\": \"2026-04-25T20:46:40.000000Z\", \"hora_inicio\": \"16:46:05\", \"sucursal_id\": 1, \"fecha_inicio\": \"2026-04-25\", \"hora_registro\": \"16:46:05\", \"tramitador_id\": null, \"fecha_registro\": \"2026-04-25\", \"certificado_detalles\": [{\"id\": 2, \"name\": \"021777149971.pdf\", \"saldo\": \"0.00\", \"precio\": \"40.00\", \"archivo\": \"021777149971.pdf\", \"cancelado\": \"40.00\", \"categoria\": \"A\", \"con_saldo\": true, \"created_at\": \"2026-04-25T20:46:05.000000Z\", \"updated_at\": \"2026-04-25T20:47:03.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/021777149971.pdf\", \"certificado_id\": 2, \"tipo_certificado_id\": 1}]}', '{\"id\": 2, \"tipo\": \"NORMAL\", \"saldo\": \"0.00\", \"total\": \"40.00\", \"estado\": 1, \"status\": 1, \"user_id\": 8, \"hora_fin\": \"16:46:11\", \"cancelado\": \"40.00\", \"fecha_fin\": \"2026-04-25\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"2\", \"created_at\": \"2026-04-25T20:46:05.000000Z\", \"updated_at\": \"2026-04-25T20:47:03.000000Z\", \"hora_inicio\": \"16:46:05\", \"sucursal_id\": 1, \"fecha_inicio\": \"2026-04-25\", \"hora_registro\": \"16:46:05\", \"tramitador_id\": null, \"fecha_registro\": \"2026-04-25\", \"certificado_detalles\": [{\"id\": 2, \"name\": \"021777149971.pdf\", \"saldo\": \"0.00\", \"precio\": \"40.00\", \"archivo\": \"021777149971.pdf\", \"cancelado\": \"40.00\", \"categoria\": \"A\", \"con_saldo\": true, \"created_at\": \"2026-04-25T20:46:05.000000Z\", \"updated_at\": \"2026-04-25T20:47:03.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/021777149971.pdf\", \"certificado_id\": 2, \"tipo_certificado_id\": 1}]}', 'CERTIFICADOS', '2026-04-25', '16:47:03', '2026-04-25 20:47:03', '2026-04-25 20:47:03'),
(15, 8, 'MODIFICACIÓN', 'EL USUARIO AGONZALES ACTUALIZÓ UN CERTIFICADO', '{\"id\": 2, \"tipo\": \"NORMAL\", \"saldo\": \"0.00\", \"total\": \"40.00\", \"estado\": 1, \"status\": 1, \"user_id\": 8, \"hora_fin\": \"16:46:11\", \"cancelado\": \"40.00\", \"fecha_fin\": \"2026-04-25\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": 2, \"created_at\": \"2026-04-25T20:46:05.000000Z\", \"updated_at\": \"2026-04-25T20:47:03.000000Z\", \"hora_inicio\": \"16:46:05\", \"sucursal_id\": 1, \"fecha_inicio\": \"2026-04-25\", \"hora_registro\": \"16:46:05\", \"tramitador_id\": null, \"fecha_registro\": \"2026-04-25\", \"certificado_detalles\": [{\"id\": 2, \"name\": \"021777149971.pdf\", \"saldo\": \"0.00\", \"precio\": \"40.00\", \"archivo\": \"021777149971.pdf\", \"cancelado\": \"40.00\", \"categoria\": \"A\", \"con_saldo\": true, \"created_at\": \"2026-04-25T20:46:05.000000Z\", \"updated_at\": \"2026-04-25T20:49:47.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/021777149971.pdf\", \"certificado_id\": 2, \"tipo_certificado_id\": 1}]}', '{\"id\": 2, \"tipo\": \"NORMAL\", \"saldo\": \"0.00\", \"total\": \"40.00\", \"estado\": 1, \"status\": 1, \"user_id\": 8, \"hora_fin\": \"16:46:11\", \"cancelado\": \"40.00\", \"fecha_fin\": \"2026-04-25\", \"tipo_pago\": \"QR\", \"cliente_id\": \"2\", \"created_at\": \"2026-04-25T20:46:05.000000Z\", \"updated_at\": \"2026-04-25T20:49:47.000000Z\", \"hora_inicio\": \"16:46:05\", \"sucursal_id\": 1, \"fecha_inicio\": \"2026-04-25\", \"hora_registro\": \"16:46:05\", \"tramitador_id\": null, \"fecha_registro\": \"2026-04-25\", \"certificado_detalles\": [{\"id\": 2, \"name\": \"021777149971.pdf\", \"saldo\": \"0.00\", \"precio\": \"40.00\", \"archivo\": \"021777149971.pdf\", \"cancelado\": \"40.00\", \"categoria\": \"A\", \"con_saldo\": true, \"created_at\": \"2026-04-25T20:46:05.000000Z\", \"updated_at\": \"2026-04-25T20:49:47.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/021777149971.pdf\", \"certificado_id\": 2, \"tipo_certificado_id\": 1}]}', 'CERTIFICADOS', '2026-04-25', '16:49:47', '2026-04-25 20:49:47', '2026-04-25 20:49:47'),
(16, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN CERTIFICADO', '{\"id\": 2, \"tipo\": \"NORMAL\", \"saldo\": \"0.00\", \"total\": \"40.00\", \"estado\": 1, \"status\": 1, \"user_id\": 8, \"hora_fin\": \"16:46:11\", \"cancelado\": \"40.00\", \"fecha_fin\": \"2026-04-25\", \"tipo_pago\": \"QR\", \"cliente_id\": 2, \"created_at\": \"2026-04-25T20:46:05.000000Z\", \"updated_at\": \"2026-04-25T20:49:47.000000Z\", \"hora_inicio\": \"16:46:05\", \"sucursal_id\": 1, \"fecha_inicio\": \"2026-04-25\", \"hora_registro\": \"16:46:05\", \"tramitador_id\": null, \"fecha_registro\": \"2026-04-25\", \"certificado_detalles\": [{\"id\": 2, \"name\": \"021777149971.pdf\", \"saldo\": \"0.00\", \"precio\": \"40.00\", \"archivo\": \"021777149971.pdf\", \"cancelado\": \"40.00\", \"categoria\": \"A\", \"con_saldo\": true, \"created_at\": \"2026-04-25T20:46:05.000000Z\", \"updated_at\": \"2026-04-25T20:56:13.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/021777149971.pdf\", \"certificado_id\": 2, \"tipo_certificado_id\": 1}]}', '{\"id\": 2, \"tipo\": \"NORMAL\", \"saldo\": \"0.00\", \"total\": \"40.00\", \"estado\": 1, \"status\": 1, \"user_id\": 8, \"hora_fin\": \"16:46:11\", \"cancelado\": \"40.00\", \"fecha_fin\": \"2026-04-25\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"2\", \"created_at\": \"2026-04-25T20:46:05.000000Z\", \"updated_at\": \"2026-04-25T20:56:13.000000Z\", \"hora_inicio\": \"16:46:05\", \"sucursal_id\": 1, \"fecha_inicio\": \"2026-04-25\", \"hora_registro\": \"16:46:05\", \"tramitador_id\": null, \"fecha_registro\": \"2026-04-25\", \"certificado_detalles\": [{\"id\": 2, \"name\": \"021777149971.pdf\", \"saldo\": \"0.00\", \"precio\": \"40.00\", \"archivo\": \"021777149971.pdf\", \"cancelado\": \"40.00\", \"categoria\": \"A\", \"con_saldo\": true, \"created_at\": \"2026-04-25T20:46:05.000000Z\", \"updated_at\": \"2026-04-25T20:56:13.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/021777149971.pdf\", \"certificado_id\": 2, \"tipo_certificado_id\": 1}]}', 'CERTIFICADOS', '2026-04-25', '16:56:14', '2026-04-25 20:56:14', '2026-04-25 20:56:14'),
(17, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN CERTIFICADO', '{\"id\": 2, \"tipo\": \"NORMAL\", \"saldo\": \"0.00\", \"total\": \"40.00\", \"estado\": 1, \"status\": 1, \"user_id\": 8, \"hora_fin\": \"16:46:11\", \"cancelado\": \"40.00\", \"fecha_fin\": \"2026-04-25\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": 2, \"created_at\": \"2026-04-25T20:46:05.000000Z\", \"updated_at\": \"2026-04-25T20:56:13.000000Z\", \"hora_inicio\": \"16:46:05\", \"sucursal_id\": 1, \"fecha_inicio\": \"2026-04-25\", \"hora_registro\": \"16:46:05\", \"tramitador_id\": null, \"fecha_registro\": \"2026-04-25\", \"certificado_detalles\": [{\"id\": 2, \"name\": \"021777149971.pdf\", \"saldo\": \"0.00\", \"precio\": \"40.00\", \"archivo\": \"021777149971.pdf\", \"cancelado\": \"40.00\", \"categoria\": \"A\", \"con_saldo\": true, \"created_at\": \"2026-04-25T20:46:05.000000Z\", \"updated_at\": \"2026-04-25T20:56:33.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/021777149971.pdf\", \"certificado_id\": 2, \"tipo_certificado_id\": 1}]}', '{\"id\": 2, \"tipo\": \"NORMAL\", \"saldo\": \"0.00\", \"total\": \"40.00\", \"estado\": 1, \"status\": 1, \"user_id\": 8, \"hora_fin\": \"16:46:11\", \"cancelado\": \"40.00\", \"fecha_fin\": \"2026-04-25\", \"tipo_pago\": \"QR\", \"cliente_id\": \"2\", \"created_at\": \"2026-04-25T20:46:05.000000Z\", \"updated_at\": \"2026-04-25T20:56:33.000000Z\", \"hora_inicio\": \"16:46:05\", \"sucursal_id\": 1, \"fecha_inicio\": \"2026-04-25\", \"hora_registro\": \"16:46:05\", \"tramitador_id\": null, \"fecha_registro\": \"2026-04-25\", \"certificado_detalles\": [{\"id\": 2, \"name\": \"021777149971.pdf\", \"saldo\": \"0.00\", \"precio\": \"40.00\", \"archivo\": \"021777149971.pdf\", \"cancelado\": \"40.00\", \"categoria\": \"A\", \"con_saldo\": true, \"created_at\": \"2026-04-25T20:46:05.000000Z\", \"updated_at\": \"2026-04-25T20:56:33.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/021777149971.pdf\", \"certificado_id\": 2, \"tipo_certificado_id\": 1}]}', 'CERTIFICADOS', '2026-04-25', '16:56:33', '2026-04-25 20:56:33', '2026-04-25 20:56:33'),
(18, 1, 'ACTUALIZACIÓN', 'EL USUARIO admin ACTUALIZÓ EL MONTO DEL PAGO DE UN CERTIFICADO DETALLE DE 40.00 A 39.9', '{\"id\": 2, \"hora\": \"16:46:05\", \"fecha\": \"2026-04-25\", \"monto\": \"39.9\", \"modulo\": \"CertificadoDetalle\", \"status\": 1, \"user_id\": 5, \"medico_id\": 8, \"tipo_pago\": \"QR\", \"cliente_id\": 2, \"created_at\": \"2026-04-25T20:46:05.000000Z\", \"updated_at\": \"2026-04-25T20:56:44.000000Z\", \"verificado\": 1, \"descripcion\": \"PAGO POR CERTIFICADO\", \"registro_id\": 2, \"sucursal_id\": 1, \"hora_verificado\": \"16:50:05\", \"fecha_verificado\": \"2026-04-25\"}', NULL, 'PAGOS', '2026-04-25', '16:56:44', '2026-04-25 20:56:44', '2026-04-25 20:56:44'),
(19, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN CERTIFICADO', '{\"id\": 2, \"tipo\": \"NORMAL\", \"saldo\": \"0.00\", \"total\": \"40.00\", \"estado\": 1, \"status\": 1, \"user_id\": 8, \"hora_fin\": \"16:46:11\", \"cancelado\": \"40.00\", \"fecha_fin\": \"2026-04-25\", \"tipo_pago\": \"QR\", \"cliente_id\": 2, \"created_at\": \"2026-04-25T20:46:05.000000Z\", \"updated_at\": \"2026-04-25T20:56:33.000000Z\", \"hora_inicio\": \"16:46:05\", \"sucursal_id\": 1, \"fecha_inicio\": \"2026-04-25\", \"hora_registro\": \"16:46:05\", \"tramitador_id\": null, \"fecha_registro\": \"2026-04-25\", \"certificado_detalles\": [{\"id\": 2, \"name\": \"021777149971.pdf\", \"saldo\": \"0.00\", \"precio\": \"39.90\", \"archivo\": \"021777149971.pdf\", \"cancelado\": \"39.90\", \"categoria\": \"A\", \"con_saldo\": true, \"created_at\": \"2026-04-25T20:46:05.000000Z\", \"updated_at\": \"2026-04-25T20:56:44.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/021777149971.pdf\", \"certificado_id\": 2, \"tipo_certificado_id\": 1}]}', '{\"id\": 2, \"tipo\": \"NORMAL\", \"saldo\": \"0.00\", \"total\": \"39.90\", \"estado\": 1, \"status\": 1, \"user_id\": 8, \"hora_fin\": \"16:46:11\", \"cancelado\": \"39.90\", \"fecha_fin\": \"2026-04-25\", \"tipo_pago\": \"QR\", \"cliente_id\": \"2\", \"created_at\": \"2026-04-25T20:46:05.000000Z\", \"updated_at\": \"2026-04-25T20:56:44.000000Z\", \"hora_inicio\": \"16:46:05\", \"sucursal_id\": 1, \"fecha_inicio\": \"2026-04-25\", \"hora_registro\": \"16:46:05\", \"tramitador_id\": null, \"fecha_registro\": \"2026-04-25\", \"certificado_detalles\": [{\"id\": 2, \"name\": \"021777149971.pdf\", \"saldo\": \"0.00\", \"precio\": \"39.90\", \"archivo\": \"021777149971.pdf\", \"cancelado\": \"39.90\", \"categoria\": \"A\", \"con_saldo\": true, \"created_at\": \"2026-04-25T20:46:05.000000Z\", \"updated_at\": \"2026-04-25T20:56:44.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/021777149971.pdf\", \"certificado_id\": 2, \"tipo_certificado_id\": 1}]}', 'CERTIFICADOS', '2026-04-25', '16:56:44', '2026-04-25 20:56:44', '2026-04-25 20:56:44'),
(20, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN CERTIFICADO', '{\"id\": 2, \"tipo\": \"NORMAL\", \"saldo\": \"0.00\", \"total\": \"39.90\", \"estado\": 1, \"status\": 1, \"user_id\": 8, \"hora_fin\": \"16:46:11\", \"cancelado\": \"39.90\", \"fecha_fin\": \"2026-04-25\", \"tipo_pago\": \"QR\", \"cliente_id\": 2, \"created_at\": \"2026-04-25T20:46:05.000000Z\", \"updated_at\": \"2026-04-25T20:56:44.000000Z\", \"hora_inicio\": \"16:46:05\", \"sucursal_id\": 1, \"fecha_inicio\": \"2026-04-25\", \"hora_registro\": \"16:46:05\", \"tramitador_id\": null, \"fecha_registro\": \"2026-04-25\", \"certificado_detalles\": [{\"id\": 2, \"name\": \"021777149971.pdf\", \"saldo\": \"39.90\", \"precio\": \"39.90\", \"archivo\": \"021777149971.pdf\", \"cancelado\": \"0.00\", \"categoria\": \"A\", \"con_saldo\": false, \"created_at\": \"2026-04-25T20:46:05.000000Z\", \"updated_at\": \"2026-04-25T20:57:28.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/021777149971.pdf\", \"certificado_id\": 2, \"tipo_certificado_id\": 1}]}', '{\"id\": 2, \"tipo\": \"NORMAL\", \"saldo\": \"39.90\", \"total\": \"39.90\", \"estado\": 1, \"status\": 1, \"user_id\": 8, \"hora_fin\": \"16:46:11\", \"cancelado\": \"0.00\", \"fecha_fin\": \"2026-04-25\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"2\", \"created_at\": \"2026-04-25T20:46:05.000000Z\", \"updated_at\": \"2026-04-25T20:57:28.000000Z\", \"hora_inicio\": \"16:46:05\", \"sucursal_id\": 1, \"fecha_inicio\": \"2026-04-25\", \"hora_registro\": \"16:46:05\", \"tramitador_id\": null, \"fecha_registro\": \"2026-04-25\", \"certificado_detalles\": [{\"id\": 2, \"name\": \"021777149971.pdf\", \"saldo\": \"39.90\", \"precio\": \"39.90\", \"archivo\": \"021777149971.pdf\", \"cancelado\": \"0.00\", \"categoria\": \"A\", \"con_saldo\": false, \"created_at\": \"2026-04-25T20:46:05.000000Z\", \"updated_at\": \"2026-04-25T20:57:28.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/021777149971.pdf\", \"certificado_id\": 2, \"tipo_certificado_id\": 1}]}', 'CERTIFICADOS', '2026-04-25', '16:57:28', '2026-04-25 20:57:28', '2026-04-25 20:57:28'),
(21, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN CERTIFICADO', '{\"id\": 2, \"tipo\": \"NORMAL\", \"saldo\": \"0.00\", \"total\": \"39.90\", \"estado\": 1, \"status\": 1, \"user_id\": 8, \"hora_fin\": \"16:46:11\", \"cancelado\": \"39.90\", \"fecha_fin\": \"2026-04-25\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": 2, \"created_at\": \"2026-04-25T20:46:05.000000Z\", \"updated_at\": \"2026-04-25T21:00:45.000000Z\", \"hora_inicio\": \"16:46:05\", \"sucursal_id\": 1, \"fecha_inicio\": \"2026-04-25\", \"hora_registro\": \"16:46:05\", \"tramitador_id\": null, \"fecha_registro\": \"2026-04-25\", \"certificado_detalles\": [{\"id\": 2, \"name\": \"021777149971.pdf\", \"saldo\": \"39.90\", \"precio\": \"39.90\", \"archivo\": \"021777149971.pdf\", \"cancelado\": \"0.00\", \"categoria\": \"A\", \"con_saldo\": false, \"created_at\": \"2026-04-25T20:46:05.000000Z\", \"updated_at\": \"2026-04-25T21:01:06.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/021777149971.pdf\", \"certificado_id\": 2, \"tipo_certificado_id\": 1}]}', '{\"id\": 2, \"tipo\": \"NORMAL\", \"saldo\": \"39.90\", \"total\": \"39.90\", \"estado\": 1, \"status\": 1, \"user_id\": 8, \"hora_fin\": \"16:46:11\", \"cancelado\": \"0.00\", \"fecha_fin\": \"2026-04-25\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"2\", \"created_at\": \"2026-04-25T20:46:05.000000Z\", \"updated_at\": \"2026-04-25T21:01:06.000000Z\", \"hora_inicio\": \"16:46:05\", \"sucursal_id\": 1, \"fecha_inicio\": \"2026-04-25\", \"hora_registro\": \"16:46:05\", \"tramitador_id\": null, \"fecha_registro\": \"2026-04-25\", \"certificado_detalles\": [{\"id\": 2, \"name\": \"021777149971.pdf\", \"saldo\": \"39.90\", \"precio\": \"39.90\", \"archivo\": \"021777149971.pdf\", \"cancelado\": \"0.00\", \"categoria\": \"A\", \"con_saldo\": false, \"created_at\": \"2026-04-25T20:46:05.000000Z\", \"updated_at\": \"2026-04-25T21:01:06.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/021777149971.pdf\", \"certificado_id\": 2, \"tipo_certificado_id\": 1}]}', 'CERTIFICADOS', '2026-04-25', '17:01:06', '2026-04-25 21:01:06', '2026-04-25 21:01:06'),
(22, 5, 'CREACIÓN', 'EL USUARIO JVILLCA REGISTRO EL PAGO DE UN CERTIFICADO', '{\"id\": 3, \"hora\": \"17:09:51\", \"fecha\": \"2026-04-25\", \"monto\": \"50.00\", \"modulo\": \"CertificadoDetalle\", \"user_id\": 5, \"medico_id\": null, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": 4, \"created_at\": \"2026-04-25T21:09:51.000000Z\", \"updated_at\": \"2026-04-25T21:09:51.000000Z\", \"verificado\": 1, \"descripcion\": \"PAGO POR CERTIFICADO\", \"registro_id\": 3, \"sucursal_id\": 1, \"hora_verificado\": \"17:09:51\", \"fecha_verificado\": \"2026-04-25\"}', NULL, 'PAGOS', '2026-04-25', '17:09:51', '2026-04-25 21:09:51', '2026-04-25 21:09:51'),
(23, 5, 'CREACIÓN', 'EL USUARIO JVILLCA INICIO UN CERTIFICADO', '{\"id\": 3, \"tipo\": \"NORMAL\", \"saldo\": \"0.00\", \"total\": \"50.00\", \"estado\": 0, \"user_id\": null, \"cancelado\": \"50.00\", \"inicio_id\": 0, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": 4, \"created_at\": \"2026-04-25T21:09:51.000000Z\", \"updated_at\": \"2026-04-25T21:09:51.000000Z\", \"sucursal_id\": 1, \"hora_registro\": \"17:09:51\", \"tramitador_id\": null, \"fecha_registro\": \"2026-04-25\", \"certificado_detalles\": [{\"id\": 3, \"name\": null, \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": null, \"cancelado\": \"50.00\", \"categoria\": \"\", \"con_saldo\": true, \"created_at\": \"2026-04-25T21:09:51.000000Z\", \"updated_at\": \"2026-04-25T21:09:51.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados\", \"certificado_id\": 3, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-25', '17:09:51', '2026-04-25 21:09:51', '2026-04-25 21:09:51'),
(24, 5, 'CREACIÓN', 'EL USUARIO JVILLCA REGISTRO UN CLIENTE', '{\"ci\": \"1231313123\", \"id\": 4, \"cel\": null, \"edad\": \"27\", \"ci_exp\": \"LP\", \"nombre\": \"ELVIRA\", \"materno\": \"\", \"paterno\": \"GONZALES\", \"fecha_nac\": \"1999-01-01\", \"created_at\": \"2026-04-25T21:09:51.000000Z\", \"updated_at\": \"2026-04-25T21:09:51.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-25\"}', NULL, 'CLIENTES', '2026-04-25', '17:09:51', '2026-04-25 21:09:51', '2026-04-25 21:09:51'),
(25, 8, 'CREACIÓN', 'EL USUARIO AGONZALES INICIO UN CERTIFICADO', '{\"id\": 4, \"tipo\": \"NORMAL\", \"saldo\": \"50.00\", \"total\": \"50.00\", \"estado\": 0, \"user_id\": null, \"cancelado\": \"0.00\", \"inicio_id\": 0, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": 5, \"created_at\": \"2026-04-25T21:10:14.000000Z\", \"updated_at\": \"2026-04-25T21:10:14.000000Z\", \"sucursal_id\": 1, \"hora_registro\": \"17:10:14\", \"tramitador_id\": null, \"fecha_registro\": \"2026-04-25\", \"certificado_detalles\": [{\"id\": 4, \"name\": null, \"saldo\": \"50.00\", \"precio\": \"50.00\", \"archivo\": null, \"cancelado\": \"0.00\", \"categoria\": \"\", \"con_saldo\": false, \"created_at\": \"2026-04-25T21:10:14.000000Z\", \"updated_at\": \"2026-04-25T21:10:14.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados\", \"certificado_id\": 4, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-25', '17:10:14', '2026-04-25 21:10:14', '2026-04-25 21:10:14'),
(26, 8, 'CREACIÓN', 'EL USUARIO AGONZALES REGISTRO UN CLIENTE', '{\"ci\": \"3242424234\", \"id\": 5, \"cel\": null, \"edad\": 26, \"ci_exp\": \"LP\", \"nombre\": \"OLIVER\", \"materno\": \"\", \"paterno\": \"CARVAJAL\", \"fecha_nac\": \"2000-02-02\", \"created_at\": \"2026-04-25T21:10:14.000000Z\", \"updated_at\": \"2026-04-25T21:10:14.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-25\"}', NULL, 'CLIENTES', '2026-04-25', '17:10:14', '2026-04-25 21:10:14', '2026-04-25 21:10:14'),
(27, 8, 'CREACIÓN', 'EL USUARIO AGONZALES REGISTRO EL PAGO DE UN CERTIFICADO', '{\"id\": 4, \"hora\": \"19:00:22\", \"fecha\": \"2026-04-25\", \"monto\": 30, \"modulo\": \"CertificadoDetalle\", \"user_id\": 8, \"medico_id\": null, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": 8, \"created_at\": \"2026-04-25T23:00:22.000000Z\", \"updated_at\": \"2026-04-25T23:00:22.000000Z\", \"verificado\": 0, \"descripcion\": \"PAGO POR CERTIFICADO\", \"registro_id\": 5, \"sucursal_id\": 1, \"hora_verificado\": \"19:00:22\", \"fecha_verificado\": \"2026-04-25\"}', NULL, 'PAGOS', '2026-04-25', '19:00:22', '2026-04-25 23:00:22', '2026-04-25 23:00:22'),
(28, 8, 'CREACIÓN', 'EL USUARIO AGONZALES INICIO UN CERTIFICADO', '{\"id\": 7, \"tipo\": \"TRAMITE\", \"saldo\": \"0.00\", \"total\": \"30.00\", \"estado\": 0, \"user_id\": null, \"cancelado\": \"30.00\", \"inicio_id\": 8, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": 8, \"created_at\": \"2026-04-25T23:00:22.000000Z\", \"updated_at\": \"2026-04-25T23:00:22.000000Z\", \"sucursal_id\": 1, \"hora_registro\": \"19:00:22\", \"tramitador_id\": 1, \"fecha_registro\": \"2026-04-25\", \"certificado_detalles\": [{\"id\": 5, \"name\": null, \"saldo\": \"0.00\", \"precio\": \"30.00\", \"archivo\": null, \"cancelado\": \"30.00\", \"categoria\": \"\", \"con_saldo\": true, \"created_at\": \"2026-04-25T23:00:22.000000Z\", \"updated_at\": \"2026-04-25T23:00:22.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados\", \"certificado_id\": 7, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-25', '19:00:22', '2026-04-25 23:00:22', '2026-04-25 23:00:22'),
(29, 8, 'CREACIÓN', 'EL USUARIO AGONZALES REGISTRO UN CLIENTE', '{\"ci\": \"2242343\", \"id\": 8, \"cel\": null, \"edad\": 26, \"ci_exp\": \"CB\", \"nombre\": \"ALVARO\", \"materno\": \"\", \"paterno\": \"MARTINEZ\", \"fecha_nac\": \"2000-01-01\", \"created_at\": \"2026-04-25T23:00:22.000000Z\", \"updated_at\": \"2026-04-25T23:00:22.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-25\"}', NULL, 'CLIENTES', '2026-04-25', '19:00:22', '2026-04-25 23:00:22', '2026-04-25 23:00:22'),
(30, 8, 'CREACIÓN', 'EL USUARIO AGONZALES REGISTRO UN CERTIFICADO', '{\"id\": 7, \"tipo\": \"TRAMITE\", \"saldo\": \"0.00\", \"total\": \"30.00\", \"estado\": 1, \"status\": 1, \"user_id\": 8, \"hora_fin\": \"19:00:37\", \"cancelado\": \"30.00\", \"fecha_fin\": \"2026-04-25\", \"inicio_id\": 8, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"8\", \"created_at\": \"2026-04-25T23:00:22.000000Z\", \"updated_at\": \"2026-04-25T23:00:37.000000Z\", \"hora_inicio\": \"19:00:22\", \"sucursal_id\": 1, \"fecha_inicio\": \"2026-04-25\", \"hora_registro\": \"19:00:22\", \"tramitador_id\": 1, \"fecha_registro\": \"2026-04-25\", \"certificado_detalles\": [{\"id\": 5, \"name\": \"051777158037.docx\", \"saldo\": \"0.00\", \"precio\": \"30.00\", \"archivo\": \"051777158037.docx\", \"cancelado\": \"30.00\", \"categoria\": \"A\", \"con_saldo\": true, \"created_at\": \"2026-04-25T23:00:22.000000Z\", \"updated_at\": \"2026-04-25T23:00:37.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/051777158037.docx\", \"certificado_id\": 7, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-25', '19:00:37', '2026-04-25 23:00:37', '2026-04-25 23:00:37'),
(31, 8, 'CREACIÓN', 'EL USUARIO AGONZALES REGISTRO UN CLIENTE', '{\"ci\": \"435345345\", \"id\": 9, \"cel\": null, \"edad\": 26, \"ci_exp\": \"LP\", \"nombre\": \"OLIVIA\", \"materno\": \"\", \"paterno\": \"MARTINEZ\", \"fecha_nac\": \"2000-02-02\", \"created_at\": \"2026-04-25T23:01:21.000000Z\", \"updated_at\": \"2026-04-25T23:01:21.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-25\"}', NULL, 'CLIENTES', '2026-04-25', '19:01:21', '2026-04-25 23:01:21', '2026-04-25 23:01:21'),
(32, 8, 'CREACIÓN', 'EL USUARIO AGONZALES REGISTRO EL PAGO DE UN CERTIFICADO', '{\"id\": 5, \"hora\": \"19:02:48\", \"fecha\": \"2026-04-25\", \"monto\": \"50.00\", \"modulo\": \"CertificadoDetalle\", \"user_id\": 8, \"medico_id\": 8, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"9\", \"created_at\": \"2026-04-25T23:02:48.000000Z\", \"updated_at\": \"2026-04-25T23:02:48.000000Z\", \"verificado\": 0, \"descripcion\": \"PAGO POR CERTIFICADO\", \"registro_id\": 6, \"sucursal_id\": 1, \"hora_verificado\": \"19:02:48\", \"fecha_verificado\": \"2026-04-25\"}', NULL, 'PAGOS', '2026-04-25', '19:02:48', '2026-04-25 23:02:48', '2026-04-25 23:02:48'),
(33, 8, 'CREACIÓN', 'EL USUARIO AGONZALES REGISTRO UN CERTIFICADO', '{\"id\": 8, \"tipo\": \"NORMAL\", \"saldo\": \"0.00\", \"total\": \"50.00\", \"estado\": 1, \"user_id\": 8, \"hora_fin\": \"19:02:48\", \"cancelado\": \"50.00\", \"fecha_fin\": \"2026-04-25\", \"inicio_id\": 8, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"9\", \"created_at\": \"2026-04-25T23:02:48.000000Z\", \"updated_at\": \"2026-04-25T23:02:48.000000Z\", \"hora_inicio\": \"19:02:28\", \"sucursal_id\": 1, \"fecha_inicio\": \"2026-04-25\", \"hora_registro\": \"19:02:48\", \"tramitador_id\": null, \"fecha_registro\": \"2026-04-25\", \"certificado_detalles\": [{\"id\": 6, \"name\": \"061777158168.docx\", \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": \"061777158168.docx\", \"cancelado\": \"50.00\", \"categoria\": \"p\", \"con_saldo\": true, \"created_at\": \"2026-04-25T23:02:48.000000Z\", \"updated_at\": \"2026-04-25T23:02:48.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/061777158168.docx\", \"certificado_id\": 8, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-25', '19:02:48', '2026-04-25 23:02:48', '2026-04-25 23:02:48'),
(34, 8, 'CREACIÓN', 'EL USUARIO AGONZALES REGISTRO EL PAGO DE UN CERTIFICADO', '{\"id\": 6, \"hora\": \"19:03:28\", \"fecha\": \"2026-04-25\", \"monto\": \"50.00\", \"modulo\": \"CertificadoDetalle\", \"user_id\": 8, \"medico_id\": null, \"tipo_pago\": \"QR\", \"cliente_id\": 10, \"created_at\": \"2026-04-25T23:03:28.000000Z\", \"updated_at\": \"2026-04-25T23:03:28.000000Z\", \"verificado\": 0, \"descripcion\": \"PAGO POR CERTIFICADO\", \"registro_id\": 7, \"sucursal_id\": 1, \"hora_verificado\": \"19:03:28\", \"fecha_verificado\": \"2026-04-25\"}', NULL, 'PAGOS', '2026-04-25', '19:03:28', '2026-04-25 23:03:28', '2026-04-25 23:03:28'),
(35, 8, 'CREACIÓN', 'EL USUARIO AGONZALES INICIO UN CERTIFICADO', '{\"id\": 9, \"tipo\": \"NORMAL\", \"saldo\": \"0.00\", \"total\": \"50.00\", \"estado\": 0, \"user_id\": null, \"cancelado\": \"50.00\", \"inicio_id\": 8, \"tipo_pago\": \"QR\", \"cliente_id\": 10, \"created_at\": \"2026-04-25T23:03:28.000000Z\", \"updated_at\": \"2026-04-25T23:03:28.000000Z\", \"sucursal_id\": 1, \"hora_registro\": \"19:03:28\", \"tramitador_id\": null, \"fecha_registro\": \"2026-04-25\", \"certificado_detalles\": [{\"id\": 7, \"name\": null, \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": null, \"cancelado\": \"50.00\", \"categoria\": \"\", \"con_saldo\": true, \"created_at\": \"2026-04-25T23:03:28.000000Z\", \"updated_at\": \"2026-04-25T23:03:28.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados\", \"certificado_id\": 9, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-25', '19:03:28', '2026-04-25 23:03:28', '2026-04-25 23:03:28'),
(36, 8, 'CREACIÓN', 'EL USUARIO AGONZALES REGISTRO UN CLIENTE', '{\"ci\": \"456456456\", \"id\": 10, \"cel\": null, \"edad\": 27, \"ci_exp\": \"CB\", \"nombre\": \"EFRAIN\", \"materno\": \"\", \"paterno\": \"CONDORI\", \"fecha_nac\": \"1999-03-03\", \"created_at\": \"2026-04-25T23:03:28.000000Z\", \"updated_at\": \"2026-04-25T23:03:28.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-25\"}', NULL, 'CLIENTES', '2026-04-25', '19:03:28', '2026-04-25 23:03:28', '2026-04-25 23:03:28'),
(37, 8, 'CREACIÓN', 'EL USUARIO AGONZALES REGISTRO UN CERTIFICADO', '{\"id\": 9, \"tipo\": \"NORMAL\", \"saldo\": \"0.00\", \"total\": \"50.00\", \"estado\": 1, \"status\": 1, \"user_id\": 8, \"hora_fin\": \"19:03:43\", \"cancelado\": \"50.00\", \"fecha_fin\": \"2026-04-25\", \"inicio_id\": 8, \"tipo_pago\": \"QR\", \"cliente_id\": \"10\", \"created_at\": \"2026-04-25T23:03:28.000000Z\", \"updated_at\": \"2026-04-25T23:03:43.000000Z\", \"hora_inicio\": \"19:03:28\", \"sucursal_id\": 1, \"fecha_inicio\": \"2026-04-25\", \"hora_registro\": \"19:03:28\", \"tramitador_id\": null, \"fecha_registro\": \"2026-04-25\", \"certificado_detalles\": [{\"id\": 7, \"name\": \"071777158223.docx\", \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": \"071777158223.docx\", \"cancelado\": \"50.00\", \"categoria\": \"p\", \"con_saldo\": true, \"created_at\": \"2026-04-25T23:03:28.000000Z\", \"updated_at\": \"2026-04-25T23:03:43.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/071777158223.docx\", \"certificado_id\": 9, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-25', '19:03:43', '2026-04-25 23:03:43', '2026-04-25 23:03:43'),
(38, 8, 'CREACIÓN', 'EL USUARIO AGONZALES INICIO UN CERTIFICADO', '{\"id\": 10, \"tipo\": \"NORMAL\", \"saldo\": \"50.00\", \"total\": \"50.00\", \"estado\": 0, \"user_id\": null, \"cancelado\": \"0.00\", \"inicio_id\": 8, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": 11, \"created_at\": \"2026-04-25T23:11:49.000000Z\", \"updated_at\": \"2026-04-25T23:11:49.000000Z\", \"sucursal_id\": 1, \"hora_registro\": \"19:11:49\", \"tramitador_id\": null, \"fecha_registro\": \"2026-04-25\", \"certificado_detalles\": [{\"id\": 8, \"name\": null, \"saldo\": \"50.00\", \"precio\": \"50.00\", \"archivo\": null, \"cancelado\": \"0.00\", \"categoria\": \"\", \"con_saldo\": false, \"created_at\": \"2026-04-25T23:11:49.000000Z\", \"updated_at\": \"2026-04-25T23:11:49.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados\", \"certificado_id\": 10, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-25', '19:11:49', '2026-04-25 23:11:49', '2026-04-25 23:11:49'),
(39, 8, 'CREACIÓN', 'EL USUARIO AGONZALES REGISTRO UN CLIENTE', '{\"ci\": \"435345322\", \"id\": 11, \"cel\": null, \"edad\": 26, \"ci_exp\": \"CB\", \"nombre\": \"CARLOS\", \"materno\": \"\", \"paterno\": \"SANZ\", \"fecha_nac\": \"2000-03-03\", \"created_at\": \"2026-04-25T23:11:49.000000Z\", \"updated_at\": \"2026-04-25T23:11:49.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-25\"}', NULL, 'CLIENTES', '2026-04-25', '19:11:49', '2026-04-25 23:11:49', '2026-04-25 23:11:49'),
(40, 8, 'CREACIÓN', 'EL USUARIO AGONZALES REGISTRO UN CERTIFICADO', '{\"id\": 10, \"tipo\": \"NORMAL\", \"saldo\": \"50.00\", \"total\": \"50.00\", \"estado\": 1, \"status\": 1, \"user_id\": 8, \"hora_fin\": \"19:12:02\", \"cancelado\": \"0.00\", \"fecha_fin\": \"2026-04-25\", \"inicio_id\": 8, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"11\", \"created_at\": \"2026-04-25T23:11:49.000000Z\", \"updated_at\": \"2026-04-25T23:12:02.000000Z\", \"hora_inicio\": \"19:11:50\", \"sucursal_id\": 1, \"fecha_inicio\": \"2026-04-25\", \"hora_registro\": \"19:11:49\", \"tramitador_id\": null, \"fecha_registro\": \"2026-04-25\", \"certificado_detalles\": [{\"id\": 8, \"name\": \"081777158722.docx\", \"saldo\": \"50.00\", \"precio\": \"50.00\", \"archivo\": \"081777158722.docx\", \"cancelado\": \"0.00\", \"categoria\": \"P\", \"con_saldo\": false, \"created_at\": \"2026-04-25T23:11:49.000000Z\", \"updated_at\": \"2026-04-25T23:12:02.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/081777158722.docx\", \"certificado_id\": 10, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-25', '19:12:02', '2026-04-25 23:12:02', '2026-04-25 23:12:02'),
(41, 7, 'CREACIÓN', 'EL USUARIO CMERCADO INICIO UN CERTIFICADO', '{\"id\": 11, \"tipo\": \"NORMAL\", \"saldo\": \"50.00\", \"total\": \"50.00\", \"estado\": 0, \"user_id\": null, \"cancelado\": \"0.00\", \"inicio_id\": 7, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": 12, \"created_at\": \"2026-04-26T23:30:58.000000Z\", \"updated_at\": \"2026-04-26T23:30:58.000000Z\", \"sucursal_id\": 2, \"hora_registro\": \"19:30:58\", \"tramitador_id\": null, \"fecha_registro\": \"2026-04-26\", \"certificado_detalles\": [{\"id\": 9, \"name\": null, \"saldo\": \"50.00\", \"precio\": \"50.00\", \"archivo\": null, \"cancelado\": \"0.00\", \"categoria\": \"\", \"con_saldo\": false, \"created_at\": \"2026-04-26T23:30:58.000000Z\", \"updated_at\": \"2026-04-26T23:30:58.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados\", \"certificado_id\": 11, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-26', '19:30:58', '2026-04-26 23:30:58', '2026-04-26 23:30:58'),
(42, 7, 'CREACIÓN', 'EL USUARIO CMERCADO REGISTRO UN CLIENTE', '{\"ci\": \"12313212\", \"id\": 12, \"cel\": null, \"edad\": \"26\", \"ci_exp\": \"CB\", \"nombre\": \"ASDASDASD\", \"materno\": \"\", \"paterno\": \"ASDASDAS\", \"fecha_nac\": \"2000-01-01\", \"created_at\": \"2026-04-26T23:30:58.000000Z\", \"updated_at\": \"2026-04-26T23:30:58.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-26\"}', NULL, 'CLIENTES', '2026-04-26', '19:30:58', '2026-04-26 23:30:58', '2026-04-26 23:30:58'),
(43, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": \"1231321\", \"id\": 13, \"cel\": null, \"edad\": \"4\", \"ci_exp\": \"LP\", \"nombre\": \"DSFDFDFFF\", \"materno\": \"\", \"paterno\": \"XXXXXX\", \"fecha_nac\": \"2022-01-01\", \"created_at\": \"2026-04-26T23:45:32.000000Z\", \"updated_at\": \"2026-04-26T23:45:32.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-26\"}', NULL, 'CLIENTES', '2026-04-26', '19:45:32', '2026-04-26 23:45:32', '2026-04-26 23:45:32'),
(44, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": \"3234\", \"id\": 14, \"cel\": null, \"edad\": \"27\", \"ci_exp\": \"LP\", \"nombre\": \"BBBB\", \"materno\": \"\", \"paterno\": \"BBB\", \"fecha_nac\": \"1999-01-01\", \"created_at\": \"2026-04-26T23:46:40.000000Z\", \"updated_at\": \"2026-04-26T23:46:40.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-26\"}', NULL, 'CLIENTES', '2026-04-26', '19:46:40', '2026-04-26 23:46:40', '2026-04-26 23:46:40'),
(45, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": \"123123\", \"id\": 15, \"cel\": null, \"edad\": \"27\", \"ci_exp\": \"LP\", \"nombre\": \"RRRRR\", \"materno\": \"\", \"paterno\": \"RRRRR\", \"fecha_nac\": \"1999-01-01\", \"created_at\": \"2026-04-26T23:46:54.000000Z\", \"updated_at\": \"2026-04-26T23:46:54.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-26\"}', NULL, 'CLIENTES', '2026-04-26', '19:46:54', '2026-04-26 23:46:54', '2026-04-26 23:46:54');
INSERT INTO `historial_accions` (`id`, `user_id`, `accion`, `descripcion`, `datos_original`, `datos_nuevo`, `modulo`, `fecha`, `hora`, `created_at`, `updated_at`) VALUES
(46, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": \"345345345\", \"id\": 16, \"cel\": null, \"edad\": \"27\", \"ci_exp\": \"LP\", \"nombre\": \"TTT\", \"materno\": \"\", \"paterno\": \"TTT\", \"fecha_nac\": \"1999-03-03\", \"created_at\": \"2026-04-26T23:47:08.000000Z\", \"updated_at\": \"2026-04-26T23:47:08.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-26\"}', NULL, 'CLIENTES', '2026-04-26', '19:47:08', '2026-04-26 23:47:08', '2026-04-26 23:47:08'),
(47, 8, 'CREACIÓN', 'EL USUARIO AGONZALES REGISTRO EL PAGO DE UN CERTIFICADO', '{\"id\": 7, \"hora\": \"20:14:02\", \"fecha\": \"2026-04-26\", \"monto\": 35, \"modulo\": \"CertificadoDetalle\", \"user_id\": 8, \"medico_id\": null, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": 17, \"created_at\": \"2026-04-27T00:14:02.000000Z\", \"updated_at\": \"2026-04-27T00:14:02.000000Z\", \"verificado\": 1, \"descripcion\": \"PAGO POR CERTIFICADO\", \"registro_id\": 10, \"sucursal_id\": 1, \"hora_verificado\": \"20:14:02\", \"fecha_verificado\": \"2026-04-26\"}', NULL, 'PAGOS', '2026-04-26', '20:14:02', '2026-04-27 00:14:02', '2026-04-27 00:14:02'),
(48, 8, 'CREACIÓN', 'EL USUARIO AGONZALES INICIO UN CERTIFICADO', '{\"id\": 12, \"tipo\": \"TRAMITE\", \"saldo\": \"0.00\", \"total\": \"35.00\", \"estado\": 0, \"user_id\": null, \"cancelado\": \"35.00\", \"inicio_id\": 8, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": 17, \"created_at\": \"2026-04-27T00:14:02.000000Z\", \"updated_at\": \"2026-04-27T00:14:02.000000Z\", \"sucursal_id\": 1, \"hora_registro\": \"20:14:02\", \"tramitador_id\": 1, \"fecha_registro\": \"2026-04-26\", \"certificado_detalles\": [{\"id\": 10, \"name\": null, \"saldo\": \"0.00\", \"precio\": \"35.00\", \"archivo\": null, \"cancelado\": \"35.00\", \"categoria\": \"\", \"con_saldo\": true, \"created_at\": \"2026-04-27T00:14:02.000000Z\", \"updated_at\": \"2026-04-27T00:14:02.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados\", \"certificado_id\": 12, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-26', '20:14:02', '2026-04-27 00:14:02', '2026-04-27 00:14:02'),
(49, 8, 'CREACIÓN', 'EL USUARIO AGONZALES REGISTRO UN CLIENTE', '{\"ci\": \"345345\", \"id\": 17, \"cel\": null, \"edad\": 27, \"ci_exp\": \"LP\", \"nombre\": \"VVVVVV\", \"materno\": \"\", \"paterno\": \"VVVVVVV\", \"fecha_nac\": \"1999-01-01\", \"created_at\": \"2026-04-27T00:14:02.000000Z\", \"updated_at\": \"2026-04-27T00:14:02.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-26\"}', NULL, 'CLIENTES', '2026-04-26', '20:14:02', '2026-04-27 00:14:02', '2026-04-27 00:14:02'),
(50, 8, 'CREACIÓN', 'EL USUARIO AGONZALES REGISTRO UN CERTIFICADO', '{\"id\": 12, \"tipo\": \"TRAMITE\", \"saldo\": \"0.00\", \"total\": \"35.00\", \"estado\": 1, \"status\": 1, \"user_id\": 8, \"hora_fin\": \"20:15:38\", \"cancelado\": \"35.00\", \"fecha_fin\": \"2026-04-26\", \"inicio_id\": 8, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"17\", \"created_at\": \"2026-04-27T00:14:02.000000Z\", \"updated_at\": \"2026-04-27T00:15:38.000000Z\", \"hora_inicio\": \"20:14:02\", \"sucursal_id\": 1, \"fecha_inicio\": \"2026-04-26\", \"hora_registro\": \"20:14:02\", \"tramitador_id\": 1, \"fecha_registro\": \"2026-04-26\", \"certificado_detalles\": [{\"id\": 10, \"name\": \"0101777248938.docx\", \"saldo\": \"0.00\", \"precio\": \"35.00\", \"archivo\": \"0101777248938.docx\", \"cancelado\": \"35.00\", \"categoria\": \"p\", \"con_saldo\": true, \"created_at\": \"2026-04-27T00:14:02.000000Z\", \"updated_at\": \"2026-04-27T00:15:38.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/0101777248938.docx\", \"certificado_id\": 12, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-26', '20:15:38', '2026-04-27 00:15:38', '2026-04-27 00:15:38'),
(51, 6, 'CREACIÓN', 'EL USUARIO JSOTO REGISTRO EL PAGO DE UN CERTIFICADO', '{\"id\": 8, \"hora\": \"20:16:01\", \"fecha\": \"2026-04-26\", \"monto\": 40, \"modulo\": \"CertificadoDetalle\", \"user_id\": 6, \"medico_id\": null, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": 18, \"created_at\": \"2026-04-27T00:16:01.000000Z\", \"updated_at\": \"2026-04-27T00:16:01.000000Z\", \"verificado\": 0, \"descripcion\": \"PAGO POR CERTIFICADO\", \"registro_id\": 11, \"sucursal_id\": 1, \"hora_verificado\": \"20:16:01\", \"fecha_verificado\": \"2026-04-26\"}', NULL, 'PAGOS', '2026-04-26', '20:16:01', '2026-04-27 00:16:01', '2026-04-27 00:16:01'),
(52, 6, 'CREACIÓN', 'EL USUARIO JSOTO INICIO UN CERTIFICADO', '{\"id\": 13, \"tipo\": \"NORMAL\", \"saldo\": \"0.00\", \"total\": \"40.00\", \"estado\": 0, \"user_id\": null, \"cancelado\": \"40.00\", \"inicio_id\": 6, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": 18, \"created_at\": \"2026-04-27T00:16:01.000000Z\", \"updated_at\": \"2026-04-27T00:16:01.000000Z\", \"sucursal_id\": 1, \"hora_registro\": \"20:16:01\", \"tramitador_id\": null, \"fecha_registro\": \"2026-04-26\", \"certificado_detalles\": [{\"id\": 11, \"name\": null, \"saldo\": \"0.00\", \"precio\": \"40.00\", \"archivo\": null, \"cancelado\": \"40.00\", \"categoria\": \"\", \"con_saldo\": true, \"created_at\": \"2026-04-27T00:16:01.000000Z\", \"updated_at\": \"2026-04-27T00:16:01.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados\", \"certificado_id\": 13, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-26', '20:16:01', '2026-04-27 00:16:01', '2026-04-27 00:16:01'),
(53, 6, 'CREACIÓN', 'EL USUARIO JSOTO REGISTRO UN CLIENTE', '{\"ci\": \"4532435345\", \"id\": 18, \"cel\": null, \"edad\": 27, \"ci_exp\": \"LP\", \"nombre\": \"NNNNNNN\", \"materno\": \"\", \"paterno\": \"NNNN\", \"fecha_nac\": \"1999-01-01\", \"created_at\": \"2026-04-27T00:16:01.000000Z\", \"updated_at\": \"2026-04-27T00:16:01.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-26\"}', NULL, 'CLIENTES', '2026-04-26', '20:16:01', '2026-04-27 00:16:01', '2026-04-27 00:16:01'),
(54, 6, 'CREACIÓN', 'EL USUARIO JSOTO REGISTRO EL PAGO DE UN CERTIFICADO', '{\"id\": 9, \"hora\": \"20:39:19\", \"fecha\": \"2026-04-26\", \"monto\": \"50.00\", \"modulo\": \"CertificadoDetalle\", \"user_id\": 6, \"medico_id\": 8, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": 11, \"created_at\": \"2026-04-27T00:39:19.000000Z\", \"updated_at\": \"2026-04-27T00:39:19.000000Z\", \"verificado\": 0, \"descripcion\": \"PAGO POR CERTIFICADO\", \"registro_id\": 8, \"sucursal_id\": 1, \"hora_verificado\": \"20:39:19\", \"fecha_verificado\": \"2026-04-26\"}', NULL, 'PAGOS', '2026-04-26', '20:39:19', '2026-04-27 00:39:19', '2026-04-27 00:39:19'),
(55, 8, 'CREACIÓN', 'EL USUARIO AGONZALES REGISTRO EL PAGO DE UN CERTIFICADO', '{\"id\": 10, \"hora\": \"20:39:32\", \"fecha\": \"2026-04-26\", \"monto\": \"50.00\", \"modulo\": \"CertificadoDetalle\", \"user_id\": 8, \"tipo_pago\": \"QR\", \"cliente_id\": 5, \"created_at\": \"2026-04-27T00:39:32.000000Z\", \"updated_at\": \"2026-04-27T00:39:32.000000Z\", \"verificado\": 1, \"descripcion\": \"PAGO POR CERTIFICADO\", \"registro_id\": 4, \"sucursal_id\": 1, \"hora_verificado\": \"20:39:32\", \"fecha_verificado\": \"2026-04-26\"}', NULL, 'PAGOS', '2026-04-26', '20:39:32', '2026-04-27 00:39:32', '2026-04-27 00:39:32');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `login_users`
--

CREATE TABLE `login_users` (
  `id` bigint UNSIGNED NOT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `sucursal_id` bigint UNSIGNED NOT NULL,
  `verifica_pagos` int NOT NULL DEFAULT '0',
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `login_users`
--

INSERT INTO `login_users` (`id`, `user_id`, `sucursal_id`, `verifica_pagos`, `fecha`, `hora`, `created_at`, `updated_at`) VALUES
(1, 1, 1, 0, '2026-04-25', '16:10:53', '2026-04-25 20:10:53', '2026-04-25 20:10:53'),
(2, 8, 1, 0, '2026-04-25', '16:11:21', '2026-04-25 20:11:21', '2026-04-25 20:11:21'),
(3, 5, 1, 0, '2026-04-25', '16:11:50', '2026-04-25 20:11:50', '2026-04-25 20:11:50'),
(4, 4, 2, 0, '2026-04-25', '18:26:15', '2026-04-25 22:26:15', '2026-04-25 22:26:15'),
(5, 1, 1, 1, '2026-04-26', '19:15:22', '2026-04-26 23:15:22', '2026-04-27 00:05:39'),
(6, 7, 1, 0, '2026-04-26', '19:16:09', '2026-04-26 23:16:09', '2026-04-26 23:16:09'),
(7, 7, 2, 0, '2026-04-26', '19:17:58', '2026-04-26 23:17:58', '2026-04-26 23:17:58'),
(8, 5, 1, 1, '2026-04-26', '19:58:40', '2026-04-26 23:58:40', '2026-04-26 23:58:40'),
(9, 8, 1, 1, '2026-04-26', '20:09:46', '2026-04-27 00:09:46', '2026-04-27 00:09:46'),
(10, 6, 1, 0, '2026-04-26', '20:10:38', '2026-04-27 00:10:38', '2026-04-27 00:10:38'),
(11, 2, 2, 1, '2026-04-26', '20:11:56', '2026-04-27 00:11:56', '2026-04-27 00:11:56');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `migrations`
--

CREATE TABLE `migrations` (
  `id` int UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
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
(14, '2026_04_12_111900_create_tramite_clientes_table', 6),
(15, '2026_04_13_161152_create_certificado_pagos_table', 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagos`
--

CREATE TABLE `pagos` (
  `id` bigint UNSIGNED NOT NULL,
  `registro_id` bigint UNSIGNED NOT NULL,
  `modulo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `monto` decimal(24,2) NOT NULL,
  `tipo_pago` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(900) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `cliente_id` bigint UNSIGNED DEFAULT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `medico_id` bigint UNSIGNED DEFAULT NULL,
  `sucursal_id` bigint UNSIGNED NOT NULL,
  `verificado` int NOT NULL DEFAULT '0',
  `fecha_verificado` date DEFAULT NULL,
  `hora_verificado` time DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `pagos`
--

INSERT INTO `pagos` (`id`, `registro_id`, `modulo`, `monto`, `tipo_pago`, `descripcion`, `fecha`, `hora`, `cliente_id`, `user_id`, `medico_id`, `sucursal_id`, `verificado`, `fecha_verificado`, `hora_verificado`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 'CertificadoDetalle', 50.00, 'EFECTIVO', 'PAGO POR CERTIFICADO', '2026-04-25', '16:32:28', 1, 5, 8, 1, 1, '2026-04-25', '16:36:16', 1, '2026-04-25 20:32:28', '2026-04-25 20:36:16'),
(2, 2, 'CertificadoDetalle', 39.90, 'EFECTIVO', 'PAGO POR CERTIFICADO', '2026-04-25', '16:46:05', 2, 5, 8, 1, 1, '2026-04-25', '17:01:21', 1, '2026-04-25 20:46:05', '2026-04-25 21:01:21'),
(3, 3, 'CertificadoDetalle', 50.00, 'EFECTIVO', 'PAGO POR CERTIFICADO', '2026-04-25', '17:09:51', 4, 5, NULL, 1, 1, '2026-04-25', '17:09:51', 1, '2026-04-25 21:09:51', '2026-04-25 21:09:51'),
(4, 5, 'CertificadoDetalle', 30.00, 'EFECTIVO', 'PAGO POR CERTIFICADO', '2026-04-25', '19:00:22', 8, 8, 8, 1, 0, '2026-04-25', '19:00:22', 1, '2026-04-25 23:00:22', '2026-04-25 23:00:37'),
(5, 6, 'CertificadoDetalle', 50.00, 'EFECTIVO', 'PAGO POR CERTIFICADO', '2026-04-25', '19:02:48', 9, 8, NULL, 1, 0, '2026-04-25', '19:02:48', 1, '2026-04-25 23:02:48', '2026-04-25 23:02:48'),
(6, 7, 'CertificadoDetalle', 50.00, 'QR', 'PAGO POR CERTIFICADO', '2026-04-25', '19:03:28', 10, 8, 8, 1, 0, '2026-04-25', '19:03:28', 1, '2026-04-25 23:03:28', '2026-04-25 23:03:43'),
(7, 10, 'CertificadoDetalle', 35.00, 'EFECTIVO', 'PAGO POR CERTIFICADO', '2026-04-26', '20:14:02', 17, 8, 8, 1, 1, '2026-04-26', '20:14:02', 1, '2026-04-27 00:14:02', '2026-04-27 00:15:38'),
(8, 11, 'CertificadoDetalle', 40.00, 'EFECTIVO', 'PAGO POR CERTIFICADO', '2026-04-26', '20:16:01', 18, 6, NULL, 1, 0, '2026-04-26', '20:16:01', 1, '2026-04-27 00:16:01', '2026-04-27 00:16:01'),
(9, 8, 'CertificadoDetalle', 50.00, 'EFECTIVO', 'PAGO POR CERTIFICADO', '2026-04-26', '20:39:19', 11, 6, 8, 1, 0, '2026-04-26', '20:39:19', 1, '2026-04-27 00:39:19', '2026-04-27 00:39:19'),
(10, 4, 'CertificadoDetalle', 50.00, 'QR', 'PAGO POR CERTIFICADO', '2026-04-26', '20:39:32', 5, 8, NULL, 1, 1, '2026-04-26', '20:39:32', 1, '2026-04-27 00:39:32', '2026-04-27 00:39:32');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sucursals`
--

CREATE TABLE `sucursals` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(300) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(900) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `sucursals`
--

INSERT INTO `sucursals` (`id`, `nombre`, `descripcion`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 'SUCURSAL 1', 'SUCURSAL 1', '2026-04-03', '2026-04-03 23:28:07', '2026-04-03 23:28:07'),
(2, 'SUCURSAL 2', '', '2026-04-03', '2026-04-03 23:28:14', '2026-04-03 23:28:14'),
(3, 'SUCURSAL 3', 'DESC', '2026-04-25', '2026-04-25 15:36:22', '2026-04-25 15:36:22');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `tipo_certificados`
--

CREATE TABLE `tipo_certificados` (
  `id` bigint UNSIGNED NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `precio` decimal(24,2) NOT NULL,
  `descripcion` varchar(1200) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
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
  `cel` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_registro` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tramitadors`
--

INSERT INTO `tramitadors` (`id`, `nombre`, `ci`, `ci_exp`, `cel`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 'EDUARDO GONZALES', '34234', 'LP', '67676767', '2026-04-20', '2026-04-20 21:44:07', '2026-04-25 15:39:53');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `users`
--

CREATE TABLE `users` (
  `id` bigint UNSIGNED NOT NULL,
  `usuario` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `nombre` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `paterno` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `materno` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ci` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ci_exp` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `dir` varchar(600) COLLATE utf8mb4_unicode_ci NOT NULL,
  `correo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fono` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `acceso` int NOT NULL,
  `tipo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `foto` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
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
(2, 'MGONZALES', 'MARIA', 'GONZALES', '', '123456', 'LP', '', NULL, '676767676', '$2y$12$O1HDJS2mAu4QMb9M2ullZue.bXo3zqMdeoj2Mn8cvPqnffSPMg7fy', 1, 'SECRETARIA', NULL, 1, '2026-04-20', 1, '2026-04-20 21:26:27', '2026-04-20 21:26:27'),
(3, 'JPERES', 'JUAN', 'PERES', '', '56565656', 'LP', '', NULL, '78787878', '$2y$12$wpbR0y4c0JILKd61wf0OsOaddyaw7.lD5sFOKuPXBSdHekitTMbn2', 1, 'MÉDICO', NULL, 1, '2026-04-20', 1, '2026-04-20 21:26:42', '2026-04-20 21:26:42'),
(4, 'MTORREZ', 'MARIANA', 'TORREZ', '', '2342341', 'CB', '', NULL, '67676767', '$2y$12$Q8YaoV5O3/zznweuUBODJuXlDdAVEd3aVXC5.nJFKLGs06qZubqFa', 1, 'MÉDICO', NULL, 2, '2026-04-20', 1, '2026-04-20 21:54:13', '2026-04-25 22:26:09'),
(5, 'JVILLCA', 'JOEL', 'VILLCA', 'QUISBERT', '1234567', 'CB', '', NULL, '88888888', '$2y$12$P2hZGtTB5epjcU2ElJPBn.EzIp4pUuKdd3GeaeW9ElRjJPphTVYV6', 1, 'SECRETARIA', '51776737693.jpeg', 2, '2026-04-20', 1, '2026-04-20 22:14:53', '2026-04-25 15:16:15'),
(6, 'JSOTO', 'JUAN', 'SOTO', 'PARDO', '1234567-1', 'LP', '', NULL, '7777777', '$2y$12$rTseXLPnpHGwCIPaYLbj2eedlF1lifX4bWMb7WfVCciB6AI5nFaky', 1, 'MÉDICO', NULL, 2, '2026-04-20', 1, '2026-04-20 22:18:52', '2026-04-27 00:09:57'),
(7, 'CMERCADO', 'CLAUDIA', 'MERCADO', 'COCA', '6666666', 'SC', '', NULL, '33333333', '$2y$12$h0MdnCgy/Ag/t.NhJKmQoe41zyajDLoiHfBKQcYHT5RJw4PEJBR5.', 1, 'GERENTE', NULL, 2, '2026-04-20', 1, '2026-04-20 22:30:05', '2026-04-26 23:16:01'),
(8, 'AGONZALES', 'ALVARO', 'GONZALES', 'GONZALES', '453535', 'LP', '', NULL, '657575767', '$2y$12$PzTu9OhymasRunqH5xAcuOR0hFXkIm3gfD/9S24xS6WuHDlH8ORvS', 1, 'MÉDICO', NULL, 1, '2026-04-25', 1, '2026-04-25 15:25:46', '2026-04-25 16:04:02');

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
  ADD KEY `certificados_sucursal_id_foreign` (`sucursal_id`),
  ADD KEY `certificados_tramitador_id` (`tramitador_id`),
  ADD KEY `certificados_inicio_id` (`inicio_id`);

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
-- Indices de la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD PRIMARY KEY (`id`),
  ADD KEY `fk_user_pagos_id` (`user_id`),
  ADD KEY `fk_sucursal_pagos_id` (`sucursal_id`),
  ADD KEY `pagos_cliente_id` (`cliente_id`),
  ADD KEY `pagos_medico_id` (`medico_id`);

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT de la tabla `certificado_detalles`
--
ALTER TABLE `certificado_detalles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `certificado_emitidos`
--
ALTER TABLE `certificado_emitidos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=19;

--
-- AUTO_INCREMENT de la tabla `configuracions`
--
ALTER TABLE `configuracions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `historial_accions`
--
ALTER TABLE `historial_accions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `login_users`
--
ALTER TABLE `login_users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `pagos`
--
ALTER TABLE `pagos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT de la tabla `sucursals`
--
ALTER TABLE `sucursals`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `tipo_certificados`
--
ALTER TABLE `tipo_certificados`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `tramitadors`
--
ALTER TABLE `tramitadors`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `certificados`
--
ALTER TABLE `certificados`
  ADD CONSTRAINT `certificados_cliente_id_foreign` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`),
  ADD CONSTRAINT `certificados_inicio_id` FOREIGN KEY (`inicio_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `certificados_sucursal_id_foreign` FOREIGN KEY (`sucursal_id`) REFERENCES `sucursals` (`id`),
  ADD CONSTRAINT `certificados_tramitador_id` FOREIGN KEY (`tramitador_id`) REFERENCES `tramitadors` (`id`),
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
-- Filtros para la tabla `pagos`
--
ALTER TABLE `pagos`
  ADD CONSTRAINT `fk_sucursal_pagos_id` FOREIGN KEY (`sucursal_id`) REFERENCES `sucursals` (`id`),
  ADD CONSTRAINT `fk_user_pagos_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `pagos_cliente_id` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`),
  ADD CONSTRAINT `pagos_medico_id` FOREIGN KEY (`medico_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
