-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 21-04-2026 a las 01:11:36
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
  `user_id` bigint UNSIGNED DEFAULT NULL,
  `sucursal_id` bigint UNSIGNED NOT NULL,
  `tipo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'NORMAL',
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

INSERT INTO `certificados` (`id`, `cliente_id`, `total`, `cancelado`, `saldo`, `tipo_pago`, `user_id`, `sucursal_id`, `tipo`, `tramitador_id`, `fecha_inicio`, `hora_inicio`, `fecha_fin`, `hora_fin`, `fecha_registro`, `hora_registro`, `estado`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 50.00, 50.00, 0.00, 'EFECTIVO', 3, 1, 'NORMAL', NULL, '2026-04-20', '17:28:43', '2026-04-20', '17:29:09', '2026-04-20', '17:28:35', 1, 1, '2026-04-20 21:28:35', '2026-04-20 21:31:01'),
(2, 2, 50.00, 50.00, 0.00, 'QR', 1, 1, 'NORMAL', NULL, '2026-04-20', '17:31:36', '2026-04-20', '17:31:42', '2026-04-20', '17:31:36', 1, 1, '2026-04-20 21:31:36', '2026-04-20 21:31:42'),
(3, 3, 50.00, 50.00, 0.00, 'EFECTIVO', 3, 1, 'TRAMITE', 1, '2026-04-20', '17:44:53', '2026-04-20', '17:45:11', '2026-04-20', '17:44:38', 1, 1, '2026-04-20 21:44:38', '2026-04-20 21:45:11'),
(4, 4, 50.00, 50.00, 0.00, 'EFECTIVO', 4, 2, 'NORMAL', NULL, '2026-04-20', '17:55:32', '2026-04-20', '17:55:44', '2026-04-20', '17:55:32', 1, 1, '2026-04-20 21:55:32', '2026-04-20 21:55:44'),
(5, 5, 50.00, 50.00, 0.00, 'EFECTIVO', 4, 2, 'NORMAL', NULL, '2026-04-20', '18:00:36', '2026-04-20', '18:00:45', '2026-04-20', '18:00:36', 1, 1, '2026-04-20 22:00:36', '2026-04-20 22:00:45'),
(6, 5, 50.00, 50.00, 0.00, 'EFECTIVO', 3, 1, 'NORMAL', NULL, '2026-04-20', '21:05:00', '2026-04-20', '21:05:13', '2026-04-20', '21:04:18', 1, 1, '2026-04-21 01:04:18', '2026-04-21 01:05:13'),
(7, 6, 50.00, 50.00, 0.00, 'QR', 3, 1, 'NORMAL', NULL, '2026-04-20', '21:06:46', '2026-04-20', '21:06:57', '2026-04-20', '21:06:36', 1, 1, '2026-04-21 01:06:36', '2026-04-21 01:06:57'),
(8, 7, 50.00, 50.00, 0.00, 'EFECTIVO', 3, 1, 'TRAMITE', 1, '2026-04-20', '21:07:54', '2026-04-20', '21:08:03', '2026-04-20', '21:07:54', 1, 1, '2026-04-21 01:07:54', '2026-04-21 01:08:26');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `certificado_detalles`
--

CREATE TABLE `certificado_detalles` (
  `id` bigint UNSIGNED NOT NULL,
  `certificado_id` bigint UNSIGNED NOT NULL,
  `categoria` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `precio` decimal(24,2) NOT NULL,
  `cancelado` decimal(24,2) DEFAULT NULL,
  `saldo` decimal(24,2) DEFAULT NULL,
  `tipo_certificado_id` bigint UNSIGNED NOT NULL,
  `archivo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `certificado_detalles`
--

INSERT INTO `certificado_detalles` (`id`, `certificado_id`, `categoria`, `precio`, `cancelado`, `saldo`, `tipo_certificado_id`, `archivo`, `created_at`, `updated_at`) VALUES
(1, 1, 'A', 50.00, 50.00, 0.00, 1, '011776720549.docx', '2026-04-20 21:28:35', '2026-04-20 21:31:01'),
(2, 2, 'A', 50.00, 50.00, 0.00, 1, '021776720702.docx', '2026-04-20 21:31:36', '2026-04-20 21:31:42'),
(3, 3, 'B', 50.00, 50.00, 0.00, 1, '031776721511.docx', '2026-04-20 21:44:38', '2026-04-20 21:53:18'),
(4, 4, 'A', 50.00, 50.00, 0.00, 1, '041776722144.docx', '2026-04-20 21:55:32', '2026-04-20 21:55:44'),
(5, 5, 'C', 50.00, 50.00, 0.00, 1, '051776722445.docx', '2026-04-20 22:00:36', '2026-04-20 22:00:45'),
(6, 6, 'B', 50.00, 50.00, 0.00, 1, '061776733513.docx', '2026-04-21 01:04:18', '2026-04-21 01:05:13'),
(7, 7, 'B', 50.00, 50.00, 0.00, 1, '071776733617.docx', '2026-04-21 01:06:36', '2026-04-21 01:06:57'),
(8, 8, 'C', 50.00, 50.00, 0.00, 1, '081776733683.docx', '2026-04-21 01:07:54', '2026-04-21 01:08:26');

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
(1, '2026-04-20', 3, 1, 5, '2026-04-20 21:29:09', '2026-04-21 01:08:03'),
(2, '2026-04-20', 1, 1, 1, '2026-04-20 21:31:42', '2026-04-20 21:31:42'),
(3, '2026-04-20', 4, 1, 2, '2026-04-20 21:55:44', '2026-04-20 22:00:45');

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
(1, 'JOSUE', 'AGUIRRE', '', '67676767', 'LP', '', '2001-01-01', 25, NULL, '2026-04-20', 1, '2026-04-20 21:28:35', '2026-04-20 21:28:35'),
(2, 'FRANCISCA', 'GONZALES', '', '56564564', 'LP', '', '2001-01-01', 25, NULL, '2026-04-20', 1, '2026-04-20 21:31:36', '2026-04-20 21:31:36'),
(3, 'JORGE', 'CASTRO', '', '54645645', 'LP', '', '2000-01-01', 26, NULL, '2026-04-20', 1, '2026-04-20 21:44:38', '2026-04-20 21:44:38'),
(4, 'ALBERTO', 'MARTINEZ', 'GONZALES', '56446454', 'LP', '', '2000-01-01', 26, NULL, '2026-04-20', 1, '2026-04-20 21:55:32', '2026-04-20 21:55:32'),
(5, 'JIMENA', 'ROMERO', '', '656546', 'LP', '', '1999-11-01', 26, NULL, '2026-04-20', 1, '2026-04-20 22:00:36', '2026-04-20 22:00:36'),
(6, 'FELIX', 'CONTRERAS', '', '34535344', 'CB', '', '2000-01-01', 26, NULL, '2026-04-20', 1, '2026-04-21 01:06:36', '2026-04-21 01:06:36'),
(7, 'CARLOS', 'GONZALES', '', '56756756', 'LP', '', '1999-03-03', 27, NULL, '2026-04-20', 1, '2026-04-21 01:07:54', '2026-04-21 01:07:54');

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
(1, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN USUARIO', '{\"ci\": \"123456\", \"id\": 2, \"dir\": \"\", \"fono\": \"676767676\", \"tipo\": \"SECRETARIA\", \"acceso\": \"1\", \"ci_exp\": \"LP\", \"correo\": null, \"nombre\": \"MARIA\", \"materno\": \"\", \"paterno\": \"GONZALES\", \"usuario\": \"MGONZALES\", \"created_at\": \"2026-04-20T21:26:27.000000Z\", \"updated_at\": \"2026-04-20T21:26:27.000000Z\", \"sucursal_id\": \"1\", \"fecha_registro\": \"2026-04-20\"}', NULL, 'USUARIOS', '2026-04-20', '17:26:27', '2026-04-20 21:26:28', '2026-04-20 21:26:28'),
(2, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN USUARIO', '{\"ci\": \"56565656\", \"id\": 3, \"dir\": \"\", \"fono\": \"78787878\", \"tipo\": \"MÉDICO\", \"acceso\": \"1\", \"ci_exp\": \"LP\", \"correo\": null, \"nombre\": \"JUAN\", \"materno\": \"\", \"paterno\": \"PERES\", \"usuario\": \"JPERES\", \"created_at\": \"2026-04-20T21:26:42.000000Z\", \"updated_at\": \"2026-04-20T21:26:42.000000Z\", \"sucursal_id\": \"1\", \"fecha_registro\": \"2026-04-20\"}', NULL, 'USUARIOS', '2026-04-20', '17:26:42', '2026-04-20 21:26:42', '2026-04-20 21:26:42'),
(3, 2, 'CREACIÓN', 'EL USUARIO MGONZALES INICIO UN CERTIFICADO', '{\"id\": 1, \"tipo\": \"NORMAL\", \"saldo\": \"50\", \"total\": \"50\", \"estado\": 0, \"user_id\": null, \"cancelado\": \"0\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": 1, \"created_at\": \"2026-04-20T21:28:35.000000Z\", \"updated_at\": \"2026-04-20T21:28:35.000000Z\", \"sucursal_id\": 1, \"hora_registro\": \"17:28:35\", \"tramitador_id\": null, \"fecha_registro\": \"2026-04-20\", \"certificado_detalles\": [{\"id\": 1, \"name\": null, \"saldo\": \"50.00\", \"precio\": \"50.00\", \"archivo\": null, \"cancelado\": \"0.00\", \"categoria\": \"\", \"con_saldo\": false, \"created_at\": \"2026-04-20T21:28:35.000000Z\", \"updated_at\": \"2026-04-20T21:28:35.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados\", \"certificado_id\": 1, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-20', '17:28:35', '2026-04-20 21:28:35', '2026-04-20 21:28:35'),
(4, 2, 'CREACIÓN', 'EL USUARIO MGONZALES REGISTRO UN CLIENTE', '{\"ci\": \"67676767\", \"id\": 1, \"cel\": null, \"edad\": \"25\", \"ci_exp\": \"LP\", \"nombre\": \"JOSUE\", \"materno\": \"\", \"paterno\": \"AGUIRRE\", \"fecha_nac\": \"2001-01-01\", \"created_at\": \"2026-04-20T21:28:35.000000Z\", \"updated_at\": \"2026-04-20T21:28:35.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-20\"}', NULL, 'CLIENTES', '2026-04-20', '17:28:35', '2026-04-20 21:28:35', '2026-04-20 21:28:35'),
(5, 3, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN CERTIFICADO', '{\"id\": 1, \"tipo\": \"NORMAL\", \"saldo\": \"50.00\", \"total\": \"50.00\", \"estado\": 1, \"status\": 1, \"user_id\": 3, \"hora_fin\": \"17:29:09\", \"cancelado\": \"0.00\", \"fecha_fin\": \"2026-04-20\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"1\", \"created_at\": \"2026-04-20T21:28:35.000000Z\", \"updated_at\": \"2026-04-20T21:29:09.000000Z\", \"hora_inicio\": \"17:28:43\", \"sucursal_id\": 1, \"fecha_inicio\": \"2026-04-20\", \"hora_registro\": \"17:28:35\", \"tramitador_id\": null, \"fecha_registro\": \"2026-04-20\", \"certificado_detalles\": [{\"id\": 1, \"name\": \"011776720549.docx\", \"saldo\": \"50.00\", \"precio\": \"50.00\", \"archivo\": \"011776720549.docx\", \"cancelado\": \"0.00\", \"categoria\": \"A\", \"con_saldo\": false, \"created_at\": \"2026-04-20T21:28:35.000000Z\", \"updated_at\": \"2026-04-20T21:29:09.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/011776720549.docx\", \"certificado_id\": 1, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-20', '17:29:09', '2026-04-20 21:29:09', '2026-04-20 21:29:09'),
(6, 2, 'CREACIÓN', 'EL USUARIO MGONZALES REGISTRO EL PAGO DE UN CERTIFICADO', '{\"id\": 1, \"hora\": \"17:31:01\", \"fecha\": \"2026-04-20\", \"monto\": \"50.00\", \"modulo\": \"CertificadoDetalle\", \"user_id\": 2, \"medico_id\": 3, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": 1, \"created_at\": \"2026-04-20T21:31:01.000000Z\", \"updated_at\": \"2026-04-20T21:31:01.000000Z\", \"verificado\": 1, \"descripcion\": \"PAGO POR CERTIFICADO\", \"registro_id\": 1, \"sucursal_id\": 1, \"hora_verificado\": \"17:31:01\", \"fecha_verificado\": \"2026-04-20\"}', NULL, 'PAGOS', '2026-04-20', '17:31:01', '2026-04-20 21:31:01', '2026-04-20 21:31:01'),
(7, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO EL PAGO DE UN CERTIFICADO', '{\"id\": 2, \"hora\": \"17:31:36\", \"fecha\": \"2026-04-20\", \"monto\": \"50.00\", \"modulo\": \"CertificadoDetalle\", \"user_id\": 1, \"medico_id\": null, \"tipo_pago\": \"QR\", \"cliente_id\": 2, \"created_at\": \"2026-04-20T21:31:36.000000Z\", \"updated_at\": \"2026-04-20T21:31:36.000000Z\", \"verificado\": 0, \"descripcion\": \"PAGO POR CERTIFICADO\", \"registro_id\": 2, \"sucursal_id\": 1, \"hora_verificado\": null, \"fecha_verificado\": null}', NULL, 'PAGOS', '2026-04-20', '17:31:36', '2026-04-20 21:31:36', '2026-04-20 21:31:36'),
(8, 1, 'CREACIÓN', 'EL USUARIO admin INICIO UN CERTIFICADO', '{\"id\": 2, \"tipo\": \"NORMAL\", \"saldo\": \"0.00\", \"total\": 50, \"estado\": 0, \"user_id\": null, \"cancelado\": \"50.00\", \"tipo_pago\": \"QR\", \"cliente_id\": 2, \"created_at\": \"2026-04-20T21:31:36.000000Z\", \"updated_at\": \"2026-04-20T21:31:36.000000Z\", \"sucursal_id\": 1, \"hora_registro\": \"17:31:36\", \"tramitador_id\": null, \"fecha_registro\": \"2026-04-20\", \"certificado_detalles\": [{\"id\": 2, \"name\": null, \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": null, \"cancelado\": \"50.00\", \"categoria\": \"\", \"con_saldo\": true, \"created_at\": \"2026-04-20T21:31:36.000000Z\", \"updated_at\": \"2026-04-20T21:31:36.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados\", \"certificado_id\": 2, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-20', '17:31:36', '2026-04-20 21:31:36', '2026-04-20 21:31:36'),
(9, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": \"56564564\", \"id\": 2, \"cel\": null, \"edad\": 25, \"ci_exp\": \"LP\", \"nombre\": \"FRANCISCA\", \"materno\": \"\", \"paterno\": \"GONZALES\", \"fecha_nac\": \"2001-01-01\", \"created_at\": \"2026-04-20T21:31:36.000000Z\", \"updated_at\": \"2026-04-20T21:31:36.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-20\"}', NULL, 'CLIENTES', '2026-04-20', '17:31:36', '2026-04-20 21:31:36', '2026-04-20 21:31:36'),
(10, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CERTIFICADO', '{\"id\": 2, \"tipo\": \"NORMAL\", \"saldo\": \"0.00\", \"total\": \"50.00\", \"estado\": 1, \"status\": 1, \"user_id\": 1, \"hora_fin\": \"17:31:42\", \"cancelado\": \"50.00\", \"fecha_fin\": \"2026-04-20\", \"tipo_pago\": \"QR\", \"cliente_id\": \"2\", \"created_at\": \"2026-04-20T21:31:36.000000Z\", \"updated_at\": \"2026-04-20T21:31:42.000000Z\", \"hora_inicio\": \"17:31:36\", \"sucursal_id\": 1, \"fecha_inicio\": \"2026-04-20\", \"hora_registro\": \"17:31:36\", \"tramitador_id\": null, \"fecha_registro\": \"2026-04-20\", \"certificado_detalles\": [{\"id\": 2, \"name\": \"021776720702.docx\", \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": \"021776720702.docx\", \"cancelado\": \"50.00\", \"categoria\": \"A\", \"con_saldo\": true, \"created_at\": \"2026-04-20T21:31:36.000000Z\", \"updated_at\": \"2026-04-20T21:31:42.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/021776720702.docx\", \"certificado_id\": 2, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-20', '17:31:42', '2026-04-20 21:31:42', '2026-04-20 21:31:42'),
(11, 2, 'CREACIÓN', 'EL USUARIO MGONZALES REGISTRO UN TRAMITADOR', '{\"ci\": \"GONZALES\", \"id\": 1, \"cel\": \"67676767\", \"ci_exp\": \"LP\", \"nombre\": \"EDUARDO\", \"created_at\": \"2026-04-20T21:44:07.000000Z\", \"updated_at\": \"2026-04-20T21:44:07.000000Z\", \"fecha_registro\": \"2026-04-20\"}', NULL, 'TRAMITADORES', '2026-04-20', '17:44:07', '2026-04-20 21:44:07', '2026-04-20 21:44:07'),
(12, 2, 'CREACIÓN', 'EL USUARIO MGONZALES REGISTRO EL PAGO DE UN CERTIFICADO', '{\"id\": 3, \"hora\": \"17:44:38\", \"fecha\": \"2026-04-20\", \"monto\": \"50.00\", \"modulo\": \"CertificadoDetalle\", \"user_id\": 2, \"medico_id\": null, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": 3, \"created_at\": \"2026-04-20T21:44:38.000000Z\", \"updated_at\": \"2026-04-20T21:44:38.000000Z\", \"verificado\": 1, \"descripcion\": \"PAGO POR CERTIFICADO\", \"registro_id\": 3, \"sucursal_id\": 1, \"hora_verificado\": \"17:44:38\", \"fecha_verificado\": \"2026-04-20\"}', NULL, 'PAGOS', '2026-04-20', '17:44:38', '2026-04-20 21:44:38', '2026-04-20 21:44:38'),
(13, 2, 'CREACIÓN', 'EL USUARIO MGONZALES INICIO UN CERTIFICADO', '{\"id\": 3, \"tipo\": \"TRAMITE\", \"saldo\": \"0.00\", \"total\": \"50\", \"estado\": 0, \"user_id\": null, \"cancelado\": \"50.00\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": 3, \"created_at\": \"2026-04-20T21:44:38.000000Z\", \"updated_at\": \"2026-04-20T21:44:38.000000Z\", \"sucursal_id\": 1, \"hora_registro\": \"17:44:38\", \"tramitador_id\": \"1\", \"fecha_registro\": \"2026-04-20\", \"certificado_detalles\": [{\"id\": 3, \"name\": null, \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": null, \"cancelado\": \"50.00\", \"categoria\": \"\", \"con_saldo\": true, \"created_at\": \"2026-04-20T21:44:38.000000Z\", \"updated_at\": \"2026-04-20T21:44:38.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados\", \"certificado_id\": 3, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-20', '17:44:38', '2026-04-20 21:44:38', '2026-04-20 21:44:38'),
(14, 2, 'CREACIÓN', 'EL USUARIO MGONZALES REGISTRO UN CLIENTE', '{\"ci\": \"54645645\", \"id\": 3, \"cel\": null, \"edad\": \"26\", \"ci_exp\": \"LP\", \"nombre\": \"JORGE\", \"materno\": \"\", \"paterno\": \"CASTRO\", \"fecha_nac\": \"2000-01-01\", \"created_at\": \"2026-04-20T21:44:38.000000Z\", \"updated_at\": \"2026-04-20T21:44:38.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-20\"}', NULL, 'CLIENTES', '2026-04-20', '17:44:38', '2026-04-20 21:44:38', '2026-04-20 21:44:38'),
(15, 3, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN CERTIFICADO', '{\"id\": 3, \"tipo\": \"TRAMITE\", \"saldo\": \"0.00\", \"total\": \"50.00\", \"estado\": 1, \"status\": 1, \"user_id\": 3, \"hora_fin\": \"17:45:11\", \"cancelado\": \"50.00\", \"fecha_fin\": \"2026-04-20\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"3\", \"created_at\": \"2026-04-20T21:44:38.000000Z\", \"updated_at\": \"2026-04-20T21:45:11.000000Z\", \"hora_inicio\": \"17:44:53\", \"sucursal_id\": 1, \"fecha_inicio\": \"2026-04-20\", \"hora_registro\": \"17:44:38\", \"tramitador_id\": 1, \"fecha_registro\": \"2026-04-20\", \"certificado_detalles\": [{\"id\": 3, \"name\": \"031776721511.docx\", \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": \"031776721511.docx\", \"cancelado\": \"50.00\", \"categoria\": \"A\", \"con_saldo\": true, \"created_at\": \"2026-04-20T21:44:38.000000Z\", \"updated_at\": \"2026-04-20T21:45:11.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/031776721511.docx\", \"certificado_id\": 3, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-20', '17:45:11', '2026-04-20 21:45:11', '2026-04-20 21:45:11'),
(16, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN USUARIO', '{\"ci\": \"2342341\", \"id\": 4, \"dir\": \"\", \"fono\": \"67676767\", \"tipo\": \"MÉDICO\", \"acceso\": \"1\", \"ci_exp\": \"CB\", \"correo\": null, \"nombre\": \"MARIANA\", \"materno\": \"\", \"paterno\": \"TORREZ\", \"usuario\": \"MTORREZ\", \"created_at\": \"2026-04-20T21:54:13.000000Z\", \"updated_at\": \"2026-04-20T21:54:13.000000Z\", \"sucursal_id\": \"2\", \"fecha_registro\": \"2026-04-20\"}', NULL, 'USUARIOS', '2026-04-20', '17:54:13', '2026-04-20 21:54:13', '2026-04-20 21:54:13'),
(17, 4, 'CREACIÓN', 'EL USUARIO MTORREZ REGISTRO EL PAGO DE UN CERTIFICADO', '{\"id\": 4, \"hora\": \"17:55:32\", \"fecha\": \"2026-04-20\", \"monto\": \"50.00\", \"modulo\": \"CertificadoDetalle\", \"user_id\": 4, \"medico_id\": null, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": 4, \"created_at\": \"2026-04-20T21:55:32.000000Z\", \"updated_at\": \"2026-04-20T21:55:32.000000Z\", \"verificado\": 0, \"descripcion\": \"PAGO POR CERTIFICADO\", \"registro_id\": 4, \"sucursal_id\": 2, \"hora_verificado\": null, \"fecha_verificado\": null}', NULL, 'PAGOS', '2026-04-20', '17:55:32', '2026-04-20 21:55:32', '2026-04-20 21:55:32'),
(18, 4, 'CREACIÓN', 'EL USUARIO MTORREZ INICIO UN CERTIFICADO', '{\"id\": 4, \"tipo\": \"NORMAL\", \"saldo\": \"0.00\", \"total\": 50, \"estado\": 0, \"user_id\": null, \"cancelado\": \"50.00\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": 4, \"created_at\": \"2026-04-20T21:55:32.000000Z\", \"updated_at\": \"2026-04-20T21:55:32.000000Z\", \"sucursal_id\": 2, \"hora_registro\": \"17:55:32\", \"tramitador_id\": null, \"fecha_registro\": \"2026-04-20\", \"certificado_detalles\": [{\"id\": 4, \"name\": null, \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": null, \"cancelado\": \"50.00\", \"categoria\": \"\", \"con_saldo\": true, \"created_at\": \"2026-04-20T21:55:32.000000Z\", \"updated_at\": \"2026-04-20T21:55:32.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados\", \"certificado_id\": 4, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-20', '17:55:32', '2026-04-20 21:55:32', '2026-04-20 21:55:32'),
(19, 4, 'CREACIÓN', 'EL USUARIO MTORREZ REGISTRO UN CLIENTE', '{\"ci\": \"56446454\", \"id\": 4, \"cel\": null, \"edad\": 26, \"ci_exp\": \"LP\", \"nombre\": \"ALBERTO\", \"materno\": \"GONZALES\", \"paterno\": \"MARTINEZ\", \"fecha_nac\": \"2000-01-01\", \"created_at\": \"2026-04-20T21:55:32.000000Z\", \"updated_at\": \"2026-04-20T21:55:32.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-20\"}', NULL, 'CLIENTES', '2026-04-20', '17:55:32', '2026-04-20 21:55:32', '2026-04-20 21:55:32'),
(20, 4, 'CREACIÓN', 'EL USUARIO MTORREZ REGISTRO UN CERTIFICADO', '{\"id\": 4, \"tipo\": \"NORMAL\", \"saldo\": \"0.00\", \"total\": \"50.00\", \"estado\": 1, \"status\": 1, \"user_id\": 4, \"hora_fin\": \"17:55:44\", \"cancelado\": \"50.00\", \"fecha_fin\": \"2026-04-20\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"4\", \"created_at\": \"2026-04-20T21:55:32.000000Z\", \"updated_at\": \"2026-04-20T21:55:44.000000Z\", \"hora_inicio\": \"17:55:32\", \"sucursal_id\": 2, \"fecha_inicio\": \"2026-04-20\", \"hora_registro\": \"17:55:32\", \"tramitador_id\": null, \"fecha_registro\": \"2026-04-20\", \"certificado_detalles\": [{\"id\": 4, \"name\": \"041776722144.docx\", \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": \"041776722144.docx\", \"cancelado\": \"50.00\", \"categoria\": \"A\", \"con_saldo\": true, \"created_at\": \"2026-04-20T21:55:32.000000Z\", \"updated_at\": \"2026-04-20T21:55:44.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/041776722144.docx\", \"certificado_id\": 4, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-20', '17:55:44', '2026-04-20 21:55:44', '2026-04-20 21:55:44'),
(21, 4, 'CREACIÓN', 'EL USUARIO MTORREZ REGISTRO EL PAGO DE UN CERTIFICADO', '{\"id\": 5, \"hora\": \"18:00:36\", \"fecha\": \"2026-04-20\", \"monto\": \"50.00\", \"modulo\": \"CertificadoDetalle\", \"user_id\": 4, \"medico_id\": null, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": 5, \"created_at\": \"2026-04-20T22:00:36.000000Z\", \"updated_at\": \"2026-04-20T22:00:36.000000Z\", \"verificado\": 1, \"descripcion\": \"PAGO POR CERTIFICADO\", \"registro_id\": 5, \"sucursal_id\": 2, \"hora_verificado\": \"18:00:36\", \"fecha_verificado\": \"2026-04-20\"}', NULL, 'PAGOS', '2026-04-20', '18:00:36', '2026-04-20 22:00:36', '2026-04-20 22:00:36'),
(22, 4, 'CREACIÓN', 'EL USUARIO MTORREZ INICIO UN CERTIFICADO', '{\"id\": 5, \"tipo\": \"NORMAL\", \"saldo\": \"0.00\", \"total\": 50, \"estado\": 0, \"user_id\": null, \"cancelado\": \"50.00\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": 5, \"created_at\": \"2026-04-20T22:00:36.000000Z\", \"updated_at\": \"2026-04-20T22:00:36.000000Z\", \"sucursal_id\": 2, \"hora_registro\": \"18:00:36\", \"tramitador_id\": null, \"fecha_registro\": \"2026-04-20\", \"certificado_detalles\": [{\"id\": 5, \"name\": null, \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": null, \"cancelado\": \"50.00\", \"categoria\": \"\", \"con_saldo\": true, \"created_at\": \"2026-04-20T22:00:36.000000Z\", \"updated_at\": \"2026-04-20T22:00:36.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados\", \"certificado_id\": 5, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-20', '18:00:36', '2026-04-20 22:00:36', '2026-04-20 22:00:36'),
(23, 4, 'CREACIÓN', 'EL USUARIO MTORREZ REGISTRO UN CLIENTE', '{\"ci\": \"656546\", \"id\": 5, \"cel\": null, \"edad\": 26, \"ci_exp\": \"LP\", \"nombre\": \"JIMENA\", \"materno\": \"\", \"paterno\": \"ROMERO\", \"fecha_nac\": \"1999-11-01\", \"created_at\": \"2026-04-20T22:00:36.000000Z\", \"updated_at\": \"2026-04-20T22:00:36.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-20\"}', NULL, 'CLIENTES', '2026-04-20', '18:00:36', '2026-04-20 22:00:36', '2026-04-20 22:00:36'),
(24, 4, 'CREACIÓN', 'EL USUARIO MTORREZ REGISTRO UN CERTIFICADO', '{\"id\": 5, \"tipo\": \"NORMAL\", \"saldo\": \"0.00\", \"total\": \"50.00\", \"estado\": 1, \"status\": 1, \"user_id\": 4, \"hora_fin\": \"18:00:45\", \"cancelado\": \"50.00\", \"fecha_fin\": \"2026-04-20\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"5\", \"created_at\": \"2026-04-20T22:00:36.000000Z\", \"updated_at\": \"2026-04-20T22:00:45.000000Z\", \"hora_inicio\": \"18:00:36\", \"sucursal_id\": 2, \"fecha_inicio\": \"2026-04-20\", \"hora_registro\": \"18:00:36\", \"tramitador_id\": null, \"fecha_registro\": \"2026-04-20\", \"certificado_detalles\": [{\"id\": 5, \"name\": \"051776722445.docx\", \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": \"051776722445.docx\", \"cancelado\": \"50.00\", \"categoria\": \"C\", \"con_saldo\": true, \"created_at\": \"2026-04-20T22:00:36.000000Z\", \"updated_at\": \"2026-04-20T22:00:45.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/051776722445.docx\", \"certificado_id\": 5, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-20', '18:00:45', '2026-04-20 22:00:45', '2026-04-20 22:00:45'),
(25, 2, 'CREACIÓN', 'EL USUARIO MGONZALES REGISTRO EL PAGO DE UN CERTIFICADO', '{\"id\": 6, \"hora\": \"21:04:18\", \"fecha\": \"2026-04-20\", \"monto\": \"50.00\", \"modulo\": \"CertificadoDetalle\", \"user_id\": 2, \"medico_id\": null, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": 5, \"created_at\": \"2026-04-21T01:04:18.000000Z\", \"updated_at\": \"2026-04-21T01:04:18.000000Z\", \"verificado\": 1, \"descripcion\": \"PAGO POR CERTIFICADO\", \"registro_id\": 6, \"sucursal_id\": 1, \"hora_verificado\": \"21:04:18\", \"fecha_verificado\": \"2026-04-20\"}', NULL, 'PAGOS', '2026-04-20', '21:04:18', '2026-04-21 01:04:18', '2026-04-21 01:04:18'),
(26, 2, 'CREACIÓN', 'EL USUARIO MGONZALES INICIO UN CERTIFICADO', '{\"id\": 6, \"tipo\": \"NORMAL\", \"saldo\": \"0.00\", \"total\": \"50.00\", \"estado\": 0, \"user_id\": null, \"cancelado\": \"50.00\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": 5, \"created_at\": \"2026-04-21T01:04:18.000000Z\", \"updated_at\": \"2026-04-21T01:04:18.000000Z\", \"sucursal_id\": 1, \"hora_registro\": \"21:04:18\", \"tramitador_id\": null, \"fecha_registro\": \"2026-04-20\", \"certificado_detalles\": [{\"id\": 6, \"name\": null, \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": null, \"cancelado\": \"50.00\", \"categoria\": \"\", \"con_saldo\": true, \"created_at\": \"2026-04-21T01:04:18.000000Z\", \"updated_at\": \"2026-04-21T01:04:18.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados\", \"certificado_id\": 6, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-20', '21:04:18', '2026-04-21 01:04:18', '2026-04-21 01:04:18'),
(27, 3, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN CERTIFICADO', '{\"id\": 6, \"tipo\": \"NORMAL\", \"saldo\": \"0.00\", \"total\": \"50.00\", \"estado\": 1, \"status\": 1, \"user_id\": 3, \"hora_fin\": \"21:05:13\", \"cancelado\": \"50.00\", \"fecha_fin\": \"2026-04-20\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"5\", \"created_at\": \"2026-04-21T01:04:18.000000Z\", \"updated_at\": \"2026-04-21T01:05:13.000000Z\", \"hora_inicio\": \"21:05:00\", \"sucursal_id\": 1, \"fecha_inicio\": \"2026-04-20\", \"hora_registro\": \"21:04:18\", \"tramitador_id\": null, \"fecha_registro\": \"2026-04-20\", \"certificado_detalles\": [{\"id\": 6, \"name\": \"061776733513.docx\", \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": \"061776733513.docx\", \"cancelado\": \"50.00\", \"categoria\": \"B\", \"con_saldo\": true, \"created_at\": \"2026-04-21T01:04:18.000000Z\", \"updated_at\": \"2026-04-21T01:05:13.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/061776733513.docx\", \"certificado_id\": 6, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-20', '21:05:13', '2026-04-21 01:05:13', '2026-04-21 01:05:13'),
(28, 2, 'CREACIÓN', 'EL USUARIO MGONZALES REGISTRO EL PAGO DE UN CERTIFICADO', '{\"id\": 7, \"hora\": \"21:06:36\", \"fecha\": \"2026-04-20\", \"monto\": \"50.00\", \"modulo\": \"CertificadoDetalle\", \"user_id\": 2, \"medico_id\": null, \"tipo_pago\": \"QR\", \"cliente_id\": 6, \"created_at\": \"2026-04-21T01:06:36.000000Z\", \"updated_at\": \"2026-04-21T01:06:36.000000Z\", \"verificado\": 1, \"descripcion\": \"PAGO POR CERTIFICADO\", \"registro_id\": 7, \"sucursal_id\": 1, \"hora_verificado\": \"21:06:36\", \"fecha_verificado\": \"2026-04-20\"}', NULL, 'PAGOS', '2026-04-20', '21:06:36', '2026-04-21 01:06:36', '2026-04-21 01:06:36'),
(29, 2, 'CREACIÓN', 'EL USUARIO MGONZALES INICIO UN CERTIFICADO', '{\"id\": 7, \"tipo\": \"NORMAL\", \"saldo\": \"0.00\", \"total\": \"50.00\", \"estado\": 0, \"user_id\": null, \"cancelado\": \"50.00\", \"tipo_pago\": \"QR\", \"cliente_id\": 6, \"created_at\": \"2026-04-21T01:06:36.000000Z\", \"updated_at\": \"2026-04-21T01:06:36.000000Z\", \"sucursal_id\": 1, \"hora_registro\": \"21:06:36\", \"tramitador_id\": null, \"fecha_registro\": \"2026-04-20\", \"certificado_detalles\": [{\"id\": 7, \"name\": null, \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": null, \"cancelado\": \"50.00\", \"categoria\": \"\", \"con_saldo\": true, \"created_at\": \"2026-04-21T01:06:36.000000Z\", \"updated_at\": \"2026-04-21T01:06:36.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados\", \"certificado_id\": 7, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-20', '21:06:36', '2026-04-21 01:06:36', '2026-04-21 01:06:36'),
(30, 2, 'CREACIÓN', 'EL USUARIO MGONZALES REGISTRO UN CLIENTE', '{\"ci\": \"34535344\", \"id\": 6, \"cel\": null, \"edad\": \"26\", \"ci_exp\": \"CB\", \"nombre\": \"FELIX\", \"materno\": \"\", \"paterno\": \"CONTRERAS\", \"fecha_nac\": \"2000-01-01\", \"created_at\": \"2026-04-21T01:06:36.000000Z\", \"updated_at\": \"2026-04-21T01:06:36.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-20\"}', NULL, 'CLIENTES', '2026-04-20', '21:06:36', '2026-04-21 01:06:36', '2026-04-21 01:06:36'),
(31, 3, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN CERTIFICADO', '{\"id\": 7, \"tipo\": \"NORMAL\", \"saldo\": \"0.00\", \"total\": \"50.00\", \"estado\": 1, \"status\": 1, \"user_id\": 3, \"hora_fin\": \"21:06:57\", \"cancelado\": \"50.00\", \"fecha_fin\": \"2026-04-20\", \"tipo_pago\": \"QR\", \"cliente_id\": \"6\", \"created_at\": \"2026-04-21T01:06:36.000000Z\", \"updated_at\": \"2026-04-21T01:06:57.000000Z\", \"hora_inicio\": \"21:06:46\", \"sucursal_id\": 1, \"fecha_inicio\": \"2026-04-20\", \"hora_registro\": \"21:06:36\", \"tramitador_id\": null, \"fecha_registro\": \"2026-04-20\", \"certificado_detalles\": [{\"id\": 7, \"name\": \"071776733617.docx\", \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": \"071776733617.docx\", \"cancelado\": \"50.00\", \"categoria\": \"B\", \"con_saldo\": true, \"created_at\": \"2026-04-21T01:06:36.000000Z\", \"updated_at\": \"2026-04-21T01:06:57.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/071776733617.docx\", \"certificado_id\": 7, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-20', '21:06:57', '2026-04-21 01:06:57', '2026-04-21 01:06:57'),
(32, 3, 'CREACIÓN', 'EL USUARIO JPERES INICIO UN CERTIFICADO', '{\"id\": 8, \"tipo\": \"TRAMITE\", \"saldo\": \"50.00\", \"total\": \"50.00\", \"estado\": 0, \"user_id\": null, \"cancelado\": \"0.00\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": 7, \"created_at\": \"2026-04-21T01:07:54.000000Z\", \"updated_at\": \"2026-04-21T01:07:54.000000Z\", \"sucursal_id\": 1, \"hora_registro\": \"21:07:54\", \"tramitador_id\": 1, \"fecha_registro\": \"2026-04-20\", \"certificado_detalles\": [{\"id\": 8, \"name\": null, \"saldo\": \"50.00\", \"precio\": \"50.00\", \"archivo\": null, \"cancelado\": \"0.00\", \"categoria\": \"\", \"con_saldo\": false, \"created_at\": \"2026-04-21T01:07:54.000000Z\", \"updated_at\": \"2026-04-21T01:07:54.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados\", \"certificado_id\": 8, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-20', '21:07:54', '2026-04-21 01:07:54', '2026-04-21 01:07:54'),
(33, 3, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN CLIENTE', '{\"ci\": \"56756756\", \"id\": 7, \"cel\": null, \"edad\": 27, \"ci_exp\": \"LP\", \"nombre\": \"CARLOS\", \"materno\": \"\", \"paterno\": \"GONZALES\", \"fecha_nac\": \"1999-03-03\", \"created_at\": \"2026-04-21T01:07:54.000000Z\", \"updated_at\": \"2026-04-21T01:07:54.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-20\"}', NULL, 'CLIENTES', '2026-04-20', '21:07:54', '2026-04-21 01:07:54', '2026-04-21 01:07:54'),
(34, 3, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN CERTIFICADO', '{\"id\": 8, \"tipo\": \"TRAMITE\", \"saldo\": \"50.00\", \"total\": \"50.00\", \"estado\": 1, \"status\": 1, \"user_id\": 3, \"hora_fin\": \"21:08:03\", \"cancelado\": \"0.00\", \"fecha_fin\": \"2026-04-20\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"7\", \"created_at\": \"2026-04-21T01:07:54.000000Z\", \"updated_at\": \"2026-04-21T01:08:03.000000Z\", \"hora_inicio\": \"21:07:54\", \"sucursal_id\": 1, \"fecha_inicio\": \"2026-04-20\", \"hora_registro\": \"21:07:54\", \"tramitador_id\": 1, \"fecha_registro\": \"2026-04-20\", \"certificado_detalles\": [{\"id\": 8, \"name\": \"081776733683.docx\", \"saldo\": \"50.00\", \"precio\": \"50.00\", \"archivo\": \"081776733683.docx\", \"cancelado\": \"0.00\", \"categoria\": \"C\", \"con_saldo\": false, \"created_at\": \"2026-04-21T01:07:54.000000Z\", \"updated_at\": \"2026-04-21T01:08:03.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/081776733683.docx\", \"certificado_id\": 8, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-20', '21:08:03', '2026-04-21 01:08:03', '2026-04-21 01:08:03'),
(35, 2, 'CREACIÓN', 'EL USUARIO MGONZALES REGISTRO EL PAGO DE UN CERTIFICADO', '{\"id\": 8, \"hora\": \"21:08:26\", \"fecha\": \"2026-04-20\", \"monto\": \"50.00\", \"modulo\": \"CertificadoDetalle\", \"user_id\": 2, \"medico_id\": 3, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": 7, \"created_at\": \"2026-04-21T01:08:26.000000Z\", \"updated_at\": \"2026-04-21T01:08:26.000000Z\", \"verificado\": 1, \"descripcion\": \"PAGO POR CERTIFICADO\", \"registro_id\": 8, \"sucursal_id\": 1, \"hora_verificado\": \"21:08:26\", \"fecha_verificado\": \"2026-04-20\"}', NULL, 'PAGOS', '2026-04-20', '21:08:26', '2026-04-21 01:08:26', '2026-04-21 01:08:26');

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
(1, 1, 1, '2026-04-20', '17:25:58', '2026-04-20 21:25:58', '2026-04-20 21:25:58'),
(2, 3, 1, '2026-04-20', '17:27:19', '2026-04-20 21:27:19', '2026-04-20 21:27:19'),
(3, 2, 1, '2026-04-20', '17:28:01', '2026-04-20 21:28:01', '2026-04-20 21:28:01'),
(4, 4, 2, '2026-04-20', '17:54:29', '2026-04-20 21:54:29', '2026-04-20 21:54:29');

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
(14, '2026_04_12_111900_create_tramite_clientes_table', 6),
(15, '2026_04_13_161152_create_certificado_pagos_table', 7);

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pagos`
--

CREATE TABLE `pagos` (
  `id` bigint UNSIGNED NOT NULL,
  `registro_id` bigint UNSIGNED NOT NULL,
  `modulo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `monto` decimal(24,2) NOT NULL,
  `tipo_pago` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` varchar(900) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
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
(1, 1, 'CertificadoDetalle', 50.00, 'EFECTIVO', 'PAGO POR CERTIFICADO', '2026-04-20', '17:31:01', 1, 2, 3, 1, 1, '2026-04-20', '17:31:01', 1, '2026-04-20 21:31:01', '2026-04-20 21:31:01'),
(2, 2, 'CertificadoDetalle', 50.00, 'QR', 'PAGO POR CERTIFICADO', '2026-04-20', '17:31:36', 2, 2, 1, 1, 1, '2026-04-20', '17:42:45', 1, '2026-04-20 21:31:36', '2026-04-20 21:42:45'),
(3, 3, 'CertificadoDetalle', 50.00, 'EFECTIVO', 'PAGO POR CERTIFICADO', '2026-04-20', '17:44:38', 3, 2, 3, 1, 1, '2026-04-20', '17:44:38', 1, '2026-04-20 21:44:38', '2026-04-20 21:45:11'),
(4, 4, 'CertificadoDetalle', 50.00, 'EFECTIVO', 'PAGO POR CERTIFICADO', '2026-04-20', '17:55:32', 4, 4, 4, 2, 1, '2026-04-20', '17:55:42', 1, '2026-04-20 21:55:32', '2026-04-20 21:55:44'),
(5, 5, 'CertificadoDetalle', 50.00, 'EFECTIVO', 'PAGO POR CERTIFICADO', '2026-04-20', '18:00:36', 5, 4, 4, 2, 1, '2026-04-20', '18:00:36', 1, '2026-04-20 22:00:36', '2026-04-20 22:00:45'),
(6, 6, 'CertificadoDetalle', 50.00, 'EFECTIVO', 'PAGO POR CERTIFICADO', '2026-04-20', '21:04:18', 5, 2, 3, 1, 1, '2026-04-20', '21:04:18', 1, '2026-04-21 01:04:18', '2026-04-21 01:05:13'),
(7, 7, 'CertificadoDetalle', 50.00, 'QR', 'PAGO POR CERTIFICADO', '2026-04-20', '21:06:36', 6, 2, 3, 1, 1, '2026-04-20', '21:06:36', 1, '2026-04-21 01:06:36', '2026-04-21 01:06:57'),
(8, 8, 'CertificadoDetalle', 50.00, 'EFECTIVO', 'PAGO POR CERTIFICADO', '2026-04-20', '21:08:26', 7, 2, 3, 1, 1, '2026-04-20', '21:08:26', 1, '2026-04-21 01:08:26', '2026-04-21 01:08:26');

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
  `nombre` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ci` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `ci_exp` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `cel` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `fecha_registro` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `tramitadors`
--

INSERT INTO `tramitadors` (`id`, `nombre`, `ci`, `ci_exp`, `cel`, `fecha_registro`, `created_at`, `updated_at`) VALUES
(1, 'EDUARDO', 'GONZALES', 'LP', '67676767', '2026-04-20', '2026-04-20 21:44:07', '2026-04-20 21:44:07');

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
(2, 'MGONZALES', 'MARIA', 'GONZALES', '', '123456', 'LP', '', NULL, '676767676', '$2y$12$O1HDJS2mAu4QMb9M2ullZue.bXo3zqMdeoj2Mn8cvPqnffSPMg7fy', 1, 'SECRETARIA', NULL, 1, '2026-04-20', 1, '2026-04-20 21:26:27', '2026-04-20 21:26:27'),
(3, 'JPERES', 'JUAN', 'PERES', '', '56565656', 'LP', '', NULL, '78787878', '$2y$12$wpbR0y4c0JILKd61wf0OsOaddyaw7.lD5sFOKuPXBSdHekitTMbn2', 1, 'MÉDICO', NULL, 1, '2026-04-20', 1, '2026-04-20 21:26:42', '2026-04-20 21:26:42'),
(4, 'MTORREZ', 'MARIANA', 'TORREZ', '', '2342341', 'CB', '', NULL, '67676767', '$2y$12$SFRPtRmgomOFK0WK74besOnc40pF26LnbvYd3oN9U.4G6Dn.aYzhm', 1, 'MÉDICO', NULL, 2, '2026-04-20', 1, '2026-04-20 21:54:13', '2026-04-20 21:54:13');

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
  ADD KEY `certificados_tramitador_id` (`tramitador_id`);

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `certificado_detalles`
--
ALTER TABLE `certificado_detalles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `certificado_emitidos`
--
ALTER TABLE `certificado_emitidos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT de la tabla `configuracions`
--
ALTER TABLE `configuracions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `historial_accions`
--
ALTER TABLE `historial_accions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT de la tabla `login_users`
--
ALTER TABLE `login_users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `pagos`
--
ALTER TABLE `pagos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `certificados`
--
ALTER TABLE `certificados`
  ADD CONSTRAINT `certificados_cliente_id_foreign` FOREIGN KEY (`cliente_id`) REFERENCES `clientes` (`id`),
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
