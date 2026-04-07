-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 07-04-2026 a las 14:07:51
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
  `precio` decimal(24,2) NOT NULL,
  `tipo_certificado_id` bigint UNSIGNED NOT NULL,
  `tipo_pago` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `archivo1` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `archivo2` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `user_id` bigint UNSIGNED NOT NULL,
  `sucursal_id` bigint UNSIGNED NOT NULL,
  `fecha_registro` date DEFAULT NULL,
  `hora_registro` time DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `certificados`
--

INSERT INTO `certificados` (`id`, `cliente_id`, `precio`, `tipo_certificado_id`, `tipo_pago`, `archivo1`, `archivo2`, `user_id`, `sucursal_id`, `fecha_registro`, `hora_registro`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 90.00, 1, 'EFECTIVO', 'archivo111775482303.docx', 'archivo211775482303.docx', 2, 1, '2026-04-06', '09:31:43', 1, '2026-04-06 17:31:43', '2026-04-06 17:31:43'),
(2, 3, 60.00, 2, 'QR', NULL, NULL, 2, 1, '2026-04-06', '09:40:25', 1, '2026-04-06 17:40:25', '2026-04-06 17:40:25'),
(3, 4, 90.00, 1, 'EFECTIVO', NULL, NULL, 2, 1, '2026-04-06', '09:41:33', 1, '2026-04-06 17:41:33', '2026-04-06 17:41:33'),
(4, 5, 90.00, 1, 'EFECTIVO', NULL, NULL, 2, 1, '2026-04-06', '09:41:49', 1, '2026-04-06 17:41:49', '2026-04-06 17:41:49'),
(5, 6, 90.00, 1, 'EFECTIVO', NULL, NULL, 2, 1, '2026-04-06', '09:42:05', 1, '2026-04-06 17:42:05', '2026-04-06 17:42:05'),
(6, 7, 90.00, 1, 'EFECTIVO', NULL, NULL, 2, 1, '2026-04-06', '09:42:20', 1, '2026-04-06 17:42:20', '2026-04-06 17:42:20'),
(7, 8, 90.00, 1, 'EFECTIVO', NULL, NULL, 2, 1, '2026-04-06', '09:42:33', 1, '2026-04-06 17:42:33', '2026-04-06 17:42:33'),
(8, 9, 90.00, 1, 'EFECTIVO', NULL, NULL, 2, 1, '2026-04-06', '09:42:46', 1, '2026-04-06 17:42:46', '2026-04-06 17:42:46'),
(9, 2, 90.00, 1, 'QR', NULL, NULL, 2, 1, '2026-04-06', '09:43:10', 1, '2026-04-06 17:43:10', '2026-04-06 17:43:10'),
(10, 10, 90.00, 1, 'EFECTIVO', NULL, NULL, 2, 1, '2026-04-06', '09:43:42', 1, '2026-04-06 17:43:42', '2026-04-06 17:43:42'),
(11, 11, 0.00, 1, 'EFECTIVO', 'archivo1111775483063.docx', NULL, 2, 1, '2026-04-06', '09:44:23', 1, '2026-04-06 17:44:23', '2026-04-06 17:44:23'),
(12, 12, 90.00, 1, 'EFECTIVO', NULL, NULL, 2, 1, '2026-04-06', '09:44:59', 1, '2026-04-06 17:44:59', '2026-04-06 17:44:59'),
(13, 13, 90.00, 1, 'QR', NULL, NULL, 2, 1, '2026-04-06', '09:45:18', 1, '2026-04-06 17:45:18', '2026-04-06 17:45:18'),
(14, 14, 90.00, 1, 'EFECTIVO', NULL, NULL, 2, 1, '2026-04-06', '09:45:38', 1, '2026-04-06 17:45:38', '2026-04-06 17:45:38'),
(15, 15, 90.00, 1, 'QR', NULL, NULL, 2, 1, '2026-04-06', '09:45:58', 1, '2026-04-06 17:45:58', '2026-04-06 17:45:58'),
(16, 16, 90.00, 1, 'EFECTIVO', NULL, NULL, 2, 1, '2026-04-06', '09:46:21', 1, '2026-04-06 17:46:21', '2026-04-06 17:46:21'),
(17, 17, 90.00, 1, 'EFECTIVO', NULL, NULL, 2, 1, '2026-04-06', '09:46:40', 1, '2026-04-06 17:46:40', '2026-04-06 17:46:40'),
(18, 18, 90.00, 1, 'EFECTIVO', NULL, NULL, 2, 1, '2026-04-06', '09:46:54', 1, '2026-04-06 17:46:54', '2026-04-06 17:46:54'),
(19, 19, 90.00, 1, 'EFECTIVO', NULL, NULL, 2, 1, '2026-04-06', '09:47:10', 1, '2026-04-06 17:47:10', '2026-04-06 17:47:10'),
(20, 20, 90.00, 1, 'EFECTIVO', NULL, NULL, 2, 1, '2026-04-06', '09:47:35', 1, '2026-04-06 17:47:35', '2026-04-06 17:47:35'),
(21, 21, 0.00, 1, 'QR', NULL, NULL, 2, 1, '2026-04-06', '09:47:59', 1, '2026-04-06 17:47:59', '2026-04-06 17:47:59'),
(22, 22, 90.00, 1, 'EFECTIVO', NULL, NULL, 4, 2, '2026-04-06', '10:22:33', 1, '2026-04-06 18:22:33', '2026-04-06 18:22:33'),
(23, 23, 90.00, 1, 'EFECTIVO', NULL, NULL, 4, 2, '2026-04-07', '09:31:16', 0, '2026-04-07 17:31:16', '2026-04-07 17:31:55');

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
(1, '2026-04-06', 2, 1, 20, '2026-04-06 17:31:31', '2026-04-06 17:47:59'),
(2, '2026-04-06', 2, 2, 1, '2026-04-06 17:40:21', '2026-04-06 17:40:25'),
(3, '2026-04-06', 4, 1, 1, '2026-04-06 18:22:31', '2026-04-06 18:22:33'),
(4, '2026-04-07', 4, 1, 0, '2026-04-07 17:31:14', '2026-04-07 17:31:55');

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
  `cel` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL,
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `clientes`
--

INSERT INTO `clientes` (`id`, `nombre`, `paterno`, `materno`, `ci`, `ci_exp`, `complemento`, `fecha_nac`, `cel`, `fecha_registro`, `status`, `created_at`, `updated_at`) VALUES
(1, 'JUAN', 'PEREZ', 'MAMANI', '123456', 'LP', 'CD', '2000-01-01', '67676767', '2026-04-03', 1, '2026-04-04 00:14:52', '2026-04-04 00:14:52'),
(2, 'EDUARDO', 'RAMIRES', '', '123456', 'SC', '', '1999-01-01', NULL, '2026-04-03', 1, '2026-04-04 00:17:56', '2026-04-04 00:17:56'),
(3, 'DANIELA', 'QUISPE', 'QUISPE', '543433', 'CB', '', NULL, NULL, '2026-04-03', 1, '2026-04-04 00:18:41', '2026-04-04 00:18:41'),
(4, 'MARCOS', 'CHOQUE', '', '3453453', 'SC', '', NULL, NULL, '2026-04-03', 1, '2026-04-04 02:29:13', '2026-04-04 02:29:13'),
(5, 'HERNAN', 'ROSALES', '', '1234567', 'LP', '', NULL, NULL, '2026-04-03', 1, '2026-04-04 02:38:04', '2026-04-04 02:38:04'),
(6, 'FRANZ', 'SALINAS', '', '435534', 'LP', '', '2000-01-01', '756756756', '2026-04-03', 1, '2026-04-04 02:40:45', '2026-04-04 02:40:45'),
(7, 'LUIS', 'CACERES', 'MARTINEZ', '567567567', 'LP', 'ED', '1999-01-01', '676767676', '2026-04-03', 1, '2026-04-04 02:42:12', '2026-04-04 02:42:12'),
(8, 'JAIME', 'ROSALES', '', '7686786', 'CB', '', NULL, NULL, '2026-04-03', 1, '2026-04-04 02:46:49', '2026-04-04 02:46:49'),
(9, 'ALEX', 'MAGALLANES', 'SOLIZ', '76867867', 'OR', '', NULL, NULL, '2026-04-03', 1, '2026-04-04 02:47:29', '2026-04-04 02:47:29'),
(10, 'JORGE', 'ALVA', 'CORTEZ', '6544565', 'LP', '', NULL, NULL, '2026-04-06', 1, '2026-04-06 17:43:35', '2026-04-06 17:43:35'),
(11, 'FRANCO', 'GONZALES', '', '34534543', 'SC', '', NULL, NULL, '2026-04-06', 1, '2026-04-06 17:44:02', '2026-04-06 17:44:02'),
(12, 'ELVIS', 'CHOQUE', 'CHOQUE', '45645645', 'CB', '', '2000-09-21', '65756565', '2026-04-06', 1, '2026-04-06 17:44:50', '2026-04-06 17:44:50'),
(13, 'SANDRA', 'MARTINEZ', '', '53535345', 'CB', '', NULL, NULL, '2026-04-06', 1, '2026-04-06 17:45:13', '2026-04-06 17:45:13'),
(14, 'CARLOS', 'CONTRERAS', '', '4353454', 'LP', '', NULL, NULL, '2026-04-06', 1, '2026-04-06 17:45:34', '2026-04-06 17:45:34'),
(15, 'SANDRA', 'MARCEL', '', '45335345', 'LP', '', NULL, NULL, '2026-04-06', 1, '2026-04-06 17:45:51', '2026-04-06 17:45:51'),
(16, 'CESAR', 'VILLANUEVA', '', '5345345', 'LP', '', NULL, NULL, '2026-04-06', 1, '2026-04-06 17:46:16', '2026-04-06 17:46:16'),
(17, 'CRISTIAN', 'CORTEZ', '', '54646456', 'LP', '', NULL, NULL, '2026-04-06', 1, '2026-04-06 17:46:36', '2026-04-06 17:46:36'),
(18, 'JUAN', 'CARVAJAL', '', '5464645', 'CB', '', NULL, NULL, '2026-04-06', 1, '2026-04-06 17:46:50', '2026-04-06 17:46:50'),
(19, 'GRACIELA', 'CONDORI', '', '34534544', 'CB', '', NULL, NULL, '2026-04-06', 1, '2026-04-06 17:47:06', '2026-04-06 17:47:06'),
(20, 'JORGE LUIS', 'GARNICA', '', '34534534', 'SC', '', NULL, NULL, '2026-04-06', 1, '2026-04-06 17:47:30', '2026-04-06 17:47:30'),
(21, 'FELIX', 'CARVAJAL', '', '4564565', 'SC', '', NULL, NULL, '2026-04-06', 1, '2026-04-06 17:47:48', '2026-04-06 17:47:48'),
(22, 'FRANCO', 'VALVIDIESO', '', '465645645', 'CB', '', NULL, NULL, '2026-04-06', 1, '2026-04-06 18:22:27', '2026-04-06 18:22:27'),
(23, 'FRANZ', 'SALINAS', '', '46545443', 'CB', '', NULL, NULL, '2026-04-07', 1, '2026-04-07 17:31:11', '2026-04-07 17:31:11');

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
  `dir` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fono` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `actividad` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `correo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `logo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
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
  `accion` varchar(155) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `datos_original` json DEFAULT NULL,
  `datos_nuevo` json DEFAULT NULL,
  `modulo` varchar(155) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha` date NOT NULL,
  `hora` time NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `historial_accions`
--

INSERT INTO `historial_accions` (`id`, `user_id`, `accion`, `descripcion`, `datos_original`, `datos_nuevo`, `modulo`, `fecha`, `hora`, `created_at`, `updated_at`) VALUES
(1, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRODUCTO', '{\"id\": 1, \"nombre\": \"SUCURSAL 1\", \"created_at\": \"2026-04-03T19:28:07.000000Z\", \"updated_at\": \"2026-04-03T19:28:07.000000Z\", \"descripcion\": \"SUCURSAL 1\"}', NULL, 'SUCURSALES', '2026-04-03', '19:28:07', '2026-04-03 23:28:07', '2026-04-03 23:28:07'),
(2, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRODUCTO', '{\"id\": 2, \"nombre\": \"SUCURSAL 2\", \"created_at\": \"2026-04-03T19:28:14.000000Z\", \"updated_at\": \"2026-04-03T19:28:14.000000Z\", \"descripcion\": \"\"}', NULL, 'SUCURSALES', '2026-04-03', '19:28:14', '2026-04-03 23:28:14', '2026-04-03 23:28:14'),
(3, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRODUCTO', '{\"id\": 1, \"nombre\": \"TIPO CERTIFICADO 1\", \"precio\": \"90\", \"created_at\": \"2026-04-03T19:44:24.000000Z\", \"updated_at\": \"2026-04-03T19:44:24.000000Z\", \"descripcion\": \"DESC TIPO 1\", \"fecha_registro\": \"2026-04-03\"}', NULL, 'SUCURSALES', '2026-04-03', '19:44:24', '2026-04-03 23:44:24', '2026-04-03 23:44:24'),
(4, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN PRODUCTO', '{\"id\": 1, \"nombre\": \"TIPO CERTIFICADO 1\", \"precio\": \"90.00\", \"created_at\": \"2026-04-03T19:44:24.000000Z\", \"updated_at\": \"2026-04-03T19:44:24.000000Z\", \"descripcion\": \"DESC TIPO 1\", \"fecha_registro\": \"2026-04-03\"}', '{\"id\": 1, \"nombre\": \"TIPO CERTIFICADO 1ASD\", \"precio\": \"100\", \"created_at\": \"2026-04-03T19:44:24.000000Z\", \"updated_at\": \"2026-04-03T19:45:00.000000Z\", \"descripcion\": \"DESC TIPO 1ASD\", \"fecha_registro\": \"2026-04-03\"}', 'SUCURSALES', '2026-04-03', '19:45:00', '2026-04-03 23:45:00', '2026-04-03 23:45:00'),
(5, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRODUCTO', '{\"id\": 1, \"nombre\": \"TIPO CERTIFICADO 1\", \"precio\": \"90\", \"created_at\": \"2026-04-03T19:45:20.000000Z\", \"updated_at\": \"2026-04-03T19:45:20.000000Z\", \"descripcion\": \"DESC TIPO 1\", \"fecha_registro\": \"2026-04-03\"}', NULL, 'SUCURSALES', '2026-04-03', '19:45:21', '2026-04-03 23:45:21', '2026-04-03 23:45:21'),
(6, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRODUCTO', '{\"id\": 2, \"nombre\": \"TIPO CERTIFCADO 2\", \"precio\": \"60\", \"created_at\": \"2026-04-03T19:47:30.000000Z\", \"updated_at\": \"2026-04-03T19:47:30.000000Z\", \"descripcion\": \"\", \"fecha_registro\": \"2026-04-03\"}', NULL, 'SUCURSALES', '2026-04-03', '19:47:30', '2026-04-03 23:47:30', '2026-04-03 23:47:30'),
(7, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRODUCTO', '{\"id\": 3, \"nombre\": \"TIPO CERTIFICADO 2\", \"precio\": \"50\", \"created_at\": \"2026-04-03T19:47:44.000000Z\", \"updated_at\": \"2026-04-03T19:47:44.000000Z\", \"descripcion\": \"\", \"fecha_registro\": \"2026-04-03\"}', NULL, 'SUCURSALES', '2026-04-03', '19:47:44', '2026-04-03 23:47:44', '2026-04-03 23:47:44'),
(8, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN PRODUCTO', '{\"id\": 3, \"nombre\": \"TIPO CERTIFICADO 2\", \"precio\": \"50.00\", \"created_at\": \"2026-04-03T19:47:44.000000Z\", \"updated_at\": \"2026-04-03T19:47:44.000000Z\", \"descripcion\": \"\", \"fecha_registro\": \"2026-04-03\"}', '{\"id\": 3, \"nombre\": \"TIPO CERTIFICADO 3\", \"precio\": \"50.00\", \"created_at\": \"2026-04-03T19:47:44.000000Z\", \"updated_at\": \"2026-04-03T19:48:02.000000Z\", \"descripcion\": \"\", \"fecha_registro\": \"2026-04-03\"}', 'SUCURSALES', '2026-04-03', '19:48:02', '2026-04-03 23:48:02', '2026-04-03 23:48:02'),
(9, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN PRODUCTO', '{\"id\": 2, \"nombre\": \"TIPO CERTIFCADO 2\", \"precio\": \"60.00\", \"created_at\": \"2026-04-03T19:47:30.000000Z\", \"updated_at\": \"2026-04-03T19:47:30.000000Z\", \"descripcion\": \"\", \"fecha_registro\": \"2026-04-03\"}', '{\"id\": 2, \"nombre\": \"TIPO CERTIFICADO 2\", \"precio\": \"60.00\", \"created_at\": \"2026-04-03T19:47:30.000000Z\", \"updated_at\": \"2026-04-03T19:48:06.000000Z\", \"descripcion\": \"\", \"fecha_registro\": \"2026-04-03\"}', 'SUCURSALES', '2026-04-03', '19:48:06', '2026-04-03 23:48:06', '2026-04-03 23:48:06'),
(10, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRODUCTO', '{\"ci\": \"123456\", \"id\": 1, \"cel\": \"67676767\", \"ci_exp\": \"LP\", \"nombre\": \"JUAN\", \"materno\": \"MAMANI\", \"paterno\": \"PEREZ\", \"fecha_nac\": \"2000-01-01\", \"created_at\": \"2026-04-03T20:14:52.000000Z\", \"updated_at\": \"2026-04-03T20:14:52.000000Z\", \"complemento\": \"CD\", \"fecha_registro\": \"2026-04-03\"}', NULL, 'SUCURSALES', '2026-04-03', '20:14:52', '2026-04-04 00:14:52', '2026-04-04 00:14:52'),
(11, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRODUCTO', '{\"ci\": \"123456\", \"id\": 2, \"cel\": null, \"ci_exp\": \"SC\", \"nombre\": \"EDUARDO\", \"materno\": \"\", \"paterno\": \"RAMIRES\", \"fecha_nac\": \"1999-01-01\", \"created_at\": \"2026-04-03T20:17:56.000000Z\", \"updated_at\": \"2026-04-03T20:17:56.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-03\"}', NULL, 'SUCURSALES', '2026-04-03', '20:17:56', '2026-04-04 00:17:56', '2026-04-04 00:17:56'),
(12, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRODUCTO', '{\"ci\": \"543433\", \"id\": 3, \"cel\": null, \"ci_exp\": \"CB\", \"nombre\": \"DANIELA\", \"materno\": \"QUISPE\", \"paterno\": \"QUISPE\", \"fecha_nac\": null, \"created_at\": \"2026-04-03T20:18:41.000000Z\", \"updated_at\": \"2026-04-03T20:18:41.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-03\"}', NULL, 'SUCURSALES', '2026-04-03', '20:18:41', '2026-04-04 00:18:41', '2026-04-04 00:18:41'),
(13, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRODUCTO', '{\"ci\": \"3453453\", \"id\": 4, \"cel\": null, \"ci_exp\": \"SC\", \"nombre\": \"MARCOS\", \"materno\": \"\", \"paterno\": \"CHOQUE\", \"fecha_nac\": null, \"created_at\": \"2026-04-03T22:29:13.000000Z\", \"updated_at\": \"2026-04-03T22:29:13.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-03\"}', NULL, 'SUCURSALES', '2026-04-03', '22:29:13', '2026-04-04 02:29:13', '2026-04-04 02:29:13'),
(14, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRODUCTO', '{\"ci\": \"1234567\", \"id\": 5, \"cel\": null, \"ci_exp\": \"LP\", \"nombre\": \"HERNAN\", \"materno\": \"\", \"paterno\": \"ROSALES\", \"fecha_nac\": null, \"created_at\": \"2026-04-03T22:38:04.000000Z\", \"updated_at\": \"2026-04-03T22:38:04.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-03\"}', NULL, 'SUCURSALES', '2026-04-03', '22:38:04', '2026-04-04 02:38:04', '2026-04-04 02:38:04'),
(15, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRODUCTO', '{\"ci\": \"435534\", \"id\": 6, \"cel\": \"756756756\", \"ci_exp\": \"LP\", \"nombre\": \"FRANZ\", \"materno\": \"\", \"paterno\": \"SALINAS\", \"fecha_nac\": \"2000-01-01\", \"created_at\": \"2026-04-03T22:40:45.000000Z\", \"updated_at\": \"2026-04-03T22:40:45.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-03\"}', NULL, 'SUCURSALES', '2026-04-03', '22:40:45', '2026-04-04 02:40:45', '2026-04-04 02:40:45'),
(16, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRODUCTO', '{\"ci\": \"567567567\", \"id\": 7, \"cel\": \"676767676\", \"ci_exp\": \"LP\", \"nombre\": \"LUIS\", \"materno\": \"MARTINEZ\", \"paterno\": \"CACERES\", \"fecha_nac\": \"1999-01-01\", \"created_at\": \"2026-04-03T22:42:12.000000Z\", \"updated_at\": \"2026-04-03T22:42:12.000000Z\", \"complemento\": \"ED\", \"fecha_registro\": \"2026-04-03\"}', NULL, 'SUCURSALES', '2026-04-03', '22:42:12', '2026-04-04 02:42:12', '2026-04-04 02:42:12'),
(17, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRODUCTO', '{\"ci\": \"7686786\", \"id\": 8, \"cel\": null, \"ci_exp\": \"CB\", \"nombre\": \"JAIME\", \"materno\": \"\", \"paterno\": \"ROSALES\", \"fecha_nac\": null, \"created_at\": \"2026-04-03T22:46:49.000000Z\", \"updated_at\": \"2026-04-03T22:46:49.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-03\"}', NULL, 'SUCURSALES', '2026-04-03', '22:46:49', '2026-04-04 02:46:49', '2026-04-04 02:46:49'),
(18, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN PRODUCTO', '{\"ci\": \"76867867\", \"id\": 9, \"cel\": null, \"ci_exp\": \"OR\", \"nombre\": \"ALEX\", \"materno\": \"SOLIZ\", \"paterno\": \"MAGALLANES\", \"fecha_nac\": null, \"created_at\": \"2026-04-03T22:47:29.000000Z\", \"updated_at\": \"2026-04-03T22:47:29.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-03\"}', NULL, 'SUCURSALES', '2026-04-03', '22:47:29', '2026-04-04 02:47:29', '2026-04-04 02:47:29'),
(19, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN CERTIFICADO', '{\"id\": 2, \"precio\": \"90.00\", \"user_id\": 2, \"archivo1\": \"archivo121775482238.docx\", \"archivo2\": \"archivo221775482238.docx\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"1\", \"created_at\": \"2026-04-06T13:30:38.000000Z\", \"updated_at\": \"2026-04-06T13:30:38.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"09:30:38\", \"fecha_registro\": \"2026-04-06\", \"tipo_certificado_id\": \"1\"}', NULL, 'CERTIFICADOS', '2026-04-06', '13:30:38', '2026-04-06 17:30:38', '2026-04-06 17:30:38'),
(20, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN CERTIFICADO', '{\"id\": 1, \"precio\": \"90.00\", \"user_id\": 2, \"archivo1\": \"archivo111775482303.docx\", \"archivo2\": \"archivo211775482303.docx\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"1\", \"created_at\": \"2026-04-06T13:31:43.000000Z\", \"updated_at\": \"2026-04-06T13:31:43.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"09:31:43\", \"fecha_registro\": \"2026-04-06\", \"tipo_certificado_id\": \"1\"}', NULL, 'CERTIFICADOS', '2026-04-06', '13:31:43', '2026-04-06 17:31:43', '2026-04-06 17:31:43'),
(21, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN CERTIFICADO', '{\"id\": 2, \"precio\": \"60.00\", \"user_id\": 2, \"tipo_pago\": \"QR\", \"cliente_id\": \"3\", \"created_at\": \"2026-04-06T13:40:25.000000Z\", \"updated_at\": \"2026-04-06T13:40:25.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"09:40:25\", \"fecha_registro\": \"2026-04-06\", \"tipo_certificado_id\": \"2\"}', NULL, 'CERTIFICADOS', '2026-04-06', '13:40:25', '2026-04-06 17:40:25', '2026-04-06 17:40:25'),
(22, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN CERTIFICADO', '{\"id\": 3, \"precio\": \"90.00\", \"user_id\": 2, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"4\", \"created_at\": \"2026-04-06T13:41:33.000000Z\", \"updated_at\": \"2026-04-06T13:41:33.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"09:41:33\", \"fecha_registro\": \"2026-04-06\", \"tipo_certificado_id\": \"1\"}', NULL, 'CERTIFICADOS', '2026-04-06', '13:41:33', '2026-04-06 17:41:33', '2026-04-06 17:41:33'),
(23, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN CERTIFICADO', '{\"id\": 4, \"precio\": \"90.00\", \"user_id\": 2, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"5\", \"created_at\": \"2026-04-06T13:41:49.000000Z\", \"updated_at\": \"2026-04-06T13:41:49.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"09:41:49\", \"fecha_registro\": \"2026-04-06\", \"tipo_certificado_id\": \"1\"}', NULL, 'CERTIFICADOS', '2026-04-06', '13:41:49', '2026-04-06 17:41:49', '2026-04-06 17:41:49'),
(24, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN CERTIFICADO', '{\"id\": 5, \"precio\": \"90.00\", \"user_id\": 2, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"6\", \"created_at\": \"2026-04-06T13:42:05.000000Z\", \"updated_at\": \"2026-04-06T13:42:05.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"09:42:05\", \"fecha_registro\": \"2026-04-06\", \"tipo_certificado_id\": \"1\"}', NULL, 'CERTIFICADOS', '2026-04-06', '13:42:05', '2026-04-06 17:42:05', '2026-04-06 17:42:05'),
(25, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN CERTIFICADO', '{\"id\": 6, \"precio\": \"90.00\", \"user_id\": 2, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"7\", \"created_at\": \"2026-04-06T13:42:20.000000Z\", \"updated_at\": \"2026-04-06T13:42:20.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"09:42:20\", \"fecha_registro\": \"2026-04-06\", \"tipo_certificado_id\": \"1\"}', NULL, 'CERTIFICADOS', '2026-04-06', '13:42:20', '2026-04-06 17:42:20', '2026-04-06 17:42:20'),
(26, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN CERTIFICADO', '{\"id\": 7, \"precio\": \"90.00\", \"user_id\": 2, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"8\", \"created_at\": \"2026-04-06T13:42:33.000000Z\", \"updated_at\": \"2026-04-06T13:42:33.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"09:42:33\", \"fecha_registro\": \"2026-04-06\", \"tipo_certificado_id\": \"1\"}', NULL, 'CERTIFICADOS', '2026-04-06', '13:42:33', '2026-04-06 17:42:33', '2026-04-06 17:42:33'),
(27, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN CERTIFICADO', '{\"id\": 8, \"precio\": \"90.00\", \"user_id\": 2, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"9\", \"created_at\": \"2026-04-06T13:42:46.000000Z\", \"updated_at\": \"2026-04-06T13:42:46.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"09:42:46\", \"fecha_registro\": \"2026-04-06\", \"tipo_certificado_id\": \"1\"}', NULL, 'CERTIFICADOS', '2026-04-06', '13:42:46', '2026-04-06 17:42:46', '2026-04-06 17:42:46'),
(28, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN CERTIFICADO', '{\"id\": 9, \"precio\": \"90.00\", \"user_id\": 2, \"tipo_pago\": \"QR\", \"cliente_id\": \"2\", \"created_at\": \"2026-04-06T13:43:10.000000Z\", \"updated_at\": \"2026-04-06T13:43:10.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"09:43:10\", \"fecha_registro\": \"2026-04-06\", \"tipo_certificado_id\": \"1\"}', NULL, 'CERTIFICADOS', '2026-04-06', '13:43:10', '2026-04-06 17:43:10', '2026-04-06 17:43:10'),
(29, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN PRODUCTO', '{\"ci\": \"6544565\", \"id\": 10, \"cel\": null, \"ci_exp\": \"LP\", \"nombre\": \"JORGE\", \"materno\": \"CORTEZ\", \"paterno\": \"ALVA\", \"fecha_nac\": null, \"created_at\": \"2026-04-06T13:43:35.000000Z\", \"updated_at\": \"2026-04-06T13:43:35.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-06\"}', NULL, 'SUCURSALES', '2026-04-06', '13:43:35', '2026-04-06 17:43:35', '2026-04-06 17:43:35'),
(30, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN CERTIFICADO', '{\"id\": 10, \"precio\": \"90.00\", \"user_id\": 2, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"10\", \"created_at\": \"2026-04-06T13:43:42.000000Z\", \"updated_at\": \"2026-04-06T13:43:42.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"09:43:42\", \"fecha_registro\": \"2026-04-06\", \"tipo_certificado_id\": \"1\"}', NULL, 'CERTIFICADOS', '2026-04-06', '13:43:42', '2026-04-06 17:43:42', '2026-04-06 17:43:42'),
(31, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN PRODUCTO', '{\"ci\": \"34534543\", \"id\": 11, \"cel\": null, \"ci_exp\": \"SC\", \"nombre\": \"FRANCO\", \"materno\": \"\", \"paterno\": \"GONZALES\", \"fecha_nac\": null, \"created_at\": \"2026-04-06T13:44:02.000000Z\", \"updated_at\": \"2026-04-06T13:44:02.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-06\"}', NULL, 'SUCURSALES', '2026-04-06', '13:44:02', '2026-04-06 17:44:02', '2026-04-06 17:44:02'),
(32, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN CERTIFICADO', '{\"id\": 11, \"precio\": \"0\", \"user_id\": 2, \"archivo1\": \"archivo1111775483063.docx\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"11\", \"created_at\": \"2026-04-06T13:44:23.000000Z\", \"updated_at\": \"2026-04-06T13:44:23.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"09:44:23\", \"fecha_registro\": \"2026-04-06\", \"tipo_certificado_id\": \"1\"}', NULL, 'CERTIFICADOS', '2026-04-06', '13:44:23', '2026-04-06 17:44:23', '2026-04-06 17:44:23'),
(33, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN PRODUCTO', '{\"ci\": \"45645645\", \"id\": 12, \"cel\": \"65756565\", \"ci_exp\": \"CB\", \"nombre\": \"ELVIS\", \"materno\": \"CHOQUE\", \"paterno\": \"CHOQUE\", \"fecha_nac\": \"2000-09-21\", \"created_at\": \"2026-04-06T13:44:50.000000Z\", \"updated_at\": \"2026-04-06T13:44:50.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-06\"}', NULL, 'SUCURSALES', '2026-04-06', '13:44:50', '2026-04-06 17:44:50', '2026-04-06 17:44:50'),
(34, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN CERTIFICADO', '{\"id\": 12, \"precio\": \"90.00\", \"user_id\": 2, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"12\", \"created_at\": \"2026-04-06T13:44:59.000000Z\", \"updated_at\": \"2026-04-06T13:44:59.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"09:44:59\", \"fecha_registro\": \"2026-04-06\", \"tipo_certificado_id\": \"1\"}', NULL, 'CERTIFICADOS', '2026-04-06', '13:44:59', '2026-04-06 17:44:59', '2026-04-06 17:44:59'),
(35, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN PRODUCTO', '{\"ci\": \"53535345\", \"id\": 13, \"cel\": null, \"ci_exp\": \"CB\", \"nombre\": \"SANDRA\", \"materno\": \"\", \"paterno\": \"MARTINEZ\", \"fecha_nac\": null, \"created_at\": \"2026-04-06T13:45:13.000000Z\", \"updated_at\": \"2026-04-06T13:45:13.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-06\"}', NULL, 'SUCURSALES', '2026-04-06', '13:45:14', '2026-04-06 17:45:14', '2026-04-06 17:45:14'),
(36, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN CERTIFICADO', '{\"id\": 13, \"precio\": \"90.00\", \"user_id\": 2, \"tipo_pago\": \"QR\", \"cliente_id\": \"13\", \"created_at\": \"2026-04-06T13:45:18.000000Z\", \"updated_at\": \"2026-04-06T13:45:18.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"09:45:18\", \"fecha_registro\": \"2026-04-06\", \"tipo_certificado_id\": \"1\"}', NULL, 'CERTIFICADOS', '2026-04-06', '13:45:18', '2026-04-06 17:45:18', '2026-04-06 17:45:18'),
(37, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN PRODUCTO', '{\"ci\": \"4353454\", \"id\": 14, \"cel\": null, \"ci_exp\": \"LP\", \"nombre\": \"CARLOS\", \"materno\": \"\", \"paterno\": \"CONTRERAS\", \"fecha_nac\": null, \"created_at\": \"2026-04-06T13:45:34.000000Z\", \"updated_at\": \"2026-04-06T13:45:34.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-06\"}', NULL, 'SUCURSALES', '2026-04-06', '13:45:34', '2026-04-06 17:45:34', '2026-04-06 17:45:34'),
(38, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN CERTIFICADO', '{\"id\": 14, \"precio\": \"90.00\", \"user_id\": 2, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"14\", \"created_at\": \"2026-04-06T13:45:38.000000Z\", \"updated_at\": \"2026-04-06T13:45:38.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"09:45:38\", \"fecha_registro\": \"2026-04-06\", \"tipo_certificado_id\": \"1\"}', NULL, 'CERTIFICADOS', '2026-04-06', '13:45:38', '2026-04-06 17:45:38', '2026-04-06 17:45:38'),
(39, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN PRODUCTO', '{\"ci\": \"45335345\", \"id\": 15, \"cel\": null, \"ci_exp\": \"LP\", \"nombre\": \"SANDRA\", \"materno\": \"\", \"paterno\": \"MARCEL\", \"fecha_nac\": null, \"created_at\": \"2026-04-06T13:45:51.000000Z\", \"updated_at\": \"2026-04-06T13:45:51.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-06\"}', NULL, 'SUCURSALES', '2026-04-06', '13:45:51', '2026-04-06 17:45:51', '2026-04-06 17:45:51'),
(40, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN CERTIFICADO', '{\"id\": 15, \"precio\": \"90.00\", \"user_id\": 2, \"tipo_pago\": \"QR\", \"cliente_id\": \"15\", \"created_at\": \"2026-04-06T13:45:58.000000Z\", \"updated_at\": \"2026-04-06T13:45:58.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"09:45:58\", \"fecha_registro\": \"2026-04-06\", \"tipo_certificado_id\": \"1\"}', NULL, 'CERTIFICADOS', '2026-04-06', '13:45:58', '2026-04-06 17:45:58', '2026-04-06 17:45:58'),
(41, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN PRODUCTO', '{\"ci\": \"5345345\", \"id\": 16, \"cel\": null, \"ci_exp\": \"LP\", \"nombre\": \"CESAR\", \"materno\": \"\", \"paterno\": \"VILLANUEVA\", \"fecha_nac\": null, \"created_at\": \"2026-04-06T13:46:16.000000Z\", \"updated_at\": \"2026-04-06T13:46:16.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-06\"}', NULL, 'SUCURSALES', '2026-04-06', '13:46:16', '2026-04-06 17:46:16', '2026-04-06 17:46:16'),
(42, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN CERTIFICADO', '{\"id\": 16, \"precio\": \"90.00\", \"user_id\": 2, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"16\", \"created_at\": \"2026-04-06T13:46:21.000000Z\", \"updated_at\": \"2026-04-06T13:46:21.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"09:46:21\", \"fecha_registro\": \"2026-04-06\", \"tipo_certificado_id\": \"1\"}', NULL, 'CERTIFICADOS', '2026-04-06', '13:46:21', '2026-04-06 17:46:21', '2026-04-06 17:46:21'),
(43, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN PRODUCTO', '{\"ci\": \"54646456\", \"id\": 17, \"cel\": null, \"ci_exp\": \"LP\", \"nombre\": \"CRISTIAN\", \"materno\": \"\", \"paterno\": \"CORTEZ\", \"fecha_nac\": null, \"created_at\": \"2026-04-06T13:46:36.000000Z\", \"updated_at\": \"2026-04-06T13:46:36.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-06\"}', NULL, 'SUCURSALES', '2026-04-06', '13:46:36', '2026-04-06 17:46:36', '2026-04-06 17:46:36'),
(44, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN CERTIFICADO', '{\"id\": 17, \"precio\": \"90.00\", \"user_id\": 2, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"17\", \"created_at\": \"2026-04-06T13:46:40.000000Z\", \"updated_at\": \"2026-04-06T13:46:40.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"09:46:40\", \"fecha_registro\": \"2026-04-06\", \"tipo_certificado_id\": \"1\"}', NULL, 'CERTIFICADOS', '2026-04-06', '13:46:40', '2026-04-06 17:46:40', '2026-04-06 17:46:40'),
(45, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN PRODUCTO', '{\"ci\": \"5464645\", \"id\": 18, \"cel\": null, \"ci_exp\": \"CB\", \"nombre\": \"JUAN\", \"materno\": \"\", \"paterno\": \"CARVAJAL\", \"fecha_nac\": null, \"created_at\": \"2026-04-06T13:46:50.000000Z\", \"updated_at\": \"2026-04-06T13:46:50.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-06\"}', NULL, 'SUCURSALES', '2026-04-06', '13:46:50', '2026-04-06 17:46:50', '2026-04-06 17:46:50'),
(46, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN CERTIFICADO', '{\"id\": 18, \"precio\": \"90.00\", \"user_id\": 2, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"18\", \"created_at\": \"2026-04-06T13:46:54.000000Z\", \"updated_at\": \"2026-04-06T13:46:54.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"09:46:54\", \"fecha_registro\": \"2026-04-06\", \"tipo_certificado_id\": \"1\"}', NULL, 'CERTIFICADOS', '2026-04-06', '13:46:54', '2026-04-06 17:46:54', '2026-04-06 17:46:54'),
(47, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN PRODUCTO', '{\"ci\": \"34534544\", \"id\": 19, \"cel\": null, \"ci_exp\": \"CB\", \"nombre\": \"GRACIELA\", \"materno\": \"\", \"paterno\": \"CONDORI\", \"fecha_nac\": null, \"created_at\": \"2026-04-06T13:47:06.000000Z\", \"updated_at\": \"2026-04-06T13:47:06.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-06\"}', NULL, 'SUCURSALES', '2026-04-06', '13:47:06', '2026-04-06 17:47:06', '2026-04-06 17:47:06'),
(48, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN CERTIFICADO', '{\"id\": 19, \"precio\": \"90.00\", \"user_id\": 2, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"19\", \"created_at\": \"2026-04-06T13:47:10.000000Z\", \"updated_at\": \"2026-04-06T13:47:10.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"09:47:10\", \"fecha_registro\": \"2026-04-06\", \"tipo_certificado_id\": \"1\"}', NULL, 'CERTIFICADOS', '2026-04-06', '13:47:10', '2026-04-06 17:47:10', '2026-04-06 17:47:10'),
(49, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN PRODUCTO', '{\"ci\": \"34534534\", \"id\": 20, \"cel\": null, \"ci_exp\": \"SC\", \"nombre\": \"JORGE LUIS\", \"materno\": \"\", \"paterno\": \"GARNICA\", \"fecha_nac\": null, \"created_at\": \"2026-04-06T13:47:30.000000Z\", \"updated_at\": \"2026-04-06T13:47:30.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-06\"}', NULL, 'SUCURSALES', '2026-04-06', '13:47:30', '2026-04-06 17:47:30', '2026-04-06 17:47:30'),
(50, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN CERTIFICADO', '{\"id\": 20, \"precio\": \"90.00\", \"user_id\": 2, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"20\", \"created_at\": \"2026-04-06T13:47:35.000000Z\", \"updated_at\": \"2026-04-06T13:47:35.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"09:47:35\", \"fecha_registro\": \"2026-04-06\", \"tipo_certificado_id\": \"1\"}', NULL, 'CERTIFICADOS', '2026-04-06', '13:47:35', '2026-04-06 17:47:35', '2026-04-06 17:47:35'),
(51, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN PRODUCTO', '{\"ci\": \"4564565\", \"id\": 21, \"cel\": null, \"ci_exp\": \"SC\", \"nombre\": \"FELIX\", \"materno\": \"\", \"paterno\": \"CARVAJAL\", \"fecha_nac\": null, \"created_at\": \"2026-04-06T13:47:48.000000Z\", \"updated_at\": \"2026-04-06T13:47:48.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-06\"}', NULL, 'SUCURSALES', '2026-04-06', '13:47:48', '2026-04-06 17:47:48', '2026-04-06 17:47:48'),
(52, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN CERTIFICADO', '{\"id\": 21, \"precio\": \"0\", \"user_id\": 2, \"tipo_pago\": \"QR\", \"cliente_id\": \"21\", \"created_at\": \"2026-04-06T13:47:59.000000Z\", \"updated_at\": \"2026-04-06T13:47:59.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"09:47:59\", \"fecha_registro\": \"2026-04-06\", \"tipo_certificado_id\": \"1\"}', NULL, 'CERTIFICADOS', '2026-04-06', '13:47:59', '2026-04-06 17:47:59', '2026-04-06 17:47:59'),
(53, 4, 'CREACIÓN', 'EL USUARIO GMARTINEZ REGISTRO UN PRODUCTO', '{\"ci\": \"465645645\", \"id\": 22, \"cel\": null, \"ci_exp\": \"CB\", \"nombre\": \"FRANCO\", \"materno\": \"\", \"paterno\": \"VALVIDIESO\", \"fecha_nac\": null, \"created_at\": \"2026-04-06T14:22:27.000000Z\", \"updated_at\": \"2026-04-06T14:22:27.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-06\"}', NULL, 'SUCURSALES', '2026-04-06', '14:22:27', '2026-04-06 18:22:27', '2026-04-06 18:22:27'),
(54, 4, 'CREACIÓN', 'EL USUARIO GMARTINEZ REGISTRO UN CERTIFICADO', '{\"id\": 22, \"precio\": \"90.00\", \"user_id\": 4, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"22\", \"created_at\": \"2026-04-06T14:22:33.000000Z\", \"updated_at\": \"2026-04-06T14:22:33.000000Z\", \"sucursal_id\": \"2\", \"hora_registro\": \"10:22:33\", \"fecha_registro\": \"2026-04-06\", \"tipo_certificado_id\": \"1\"}', NULL, 'CERTIFICADOS', '2026-04-06', '14:22:33', '2026-04-06 18:22:33', '2026-04-06 18:22:33'),
(55, 4, 'CREACIÓN', 'EL USUARIO GMARTINEZ REGISTRO UN PRODUCTO', '{\"ci\": \"46545443\", \"id\": 23, \"cel\": null, \"ci_exp\": \"CB\", \"nombre\": \"FRANZ\", \"materno\": \"\", \"paterno\": \"SALINAS\", \"fecha_nac\": null, \"created_at\": \"2026-04-07T13:31:11.000000Z\", \"updated_at\": \"2026-04-07T13:31:11.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-07\"}', NULL, 'SUCURSALES', '2026-04-07', '13:31:11', '2026-04-07 17:31:11', '2026-04-07 17:31:11'),
(56, 4, 'CREACIÓN', 'EL USUARIO GMARTINEZ REGISTRO UN CERTIFICADO', '{\"id\": 23, \"precio\": \"90.00\", \"user_id\": 4, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"23\", \"created_at\": \"2026-04-07T13:31:16.000000Z\", \"updated_at\": \"2026-04-07T13:31:16.000000Z\", \"sucursal_id\": \"2\", \"hora_registro\": \"09:31:16\", \"fecha_registro\": \"2026-04-07\", \"tipo_certificado_id\": \"1\"}', NULL, 'CERTIFICADOS', '2026-04-07', '13:31:16', '2026-04-07 17:31:16', '2026-04-07 17:31:16'),
(57, 5, 'ELIMINACIÓN', 'EL USUARIO SMARTINEZ ELIMINÓ UN CERTIFICADO', '{\"id\": 23, \"precio\": \"90.00\", \"status\": 1, \"user_id\": 4, \"archivo1\": null, \"archivo2\": null, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": 23, \"created_at\": \"2026-04-07T13:31:16.000000Z\", \"updated_at\": \"2026-04-07T13:31:16.000000Z\", \"sucursal_id\": 2, \"hora_registro\": \"09:31:16\", \"fecha_registro\": \"2026-04-07\", \"tipo_certificado_id\": 1}', '{\"id\": 23, \"precio\": \"90.00\", \"status\": 0, \"user_id\": 4, \"archivo1\": null, \"archivo2\": null, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": 23, \"created_at\": \"2026-04-07T13:31:16.000000Z\", \"updated_at\": \"2026-04-07T13:31:55.000000Z\", \"sucursal_id\": 2, \"hora_registro\": \"09:31:16\", \"fecha_registro\": \"2026-04-07\", \"tipo_certificado_id\": 1}', 'CERTIFICADOS', '2026-04-07', '13:31:55', '2026-04-07 17:31:55', '2026-04-07 17:31:55');

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

--
-- Volcado de datos para la tabla `login_users`
--

INSERT INTO `login_users` (`id`, `user_id`, `sucursal_id`, `fecha`, `hora`, `created_at`, `updated_at`) VALUES
(1, 2, 1, '2026-04-06', '08:57:24', '2026-04-06 16:57:24', '2026-04-06 16:57:24'),
(2, 4, 2, '2026-04-06', '10:22:10', '2026-04-06 18:22:10', '2026-04-06 18:22:10'),
(3, 2, 1, '2026-04-07', '08:37:04', '2026-04-07 16:37:04', '2026-04-07 16:37:04'),
(4, 4, 2, '2026-04-07', '09:30:43', '2026-04-07 17:30:43', '2026-04-07 17:30:43');

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
(4, '2026_04_02_203426_create_sucursals_table', 2),
(5, '2026_04_02_203435_create_clientes_table', 2),
(6, '2026_04_02_203441_create_tipo_certificados_table', 2),
(7, '2026_04_02_203448_create_certificados_table', 2),
(8, '2026_04_02_203452_create_certificado_emitidos_table', 2),
(9, '2026_04_03_195001_create_login_users_table', 3);

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
(2, 'SUCURSAL 2', '', '2026-04-03', '2026-04-03 23:28:14', '2026-04-03 23:28:14');

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
(1, 'TIPO CERTIFICADO 1', 90.00, 'DESC TIPO 1', '2026-04-03', '2026-04-03 23:45:20', '2026-04-03 23:45:20'),
(2, 'TIPO CERTIFICADO 2', 60.00, '', '2026-04-03', '2026-04-03 23:47:30', '2026-04-03 23:48:06'),
(3, 'TIPO CERTIFICADO 3', 50.00, '', '2026-04-03', '2026-04-03 23:47:44', '2026-04-03 23:48:02');

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
  `fecha_registro` date NOT NULL,
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `users`
--

INSERT INTO `users` (`id`, `usuario`, `nombre`, `paterno`, `materno`, `ci`, `ci_exp`, `dir`, `correo`, `fono`, `password`, `acceso`, `tipo`, `foto`, `fecha_registro`, `status`, `created_at`, `updated_at`) VALUES
(1, 'admin', 'admin', 'admin', '', '0', '', '', '', '', '$2y$12$65d4fgZsvBV5Lc/AxNKh4eoUdbGyaczQ4sSco20feSQANshNLuxSC', 1, 'ADMINISTRADOR', NULL, '2025-10-01', 1, '2026-02-17 22:21:27', '2026-02-17 22:21:27'),
(2, 'JPERES', 'JUAN', 'PERES', 'MAMANI', '123456', 'LP', 'LOS PEDREGALES', 'juan@gmail.com', '67676767', '$2y$12$XBzFSGL5NsnnoM4EBz3uduveQcrStDx6BtrdGxXSmeNEY0VnqdTte', 1, 'MÉDICO', '21775258381.jpg', '2026-04-03', 1, '2026-04-04 03:19:41', '2026-04-04 03:22:40'),
(3, 'MGONZALES', 'MARIA', 'GONZALES', '', '1234567', 'LP', '', NULL, '6767676', '$2y$12$okLv9H49WTpjRipKuglJO.iS4QPMl62lvwhtbJGG/EtQ5aJaLJ3bi', 1, 'SECRETARIA', '31775258613.jpg', '2026-04-03', 1, '2026-04-04 03:23:20', '2026-04-04 03:23:55'),
(4, 'GMARTINEZ', 'GEOVANA', 'MARTINEZ', 'MARTINEZ', '32234234', 'CB', '', NULL, '67676767', '$2y$12$hqaROKdsJFiFWcbuTXm7tugbl1s3LR6Rt3hA4JZ2JTdr/dJGIa0Ou', 1, 'MÉDICO', '41775258996.jpg', '2026-04-03', 1, '2026-04-04 03:29:56', '2026-04-04 03:29:56'),
(5, 'SMARTINEZ', 'SANDRA', 'MARTINEZ', '', '56445645', 'LP', '', NULL, '67676767', '$2y$12$BOrmYu5SAJSSdxrpToSux.PR4DRFWiN6YMFsvBUDmyJBUTO52cFQi', 1, 'GERENTE', NULL, '2026-04-07', 1, '2026-04-07 17:27:08', '2026-04-07 17:27:08');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `certificados`
--
ALTER TABLE `certificados`
  ADD PRIMARY KEY (`id`),
  ADD KEY `certificados_cliente_id_foreign` (`cliente_id`),
  ADD KEY `certificados_tipo_certificado_id_foreign` (`tipo_certificado_id`),
  ADD KEY `certificados_user_id_foreign` (`user_id`),
  ADD KEY `certificados_sucursal_id_foreign` (`sucursal_id`);

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de la tabla `certificado_emitidos`
--
ALTER TABLE `certificado_emitidos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT de la tabla `configuracions`
--
ALTER TABLE `configuracions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `historial_accions`
--
ALTER TABLE `historial_accions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=58;

--
-- AUTO_INCREMENT de la tabla `login_users`
--
ALTER TABLE `login_users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

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
  ADD CONSTRAINT `certificados_tipo_certificado_id_foreign` FOREIGN KEY (`tipo_certificado_id`) REFERENCES `tipo_certificados` (`id`),
  ADD CONSTRAINT `certificados_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

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
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
