-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 19-04-2026 a las 15:29:09
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
  `tipo` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'NORMAL',
  `tramitador_id` bigint UNSIGNED DEFAULT NULL,
  `fecha_inicio` date DEFAULT NULL,
  `hora_inicio` time DEFAULT NULL,
  `fecha_fin` date DEFAULT NULL,
  `hora_fin` time DEFAULT NULL,
  `fecha_registro` date DEFAULT NULL,
  `hora_registro` time DEFAULT NULL,
  `estado` int NOT NULL DEFAULT '1',
  `status` int NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `certificados`
--

INSERT INTO `certificados` (`id`, `cliente_id`, `total`, `cancelado`, `saldo`, `tipo_pago`, `user_id`, `sucursal_id`, `tipo`, `tramitador_id`, `fecha_inicio`, `hora_inicio`, `fecha_fin`, `hora_fin`, `fecha_registro`, `hora_registro`, `estado`, `status`, `created_at`, `updated_at`) VALUES
(1, 1, 110.00, 110.00, 0.00, 'EFECTIVO', 1, 1, 'NORMAL', NULL, NULL, NULL, NULL, NULL, '2026-04-11', '20:22:08', 1, 1, '2026-04-12 00:22:08', '2026-04-12 00:22:08'),
(2, 3, 30.00, 30.00, 0.00, 'EFECTIVO', 1, 1, 'TRAMITE', NULL, NULL, NULL, NULL, NULL, '2026-04-13', '10:49:32', 1, 1, '2026-04-13 14:49:32', '2026-04-13 14:49:32'),
(3, 9, 30.00, 30.00, 0.00, 'QR', 1, 1, 'TRAMITE', NULL, NULL, NULL, NULL, NULL, '2026-04-13', '10:50:23', 1, 1, '2026-04-13 14:50:23', '2026-04-13 14:50:23'),
(4, 8, 50.00, 50.00, 0.00, 'EFECTIVO', 1, 1, 'TRAMITE', NULL, NULL, NULL, NULL, NULL, '2026-04-13', '10:51:40', 1, 1, '2026-04-13 14:51:40', '2026-04-13 14:51:40'),
(5, 11, 30.00, 30.00, 0.00, 'EFECTIVO', 1, 1, 'TRAMITE', NULL, NULL, NULL, NULL, NULL, '2026-04-13', '10:52:23', 1, 1, '2026-04-13 14:52:23', '2026-04-13 14:52:23'),
(6, 10, 30.00, 30.00, 0.00, 'EFECTIVO', 1, 1, 'TRAMITE', NULL, NULL, NULL, NULL, NULL, '2026-04-13', '14:49:00', 1, 1, '2026-04-13 18:49:00', '2026-04-13 20:51:01'),
(7, 1, 30.00, 30.00, 0.00, 'EFECTIVO', 1, 1, 'NORMAL', NULL, NULL, NULL, NULL, NULL, '2026-04-13', '15:07:25', 1, 1, '2026-04-13 19:07:25', '2026-04-13 20:50:48'),
(8, 12, 30.00, 30.00, 0.00, 'EFECTIVO', 1, 1, 'TRAMITE', NULL, NULL, NULL, NULL, NULL, '2026-04-13', '15:37:00', 1, 1, '2026-04-13 19:37:00', '2026-04-13 20:49:41'),
(9, 13, 60.00, 30.00, 0.00, 'EFECTIVO', 1, 1, 'TRAMITE', NULL, NULL, NULL, NULL, NULL, '2026-04-13', '15:44:32', 1, 1, '2026-04-13 19:44:32', '2026-04-13 20:48:57'),
(10, 14, 30.00, 0.00, 0.00, 'QR', 1, 1, 'TRAMITE', NULL, NULL, NULL, NULL, NULL, '2026-04-13', '15:46:53', 1, 1, '2026-04-13 19:46:53', '2026-04-13 20:48:44'),
(19, 15, 50.00, 50.00, 0.00, 'EFECTIVO', 1, 1, 'TRAMITE', NULL, NULL, NULL, NULL, NULL, '2026-04-14', '14:21:27', 1, 1, '2026-04-14 18:21:27', '2026-04-14 18:21:27'),
(20, 17, 110.00, 0.00, 0.00, 'EFECTIVO', 1, 1, 'NORMAL', NULL, NULL, NULL, NULL, NULL, '2026-04-14', '14:23:02', 1, 1, '2026-04-14 18:23:02', '2026-04-14 18:23:02'),
(21, 18, 50.00, 0.00, 0.00, 'QR', 1, 1, 'NORMAL', NULL, NULL, NULL, NULL, NULL, '2026-04-14', '14:26:27', 1, 1, '2026-04-14 18:26:27', '2026-04-14 18:26:27'),
(22, 19, 50.00, 0.00, 0.00, 'EFECTIVO', 1, 1, 'NORMAL', NULL, NULL, NULL, NULL, NULL, '2026-04-14', '14:28:13', 1, 1, '2026-04-14 18:28:13', '2026-04-14 18:28:13'),
(23, 20, 50.00, 0.00, 0.00, 'EFECTIVO', 1, 1, 'NORMAL', NULL, NULL, NULL, NULL, NULL, '2026-04-14', '14:29:19', 1, 1, '2026-04-14 18:29:19', '2026-04-14 18:29:19'),
(24, 21, 50.00, 50.00, 0.00, 'EFECTIVO', 1, 1, 'NORMAL', NULL, NULL, NULL, NULL, NULL, '2026-04-14', '14:30:21', 1, 1, '2026-04-14 18:30:21', '2026-04-14 18:30:21'),
(25, 1, 50.00, 50.00, 0.00, 'EFECTIVO', 1, 1, 'NORMAL', NULL, NULL, NULL, NULL, NULL, '2026-04-14', '14:31:15', 1, 1, '2026-04-14 18:31:15', '2026-04-14 18:31:15'),
(26, 22, 50.00, 50.00, 0.00, 'EFECTIVO', 1, 1, 'NORMAL', NULL, NULL, NULL, NULL, NULL, '2026-04-14', '14:32:16', 1, 1, '2026-04-14 18:32:16', '2026-04-14 18:32:16'),
(27, 6, 50.00, 50.00, 0.00, 'EFECTIVO', 1, 1, 'NORMAL', NULL, NULL, NULL, NULL, NULL, '2026-04-14', '14:32:33', 1, 1, '2026-04-14 18:32:33', '2026-04-14 18:32:33'),
(28, 23, 0.00, 0.00, 0.00, 'EFECTIVO', 1, 1, 'NORMAL', NULL, NULL, NULL, NULL, NULL, '2026-04-14', '14:34:05', 1, 1, '2026-04-14 18:34:05', '2026-04-14 18:34:05'),
(29, 25, 50.00, 50.00, 0.00, 'QR', 1, 1, 'NORMAL', NULL, NULL, NULL, NULL, NULL, '2026-04-14', '14:38:07', 1, 1, '2026-04-14 18:38:07', '2026-04-14 18:38:07'),
(30, 26, 50.00, 0.00, 0.00, 'EFECTIVO', 1, 1, 'TRAMITE', NULL, NULL, NULL, NULL, NULL, '2026-04-14', '15:00:15', 1, 1, '2026-04-14 19:00:15', '2026-04-14 19:00:15'),
(31, 29, 50.00, 0.00, 0.00, 'EFECTIVO', 1, 1, 'TRAMITE', NULL, NULL, NULL, NULL, NULL, '2026-04-14', '15:30:25', 1, 1, '2026-04-14 19:30:25', '2026-04-14 19:30:25'),
(32, 27, 50.00, 0.00, 50.00, 'EFECTIVO', 1, 1, 'TRAMITE', NULL, NULL, NULL, NULL, NULL, '2026-04-14', '15:32:51', 1, 1, '2026-04-14 19:32:51', '2026-04-14 19:32:51'),
(33, 28, 50.00, 0.00, 50.00, 'EFECTIVO', 1, 1, 'TRAMITE', NULL, NULL, NULL, NULL, NULL, '2026-04-14', '15:35:31', 1, 1, '2026-04-14 19:35:31', '2026-04-14 19:35:31'),
(34, 30, 50.00, 50.00, 0.00, 'EFECTIVO', 1, 1, 'NORMAL', NULL, NULL, NULL, NULL, NULL, '2026-04-14', '15:36:57', 1, 1, '2026-04-14 19:36:57', '2026-04-14 19:36:57'),
(35, 6, 50.00, 50.00, 0.00, 'EFECTIVO', 1, 1, 'NORMAL', NULL, NULL, NULL, NULL, NULL, '2026-04-14', '15:38:46', 1, 1, '2026-04-14 19:38:46', '2026-04-14 19:38:46'),
(36, 31, 50.00, 0.00, 50.00, 'EFECTIVO', 1, 1, 'TRAMITE', NULL, NULL, NULL, NULL, NULL, '2026-04-14', '15:39:37', 1, 1, '2026-04-14 19:39:37', '2026-04-14 19:39:37'),
(37, 32, 110.00, 60.00, 50.00, 'EFECTIVO', 1, 1, 'TRAMITE', NULL, NULL, NULL, NULL, NULL, '2026-04-14', '15:40:35', 1, 1, '2026-04-14 19:40:35', '2026-04-14 19:40:35'),
(38, 1, 50.00, 50.00, 0.00, 'EFECTIVO', 4, 1, 'NORMAL', NULL, NULL, NULL, NULL, NULL, '2026-04-14', '17:01:58', 1, 1, '2026-04-14 21:01:58', '2026-04-14 21:01:58'),
(39, 33, 50.00, 0.00, 50.00, 'EFECTIVO', 4, 1, 'TRAMITE', NULL, NULL, NULL, NULL, NULL, '2026-04-14', '17:08:53', 1, 1, '2026-04-14 21:08:53', '2026-04-14 21:08:53'),
(40, 6, 50.00, 50.00, 0.00, 'EFECTIVO', 4, 1, 'TRAMITE', NULL, NULL, NULL, NULL, NULL, '2026-04-14', '17:09:07', 1, 1, '2026-04-14 21:09:07', '2026-04-14 21:09:07'),
(41, 34, 50.00, 50.00, 0.00, 'EFECTIVO', 2, 2, 'NORMAL', NULL, NULL, NULL, NULL, NULL, '2026-04-14', '17:11:10', 1, 1, '2026-04-14 21:11:10', '2026-04-14 21:11:10'),
(42, 35, 140.00, 0.00, 140.00, 'EFECTIVO', 2, 2, 'TRAMITE', NULL, NULL, NULL, NULL, NULL, '2026-04-14', '17:12:37', 1, 1, '2026-04-14 21:12:37', '2026-04-14 21:12:37'),
(43, 36, 50.00, 50.00, 0.00, 'EFECTIVO', 2, 2, 'TRAMITE', NULL, NULL, NULL, NULL, NULL, '2026-04-14', '17:12:52', 1, 1, '2026-04-14 21:12:52', '2026-04-14 21:12:52'),
(44, 1, 0.00, 0.00, 0.00, 'EFECTIVO', 1, 1, 'NORMAL', NULL, NULL, NULL, NULL, NULL, '2026-04-14', '23:26:27', 1, 1, '2026-04-15 03:26:27', '2026-04-15 03:26:27');

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
(1, 1, 'A', 50.00, 50.00, 0.00, 1, '011775953329.pdf', '2026-04-12 00:22:08', '2026-04-12 00:22:09'),
(2, 1, 'A', 60.00, 60.00, 0.00, 3, '121775953329.pdf', '2026-04-12 00:22:09', '2026-04-12 00:22:09'),
(3, 2, 'A', 30.00, 30.00, 0.00, 1, NULL, '2026-04-13 14:49:32', '2026-04-13 14:49:32'),
(4, 3, 'A', 30.00, 30.00, 0.00, 1, NULL, '2026-04-13 14:50:23', '2026-04-13 14:50:23'),
(5, 4, 'A', 30.00, 30.00, 0.00, 1, NULL, '2026-04-13 14:51:40', '2026-04-13 14:51:40'),
(6, 4, 'A', 20.00, 20.00, 0.00, 2, NULL, '2026-04-13 14:51:40', '2026-04-13 14:51:40'),
(7, 5, 'A', 30.00, 30.00, 0.00, 1, NULL, '2026-04-13 14:52:23', '2026-04-13 14:52:23'),
(8, 6, 'A', 30.00, 30.00, 0.00, 1, NULL, '2026-04-13 18:49:00', '2026-04-13 18:49:00'),
(9, 7, 'A', 30.00, 30.00, 0.00, 1, '091776107599.pdf', '2026-04-13 19:07:25', '2026-04-13 19:13:19'),
(10, 8, 'A', 30.00, 30.00, 0.00, 1, '0101776109020.pdf', '2026-04-13 19:37:00', '2026-04-13 19:37:00'),
(11, 9, 'A', 30.00, 30.00, 0.00, 1, '0111776109472.pdf', '2026-04-13 19:44:32', '2026-04-13 19:44:32'),
(12, 9, 'A', 30.00, 30.00, 0.00, 3, '1121776109472.pdf', '2026-04-13 19:44:32', '2026-04-13 19:44:32'),
(13, 10, 'A', 30.00, 30.00, 0.00, 1, NULL, '2026-04-13 19:46:53', '2026-04-13 19:46:53'),
(22, 19, 'A', 50.00, 50.00, 0.00, 1, '0221776190887.pdf', '2026-04-14 18:21:27', '2026-04-14 18:21:27'),
(23, 20, 'B', 50.00, 50.00, 0.00, 1, '0231776190982.pdf', '2026-04-14 18:23:02', '2026-04-14 18:23:02'),
(24, 20, 'B', 60.00, 60.00, 0.00, 3, '1241776190982.pdf', '2026-04-14 18:23:02', '2026-04-14 18:23:02'),
(25, 21, 'A', 50.00, 50.00, 0.00, 1, '0251776191187.pdf', '2026-04-14 18:26:27', '2026-04-14 18:26:27'),
(26, 22, 'a', 50.00, 50.00, 0.00, 1, '0261776191293.pdf', '2026-04-14 18:28:13', '2026-04-14 18:28:13'),
(27, 23, 'A', 50.00, 50.00, 0.00, 1, '0271776191359.pdf', '2026-04-14 18:29:19', '2026-04-14 18:29:19'),
(28, 24, 'A', 50.00, 50.00, 0.00, 1, '0281776191421.pdf', '2026-04-14 18:30:21', '2026-04-14 18:30:21'),
(29, 25, 'A', 50.00, 50.00, 0.00, 1, '0291776191475.pdf', '2026-04-14 18:31:15', '2026-04-14 18:31:15'),
(30, 26, 'A', 50.00, 50.00, 0.00, 1, '0301776191536.pdf', '2026-04-14 18:32:16', '2026-04-14 18:32:16'),
(31, 27, 'A', 50.00, 50.00, 0.00, 1, '0311776191553.pdf', '2026-04-14 18:32:33', '2026-04-14 18:32:33'),
(32, 28, 'A', 0.00, 0.00, 0.00, 1, '0321776191645.pdf', '2026-04-14 18:34:05', '2026-04-14 18:34:05'),
(33, 29, 'A', 50.00, 50.00, 0.00, 1, '0331776191887.pdf', '2026-04-14 18:38:07', '2026-04-14 18:38:07'),
(34, 30, 'a', 50.00, 50.00, 0.00, 1, '0341776193215.pdf', '2026-04-14 19:00:15', '2026-04-14 19:00:15'),
(35, 31, 'A', 50.00, 50.00, 0.00, 1, '0351776195025.pdf', '2026-04-14 19:30:25', '2026-04-14 19:30:25'),
(36, 32, 'A', 50.00, 50.00, 0.00, 1, '0361776195171.pdf', '2026-04-14 19:32:51', '2026-04-14 19:32:51'),
(37, 33, 'A', 50.00, 50.00, 0.00, 1, '0371776195331.pdf', '2026-04-14 19:35:31', '2026-04-14 19:35:31'),
(38, 34, 'A', 50.00, 50.00, 0.00, 1, '0381776195417.pdf', '2026-04-14 19:36:57', '2026-04-14 19:36:57'),
(39, 35, 'A', 50.00, 50.00, 0.00, 1, '0391776195526.pdf', '2026-04-14 19:38:46', '2026-04-14 19:38:46'),
(40, 36, 'A', 50.00, 50.00, 0.00, 1, NULL, '2026-04-14 19:39:37', '2026-04-14 19:39:37'),
(41, 37, 'A', 50.00, 50.00, 0.00, 1, '0411776195635.pdf', '2026-04-14 19:40:35', '2026-04-14 19:40:35'),
(42, 37, 'A', 60.00, 60.00, 0.00, 3, '1421776195635.pdf', '2026-04-14 19:40:35', '2026-04-14 19:40:35'),
(43, 38, 'A', 50.00, 50.00, 0.00, 1, '0431776200518.pdf', '2026-04-14 21:01:58', '2026-04-14 21:01:58'),
(44, 39, 'A', 50.00, 50.00, 0.00, 1, '0441776200933.pdf', '2026-04-14 21:08:53', '2026-04-14 21:08:53'),
(45, 40, 'C', 50.00, 50.00, 0.00, 1, '0451776200947.pdf', '2026-04-14 21:09:07', '2026-04-14 21:09:07'),
(46, 41, 'A', 50.00, 50.00, 0.00, 1, '0461776201070.pdf', '2026-04-14 21:11:10', '2026-04-14 21:11:10'),
(47, 42, 'A', 50.00, 50.00, 0.00, 1, '0471776201157.pdf', '2026-04-14 21:12:37', '2026-04-14 21:12:37'),
(48, 42, 'A', 90.00, 90.00, 0.00, 2, '1481776201157.pdf', '2026-04-14 21:12:37', '2026-04-14 21:12:37'),
(49, 43, 'A', 50.00, 50.00, 0.00, 1, '0491776201172.pdf', '2026-04-14 21:12:52', '2026-04-14 21:12:52'),
(50, 44, 'A', 0.00, 0.00, 0.00, 1, '0501776223587.pdf', '2026-04-15 03:26:27', '2026-04-15 03:26:27');

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
(3, '2026-04-11', 1, 3, 1, '2026-04-11 23:14:53', '2026-04-12 00:22:09'),
(4, '2026-04-13', 1, 1, 9, '2026-04-13 14:10:25', '2026-04-13 19:46:53'),
(5, '2026-04-13', 1, 2, 1, '2026-04-13 14:20:42', '2026-04-13 14:51:40'),
(6, '2026-04-13', 1, 3, 1, '2026-04-13 19:44:26', '2026-04-13 19:44:32'),
(7, '2026-04-14', 1, 1, 20, '2026-04-14 18:12:02', '2026-04-15 03:26:27'),
(8, '2026-04-14', 1, 3, 2, '2026-04-14 18:22:57', '2026-04-14 19:40:35'),
(9, '2026-04-14', 1, 2, 0, '2026-04-14 19:35:25', '2026-04-14 19:35:25'),
(10, '2026-04-14', 4, 1, 3, '2026-04-14 21:01:49', '2026-04-14 21:09:07'),
(11, '2026-04-14', 2, 1, 3, '2026-04-14 21:10:46', '2026-04-14 21:12:52'),
(12, '2026-04-14', 2, 2, 1, '2026-04-14 21:12:32', '2026-04-14 21:12:37');

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
(13, 'JOSE', 'CALCINA', 'GONZALES', '2222332', 'CH', '', '1994-01-01', 32, NULL, '2026-04-12', 1, '2026-04-12 19:14:44', '2026-04-12 19:14:44'),
(14, 'ALEX', 'CONTRERAS', '', '5443333', 'SC', '', '2026-02-02', 0, NULL, '2026-04-13', 1, '2026-04-13 19:46:37', '2026-04-13 19:46:37'),
(15, 'ALBERTO', 'GONZALES', 'GONZALES', '5464565', 'PT', '', '2026-02-02', 20, NULL, '2026-04-14', 1, '2026-04-14 18:11:14', '2026-04-14 18:11:42'),
(16, 'MAGDALENA', 'SUAREZ', 'CALCINA', '5766667', 'CB', '', '2002-01-01', 24, NULL, '2026-04-14', 1, '2026-04-14 18:22:12', '2026-04-14 18:22:12'),
(17, 'ELVIRA', 'GONZALES', '', '2342424', 'CB', '', '1990-01-01', 36, NULL, '2026-04-14', 1, '2026-04-14 18:22:41', '2026-04-14 18:22:41'),
(18, 'ELVIS', 'CARDOZO', '', '76867886', 'CB', '', '1999-01-01', 27, NULL, '2026-04-14', 1, '2026-04-14 18:26:14', '2026-04-14 18:26:14'),
(19, 'JUAN', 'FLORES', '', '6756756', 'LP', '', '1998-03-01', 28, NULL, '2026-04-14', 1, '2026-04-14 18:28:00', '2026-04-14 18:28:00'),
(20, 'CARLOS', 'FERNANDEZ', 'MARTINEZ', '6756757', 'CB', '', '1995-02-02', 31, NULL, '2026-04-14', 1, '2026-04-14 18:29:11', '2026-04-14 18:29:11'),
(21, 'EDWIN', 'CONDORI', '', '675756567', 'LP', '', '1995-01-01', 31, NULL, '2026-04-14', 1, '2026-04-14 18:30:12', '2026-04-14 18:30:12'),
(22, 'EFRAIN', 'MAMANI', '', '2432342', 'LP', '', '2000-01-01', 26, NULL, '2026-04-14', 1, '2026-04-14 18:31:49', '2026-04-14 18:31:49'),
(23, 'GLADYS', 'CONDORI', '', '23423423', 'LP', '', '1999-01-01', 27, NULL, '2026-04-14', 1, '2026-04-14 18:32:51', '2026-04-14 18:32:51'),
(24, 'FRANCO', 'MARTINEZ', '', '324234234', 'CB', '', '1997-01-01', 29, NULL, '2026-04-14', 1, '2026-04-14 18:33:42', '2026-04-14 18:33:42'),
(25, 'ALEXIS', 'CONTREAS', '', '564456', 'LP', '', '2000-01-01', 26, NULL, '2026-04-14', 1, '2026-04-14 18:37:59', '2026-04-14 18:37:59'),
(26, 'EDUARDO', 'MARTINEZ', '', '24243333', 'LP', '', '1999-12-12', 26, NULL, '2026-04-14', 1, '2026-04-14 18:59:54', '2026-04-14 18:59:54'),
(27, 'ELVIS', 'GONZALES', '', '45345345', 'LP', '', '2000-01-01', 26, NULL, '2026-04-14', 1, '2026-04-14 19:30:09', '2026-04-14 19:30:09'),
(28, 'ELIZABETH', 'CARDONA', '', '455345', 'LP', '', '2000-01-01', 26, NULL, '2026-04-14', 1, '2026-04-14 19:30:09', '2026-04-14 19:30:09'),
(29, 'FRANCISCA', 'CALLISAYA', '', '343434', 'PT', '', '1999-02-02', 27, NULL, '2026-04-14', 1, '2026-04-14 19:30:09', '2026-04-14 19:30:09'),
(30, 'ALEJANDRA', 'MARCELL', '', '4534544', 'LP', '', '2001-01-01', 25, NULL, '2026-04-14', 1, '2026-04-14 19:36:50', '2026-04-14 19:36:50'),
(31, 'ALEXA', 'MARTINEZ', '', '34534544', 'TJ', '', '1999-01-01', 27, NULL, '2026-04-14', 1, '2026-04-14 19:39:23', '2026-04-14 19:39:23'),
(32, 'FRANCIS', 'CALDERON', '', '32423434', 'LP', '', '2001-02-02', 25, NULL, '2026-04-14', 1, '2026-04-14 19:40:04', '2026-04-14 19:40:04'),
(33, 'FERNANDO', 'GONZALES', '', '234234', 'LP', '', '2006-02-02', 20, NULL, '2026-04-14', 1, '2026-04-14 21:08:16', '2026-04-14 21:08:16'),
(34, 'PEDRO', 'CASTRO', '', '43534534', 'CB', '', '1996-01-01', 30, NULL, '2026-04-14', 1, '2026-04-14 21:11:08', '2026-04-14 21:11:08'),
(35, 'FELIX', 'MAMANI', '', '1332332', 'PT', '', '2000-01-01', 26, NULL, '2026-04-14', 1, '2026-04-14 21:12:12', '2026-04-14 21:12:12'),
(36, 'ALEX', 'CONTRERAS', '', '45445444', 'LP', '', '2003-03-03', 23, NULL, '2026-04-14', 1, '2026-04-14 21:12:12', '2026-04-14 21:12:12'),
(37, 'EDUARDO', 'MANSILLA', '', '2342343', 'CB', '', '1999-01-01', 27, NULL, '2026-04-16', 1, '2026-04-16 12:25:10', '2026-04-16 12:25:10'),
(38, 'JORGE', 'CONTRERAS', '', '455445', 'LP', '', '1999-01-01', 27, NULL, '2026-04-16', 1, '2026-04-16 12:25:35', '2026-04-16 12:25:35');

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
(28, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN TRAMITE', '{\"id\": 2, \"nro\": 2, \"hora\": \"15:14:44\", \"fecha\": \"2026-04-12\", \"codigo\": \"T2\", \"user_id\": 1, \"created_at\": \"2026-04-12T19:14:44.000000Z\", \"updated_at\": \"2026-04-12T19:14:44.000000Z\", \"sucursal_id\": \"1\", \"tramitador_id\": \"2\", \"tramite_clientes\": [{\"id\": 4, \"estado\": 0, \"existente\": false, \"cliente_id\": 10, \"created_at\": \"2026-04-12T19:14:44.000000Z\", \"tramite_id\": 2, \"updated_at\": \"2026-04-12T19:14:44.000000Z\", \"certificado_id\": null}, {\"id\": 5, \"estado\": 0, \"existente\": false, \"cliente_id\": 11, \"created_at\": \"2026-04-12T19:14:44.000000Z\", \"tramite_id\": 2, \"updated_at\": \"2026-04-12T19:14:44.000000Z\", \"certificado_id\": null}, {\"id\": 6, \"estado\": 0, \"existente\": false, \"cliente_id\": 12, \"created_at\": \"2026-04-12T19:14:44.000000Z\", \"tramite_id\": 2, \"updated_at\": \"2026-04-12T19:14:44.000000Z\", \"certificado_id\": null}, {\"id\": 7, \"estado\": 0, \"existente\": false, \"cliente_id\": 13, \"created_at\": \"2026-04-12T19:14:44.000000Z\", \"tramite_id\": 2, \"updated_at\": \"2026-04-12T19:14:44.000000Z\", \"certificado_id\": null}]}', NULL, 'TRAMITES', '2026-04-12', '15:14:44', '2026-04-12 19:14:44', '2026-04-12 19:14:44'),
(29, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CERTIFICADO', '{\"id\": 2, \"tipo\": \"TRAMITE\", \"saldo\": 0, \"total\": \"30\", \"user_id\": 1, \"cancelado\": \"30\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"3\", \"created_at\": \"2026-04-13T14:49:32.000000Z\", \"updated_at\": \"2026-04-13T14:49:32.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"10:49:32\", \"fecha_registro\": \"2026-04-13\", \"certificado_detalles\": [{\"id\": 3, \"saldo\": \"0.00\", \"precio\": \"30.00\", \"archivo\": null, \"cancelado\": \"30.00\", \"created_at\": \"2026-04-13T14:49:32.000000Z\", \"updated_at\": \"2026-04-13T14:49:32.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados\", \"certificado_id\": 2, \"muestra_conteo\": false, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-13', '10:49:32', '2026-04-13 14:49:32', '2026-04-13 14:49:32'),
(30, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CERTIFICADO', '{\"id\": 3, \"tipo\": \"TRAMITE\", \"saldo\": 0, \"total\": \"30\", \"user_id\": 1, \"cancelado\": \"30\", \"tipo_pago\": \"QR\", \"cliente_id\": \"9\", \"created_at\": \"2026-04-13T14:50:23.000000Z\", \"updated_at\": \"2026-04-13T14:50:23.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"10:50:23\", \"fecha_registro\": \"2026-04-13\", \"certificado_detalles\": [{\"id\": 4, \"saldo\": \"0.00\", \"precio\": \"30.00\", \"archivo\": null, \"cancelado\": \"30.00\", \"created_at\": \"2026-04-13T14:50:23.000000Z\", \"updated_at\": \"2026-04-13T14:50:23.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados\", \"certificado_id\": 3, \"muestra_conteo\": false, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-13', '10:50:23', '2026-04-13 14:50:23', '2026-04-13 14:50:23'),
(31, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CERTIFICADO', '{\"id\": 4, \"tipo\": \"TRAMITE\", \"saldo\": 0, \"total\": \"50\", \"user_id\": 1, \"cancelado\": \"50\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"8\", \"created_at\": \"2026-04-13T14:51:40.000000Z\", \"updated_at\": \"2026-04-13T14:51:40.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"10:51:40\", \"fecha_registro\": \"2026-04-13\", \"certificado_detalles\": [{\"id\": 5, \"saldo\": \"0.00\", \"precio\": \"30.00\", \"archivo\": null, \"cancelado\": \"30.00\", \"created_at\": \"2026-04-13T14:51:40.000000Z\", \"updated_at\": \"2026-04-13T14:51:40.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados\", \"certificado_id\": 4, \"muestra_conteo\": false, \"tipo_certificado_id\": 1}, {\"id\": 6, \"saldo\": \"0.00\", \"precio\": \"20.00\", \"archivo\": null, \"cancelado\": \"20.00\", \"created_at\": \"2026-04-13T14:51:40.000000Z\", \"updated_at\": \"2026-04-13T14:51:40.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados\", \"certificado_id\": 4, \"muestra_conteo\": false, \"tipo_certificado_id\": 2}]}', NULL, 'CERTIFICADOS', '2026-04-13', '10:51:40', '2026-04-13 14:51:40', '2026-04-13 14:51:40'),
(32, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CERTIFICADO', '{\"id\": 5, \"tipo\": \"TRAMITE\", \"saldo\": 0, \"total\": \"30\", \"user_id\": 1, \"cancelado\": \"30\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"11\", \"created_at\": \"2026-04-13T14:52:23.000000Z\", \"updated_at\": \"2026-04-13T14:52:23.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"10:52:23\", \"fecha_registro\": \"2026-04-13\", \"certificado_detalles\": [{\"id\": 7, \"saldo\": \"0.00\", \"precio\": \"30.00\", \"archivo\": null, \"cancelado\": \"30.00\", \"created_at\": \"2026-04-13T14:52:23.000000Z\", \"updated_at\": \"2026-04-13T14:52:23.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados\", \"certificado_id\": 5, \"muestra_conteo\": false, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-13', '10:52:23', '2026-04-13 14:52:23', '2026-04-13 14:52:23'),
(33, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CERTIFICADO', '{\"id\": 6, \"tipo\": \"TRAMITE\", \"saldo\": \"30.00\", \"total\": \"30\", \"user_id\": 1, \"cancelado\": \"0\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"10\", \"created_at\": \"2026-04-13T18:49:00.000000Z\", \"updated_at\": \"2026-04-13T18:49:00.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"14:49:00\", \"fecha_registro\": \"2026-04-13\", \"certificado_detalles\": [{\"id\": 8, \"saldo\": \"0.00\", \"precio\": \"30.00\", \"archivo\": null, \"cancelado\": \"30.00\", \"created_at\": \"2026-04-13T18:49:00.000000Z\", \"updated_at\": \"2026-04-13T18:49:00.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados\", \"certificado_id\": 6, \"muestra_conteo\": false, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-13', '14:49:00', '2026-04-13 18:49:00', '2026-04-13 18:49:00'),
(34, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CERTIFICADO', '{\"id\": 7, \"tipo\": \"NORMAL\", \"saldo\": 0, \"total\": \"30\", \"user_id\": 1, \"cancelado\": 0, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"1\", \"created_at\": \"2026-04-13T19:07:25.000000Z\", \"updated_at\": \"2026-04-13T19:07:25.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"15:07:25\", \"fecha_registro\": \"2026-04-13\", \"certificado_detalles\": [{\"id\": 9, \"name\": \"091776107245.pdf\", \"saldo\": \"0.00\", \"precio\": \"30.00\", \"archivo\": \"091776107245.pdf\", \"cancelado\": \"30.00\", \"created_at\": \"2026-04-13T19:07:25.000000Z\", \"updated_at\": \"2026-04-13T19:07:25.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/091776107245.pdf\", \"certificado_id\": 7, \"muestra_conteo\": false, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-13', '15:07:25', '2026-04-13 19:07:25', '2026-04-13 19:07:25'),
(35, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN CERTIFICADO', '{\"id\": 7, \"tipo\": \"NORMAL\", \"saldo\": \"0.00\", \"total\": \"30.00\", \"status\": 1, \"user_id\": 1, \"hora_fin\": null, \"cancelado\": \"0.00\", \"fecha_fin\": null, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": 1, \"created_at\": \"2026-04-13T19:07:25.000000Z\", \"updated_at\": \"2026-04-13T19:07:25.000000Z\", \"verificado\": 0, \"hora_inicio\": null, \"sucursal_id\": 1, \"fecha_inicio\": null, \"hora_registro\": \"15:07:25\", \"fecha_registro\": \"2026-04-13\", \"certificado_detalles\": [{\"id\": 9, \"name\": \"091776107436.pdf\", \"saldo\": \"0.00\", \"precio\": \"30.00\", \"archivo\": \"091776107436.pdf\", \"cancelado\": \"30.00\", \"created_at\": \"2026-04-13T19:07:25.000000Z\", \"updated_at\": \"2026-04-13T19:10:36.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/091776107436.pdf\", \"certificado_id\": 7, \"muestra_conteo\": false, \"tipo_certificado_id\": 1}]}', '{\"id\": 7, \"tipo\": \"NORMAL\", \"saldo\": 0, \"total\": \"30\", \"status\": 1, \"user_id\": 1, \"hora_fin\": null, \"cancelado\": 0, \"fecha_fin\": null, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"1\", \"created_at\": \"2026-04-13T19:07:25.000000Z\", \"updated_at\": \"2026-04-13T19:10:36.000000Z\", \"verificado\": 0, \"hora_inicio\": null, \"sucursal_id\": \"1\", \"fecha_inicio\": null, \"hora_registro\": \"15:07:25\", \"fecha_registro\": \"2026-04-13\", \"certificado_detalles\": [{\"id\": 9, \"name\": \"091776107436.pdf\", \"saldo\": \"0.00\", \"precio\": \"30.00\", \"archivo\": \"091776107436.pdf\", \"cancelado\": \"30.00\", \"created_at\": \"2026-04-13T19:07:25.000000Z\", \"updated_at\": \"2026-04-13T19:10:36.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/091776107436.pdf\", \"certificado_id\": 7, \"muestra_conteo\": false, \"tipo_certificado_id\": 1}]}', 'CERTIFICADOS', '2026-04-13', '15:10:36', '2026-04-13 19:10:36', '2026-04-13 19:10:36'),
(36, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN CERTIFICADO', '{\"id\": 7, \"tipo\": \"NORMAL\", \"saldo\": \"0.00\", \"total\": \"30.00\", \"status\": 1, \"user_id\": 1, \"hora_fin\": null, \"cancelado\": \"0.00\", \"fecha_fin\": null, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": 1, \"created_at\": \"2026-04-13T19:07:25.000000Z\", \"updated_at\": \"2026-04-13T19:10:36.000000Z\", \"verificado\": 0, \"hora_inicio\": null, \"sucursal_id\": 1, \"fecha_inicio\": null, \"hora_registro\": \"15:07:25\", \"fecha_registro\": \"2026-04-13\", \"certificado_detalles\": [{\"id\": 9, \"name\": \"091776107599.pdf\", \"saldo\": \"0.00\", \"precio\": \"30.00\", \"archivo\": \"091776107599.pdf\", \"cancelado\": \"30.00\", \"created_at\": \"2026-04-13T19:07:25.000000Z\", \"updated_at\": \"2026-04-13T19:13:19.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/091776107599.pdf\", \"certificado_id\": 7, \"muestra_conteo\": false, \"tipo_certificado_id\": 1}]}', '{\"id\": 7, \"tipo\": \"NORMAL\", \"saldo\": 0, \"total\": \"30\", \"status\": 1, \"user_id\": 1, \"hora_fin\": null, \"cancelado\": 0, \"fecha_fin\": null, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"1\", \"created_at\": \"2026-04-13T19:07:25.000000Z\", \"updated_at\": \"2026-04-13T19:13:19.000000Z\", \"verificado\": 0, \"hora_inicio\": null, \"sucursal_id\": \"1\", \"fecha_inicio\": null, \"hora_registro\": \"15:07:25\", \"fecha_registro\": \"2026-04-13\", \"certificado_detalles\": [{\"id\": 9, \"name\": \"091776107599.pdf\", \"saldo\": \"0.00\", \"precio\": \"30.00\", \"archivo\": \"091776107599.pdf\", \"cancelado\": \"30.00\", \"created_at\": \"2026-04-13T19:07:25.000000Z\", \"updated_at\": \"2026-04-13T19:13:19.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/091776107599.pdf\", \"certificado_id\": 7, \"muestra_conteo\": false, \"tipo_certificado_id\": 1}]}', 'CERTIFICADOS', '2026-04-13', '15:13:19', '2026-04-13 19:13:19', '2026-04-13 19:13:19'),
(37, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CERTIFICADO', '{\"id\": 8, \"tipo\": \"TRAMITE\", \"saldo\": \"0\", \"total\": \"30\", \"user_id\": 1, \"cancelado\": \"0\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"12\", \"created_at\": \"2026-04-13T19:37:00.000000Z\", \"updated_at\": \"2026-04-13T19:37:00.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"15:37:00\", \"fecha_registro\": \"2026-04-13\", \"certificado_detalles\": [{\"id\": 10, \"name\": \"0101776109020.pdf\", \"saldo\": \"0.00\", \"precio\": \"30.00\", \"archivo\": \"0101776109020.pdf\", \"cancelado\": \"30.00\", \"created_at\": \"2026-04-13T19:37:00.000000Z\", \"updated_at\": \"2026-04-13T19:37:00.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/0101776109020.pdf\", \"certificado_id\": 8, \"muestra_conteo\": false, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-13', '15:37:00', '2026-04-13 19:37:00', '2026-04-13 19:37:00'),
(38, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CERTIFICADO', '{\"id\": 9, \"tipo\": \"TRAMITE\", \"saldo\": \"30.00\", \"total\": \"60\", \"user_id\": 1, \"cancelado\": \"30\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"13\", \"created_at\": \"2026-04-13T19:44:32.000000Z\", \"updated_at\": \"2026-04-13T19:44:32.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"15:44:32\", \"fecha_registro\": \"2026-04-13\", \"certificado_detalles\": [{\"id\": 11, \"name\": \"0111776109472.pdf\", \"saldo\": \"0.00\", \"precio\": \"30.00\", \"archivo\": \"0111776109472.pdf\", \"cancelado\": \"30.00\", \"created_at\": \"2026-04-13T19:44:32.000000Z\", \"updated_at\": \"2026-04-13T19:44:32.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/0111776109472.pdf\", \"certificado_id\": 9, \"muestra_conteo\": false, \"tipo_certificado_id\": 1}, {\"id\": 12, \"name\": \"1121776109472.pdf\", \"saldo\": \"0.00\", \"precio\": \"30.00\", \"archivo\": \"1121776109472.pdf\", \"cancelado\": \"30.00\", \"created_at\": \"2026-04-13T19:44:32.000000Z\", \"updated_at\": \"2026-04-13T19:44:32.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/1121776109472.pdf\", \"certificado_id\": 9, \"muestra_conteo\": false, \"tipo_certificado_id\": 3}]}', NULL, 'CERTIFICADOS', '2026-04-13', '15:44:32', '2026-04-13 19:44:32', '2026-04-13 19:44:32'),
(39, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": \"5443333\", \"id\": 14, \"cel\": null, \"edad\": 0, \"ci_exp\": \"SC\", \"nombre\": \"ALEX\", \"materno\": \"\", \"paterno\": \"CONTRERAS\", \"fecha_nac\": \"2026-02-02\", \"created_at\": \"2026-04-13T19:46:37.000000Z\", \"updated_at\": \"2026-04-13T19:46:37.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-13\"}', NULL, 'CLIENTES', '2026-04-13', '15:46:37', '2026-04-13 19:46:37', '2026-04-13 19:46:37'),
(40, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CERTIFICADO', '{\"id\": 10, \"tipo\": \"TRAMITE\", \"saldo\": \"30.00\", \"total\": \"30\", \"user_id\": 1, \"cancelado\": \"0\", \"tipo_pago\": \"QR\", \"cliente_id\": \"14\", \"created_at\": \"2026-04-13T19:46:53.000000Z\", \"updated_at\": \"2026-04-13T19:46:53.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"15:46:53\", \"fecha_registro\": \"2026-04-13\", \"certificado_detalles\": [{\"id\": 13, \"name\": null, \"saldo\": \"0.00\", \"precio\": \"30.00\", \"archivo\": null, \"cancelado\": \"30.00\", \"created_at\": \"2026-04-13T19:46:53.000000Z\", \"updated_at\": \"2026-04-13T19:46:53.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados\", \"certificado_id\": 10, \"muestra_conteo\": false, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-13', '15:46:53', '2026-04-13 19:46:53', '2026-04-13 19:46:53'),
(41, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO EL PAGO DE UN CERTIFICADO', '{\"id\": 6, \"hora\": \"16:45:15\", \"fecha\": \"2026-04-13\", \"monto\": \"30\", \"tipo_pago\": \"EFECTIVO\", \"created_at\": \"2026-04-13T20:45:15.000000Z\", \"updated_at\": \"2026-04-13T20:45:15.000000Z\", \"certificado\": {\"id\": 10, \"tipo\": \"TRAMITE\", \"saldo\": \"30.00\", \"total\": \"30.00\", \"status\": 1, \"user_id\": 1, \"hora_fin\": null, \"cancelado\": \"0.00\", \"fecha_fin\": null, \"tipo_pago\": \"QR\", \"cliente_id\": 14, \"created_at\": \"2026-04-13T19:46:53.000000Z\", \"updated_at\": \"2026-04-13T19:46:53.000000Z\", \"hora_inicio\": null, \"sucursal_id\": 1, \"fecha_inicio\": null, \"hora_registro\": \"15:46:53\", \"fecha_registro\": \"2026-04-13\", \"fecha_registro_t\": \"13/04/2026\"}, \"certificado_id\": 10}', NULL, 'CERTIFICADOS PAGOS', '2026-04-13', '16:45:15', '2026-04-13 20:45:15', '2026-04-13 20:45:15'),
(42, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO EL PAGO DE UN CERTIFICADO', '{\"id\": 1, \"hora\": \"16:47:31\", \"fecha\": \"2026-04-13\", \"monto\": \"30\", \"tipo_pago\": \"EFECTIVO\", \"created_at\": \"2026-04-13T20:47:31.000000Z\", \"updated_at\": \"2026-04-13T20:47:31.000000Z\", \"certificado\": {\"id\": 10, \"tipo\": \"TRAMITE\", \"saldo\": \"30.00\", \"total\": \"30.00\", \"status\": 1, \"user_id\": 1, \"hora_fin\": null, \"cancelado\": \"0.00\", \"fecha_fin\": null, \"tipo_pago\": \"QR\", \"cliente_id\": 14, \"created_at\": \"2026-04-13T19:46:53.000000Z\", \"updated_at\": \"2026-04-13T20:47:31.000000Z\", \"hora_inicio\": null, \"sucursal_id\": 1, \"fecha_inicio\": null, \"hora_registro\": \"15:46:53\", \"fecha_registro\": \"2026-04-13\", \"fecha_registro_t\": \"13/04/2026\"}, \"certificado_id\": 10}', NULL, 'CERTIFICADOS PAGOS', '2026-04-13', '16:47:31', '2026-04-13 20:47:31', '2026-04-13 20:47:31'),
(43, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO EL PAGO DE UN CERTIFICADO', '{\"id\": 1, \"hora\": \"16:48:44\", \"fecha\": \"2026-04-13\", \"monto\": \"30\", \"tipo_pago\": \"EFECTIVO\", \"created_at\": \"2026-04-13T20:48:44.000000Z\", \"updated_at\": \"2026-04-13T20:48:44.000000Z\", \"certificado\": {\"id\": 10, \"tipo\": \"TRAMITE\", \"saldo\": \"0.00\", \"total\": \"30.00\", \"status\": 1, \"user_id\": 1, \"hora_fin\": null, \"cancelado\": \"0.00\", \"fecha_fin\": null, \"tipo_pago\": \"QR\", \"cliente_id\": 14, \"created_at\": \"2026-04-13T19:46:53.000000Z\", \"updated_at\": \"2026-04-13T20:48:44.000000Z\", \"hora_inicio\": null, \"sucursal_id\": 1, \"fecha_inicio\": null, \"hora_registro\": \"15:46:53\", \"fecha_registro\": \"2026-04-13\", \"fecha_registro_t\": \"13/04/2026\"}, \"certificado_id\": 10}', NULL, 'CERTIFICADOS PAGOS', '2026-04-13', '16:48:44', '2026-04-13 20:48:44', '2026-04-13 20:48:44'),
(44, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO EL PAGO DE UN CERTIFICADO', '{\"id\": 2, \"hora\": \"16:48:57\", \"fecha\": \"2026-04-13\", \"monto\": \"30\", \"tipo_pago\": \"EFECTIVO\", \"created_at\": \"2026-04-13T20:48:57.000000Z\", \"updated_at\": \"2026-04-13T20:48:57.000000Z\", \"certificado\": {\"id\": 9, \"tipo\": \"TRAMITE\", \"saldo\": \"0.00\", \"total\": \"60.00\", \"status\": 1, \"user_id\": 1, \"hora_fin\": null, \"cancelado\": \"30.00\", \"fecha_fin\": null, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": 13, \"created_at\": \"2026-04-13T19:44:32.000000Z\", \"updated_at\": \"2026-04-13T20:48:57.000000Z\", \"hora_inicio\": null, \"sucursal_id\": 1, \"fecha_inicio\": null, \"hora_registro\": \"15:44:32\", \"fecha_registro\": \"2026-04-13\", \"fecha_registro_t\": \"13/04/2026\"}, \"certificado_id\": 9}', NULL, 'CERTIFICADOS PAGOS', '2026-04-13', '16:48:57', '2026-04-13 20:48:57', '2026-04-13 20:48:57'),
(45, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO EL PAGO DE UN CERTIFICADO', '{\"id\": 3, \"hora\": \"16:49:03\", \"fecha\": \"2026-04-13\", \"monto\": \"15\", \"tipo_pago\": \"EFECTIVO\", \"created_at\": \"2026-04-13T20:49:03.000000Z\", \"updated_at\": \"2026-04-13T20:49:03.000000Z\", \"certificado\": {\"id\": 8, \"tipo\": \"TRAMITE\", \"saldo\": \"15.00\", \"total\": \"30.00\", \"status\": 1, \"user_id\": 1, \"hora_fin\": null, \"cancelado\": \"0.00\", \"fecha_fin\": null, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": 12, \"created_at\": \"2026-04-13T19:37:00.000000Z\", \"updated_at\": \"2026-04-13T20:49:03.000000Z\", \"hora_inicio\": null, \"sucursal_id\": 1, \"fecha_inicio\": null, \"hora_registro\": \"15:37:00\", \"fecha_registro\": \"2026-04-13\", \"fecha_registro_t\": \"13/04/2026\"}, \"certificado_id\": 8}', NULL, 'CERTIFICADOS PAGOS', '2026-04-13', '16:49:03', '2026-04-13 20:49:03', '2026-04-13 20:49:03'),
(46, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO EL PAGO DE UN CERTIFICADO', '{\"id\": 4, \"hora\": \"16:49:41\", \"fecha\": \"2026-04-13\", \"monto\": \"15\", \"tipo_pago\": \"EFECTIVO\", \"created_at\": \"2026-04-13T20:49:41.000000Z\", \"updated_at\": \"2026-04-13T20:49:41.000000Z\", \"certificado\": {\"id\": 8, \"tipo\": \"TRAMITE\", \"saldo\": \"-15.00\", \"total\": \"30.00\", \"status\": 1, \"user_id\": 1, \"hora_fin\": null, \"cancelado\": \"30.00\", \"fecha_fin\": null, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": 12, \"created_at\": \"2026-04-13T19:37:00.000000Z\", \"updated_at\": \"2026-04-13T20:49:41.000000Z\", \"hora_inicio\": null, \"sucursal_id\": 1, \"fecha_inicio\": null, \"hora_registro\": \"15:37:00\", \"fecha_registro\": \"2026-04-13\", \"fecha_registro_t\": \"13/04/2026\"}, \"certificado_id\": 8}', NULL, 'CERTIFICADOS PAGOS', '2026-04-13', '16:49:41', '2026-04-13 20:49:41', '2026-04-13 20:49:41'),
(47, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO EL PAGO DE UN CERTIFICADO', '{\"id\": 5, \"hora\": \"16:50:24\", \"fecha\": \"2026-04-13\", \"monto\": \"10\", \"tipo_pago\": \"EFECTIVO\", \"created_at\": \"2026-04-13T20:50:24.000000Z\", \"updated_at\": \"2026-04-13T20:50:24.000000Z\", \"certificado\": {\"id\": 7, \"tipo\": \"NORMAL\", \"saldo\": \"20.00\", \"total\": \"30.00\", \"status\": 1, \"user_id\": 1, \"hora_fin\": null, \"cancelado\": \"10.00\", \"fecha_fin\": null, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": 1, \"created_at\": \"2026-04-13T19:07:25.000000Z\", \"updated_at\": \"2026-04-13T20:50:24.000000Z\", \"hora_inicio\": null, \"sucursal_id\": 1, \"fecha_inicio\": null, \"hora_registro\": \"15:07:25\", \"fecha_registro\": \"2026-04-13\", \"fecha_registro_t\": \"13/04/2026\"}, \"certificado_id\": 7}', NULL, 'CERTIFICADOS PAGOS', '2026-04-13', '16:50:24', '2026-04-13 20:50:24', '2026-04-13 20:50:24'),
(48, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO EL PAGO DE UN CERTIFICADO', '{\"id\": 6, \"hora\": \"16:50:36\", \"fecha\": \"2026-04-13\", \"monto\": \"10\", \"tipo_pago\": \"EFECTIVO\", \"created_at\": \"2026-04-13T20:50:36.000000Z\", \"updated_at\": \"2026-04-13T20:50:36.000000Z\", \"certificado\": {\"id\": 7, \"tipo\": \"NORMAL\", \"saldo\": \"10.00\", \"total\": \"30.00\", \"status\": 1, \"user_id\": 1, \"hora_fin\": null, \"cancelado\": \"20.00\", \"fecha_fin\": null, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": 1, \"created_at\": \"2026-04-13T19:07:25.000000Z\", \"updated_at\": \"2026-04-13T20:50:36.000000Z\", \"hora_inicio\": null, \"sucursal_id\": 1, \"fecha_inicio\": null, \"hora_registro\": \"15:07:25\", \"fecha_registro\": \"2026-04-13\", \"fecha_registro_t\": \"13/04/2026\"}, \"certificado_id\": 7}', NULL, 'CERTIFICADOS PAGOS', '2026-04-13', '16:50:36', '2026-04-13 20:50:36', '2026-04-13 20:50:36'),
(49, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO EL PAGO DE UN CERTIFICADO', '{\"id\": 7, \"hora\": \"16:50:48\", \"fecha\": \"2026-04-13\", \"monto\": \"10\", \"tipo_pago\": \"EFECTIVO\", \"created_at\": \"2026-04-13T20:50:48.000000Z\", \"updated_at\": \"2026-04-13T20:50:48.000000Z\", \"certificado\": {\"id\": 7, \"tipo\": \"NORMAL\", \"saldo\": \"0.00\", \"total\": \"30.00\", \"status\": 1, \"user_id\": 1, \"hora_fin\": null, \"cancelado\": \"30.00\", \"fecha_fin\": null, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": 1, \"created_at\": \"2026-04-13T19:07:25.000000Z\", \"updated_at\": \"2026-04-13T20:50:48.000000Z\", \"hora_inicio\": null, \"sucursal_id\": 1, \"fecha_inicio\": null, \"hora_registro\": \"15:07:25\", \"fecha_registro\": \"2026-04-13\", \"fecha_registro_t\": \"13/04/2026\"}, \"certificado_id\": 7}', NULL, 'CERTIFICADOS PAGOS', '2026-04-13', '16:50:48', '2026-04-13 20:50:48', '2026-04-13 20:50:48'),
(50, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO EL PAGO DE UN CERTIFICADO', '{\"id\": 8, \"hora\": \"16:51:01\", \"fecha\": \"2026-04-13\", \"monto\": \"30\", \"tipo_pago\": \"EFECTIVO\", \"created_at\": \"2026-04-13T20:51:01.000000Z\", \"updated_at\": \"2026-04-13T20:51:01.000000Z\", \"certificado\": {\"id\": 6, \"tipo\": \"TRAMITE\", \"saldo\": \"0.00\", \"total\": \"30.00\", \"status\": 1, \"user_id\": 1, \"hora_fin\": null, \"cancelado\": \"30.00\", \"fecha_fin\": null, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": 10, \"created_at\": \"2026-04-13T18:49:00.000000Z\", \"updated_at\": \"2026-04-13T20:51:01.000000Z\", \"hora_inicio\": null, \"sucursal_id\": 1, \"fecha_inicio\": null, \"hora_registro\": \"14:49:00\", \"fecha_registro\": \"2026-04-13\", \"fecha_registro_t\": \"13/04/2026\"}, \"certificado_id\": 6}', NULL, 'CERTIFICADOS PAGOS', '2026-04-13', '16:51:01', '2026-04-13 20:51:01', '2026-04-13 20:51:01'),
(51, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": \"5464565\", \"id\": 15, \"cel\": null, \"edad\": 0, \"ci_exp\": \"PT\", \"nombre\": \"ALBERTO\", \"materno\": \"GONZALES\", \"paterno\": \"GONZALES\", \"fecha_nac\": \"2026-02-02\", \"created_at\": \"2026-04-14T18:11:14.000000Z\", \"updated_at\": \"2026-04-14T18:11:14.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-14\"}', NULL, 'CLIENTES', '2026-04-14', '14:11:14', '2026-04-14 18:11:14', '2026-04-14 18:11:14'),
(52, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN CLIENTE', '{\"ci\": \"5464565\", \"id\": 15, \"cel\": null, \"edad\": 0, \"ci_exp\": \"PT\", \"nombre\": \"ALBERTO\", \"status\": 1, \"materno\": \"GONZALES\", \"paterno\": \"GONZALES\", \"fecha_nac\": \"2026-02-02\", \"created_at\": \"2026-04-14T18:11:14.000000Z\", \"updated_at\": \"2026-04-14T18:11:14.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-14\"}', '{\"ci\": \"5464565\", \"id\": 15, \"cel\": null, \"edad\": \"20\", \"ci_exp\": \"PT\", \"nombre\": \"ALBERTO\", \"status\": 1, \"materno\": \"GONZALES\", \"paterno\": \"GONZALES\", \"fecha_nac\": \"2026-02-02\", \"created_at\": \"2026-04-14T18:11:14.000000Z\", \"updated_at\": \"2026-04-14T18:11:42.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-14\"}', 'CLIENTES', '2026-04-14', '14:11:42', '2026-04-14 18:11:42', '2026-04-14 18:11:42'),
(53, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO EL PAGO DE UN CERTIFICADO', '{\"id\": 9, \"hora\": \"14:21:27\", \"fecha\": \"2026-04-14\", \"monto\": \"50\", \"modulo\": \"Certificado\", \"user_id\": 1, \"tipo_pago\": \"EFECTIVO\", \"created_at\": \"2026-04-14T18:21:27.000000Z\", \"updated_at\": \"2026-04-14T18:21:27.000000Z\", \"descripcion\": \"PAGO POR CERTIFICADO\", \"registro_id\": 19, \"sucursal_id\": 1}', NULL, 'PAGOS', '2026-04-14', '14:21:27', '2026-04-14 18:21:27', '2026-04-14 18:21:27');
INSERT INTO `historial_accions` (`id`, `user_id`, `accion`, `descripcion`, `datos_original`, `datos_nuevo`, `modulo`, `fecha`, `hora`, `created_at`, `updated_at`) VALUES
(54, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CERTIFICADO', '{\"id\": 19, \"tipo\": \"TRAMITE\", \"saldo\": \"0.00\", \"total\": \"50\", \"user_id\": 1, \"cancelado\": \"50\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"15\", \"created_at\": \"2026-04-14T18:21:27.000000Z\", \"updated_at\": \"2026-04-14T18:21:27.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"14:21:27\", \"fecha_registro\": \"2026-04-14\", \"certificado_detalles\": [{\"id\": 22, \"name\": \"0221776190887.pdf\", \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": \"0221776190887.pdf\", \"cancelado\": \"50.00\", \"categoria\": \"A\", \"created_at\": \"2026-04-14T18:21:27.000000Z\", \"updated_at\": \"2026-04-14T18:21:27.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/0221776190887.pdf\", \"certificado_id\": 19, \"muestra_conteo\": false, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-14', '14:21:27', '2026-04-14 18:21:27', '2026-04-14 18:21:27'),
(55, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": \"5766667\", \"id\": 16, \"cel\": null, \"edad\": 24, \"ci_exp\": \"CB\", \"nombre\": \"MAGDALENA\", \"materno\": \"CALCINA\", \"paterno\": \"SUAREZ\", \"fecha_nac\": \"2002-01-01\", \"created_at\": \"2026-04-14T18:22:12.000000Z\", \"updated_at\": \"2026-04-14T18:22:12.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-14\"}', NULL, 'CLIENTES', '2026-04-14', '14:22:12', '2026-04-14 18:22:12', '2026-04-14 18:22:12'),
(56, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": \"2342424\", \"id\": 17, \"cel\": null, \"edad\": 36, \"ci_exp\": \"CB\", \"nombre\": \"ELVIRA\", \"materno\": \"\", \"paterno\": \"GONZALES\", \"fecha_nac\": \"1990-01-01\", \"created_at\": \"2026-04-14T18:22:41.000000Z\", \"updated_at\": \"2026-04-14T18:22:41.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-14\"}', NULL, 'CLIENTES', '2026-04-14', '14:22:41', '2026-04-14 18:22:41', '2026-04-14 18:22:41'),
(57, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CERTIFICADO', '{\"id\": 20, \"tipo\": \"NORMAL\", \"saldo\": 0, \"total\": \"110\", \"user_id\": 1, \"cancelado\": 0, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"17\", \"created_at\": \"2026-04-14T18:23:02.000000Z\", \"updated_at\": \"2026-04-14T18:23:02.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"14:23:02\", \"fecha_registro\": \"2026-04-14\", \"certificado_detalles\": [{\"id\": 23, \"name\": \"0231776190982.pdf\", \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": \"0231776190982.pdf\", \"cancelado\": \"50.00\", \"categoria\": \"B\", \"created_at\": \"2026-04-14T18:23:02.000000Z\", \"updated_at\": \"2026-04-14T18:23:02.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/0231776190982.pdf\", \"certificado_id\": 20, \"muestra_conteo\": false, \"tipo_certificado_id\": 1}, {\"id\": 24, \"name\": \"1241776190982.pdf\", \"saldo\": \"0.00\", \"precio\": \"60.00\", \"archivo\": \"1241776190982.pdf\", \"cancelado\": \"60.00\", \"categoria\": \"B\", \"created_at\": \"2026-04-14T18:23:02.000000Z\", \"updated_at\": \"2026-04-14T18:23:02.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/1241776190982.pdf\", \"certificado_id\": 20, \"muestra_conteo\": false, \"tipo_certificado_id\": 3}]}', NULL, 'CERTIFICADOS', '2026-04-14', '14:23:02', '2026-04-14 18:23:02', '2026-04-14 18:23:02'),
(58, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": \"76867886\", \"id\": 18, \"cel\": null, \"edad\": 27, \"ci_exp\": \"CB\", \"nombre\": \"ELVIS\", \"materno\": \"\", \"paterno\": \"CARDOZO\", \"fecha_nac\": \"1999-01-01\", \"created_at\": \"2026-04-14T18:26:14.000000Z\", \"updated_at\": \"2026-04-14T18:26:14.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-14\"}', NULL, 'CLIENTES', '2026-04-14', '14:26:14', '2026-04-14 18:26:14', '2026-04-14 18:26:14'),
(59, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CERTIFICADO', '{\"id\": 21, \"tipo\": \"NORMAL\", \"saldo\": 0, \"total\": \"50\", \"user_id\": 1, \"cancelado\": 0, \"tipo_pago\": \"QR\", \"cliente_id\": \"18\", \"created_at\": \"2026-04-14T18:26:27.000000Z\", \"updated_at\": \"2026-04-14T18:26:27.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"14:26:27\", \"fecha_registro\": \"2026-04-14\", \"certificado_detalles\": [{\"id\": 25, \"name\": \"0251776191187.pdf\", \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": \"0251776191187.pdf\", \"cancelado\": \"50.00\", \"categoria\": \"A\", \"created_at\": \"2026-04-14T18:26:27.000000Z\", \"updated_at\": \"2026-04-14T18:26:27.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/0251776191187.pdf\", \"certificado_id\": 21, \"muestra_conteo\": false, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-14', '14:26:27', '2026-04-14 18:26:27', '2026-04-14 18:26:27'),
(60, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": \"6756756\", \"id\": 19, \"cel\": null, \"edad\": 28, \"ci_exp\": \"LP\", \"nombre\": \"JUAN\", \"materno\": \"\", \"paterno\": \"FLORES\", \"fecha_nac\": \"1998-03-01\", \"created_at\": \"2026-04-14T18:28:00.000000Z\", \"updated_at\": \"2026-04-14T18:28:00.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-14\"}', NULL, 'CLIENTES', '2026-04-14', '14:28:00', '2026-04-14 18:28:00', '2026-04-14 18:28:00'),
(61, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CERTIFICADO', '{\"id\": 22, \"tipo\": \"NORMAL\", \"saldo\": 0, \"total\": \"50\", \"user_id\": 1, \"cancelado\": 0, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"19\", \"created_at\": \"2026-04-14T18:28:13.000000Z\", \"updated_at\": \"2026-04-14T18:28:13.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"14:28:13\", \"fecha_registro\": \"2026-04-14\", \"certificado_detalles\": [{\"id\": 26, \"name\": \"0261776191293.pdf\", \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": \"0261776191293.pdf\", \"cancelado\": \"50.00\", \"categoria\": \"a\", \"created_at\": \"2026-04-14T18:28:13.000000Z\", \"updated_at\": \"2026-04-14T18:28:13.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/0261776191293.pdf\", \"certificado_id\": 22, \"muestra_conteo\": false, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-14', '14:28:13', '2026-04-14 18:28:13', '2026-04-14 18:28:13'),
(62, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": \"6756757\", \"id\": 20, \"cel\": null, \"edad\": 31, \"ci_exp\": \"CB\", \"nombre\": \"CARLOS\", \"materno\": \"MARTINEZ\", \"paterno\": \"FERNANDEZ\", \"fecha_nac\": \"1995-02-02\", \"created_at\": \"2026-04-14T18:29:11.000000Z\", \"updated_at\": \"2026-04-14T18:29:11.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-14\"}', NULL, 'CLIENTES', '2026-04-14', '14:29:11', '2026-04-14 18:29:11', '2026-04-14 18:29:11'),
(63, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CERTIFICADO', '{\"id\": 23, \"tipo\": \"NORMAL\", \"saldo\": 0, \"total\": \"50\", \"user_id\": 1, \"cancelado\": 0, \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"20\", \"created_at\": \"2026-04-14T18:29:19.000000Z\", \"updated_at\": \"2026-04-14T18:29:19.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"14:29:19\", \"fecha_registro\": \"2026-04-14\", \"certificado_detalles\": [{\"id\": 27, \"name\": \"0271776191359.pdf\", \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": \"0271776191359.pdf\", \"cancelado\": \"50.00\", \"categoria\": \"A\", \"created_at\": \"2026-04-14T18:29:19.000000Z\", \"updated_at\": \"2026-04-14T18:29:19.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/0271776191359.pdf\", \"certificado_id\": 23, \"muestra_conteo\": false, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-14', '14:29:19', '2026-04-14 18:29:19', '2026-04-14 18:29:19'),
(64, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": \"675756567\", \"id\": 21, \"cel\": null, \"edad\": 31, \"ci_exp\": \"LP\", \"nombre\": \"EDWIN\", \"materno\": \"\", \"paterno\": \"CONDORI\", \"fecha_nac\": \"1995-01-01\", \"created_at\": \"2026-04-14T18:30:12.000000Z\", \"updated_at\": \"2026-04-14T18:30:12.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-14\"}', NULL, 'CLIENTES', '2026-04-14', '14:30:12', '2026-04-14 18:30:12', '2026-04-14 18:30:12'),
(65, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO EL PAGO DE UN CERTIFICADO', '{\"id\": 10, \"hora\": \"14:30:21\", \"fecha\": \"2026-04-14\", \"monto\": \"50\", \"modulo\": \"Certificado\", \"user_id\": 1, \"tipo_pago\": \"EFECTIVO\", \"created_at\": \"2026-04-14T18:30:21.000000Z\", \"updated_at\": \"2026-04-14T18:30:21.000000Z\", \"descripcion\": \"PAGO POR CERTIFICADO\", \"registro_id\": 24, \"sucursal_id\": 1}', NULL, 'PAGOS', '2026-04-14', '14:30:21', '2026-04-14 18:30:21', '2026-04-14 18:30:21'),
(66, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CERTIFICADO', '{\"id\": 24, \"tipo\": \"NORMAL\", \"saldo\": 0, \"total\": \"50\", \"user_id\": 1, \"cancelado\": \"50\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"21\", \"created_at\": \"2026-04-14T18:30:21.000000Z\", \"updated_at\": \"2026-04-14T18:30:21.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"14:30:21\", \"fecha_registro\": \"2026-04-14\", \"certificado_detalles\": [{\"id\": 28, \"name\": \"0281776191421.pdf\", \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": \"0281776191421.pdf\", \"cancelado\": \"50.00\", \"categoria\": \"A\", \"created_at\": \"2026-04-14T18:30:21.000000Z\", \"updated_at\": \"2026-04-14T18:30:21.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/0281776191421.pdf\", \"certificado_id\": 24, \"muestra_conteo\": false, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-14', '14:30:21', '2026-04-14 18:30:21', '2026-04-14 18:30:21'),
(67, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO EL PAGO DE UN CERTIFICADO', '{\"id\": 11, \"hora\": \"14:31:15\", \"fecha\": \"2026-04-14\", \"monto\": \"50\", \"modulo\": \"Certificado\", \"user_id\": 1, \"tipo_pago\": \"EFECTIVO\", \"created_at\": \"2026-04-14T18:31:15.000000Z\", \"updated_at\": \"2026-04-14T18:31:15.000000Z\", \"descripcion\": \"PAGO POR CERTIFICADO\", \"registro_id\": 25, \"sucursal_id\": 1}', NULL, 'PAGOS', '2026-04-14', '14:31:15', '2026-04-14 18:31:15', '2026-04-14 18:31:15'),
(68, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CERTIFICADO', '{\"id\": 25, \"tipo\": \"NORMAL\", \"saldo\": 0, \"total\": \"50\", \"user_id\": 1, \"cancelado\": \"50\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"1\", \"created_at\": \"2026-04-14T18:31:15.000000Z\", \"updated_at\": \"2026-04-14T18:31:15.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"14:31:15\", \"fecha_registro\": \"2026-04-14\", \"certificado_detalles\": [{\"id\": 29, \"name\": \"0291776191475.pdf\", \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": \"0291776191475.pdf\", \"cancelado\": \"50.00\", \"categoria\": \"A\", \"created_at\": \"2026-04-14T18:31:15.000000Z\", \"updated_at\": \"2026-04-14T18:31:15.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/0291776191475.pdf\", \"certificado_id\": 25, \"muestra_conteo\": false, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-14', '14:31:15', '2026-04-14 18:31:15', '2026-04-14 18:31:15'),
(69, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": \"2432342\", \"id\": 22, \"cel\": null, \"edad\": 26, \"ci_exp\": \"LP\", \"nombre\": \"EFRAIN\", \"materno\": \"\", \"paterno\": \"MAMANI\", \"fecha_nac\": \"2000-01-01\", \"created_at\": \"2026-04-14T18:31:49.000000Z\", \"updated_at\": \"2026-04-14T18:31:49.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-14\"}', NULL, 'CLIENTES', '2026-04-14', '14:31:49', '2026-04-14 18:31:49', '2026-04-14 18:31:49'),
(70, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO EL PAGO DE UN CERTIFICADO', '{\"id\": 12, \"hora\": \"14:32:16\", \"fecha\": \"2026-04-14\", \"monto\": \"50\", \"modulo\": \"Certificado\", \"user_id\": 1, \"tipo_pago\": \"EFECTIVO\", \"created_at\": \"2026-04-14T18:32:16.000000Z\", \"updated_at\": \"2026-04-14T18:32:16.000000Z\", \"descripcion\": \"PAGO POR CERTIFICADO\", \"registro_id\": 26, \"sucursal_id\": 1}', NULL, 'PAGOS', '2026-04-14', '14:32:16', '2026-04-14 18:32:16', '2026-04-14 18:32:16'),
(71, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CERTIFICADO', '{\"id\": 26, \"tipo\": \"NORMAL\", \"saldo\": 0, \"total\": \"50\", \"user_id\": 1, \"cancelado\": \"50\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"22\", \"created_at\": \"2026-04-14T18:32:16.000000Z\", \"updated_at\": \"2026-04-14T18:32:16.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"14:32:16\", \"fecha_registro\": \"2026-04-14\", \"certificado_detalles\": [{\"id\": 30, \"name\": \"0301776191536.pdf\", \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": \"0301776191536.pdf\", \"cancelado\": \"50.00\", \"categoria\": \"A\", \"created_at\": \"2026-04-14T18:32:16.000000Z\", \"updated_at\": \"2026-04-14T18:32:16.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/0301776191536.pdf\", \"certificado_id\": 26, \"muestra_conteo\": false, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-14', '14:32:16', '2026-04-14 18:32:16', '2026-04-14 18:32:16'),
(72, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO EL PAGO DE UN CERTIFICADO', '{\"id\": 13, \"hora\": \"14:32:33\", \"fecha\": \"2026-04-14\", \"monto\": \"50\", \"modulo\": \"Certificado\", \"user_id\": 1, \"tipo_pago\": \"EFECTIVO\", \"created_at\": \"2026-04-14T18:32:33.000000Z\", \"updated_at\": \"2026-04-14T18:32:33.000000Z\", \"descripcion\": \"PAGO POR CERTIFICADO\", \"registro_id\": 27, \"sucursal_id\": 1}', NULL, 'PAGOS', '2026-04-14', '14:32:33', '2026-04-14 18:32:33', '2026-04-14 18:32:33'),
(73, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CERTIFICADO', '{\"id\": 27, \"tipo\": \"NORMAL\", \"saldo\": 0, \"total\": \"50\", \"user_id\": 1, \"cancelado\": \"50\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"6\", \"created_at\": \"2026-04-14T18:32:33.000000Z\", \"updated_at\": \"2026-04-14T18:32:33.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"14:32:33\", \"fecha_registro\": \"2026-04-14\", \"certificado_detalles\": [{\"id\": 31, \"name\": \"0311776191553.pdf\", \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": \"0311776191553.pdf\", \"cancelado\": \"50.00\", \"categoria\": \"A\", \"created_at\": \"2026-04-14T18:32:33.000000Z\", \"updated_at\": \"2026-04-14T18:32:33.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/0311776191553.pdf\", \"certificado_id\": 27, \"muestra_conteo\": false, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-14', '14:32:33', '2026-04-14 18:32:33', '2026-04-14 18:32:33'),
(74, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": \"23423423\", \"id\": 23, \"cel\": null, \"edad\": 27, \"ci_exp\": \"LP\", \"nombre\": \"GLADYS\", \"materno\": \"\", \"paterno\": \"CONDORI\", \"fecha_nac\": \"1999-01-01\", \"created_at\": \"2026-04-14T18:32:51.000000Z\", \"updated_at\": \"2026-04-14T18:32:51.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-14\"}', NULL, 'CLIENTES', '2026-04-14', '14:32:51', '2026-04-14 18:32:51', '2026-04-14 18:32:51'),
(75, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": \"324234234\", \"id\": 24, \"cel\": null, \"edad\": 29, \"ci_exp\": \"CB\", \"nombre\": \"FRANCO\", \"materno\": \"\", \"paterno\": \"MARTINEZ\", \"fecha_nac\": \"1997-01-01\", \"created_at\": \"2026-04-14T18:33:42.000000Z\", \"updated_at\": \"2026-04-14T18:33:42.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-14\"}', NULL, 'CLIENTES', '2026-04-14', '14:33:42', '2026-04-14 18:33:42', '2026-04-14 18:33:42'),
(76, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CERTIFICADO', '{\"id\": 28, \"tipo\": \"NORMAL\", \"saldo\": 0, \"total\": \"0\", \"user_id\": 1, \"cancelado\": \"0\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"23\", \"created_at\": \"2026-04-14T18:34:05.000000Z\", \"updated_at\": \"2026-04-14T18:34:05.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"14:34:05\", \"fecha_registro\": \"2026-04-14\", \"certificado_detalles\": [{\"id\": 32, \"name\": \"0321776191645.pdf\", \"saldo\": \"0.00\", \"precio\": \"0.00\", \"archivo\": \"0321776191645.pdf\", \"cancelado\": \"0.00\", \"categoria\": \"A\", \"created_at\": \"2026-04-14T18:34:05.000000Z\", \"updated_at\": \"2026-04-14T18:34:05.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/0321776191645.pdf\", \"certificado_id\": 28, \"muestra_conteo\": false, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-14', '14:34:05', '2026-04-14 18:34:05', '2026-04-14 18:34:05'),
(77, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": \"564456\", \"id\": 25, \"cel\": null, \"edad\": 26, \"ci_exp\": \"LP\", \"nombre\": \"ALEXIS\", \"materno\": \"\", \"paterno\": \"CONTREAS\", \"fecha_nac\": \"2000-01-01\", \"created_at\": \"2026-04-14T18:37:59.000000Z\", \"updated_at\": \"2026-04-14T18:37:59.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-14\"}', NULL, 'CLIENTES', '2026-04-14', '14:37:59', '2026-04-14 18:37:59', '2026-04-14 18:37:59'),
(78, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO EL PAGO DE UN CERTIFICADO', '{\"id\": 14, \"hora\": \"14:38:07\", \"fecha\": \"2026-04-14\", \"monto\": \"50\", \"modulo\": \"Certificado\", \"user_id\": 1, \"tipo_pago\": \"QR\", \"created_at\": \"2026-04-14T18:38:07.000000Z\", \"updated_at\": \"2026-04-14T18:38:07.000000Z\", \"descripcion\": \"PAGO POR CERTIFICADO\", \"registro_id\": 29, \"sucursal_id\": 1}', NULL, 'PAGOS', '2026-04-14', '14:38:07', '2026-04-14 18:38:07', '2026-04-14 18:38:07'),
(79, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CERTIFICADO', '{\"id\": 29, \"tipo\": \"NORMAL\", \"saldo\": 0, \"total\": \"50\", \"user_id\": 1, \"cancelado\": \"50\", \"tipo_pago\": \"QR\", \"cliente_id\": \"25\", \"created_at\": \"2026-04-14T18:38:07.000000Z\", \"updated_at\": \"2026-04-14T18:38:07.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"14:38:07\", \"fecha_registro\": \"2026-04-14\", \"certificado_detalles\": [{\"id\": 33, \"name\": \"0331776191887.pdf\", \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": \"0331776191887.pdf\", \"cancelado\": \"50.00\", \"categoria\": \"A\", \"created_at\": \"2026-04-14T18:38:07.000000Z\", \"updated_at\": \"2026-04-14T18:38:07.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/0331776191887.pdf\", \"certificado_id\": 29, \"muestra_conteo\": false, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-14', '14:38:07', '2026-04-14 18:38:07', '2026-04-14 18:38:07'),
(80, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": \"24243333\", \"id\": 26, \"cel\": null, \"edad\": 26, \"ci_exp\": \"LP\", \"nombre\": \"EDUARDO\", \"materno\": \"\", \"paterno\": \"MARTINEZ\", \"fecha_nac\": \"1999-12-12\", \"created_at\": \"2026-04-14T18:59:54.000000Z\", \"updated_at\": \"2026-04-14T18:59:54.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-14\"}', NULL, 'CLIENTES', '2026-04-14', '14:59:54', '2026-04-14 18:59:54', '2026-04-14 18:59:54'),
(81, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CERTIFICADO', '{\"id\": 30, \"tipo\": \"TRAMITE\", \"saldo\": \"0\", \"total\": \"50\", \"user_id\": 1, \"cancelado\": \"0\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"26\", \"created_at\": \"2026-04-14T19:00:15.000000Z\", \"updated_at\": \"2026-04-14T19:00:15.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"15:00:15\", \"fecha_registro\": \"2026-04-14\", \"certificado_detalles\": [{\"id\": 34, \"name\": \"0341776193215.pdf\", \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": \"0341776193215.pdf\", \"cancelado\": \"50.00\", \"categoria\": \"a\", \"created_at\": \"2026-04-14T19:00:15.000000Z\", \"updated_at\": \"2026-04-14T19:00:15.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/0341776193215.pdf\", \"certificado_id\": 30, \"muestra_conteo\": false, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-14', '15:00:15', '2026-04-14 19:00:15', '2026-04-14 19:00:15'),
(82, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": \"45345345\", \"id\": 27, \"cel\": null, \"edad\": 26, \"ci_exp\": \"LP\", \"nombre\": \"ELVIS\", \"materno\": \"\", \"paterno\": \"GONZALES\", \"fecha_nac\": \"2000-01-01\", \"created_at\": \"2026-04-14T19:30:09.000000Z\", \"updated_at\": \"2026-04-14T19:30:09.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-14\"}', NULL, 'CLIENTES', '2026-04-14', '15:30:09', '2026-04-14 19:30:09', '2026-04-14 19:30:09'),
(83, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTEadmin REGISTRO UN CLIENTE', '{\"ci\": \"455345\", \"id\": 28, \"cel\": null, \"edad\": 26, \"ci_exp\": \"LP\", \"nombre\": \"ELIZABETH\", \"materno\": \"\", \"paterno\": \"CARDONA\", \"fecha_nac\": \"2000-01-01\", \"created_at\": \"2026-04-14T19:30:09.000000Z\", \"updated_at\": \"2026-04-14T19:30:09.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-14\"}', NULL, 'CLIENTES', '2026-04-14', '15:30:09', '2026-04-14 19:30:09', '2026-04-14 19:30:09'),
(84, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTEadmin REGISTRO UN CLIENTEadmin REGISTRO UN CLIENTE', '{\"ci\": \"343434\", \"id\": 29, \"cel\": null, \"edad\": 27, \"ci_exp\": \"PT\", \"nombre\": \"FRANCISCA\", \"materno\": \"\", \"paterno\": \"CALLISAYA\", \"fecha_nac\": \"1999-02-02\", \"created_at\": \"2026-04-14T19:30:09.000000Z\", \"updated_at\": \"2026-04-14T19:30:09.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-14\"}', NULL, 'CLIENTES', '2026-04-14', '15:30:09', '2026-04-14 19:30:09', '2026-04-14 19:30:09'),
(85, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN TRAMITE', '{\"id\": 3, \"nro\": 3, \"hora\": \"15:30:09\", \"fecha\": \"2026-04-14\", \"codigo\": \"T3\", \"user_id\": 1, \"created_at\": \"2026-04-14T19:30:09.000000Z\", \"updated_at\": \"2026-04-14T19:30:09.000000Z\", \"sucursal_id\": \"1\", \"tramitador_id\": \"1\", \"tramite_clientes\": [{\"id\": 12, \"estado\": 0, \"existente\": false, \"cliente_id\": 27, \"created_at\": \"2026-04-14T19:30:09.000000Z\", \"tramite_id\": 3, \"updated_at\": \"2026-04-14T19:30:09.000000Z\", \"certificado_id\": null}, {\"id\": 13, \"estado\": 0, \"existente\": false, \"cliente_id\": 28, \"created_at\": \"2026-04-14T19:30:09.000000Z\", \"tramite_id\": 3, \"updated_at\": \"2026-04-14T19:30:09.000000Z\", \"certificado_id\": null}, {\"id\": 14, \"estado\": 0, \"existente\": false, \"cliente_id\": 29, \"created_at\": \"2026-04-14T19:30:09.000000Z\", \"tramite_id\": 3, \"updated_at\": \"2026-04-14T19:30:09.000000Z\", \"certificado_id\": null}]}', NULL, 'TRAMITES', '2026-04-14', '15:30:09', '2026-04-14 19:30:09', '2026-04-14 19:30:09'),
(86, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CERTIFICADO', '{\"id\": 31, \"tipo\": \"TRAMITE\", \"saldo\": \"0\", \"total\": \"50\", \"user_id\": 1, \"cancelado\": \"0\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"29\", \"created_at\": \"2026-04-14T19:30:25.000000Z\", \"updated_at\": \"2026-04-14T19:30:25.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"15:30:25\", \"fecha_registro\": \"2026-04-14\", \"certificado_detalles\": [{\"id\": 35, \"name\": \"0351776195025.pdf\", \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": \"0351776195025.pdf\", \"cancelado\": \"50.00\", \"categoria\": \"A\", \"created_at\": \"2026-04-14T19:30:25.000000Z\", \"updated_at\": \"2026-04-14T19:30:25.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/0351776195025.pdf\", \"certificado_id\": 31, \"muestra_conteo\": false, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-14', '15:30:25', '2026-04-14 19:30:25', '2026-04-14 19:30:25'),
(87, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CERTIFICADO', '{\"id\": 32, \"tipo\": \"TRAMITE\", \"saldo\": \"50.00\", \"total\": \"50\", \"user_id\": 1, \"cancelado\": \"0\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"27\", \"created_at\": \"2026-04-14T19:32:51.000000Z\", \"updated_at\": \"2026-04-14T19:32:51.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"15:32:51\", \"fecha_registro\": \"2026-04-14\", \"certificado_detalles\": [{\"id\": 36, \"name\": \"0361776195171.pdf\", \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": \"0361776195171.pdf\", \"cancelado\": \"50.00\", \"categoria\": \"A\", \"created_at\": \"2026-04-14T19:32:51.000000Z\", \"updated_at\": \"2026-04-14T19:32:51.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/0361776195171.pdf\", \"certificado_id\": 32, \"muestra_conteo\": false, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-14', '15:32:51', '2026-04-14 19:32:51', '2026-04-14 19:32:51'),
(88, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CERTIFICADO', '{\"id\": 33, \"tipo\": \"TRAMITE\", \"saldo\": \"50.00\", \"total\": \"50\", \"user_id\": 1, \"cancelado\": \"0\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"28\", \"created_at\": \"2026-04-14T19:35:31.000000Z\", \"updated_at\": \"2026-04-14T19:35:31.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"15:35:31\", \"fecha_registro\": \"2026-04-14\", \"certificado_detalles\": [{\"id\": 37, \"name\": \"0371776195331.pdf\", \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": \"0371776195331.pdf\", \"cancelado\": \"50.00\", \"categoria\": \"A\", \"created_at\": \"2026-04-14T19:35:31.000000Z\", \"updated_at\": \"2026-04-14T19:35:31.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/0371776195331.pdf\", \"certificado_id\": 33, \"muestra_conteo\": false, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-14', '15:35:31', '2026-04-14 19:35:31', '2026-04-14 19:35:31'),
(89, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": \"4534544\", \"id\": 30, \"cel\": null, \"edad\": 25, \"ci_exp\": \"LP\", \"nombre\": \"ALEJANDRA\", \"materno\": \"\", \"paterno\": \"MARCELL\", \"fecha_nac\": \"2001-01-01\", \"created_at\": \"2026-04-14T19:36:50.000000Z\", \"updated_at\": \"2026-04-14T19:36:50.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-14\"}', NULL, 'CLIENTES', '2026-04-14', '15:36:50', '2026-04-14 19:36:50', '2026-04-14 19:36:50'),
(90, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO EL PAGO DE UN CERTIFICADO', '{\"id\": 15, \"hora\": \"15:36:57\", \"fecha\": \"2026-04-14\", \"monto\": \"50\", \"modulo\": \"Certificado\", \"user_id\": 1, \"tipo_pago\": \"EFECTIVO\", \"created_at\": \"2026-04-14T19:36:57.000000Z\", \"updated_at\": \"2026-04-14T19:36:57.000000Z\", \"descripcion\": \"PAGO POR CERTIFICADO\", \"registro_id\": 34, \"sucursal_id\": 1}', NULL, 'PAGOS', '2026-04-14', '15:36:57', '2026-04-14 19:36:57', '2026-04-14 19:36:57'),
(91, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CERTIFICADO', '{\"id\": 34, \"tipo\": \"NORMAL\", \"saldo\": 0, \"total\": \"50\", \"user_id\": 1, \"cancelado\": \"50\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"30\", \"created_at\": \"2026-04-14T19:36:57.000000Z\", \"updated_at\": \"2026-04-14T19:36:57.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"15:36:57\", \"fecha_registro\": \"2026-04-14\", \"certificado_detalles\": [{\"id\": 38, \"name\": \"0381776195417.pdf\", \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": \"0381776195417.pdf\", \"cancelado\": \"50.00\", \"categoria\": \"A\", \"created_at\": \"2026-04-14T19:36:57.000000Z\", \"updated_at\": \"2026-04-14T19:36:57.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/0381776195417.pdf\", \"certificado_id\": 34, \"muestra_conteo\": false, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-14', '15:36:57', '2026-04-14 19:36:57', '2026-04-14 19:36:57'),
(92, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO EL PAGO DE UN CERTIFICADO', '{\"id\": 16, \"hora\": \"15:38:46\", \"fecha\": \"2026-04-14\", \"monto\": \"50\", \"modulo\": \"Certificado\", \"user_id\": 1, \"tipo_pago\": \"EFECTIVO\", \"created_at\": \"2026-04-14T19:38:46.000000Z\", \"updated_at\": \"2026-04-14T19:38:46.000000Z\", \"descripcion\": \"PAGO POR CERTIFICADO\", \"registro_id\": 35, \"sucursal_id\": 1}', NULL, 'PAGOS', '2026-04-14', '15:38:46', '2026-04-14 19:38:46', '2026-04-14 19:38:46'),
(93, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CERTIFICADO', '{\"id\": 35, \"tipo\": \"NORMAL\", \"saldo\": 0, \"total\": \"50\", \"user_id\": 1, \"cancelado\": \"50\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"6\", \"created_at\": \"2026-04-14T19:38:46.000000Z\", \"updated_at\": \"2026-04-14T19:38:46.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"15:38:46\", \"fecha_registro\": \"2026-04-14\", \"certificado_detalles\": [{\"id\": 39, \"name\": \"0391776195526.pdf\", \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": \"0391776195526.pdf\", \"cancelado\": \"50.00\", \"categoria\": \"A\", \"created_at\": \"2026-04-14T19:38:46.000000Z\", \"updated_at\": \"2026-04-14T19:38:46.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/0391776195526.pdf\", \"certificado_id\": 35, \"muestra_conteo\": false, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-14', '15:38:46', '2026-04-14 19:38:46', '2026-04-14 19:38:46'),
(94, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": \"34534544\", \"id\": 31, \"cel\": null, \"edad\": 27, \"ci_exp\": \"TJ\", \"nombre\": \"ALEXA\", \"materno\": \"\", \"paterno\": \"MARTINEZ\", \"fecha_nac\": \"1999-01-01\", \"created_at\": \"2026-04-14T19:39:23.000000Z\", \"updated_at\": \"2026-04-14T19:39:23.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-14\"}', NULL, 'CLIENTES', '2026-04-14', '15:39:23', '2026-04-14 19:39:23', '2026-04-14 19:39:23'),
(95, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CERTIFICADO', '{\"id\": 36, \"tipo\": \"TRAMITE\", \"saldo\": \"50.00\", \"total\": \"50\", \"user_id\": 1, \"cancelado\": \"0\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"31\", \"created_at\": \"2026-04-14T19:39:37.000000Z\", \"updated_at\": \"2026-04-14T19:39:37.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"15:39:37\", \"fecha_registro\": \"2026-04-14\", \"certificado_detalles\": [{\"id\": 40, \"name\": null, \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": null, \"cancelado\": \"50.00\", \"categoria\": \"A\", \"created_at\": \"2026-04-14T19:39:37.000000Z\", \"updated_at\": \"2026-04-14T19:39:37.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados\", \"certificado_id\": 36, \"muestra_conteo\": false, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-14', '15:39:37', '2026-04-14 19:39:37', '2026-04-14 19:39:37'),
(96, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": \"32423434\", \"id\": 32, \"cel\": null, \"edad\": 25, \"ci_exp\": \"LP\", \"nombre\": \"FRANCIS\", \"materno\": \"\", \"paterno\": \"CALDERON\", \"fecha_nac\": \"2001-02-02\", \"created_at\": \"2026-04-14T19:40:04.000000Z\", \"updated_at\": \"2026-04-14T19:40:04.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-14\"}', NULL, 'CLIENTES', '2026-04-14', '15:40:04', '2026-04-14 19:40:04', '2026-04-14 19:40:04'),
(97, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO EL PAGO DE UN CERTIFICADO', '{\"id\": 17, \"hora\": \"15:40:35\", \"fecha\": \"2026-04-14\", \"monto\": \"60\", \"modulo\": \"Certificado\", \"user_id\": 1, \"tipo_pago\": \"EFECTIVO\", \"created_at\": \"2026-04-14T19:40:35.000000Z\", \"updated_at\": \"2026-04-14T19:40:35.000000Z\", \"descripcion\": \"PAGO POR CERTIFICADO\", \"registro_id\": 37, \"sucursal_id\": 1}', NULL, 'PAGOS', '2026-04-14', '15:40:35', '2026-04-14 19:40:35', '2026-04-14 19:40:35'),
(98, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CERTIFICADO', '{\"id\": 37, \"tipo\": \"TRAMITE\", \"saldo\": 50, \"total\": \"110\", \"user_id\": 1, \"cancelado\": \"60\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"32\", \"created_at\": \"2026-04-14T19:40:35.000000Z\", \"updated_at\": \"2026-04-14T19:40:35.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"15:40:35\", \"fecha_registro\": \"2026-04-14\", \"certificado_detalles\": [{\"id\": 41, \"name\": \"0411776195635.pdf\", \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": \"0411776195635.pdf\", \"cancelado\": \"50.00\", \"categoria\": \"A\", \"created_at\": \"2026-04-14T19:40:35.000000Z\", \"updated_at\": \"2026-04-14T19:40:35.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/0411776195635.pdf\", \"certificado_id\": 37, \"muestra_conteo\": false, \"tipo_certificado_id\": 1}, {\"id\": 42, \"name\": \"1421776195635.pdf\", \"saldo\": \"0.00\", \"precio\": \"60.00\", \"archivo\": \"1421776195635.pdf\", \"cancelado\": \"60.00\", \"categoria\": \"A\", \"created_at\": \"2026-04-14T19:40:35.000000Z\", \"updated_at\": \"2026-04-14T19:40:35.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/1421776195635.pdf\", \"certificado_id\": 37, \"muestra_conteo\": false, \"tipo_certificado_id\": 3}]}', NULL, 'CERTIFICADOS', '2026-04-14', '15:40:35', '2026-04-14 19:40:35', '2026-04-14 19:40:35'),
(99, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN USUARIO', '{\"ci\": \"32234234\", \"id\": 4, \"dir\": \"\", \"fono\": \"67676767\", \"foto\": \"41775258996.jpg\", \"tipo\": \"MÉDICO\", \"acceso\": 1, \"ci_exp\": \"CB\", \"correo\": null, \"nombre\": \"GEOVANA\", \"status\": 1, \"materno\": \"MARTINEZ\", \"paterno\": \"MARTINEZ\", \"usuario\": \"GMARTINEZ\", \"created_at\": \"2026-04-04T03:29:56.000000Z\", \"updated_at\": \"2026-04-11T23:35:41.000000Z\", \"sucursal_id\": 2, \"fecha_registro\": \"2026-04-03\"}', '{\"ci\": \"32234234\", \"id\": 4, \"dir\": \"\", \"fono\": \"67676767\", \"foto\": \"41775258996.jpg\", \"tipo\": \"MÉDICO\", \"acceso\": \"1\", \"ci_exp\": \"CB\", \"correo\": null, \"nombre\": \"GEOVANA\", \"status\": 1, \"materno\": \"MARTINEZ\", \"paterno\": \"MARTINEZ\", \"usuario\": \"GMARTINEZ\", \"created_at\": \"2026-04-04T03:29:56.000000Z\", \"updated_at\": \"2026-04-14T20:55:35.000000Z\", \"sucursal_id\": \"1\", \"fecha_registro\": \"2026-04-03\"}', 'USUARIOS', '2026-04-14', '16:55:35', '2026-04-14 20:55:35', '2026-04-14 20:55:35'),
(100, 4, 'CREACIÓN', 'EL USUARIO GMARTINEZ REGISTRO EL PAGO DE UN CERTIFICADO', '{\"id\": 18, \"hora\": \"17:01:58\", \"fecha\": \"2026-04-14\", \"monto\": \"50\", \"modulo\": \"Certificado\", \"user_id\": 4, \"tipo_pago\": \"EFECTIVO\", \"created_at\": \"2026-04-14T21:01:58.000000Z\", \"updated_at\": \"2026-04-14T21:01:58.000000Z\", \"descripcion\": \"PAGO POR CERTIFICADO\", \"registro_id\": 38, \"sucursal_id\": 1}', NULL, 'PAGOS', '2026-04-14', '17:01:58', '2026-04-14 21:01:58', '2026-04-14 21:01:58'),
(101, 4, 'CREACIÓN', 'EL USUARIO GMARTINEZ REGISTRO UN CERTIFICADO', '{\"id\": 38, \"tipo\": \"NORMAL\", \"saldo\": 0, \"total\": \"50\", \"user_id\": 4, \"cancelado\": \"50\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"1\", \"created_at\": \"2026-04-14T21:01:58.000000Z\", \"updated_at\": \"2026-04-14T21:01:58.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"17:01:58\", \"fecha_registro\": \"2026-04-14\", \"certificado_detalles\": [{\"id\": 43, \"name\": \"0431776200518.pdf\", \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": \"0431776200518.pdf\", \"cancelado\": \"50.00\", \"categoria\": \"A\", \"created_at\": \"2026-04-14T21:01:58.000000Z\", \"updated_at\": \"2026-04-14T21:01:58.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/0431776200518.pdf\", \"certificado_id\": 38, \"muestra_conteo\": false, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-14', '17:01:58', '2026-04-14 21:01:58', '2026-04-14 21:01:58'),
(102, 4, 'CREACIÓN', 'EL USUARIO GMARTINEZ REGISTRO UN CLIENTE', '{\"ci\": \"234234\", \"id\": 33, \"cel\": null, \"edad\": 20, \"ci_exp\": \"LP\", \"nombre\": \"FERNANDO\", \"materno\": \"\", \"paterno\": \"GONZALES\", \"fecha_nac\": \"2006-02-02\", \"created_at\": \"2026-04-14T21:08:16.000000Z\", \"updated_at\": \"2026-04-14T21:08:16.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-14\"}', NULL, 'CLIENTES', '2026-04-14', '17:08:16', '2026-04-14 21:08:16', '2026-04-14 21:08:16'),
(103, 4, 'CREACIÓN', 'EL USUARIO GMARTINEZ REGISTRO UN TRAMITE', '{\"id\": 4, \"nro\": 4, \"hora\": \"17:08:16\", \"fecha\": \"2026-04-14\", \"codigo\": \"T4\", \"user_id\": 4, \"created_at\": \"2026-04-14T21:08:16.000000Z\", \"updated_at\": \"2026-04-14T21:08:16.000000Z\", \"sucursal_id\": \"1\", \"tramitador_id\": \"1\", \"tramite_clientes\": [{\"id\": 17, \"estado\": 0, \"existente\": false, \"cliente_id\": 33, \"created_at\": \"2026-04-14T21:08:16.000000Z\", \"tramite_id\": 4, \"updated_at\": \"2026-04-14T21:08:16.000000Z\", \"certificado_id\": null}, {\"id\": 18, \"estado\": 0, \"existente\": true, \"cliente_id\": 6, \"created_at\": \"2026-04-14T21:08:16.000000Z\", \"tramite_id\": 4, \"updated_at\": \"2026-04-14T21:08:16.000000Z\", \"certificado_id\": null}]}', NULL, 'TRAMITES', '2026-04-14', '17:08:16', '2026-04-14 21:08:16', '2026-04-14 21:08:16'),
(104, 4, 'CREACIÓN', 'EL USUARIO GMARTINEZ REGISTRO UN CERTIFICADO', '{\"id\": 39, \"tipo\": \"TRAMITE\", \"saldo\": \"50.00\", \"total\": \"50\", \"user_id\": 4, \"cancelado\": \"0\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"33\", \"created_at\": \"2026-04-14T21:08:53.000000Z\", \"updated_at\": \"2026-04-14T21:08:53.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"17:08:53\", \"fecha_registro\": \"2026-04-14\", \"certificado_detalles\": [{\"id\": 44, \"name\": \"0441776200933.pdf\", \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": \"0441776200933.pdf\", \"cancelado\": \"50.00\", \"categoria\": \"A\", \"created_at\": \"2026-04-14T21:08:53.000000Z\", \"updated_at\": \"2026-04-14T21:08:53.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/0441776200933.pdf\", \"certificado_id\": 39, \"muestra_conteo\": false, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-14', '17:08:53', '2026-04-14 21:08:53', '2026-04-14 21:08:53'),
(105, 4, 'CREACIÓN', 'EL USUARIO GMARTINEZ REGISTRO EL PAGO DE UN CERTIFICADO', '{\"id\": 19, \"hora\": \"17:09:07\", \"fecha\": \"2026-04-14\", \"monto\": \"50\", \"modulo\": \"Certificado\", \"user_id\": 4, \"tipo_pago\": \"EFECTIVO\", \"created_at\": \"2026-04-14T21:09:07.000000Z\", \"updated_at\": \"2026-04-14T21:09:07.000000Z\", \"descripcion\": \"PAGO POR CERTIFICADO\", \"registro_id\": 40, \"sucursal_id\": 1}', NULL, 'PAGOS', '2026-04-14', '17:09:07', '2026-04-14 21:09:07', '2026-04-14 21:09:07'),
(106, 4, 'CREACIÓN', 'EL USUARIO GMARTINEZ REGISTRO UN CERTIFICADO', '{\"id\": 40, \"tipo\": \"TRAMITE\", \"saldo\": 0, \"total\": \"50\", \"user_id\": 4, \"cancelado\": \"50\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"6\", \"created_at\": \"2026-04-14T21:09:07.000000Z\", \"updated_at\": \"2026-04-14T21:09:07.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"17:09:07\", \"fecha_registro\": \"2026-04-14\", \"certificado_detalles\": [{\"id\": 45, \"name\": \"0451776200947.pdf\", \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": \"0451776200947.pdf\", \"cancelado\": \"50.00\", \"categoria\": \"C\", \"created_at\": \"2026-04-14T21:09:07.000000Z\", \"updated_at\": \"2026-04-14T21:09:07.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/0451776200947.pdf\", \"certificado_id\": 40, \"muestra_conteo\": false, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-14', '17:09:07', '2026-04-14 21:09:07', '2026-04-14 21:09:07'),
(107, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN CLIENTE', '{\"ci\": \"43534534\", \"id\": 34, \"cel\": null, \"edad\": 30, \"ci_exp\": \"CB\", \"nombre\": \"PEDRO\", \"materno\": \"\", \"paterno\": \"CASTRO\", \"fecha_nac\": \"1996-01-01\", \"created_at\": \"2026-04-14T21:11:08.000000Z\", \"updated_at\": \"2026-04-14T21:11:08.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-14\"}', NULL, 'CLIENTES', '2026-04-14', '17:11:08', '2026-04-14 21:11:08', '2026-04-14 21:11:08'),
(108, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO EL PAGO DE UN CERTIFICADO', '{\"id\": 20, \"hora\": \"17:11:10\", \"fecha\": \"2026-04-14\", \"monto\": \"50\", \"modulo\": \"Certificado\", \"user_id\": 2, \"tipo_pago\": \"EFECTIVO\", \"created_at\": \"2026-04-14T21:11:10.000000Z\", \"updated_at\": \"2026-04-14T21:11:10.000000Z\", \"descripcion\": \"PAGO POR CERTIFICADO\", \"registro_id\": 41, \"sucursal_id\": 2}', NULL, 'PAGOS', '2026-04-14', '17:11:10', '2026-04-14 21:11:10', '2026-04-14 21:11:10'),
(109, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN CERTIFICADO', '{\"id\": 41, \"tipo\": \"NORMAL\", \"saldo\": 0, \"total\": \"50\", \"user_id\": 2, \"cancelado\": \"50\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"34\", \"created_at\": \"2026-04-14T21:11:10.000000Z\", \"updated_at\": \"2026-04-14T21:11:10.000000Z\", \"sucursal_id\": \"2\", \"hora_registro\": \"17:11:10\", \"fecha_registro\": \"2026-04-14\", \"certificado_detalles\": [{\"id\": 46, \"name\": \"0461776201070.pdf\", \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": \"0461776201070.pdf\", \"cancelado\": \"50.00\", \"categoria\": \"A\", \"created_at\": \"2026-04-14T21:11:10.000000Z\", \"updated_at\": \"2026-04-14T21:11:10.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/0461776201070.pdf\", \"certificado_id\": 41, \"muestra_conteo\": false, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-14', '17:11:10', '2026-04-14 21:11:10', '2026-04-14 21:11:10'),
(110, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN TRAMITADOR', '{\"ci\": \"45334534\", \"id\": 3, \"cel\": \"65656565\", \"ci_exp\": \"LP\", \"nombre\": \"ELVIRA MARTINEZ\", \"created_at\": \"2026-04-14T21:11:37.000000Z\", \"updated_at\": \"2026-04-14T21:11:37.000000Z\", \"fecha_registro\": \"2026-04-14\"}', NULL, 'TRAMITADORES', '2026-04-14', '17:11:37', '2026-04-14 21:11:37', '2026-04-14 21:11:37'),
(111, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN CLIENTE', '{\"ci\": \"1332332\", \"id\": 35, \"cel\": null, \"edad\": 26, \"ci_exp\": \"PT\", \"nombre\": \"FELIX\", \"materno\": \"\", \"paterno\": \"MAMANI\", \"fecha_nac\": \"2000-01-01\", \"created_at\": \"2026-04-14T21:12:12.000000Z\", \"updated_at\": \"2026-04-14T21:12:12.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-14\"}', NULL, 'CLIENTES', '2026-04-14', '17:12:12', '2026-04-14 21:12:12', '2026-04-14 21:12:12'),
(112, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN CLIENTEJPERES REGISTRO UN CLIENTE', '{\"ci\": \"45445444\", \"id\": 36, \"cel\": null, \"edad\": 23, \"ci_exp\": \"LP\", \"nombre\": \"ALEX\", \"materno\": \"\", \"paterno\": \"CONTRERAS\", \"fecha_nac\": \"2003-03-03\", \"created_at\": \"2026-04-14T21:12:12.000000Z\", \"updated_at\": \"2026-04-14T21:12:12.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-14\"}', NULL, 'CLIENTES', '2026-04-14', '17:12:12', '2026-04-14 21:12:12', '2026-04-14 21:12:12'),
(113, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN TRAMITE', '{\"id\": 5, \"nro\": 5, \"hora\": \"17:12:12\", \"fecha\": \"2026-04-14\", \"codigo\": \"T5\", \"user_id\": 2, \"created_at\": \"2026-04-14T21:12:12.000000Z\", \"updated_at\": \"2026-04-14T21:12:12.000000Z\", \"sucursal_id\": \"2\", \"tramitador_id\": \"3\", \"tramite_clientes\": [{\"id\": 19, \"estado\": 0, \"existente\": false, \"cliente_id\": 35, \"created_at\": \"2026-04-14T21:12:12.000000Z\", \"tramite_id\": 5, \"updated_at\": \"2026-04-14T21:12:12.000000Z\", \"certificado_id\": null}, {\"id\": 20, \"estado\": 0, \"existente\": false, \"cliente_id\": 36, \"created_at\": \"2026-04-14T21:12:12.000000Z\", \"tramite_id\": 5, \"updated_at\": \"2026-04-14T21:12:12.000000Z\", \"certificado_id\": null}]}', NULL, 'TRAMITES', '2026-04-14', '17:12:12', '2026-04-14 21:12:12', '2026-04-14 21:12:12'),
(114, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN CERTIFICADO', '{\"id\": 42, \"tipo\": \"TRAMITE\", \"saldo\": \"140.00\", \"total\": \"140\", \"user_id\": 2, \"cancelado\": \"0\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"35\", \"created_at\": \"2026-04-14T21:12:37.000000Z\", \"updated_at\": \"2026-04-14T21:12:37.000000Z\", \"sucursal_id\": \"2\", \"hora_registro\": \"17:12:37\", \"fecha_registro\": \"2026-04-14\", \"certificado_detalles\": [{\"id\": 47, \"name\": \"0471776201157.pdf\", \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": \"0471776201157.pdf\", \"cancelado\": \"50.00\", \"categoria\": \"A\", \"created_at\": \"2026-04-14T21:12:37.000000Z\", \"updated_at\": \"2026-04-14T21:12:37.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/0471776201157.pdf\", \"certificado_id\": 42, \"muestra_conteo\": false, \"tipo_certificado_id\": 1}, {\"id\": 48, \"name\": \"1481776201157.pdf\", \"saldo\": \"0.00\", \"precio\": \"90.00\", \"archivo\": \"1481776201157.pdf\", \"cancelado\": \"90.00\", \"categoria\": \"A\", \"created_at\": \"2026-04-14T21:12:37.000000Z\", \"updated_at\": \"2026-04-14T21:12:37.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/1481776201157.pdf\", \"certificado_id\": 42, \"muestra_conteo\": false, \"tipo_certificado_id\": 2}]}', NULL, 'CERTIFICADOS', '2026-04-14', '17:12:37', '2026-04-14 21:12:37', '2026-04-14 21:12:37'),
(115, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO EL PAGO DE UN CERTIFICADO', '{\"id\": 21, \"hora\": \"17:12:52\", \"fecha\": \"2026-04-14\", \"monto\": \"50\", \"modulo\": \"Certificado\", \"user_id\": 2, \"tipo_pago\": \"EFECTIVO\", \"created_at\": \"2026-04-14T21:12:52.000000Z\", \"updated_at\": \"2026-04-14T21:12:52.000000Z\", \"descripcion\": \"PAGO POR CERTIFICADO\", \"registro_id\": 43, \"sucursal_id\": 2}', NULL, 'PAGOS', '2026-04-14', '17:12:52', '2026-04-14 21:12:52', '2026-04-14 21:12:52'),
(116, 2, 'CREACIÓN', 'EL USUARIO JPERES REGISTRO UN CERTIFICADO', '{\"id\": 43, \"tipo\": \"TRAMITE\", \"saldo\": 0, \"total\": \"50\", \"user_id\": 2, \"cancelado\": \"50\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"36\", \"created_at\": \"2026-04-14T21:12:52.000000Z\", \"updated_at\": \"2026-04-14T21:12:52.000000Z\", \"sucursal_id\": \"2\", \"hora_registro\": \"17:12:52\", \"fecha_registro\": \"2026-04-14\", \"certificado_detalles\": [{\"id\": 49, \"name\": \"0491776201172.pdf\", \"saldo\": \"0.00\", \"precio\": \"50.00\", \"archivo\": \"0491776201172.pdf\", \"cancelado\": \"50.00\", \"categoria\": \"A\", \"created_at\": \"2026-04-14T21:12:52.000000Z\", \"updated_at\": \"2026-04-14T21:12:52.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/0491776201172.pdf\", \"certificado_id\": 43, \"muestra_conteo\": false, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-14', '17:12:52', '2026-04-14 21:12:52', '2026-04-14 21:12:52'),
(117, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN USUARIO', '{\"ci\": \"343434\", \"id\": 6, \"dir\": \"\", \"fono\": \"67676767\", \"tipo\": \"SECRETARIA\", \"acceso\": \"1\", \"ci_exp\": \"LP\", \"correo\": null, \"nombre\": \"MARIA\", \"materno\": \"GONZALES\", \"paterno\": \"GONZALES\", \"usuario\": \"MGONZALES1\", \"created_at\": \"2026-04-14T21:13:22.000000Z\", \"updated_at\": \"2026-04-14T21:13:22.000000Z\", \"sucursal_id\": \"2\", \"fecha_registro\": \"2026-04-14\"}', NULL, 'USUARIOS', '2026-04-14', '17:13:22', '2026-04-14 21:13:22', '2026-04-14 21:13:22'),
(118, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN USUARIO', '{\"ci\": \"56445645\", \"id\": 5, \"dir\": \"\", \"fono\": \"67676767\", \"foto\": null, \"tipo\": \"GERENTE\", \"acceso\": 1, \"ci_exp\": \"LP\", \"correo\": null, \"nombre\": \"SANDRA\", \"status\": 1, \"materno\": \"\", \"paterno\": \"MARTINEZ\", \"usuario\": \"SMARTINEZ\", \"created_at\": \"2026-04-07T17:27:08.000000Z\", \"updated_at\": \"2026-04-11T23:34:50.000000Z\", \"sucursal_id\": 1, \"fecha_registro\": \"2026-04-07\"}', '{\"ci\": \"56445645\", \"id\": 5, \"dir\": \"\", \"fono\": \"67676767\", \"foto\": \"51776222570.png\", \"tipo\": \"GERENTE\", \"acceso\": \"1\", \"ci_exp\": \"LP\", \"correo\": null, \"nombre\": \"SANDRA\", \"status\": 1, \"materno\": \"\", \"paterno\": \"MARTINEZ\", \"usuario\": \"SMARTINEZ\", \"created_at\": \"2026-04-07T17:27:08.000000Z\", \"updated_at\": \"2026-04-15T03:09:30.000000Z\", \"sucursal_id\": \"1\", \"fecha_registro\": \"2026-04-07\"}', 'USUARIOS', '2026-04-14', '23:09:30', '2026-04-15 03:09:30', '2026-04-15 03:09:30'),
(119, 1, 'MODIFICACIÓN', 'EL USUARIO admin ACTUALIZÓ UN USUARIO', '{\"ci\": \"56445645\", \"id\": 5, \"dir\": \"\", \"fono\": \"67676767\", \"foto\": \"51776222570.png\", \"tipo\": \"GERENTE\", \"acceso\": 1, \"ci_exp\": \"LP\", \"correo\": null, \"nombre\": \"SANDRA\", \"status\": 1, \"materno\": \"\", \"paterno\": \"MARTINEZ\", \"usuario\": \"SMARTINEZ\", \"created_at\": \"2026-04-07T17:27:08.000000Z\", \"updated_at\": \"2026-04-15T03:09:30.000000Z\", \"sucursal_id\": 1, \"fecha_registro\": \"2026-04-07\"}', '{\"ci\": \"56445645\", \"id\": 5, \"dir\": \"\", \"fono\": \"67676767\", \"foto\": \"51776223560.png\", \"tipo\": \"GERENTE\", \"acceso\": \"1\", \"ci_exp\": \"LP\", \"correo\": null, \"nombre\": \"SANDRA\", \"status\": 1, \"materno\": \"\", \"paterno\": \"MARTINEZ\", \"usuario\": \"SMARTINEZ\", \"created_at\": \"2026-04-07T17:27:08.000000Z\", \"updated_at\": \"2026-04-15T03:26:00.000000Z\", \"sucursal_id\": \"1\", \"fecha_registro\": \"2026-04-07\"}', 'USUARIOS', '2026-04-14', '23:26:00', '2026-04-15 03:26:00', '2026-04-15 03:26:00');
INSERT INTO `historial_accions` (`id`, `user_id`, `accion`, `descripcion`, `datos_original`, `datos_nuevo`, `modulo`, `fecha`, `hora`, `created_at`, `updated_at`) VALUES
(120, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CERTIFICADO', '{\"id\": 44, \"tipo\": \"NORMAL\", \"saldo\": 0, \"total\": \"0\", \"user_id\": 1, \"cancelado\": \"0\", \"tipo_pago\": \"EFECTIVO\", \"cliente_id\": \"1\", \"created_at\": \"2026-04-15T03:26:27.000000Z\", \"updated_at\": \"2026-04-15T03:26:27.000000Z\", \"sucursal_id\": \"1\", \"hora_registro\": \"23:26:27\", \"fecha_registro\": \"2026-04-14\", \"certificado_detalles\": [{\"id\": 50, \"name\": \"0501776223587.pdf\", \"saldo\": \"0.00\", \"precio\": \"0.00\", \"archivo\": \"0501776223587.pdf\", \"cancelado\": \"0.00\", \"categoria\": \"A\", \"created_at\": \"2026-04-15T03:26:27.000000Z\", \"updated_at\": \"2026-04-15T03:26:27.000000Z\", \"url_archivo\": \"http://medinter.test/files/certificados/0501776223587.pdf\", \"certificado_id\": 44, \"muestra_conteo\": false, \"tipo_certificado_id\": 1}]}', NULL, 'CERTIFICADOS', '2026-04-14', '23:26:27', '2026-04-15 03:26:27', '2026-04-15 03:26:27'),
(121, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": \"2342343\", \"id\": 37, \"cel\": null, \"edad\": \"27\", \"ci_exp\": \"CB\", \"nombre\": \"EDUARDO\", \"materno\": \"\", \"paterno\": \"MANSILLA\", \"fecha_nac\": \"1999-01-01\", \"created_at\": \"2026-04-16T12:25:10.000000Z\", \"updated_at\": \"2026-04-16T12:25:10.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-16\"}', NULL, 'CLIENTES', '2026-04-16', '08:25:10', '2026-04-16 12:25:10', '2026-04-16 12:25:10'),
(122, 1, 'CREACIÓN', 'EL USUARIO admin REGISTRO UN CLIENTE', '{\"ci\": \"455445\", \"id\": 38, \"cel\": null, \"edad\": \"27\", \"ci_exp\": \"LP\", \"nombre\": \"JORGE\", \"materno\": \"\", \"paterno\": \"CONTRERAS\", \"fecha_nac\": \"1999-01-01\", \"created_at\": \"2026-04-16T12:25:35.000000Z\", \"updated_at\": \"2026-04-16T12:25:35.000000Z\", \"complemento\": \"\", \"fecha_registro\": \"2026-04-16\"}', NULL, 'CLIENTES', '2026-04-16', '08:25:35', '2026-04-16 12:25:35', '2026-04-16 12:25:35');

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
(1, 4, 1, '2026-04-14', '16:55:47', '2026-04-14 20:55:47', '2026-04-14 20:55:47'),
(2, 2, 2, '2026-04-14', '17:10:28', '2026-04-14 21:10:28', '2026-04-14 21:10:28');

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
  `user_id` bigint UNSIGNED NOT NULL,
  `sucursal_id` bigint UNSIGNED NOT NULL,
  `verificado` int NOT NULL DEFAULT '0',
  `fecha_verificado` date DEFAULT NULL,
  `hora_verificado` time DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Volcado de datos para la tabla `pagos`
--

INSERT INTO `pagos` (`id`, `registro_id`, `modulo`, `monto`, `tipo_pago`, `descripcion`, `fecha`, `hora`, `user_id`, `sucursal_id`, `verificado`, `fecha_verificado`, `hora_verificado`, `created_at`, `updated_at`) VALUES
(1, 10, 'Certificado', 30.00, 'EFECTIVO', 'PAGO POR CERTIFICADO', '2026-04-13', '16:48:44', 1, 1, 1, '2026-04-14', '09:31:04', '2026-04-13 20:48:44', '2026-04-14 13:31:04'),
(2, 9, 'Certificado', 30.00, 'EFECTIVO', 'PAGO POR CERTIFICADO', '2026-04-13', '16:48:57', 1, 1, 1, '2026-04-14', '09:31:04', '2026-04-13 20:48:57', '2026-04-14 13:31:04'),
(3, 8, 'Certificado', 15.00, 'EFECTIVO', 'PAGO POR CERTIFICADO', '2026-04-13', '16:49:03', 1, 1, 1, '2026-04-14', '09:31:04', '2026-04-13 20:49:03', '2026-04-14 13:31:04'),
(4, 8, 'Certificado', 15.00, 'EFECTIVO', 'PAGO POR CERTIFICADO', '2026-04-13', '16:49:41', 1, 1, 0, NULL, NULL, '2026-04-13 20:49:41', '2026-04-13 20:49:41'),
(5, 7, 'Certificado', 10.00, 'EFECTIVO', 'PAGO POR CERTIFICADO', '2026-04-13', '16:50:24', 1, 1, 0, NULL, NULL, '2026-04-13 20:50:24', '2026-04-13 20:50:24'),
(6, 7, 'Certificado', 10.00, 'EFECTIVO', 'PAGO POR CERTIFICADO', '2026-04-13', '16:50:36', 1, 1, 0, NULL, NULL, '2026-04-13 20:50:36', '2026-04-13 20:50:36'),
(7, 7, 'Certificado', 10.00, 'EFECTIVO', 'PAGO POR CERTIFICADO', '2026-04-13', '16:50:48', 1, 1, 1, '2026-04-14', '14:30:35', '2026-04-13 20:50:48', '2026-04-14 18:30:35'),
(8, 6, 'Certificado', 30.00, 'EFECTIVO', 'PAGO POR CERTIFICADO', '2026-04-13', '16:51:01', 1, 1, 1, '2026-04-14', '14:30:35', '2026-04-13 20:51:01', '2026-04-14 18:30:35'),
(9, 19, 'Certificado', 50.00, 'EFECTIVO', 'PAGO POR CERTIFICADO', '2026-04-14', '14:21:27', 1, 1, 0, NULL, NULL, '2026-04-14 18:21:27', '2026-04-14 18:21:27'),
(10, 24, 'Certificado', 50.00, 'EFECTIVO', 'PAGO POR CERTIFICADO', '2026-04-14', '14:30:21', 1, 1, 0, NULL, NULL, '2026-04-14 18:30:21', '2026-04-14 18:30:21'),
(11, 25, 'Certificado', 50.00, 'EFECTIVO', 'PAGO POR CERTIFICADO', '2026-04-14', '14:31:15', 1, 1, 1, '2026-04-14', '15:15:57', '2026-04-14 18:31:15', '2026-04-14 19:15:57'),
(12, 26, 'Certificado', 50.00, 'EFECTIVO', 'PAGO POR CERTIFICADO', '2026-04-14', '14:32:16', 1, 1, 1, '2026-04-14', '15:15:57', '2026-04-14 18:32:16', '2026-04-14 19:15:57'),
(13, 27, 'Certificado', 50.00, 'EFECTIVO', 'PAGO POR CERTIFICADO', '2026-04-14', '14:32:33', 1, 1, 1, '2026-04-14', '14:39:07', '2026-04-14 18:32:33', '2026-04-14 18:39:07'),
(14, 29, 'Certificado', 50.00, 'QR', 'PAGO POR CERTIFICADO', '2026-04-14', '14:38:07', 1, 1, 1, '2026-04-14', '14:39:07', '2026-04-14 18:38:07', '2026-04-14 18:39:07'),
(15, 34, 'Certificado', 50.00, 'EFECTIVO', 'PAGO POR CERTIFICADO', '2026-04-14', '15:36:57', 1, 1, 0, NULL, NULL, '2026-04-14 19:36:57', '2026-04-14 19:36:57'),
(16, 35, 'Certificado', 50.00, 'EFECTIVO', 'PAGO POR CERTIFICADO', '2026-04-14', '15:38:46', 1, 1, 1, '2026-04-14', '16:54:10', '2026-04-14 19:38:46', '2026-04-14 20:54:10'),
(17, 37, 'Certificado', 60.00, 'EFECTIVO', 'PAGO POR CERTIFICADO', '2026-04-14', '15:40:35', 1, 1, 1, '2026-04-14', '16:54:10', '2026-04-14 19:40:35', '2026-04-14 20:54:10'),
(18, 38, 'Certificado', 50.00, 'EFECTIVO', 'PAGO POR CERTIFICADO', '2026-04-14', '17:01:58', 4, 1, 0, NULL, NULL, '2026-04-14 21:01:58', '2026-04-14 21:01:58'),
(19, 40, 'Certificado', 50.00, 'EFECTIVO', 'PAGO POR CERTIFICADO', '2026-04-14', '17:09:07', 4, 1, 0, NULL, NULL, '2026-04-14 21:09:07', '2026-04-14 21:09:07'),
(20, 41, 'Certificado', 50.00, 'EFECTIVO', 'PAGO POR CERTIFICADO', '2026-04-14', '17:11:10', 2, 2, 1, '2026-04-14', '17:13:58', '2026-04-14 21:11:10', '2026-04-14 21:13:58'),
(21, 43, 'Certificado', 50.00, 'EFECTIVO', 'PAGO POR CERTIFICADO', '2026-04-14', '17:12:52', 2, 2, 1, '2026-04-14', '17:13:58', '2026-04-14 21:12:52', '2026-04-14 21:13:58');

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
(1, 'EDUARDO GONZALES', '32423423', 'LP', '67676767', '2026-04-11', '2026-04-11 20:28:02', '2026-04-11 20:28:02'),
(2, 'MARIA MAMANI', '34343434', 'LP', '67676767', '2026-04-12', '2026-04-12 15:58:07', '2026-04-12 15:58:07'),
(3, 'ELVIRA MARTINEZ', '45334534', 'LP', '65656565', '2026-04-14', '2026-04-14 21:11:37', '2026-04-14 21:11:37');

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
(4, 'GMARTINEZ', 'GEOVANA', 'MARTINEZ', 'MARTINEZ', '32234234', 'CB', '', NULL, '67676767', '$2y$12$hqaROKdsJFiFWcbuTXm7tugbl1s3LR6Rt3hA4JZ2JTdr/dJGIa0Ou', 1, 'MÉDICO', '41775258996.jpg', 1, '2026-04-03', 1, '2026-04-04 03:29:56', '2026-04-14 20:55:35'),
(5, 'SMARTINEZ', 'SANDRA', 'MARTINEZ', '', '56445645', 'LP', '', NULL, '67676767', '$2y$12$BOrmYu5SAJSSdxrpToSux.PR4DRFWiN6YMFsvBUDmyJBUTO52cFQi', 1, 'GERENTE', '51776223560.png', 1, '2026-04-07', 1, '2026-04-07 17:27:08', '2026-04-15 03:26:00'),
(6, 'MGONZALES1', 'MARIA', 'GONZALES', 'GONZALES', '343434', 'LP', '', NULL, '67676767', '$2y$12$7diTukpdlOCZwh9RHgX4n.Vn61luSHVRgI8/j.Qvr4VZFLHzTePha', 1, 'SECRETARIA', NULL, 2, '2026-04-14', 1, '2026-04-14 21:13:22', '2026-04-14 21:13:22');

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
  ADD KEY `fk_sucursal_pagos_id` (`sucursal_id`);

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT de la tabla `certificado_detalles`
--
ALTER TABLE `certificado_detalles`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT de la tabla `certificado_emitidos`
--
ALTER TABLE `certificado_emitidos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT de la tabla `clientes`
--
ALTER TABLE `clientes`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT de la tabla `configuracions`
--
ALTER TABLE `configuracions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT de la tabla `historial_accions`
--
ALTER TABLE `historial_accions`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=123;

--
-- AUTO_INCREMENT de la tabla `login_users`
--
ALTER TABLE `login_users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` int UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de la tabla `pagos`
--
ALTER TABLE `pagos`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

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
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

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
  ADD CONSTRAINT `fk_user_pagos_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
