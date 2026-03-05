-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Mar 06, 2026 at 04:33 AM
-- Server version: 10.11.10-MariaDB-log
-- PHP Version: 8.3.27

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `heywork`
--

-- --------------------------------------------------------

--
-- Table structure for table `hotels`
--

CREATE TABLE `hotels` (
  `id` int(11) NOT NULL,
  `hotel_name` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `location` varchar(250) NOT NULL,
  `latitude` decimal(10,7) NOT NULL,
  `longitude` decimal(10,7) NOT NULL,
  `website` varchar(50) DEFAULT NULL,
  `description` text NOT NULL,
  `founded` year(4) NOT NULL,
  `size` int(1) DEFAULT NULL,
  `logo` varchar(250) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `created_by` int(1) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hotels`
--

INSERT INTO `hotels` (`id`, `hotel_name`, `email`, `location`, `latitude`, `longitude`, `website`, `description`, `founded`, `size`, `logo`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
(1, 'Sahira Butik Hotel Paledang', 'finance@salamdjourney.com', 'Bogor, West Java', -6.6011450, 106.7941260, 'www.sahirahotelsgroup.com', '', '2005', 100, 'images/sbh-color.png', '2026-02-21 07:56:34', 1, '2026-02-24 00:52:46', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `hotel_transactions`
--

CREATE TABLE `hotel_transactions` (
  `id` int(1) NOT NULL,
  `hotel_id` int(11) NOT NULL,
  `type` enum('debit','credit') CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL DEFAULT 'credit',
  `amount` decimal(15,2) NOT NULL,
  `dw_ratio` decimal(5,2) DEFAULT NULL,
  `dw_label` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `category` enum('topup','revenue','payroll','extend','adjustment') CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `description` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `reference_id` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `reference_type` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `date` date NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` int(1) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `hotel_transactions`
--

INSERT INTO `hotel_transactions` (`id`, `hotel_id`, `type`, `amount`, `dw_ratio`, `dw_label`, `category`, `description`, `reference_id`, `reference_type`, `date`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
(1, 1, 'credit', 47912817.00, 0.00, 'NO DATA', 'revenue', 'Daily Revenue H-1', '', '', '2026-01-20', '2026-01-20 00:00:00', 17, NULL, NULL, NULL, NULL),
(2, 1, 'debit', 2636451.61, NULL, NULL, 'payroll', 'Auto Payroll Deduction H-1', '', '', '2026-01-21', '2026-01-21 00:00:00', 17, NULL, NULL, NULL, NULL),
(3, 1, 'credit', 578512.00, 455.73, 'NOT OPTIMAL MAN POWER', 'revenue', 'Daily Revenue H-1', '', '', '2026-01-21', '2026-01-21 00:00:00', 17, NULL, NULL, NULL, NULL),
(4, 1, 'debit', 2930000.00, NULL, NULL, 'payroll', 'Auto Payroll Deduction H-1', '', '', '2026-01-22', '2026-01-22 00:00:00', 17, NULL, NULL, NULL, NULL),
(5, 1, 'credit', 2270248.00, 129.06, 'NOT OPTIMAL MAN POWER', 'revenue', 'Daily Revenue H-1', '', '', '2026-01-22', '2026-01-22 00:00:00', 17, NULL, NULL, NULL, NULL),
(6, 1, 'debit', 2830000.00, NULL, NULL, 'payroll', 'Auto Payroll Deduction H-1', '', '', '2026-01-23', '2026-01-23 00:00:00', 17, NULL, NULL, NULL, NULL),
(7, 1, 'credit', 16400053.00, 17.26, 'NOT OPTIMAL MAN POWER', 'revenue', 'Daily Revenue H-1', '', '', '2026-01-23', '2026-01-23 00:00:00', 17, NULL, NULL, NULL, NULL),
(8, 1, 'debit', 2930000.00, NULL, NULL, 'payroll', 'Auto Payroll Deduction H-1', '', '', '2026-01-24', '2026-01-24 00:00:00', 17, NULL, NULL, NULL, NULL),
(9, 1, 'credit', 6983383.00, 41.96, 'NOT OPTIMAL MAN POWER', 'revenue', 'Daily Revenue H-1', '', '', '2026-01-24', '2026-01-24 00:00:00', 17, NULL, NULL, NULL, NULL),
(10, 1, 'debit', 2736451.61, NULL, NULL, 'payroll', 'Auto Payroll Deduction H-1', '', '', '2026-01-25', '2026-01-25 00:00:00', 17, NULL, NULL, NULL, NULL),
(11, 1, 'credit', 1347367.00, 203.10, 'NOT OPTIMAL MAN POWER', 'revenue', 'Daily Revenue H-1', '', '', '2026-01-25', '2026-01-25 00:00:00', 17, NULL, NULL, NULL, NULL),
(12, 1, 'debit', 2626451.61, NULL, NULL, 'payroll', 'Auto Payroll Deduction H-1', '', '', '2026-01-26', '2026-01-26 00:00:00', 17, NULL, NULL, NULL, NULL),
(13, 1, 'credit', 1066375.00, 246.30, 'NOT OPTIMAL MAN POWER', 'revenue', 'Daily Revenue H-1', '', '', '2026-01-26', '2026-01-26 00:00:00', 17, NULL, NULL, NULL, NULL),
(14, 1, 'debit', 2930000.00, NULL, NULL, 'payroll', 'Auto Payroll Deduction H-1', '', '', '2026-01-27', '2026-01-27 00:00:00', 17, NULL, NULL, NULL, NULL),
(15, 1, 'credit', 1503587.00, 194.87, 'NOT OPTIMAL MAN POWER', 'revenue', 'Daily Revenue H-1', '', '', '2026-01-27', '2026-01-27 00:00:00', 17, NULL, NULL, NULL, NULL),
(16, 1, 'debit', 2626451.61, NULL, NULL, 'payroll', 'Auto Payroll Deduction H-1', '', '', '2026-01-28', '2026-01-28 00:00:00', 17, NULL, NULL, NULL, NULL),
(17, 1, 'credit', 1044484.00, 251.46, 'NOT OPTIMAL MAN POWER', 'revenue', 'Daily Revenue H-1', '', '', '2026-01-28', '2026-01-28 00:00:00', 17, NULL, NULL, NULL, NULL),
(18, 1, 'debit', 2720000.00, NULL, NULL, 'payroll', 'Auto Payroll Deduction H-1', '', '', '2026-01-29', '2026-01-29 00:00:00', 17, NULL, NULL, NULL, NULL),
(19, 1, 'credit', 5772987.00, 47.12, 'NOT OPTIMAL MAN POWER', 'revenue', 'Daily Revenue H-1', '', '', '2026-01-29', '2026-01-29 00:00:00', 17, NULL, NULL, NULL, NULL),
(20, 1, 'debit', 2930000.00, NULL, NULL, 'payroll', 'Auto Payroll Deduction H-1', '', '', '2026-01-30', '2026-01-30 00:00:00', 17, NULL, NULL, NULL, NULL),
(21, 1, 'credit', 3083602.00, 95.02, 'NOT OPTIMAL MAN POWER', 'revenue', 'Daily Revenue H-1', '', '', '2026-01-30', '2026-01-30 00:00:00', 17, NULL, NULL, NULL, NULL),
(22, 1, 'debit', 2736451.61, NULL, NULL, 'payroll', 'Auto Payroll Deduction H-1', '', '', '2026-01-31', '2026-01-31 00:00:00', 17, NULL, NULL, NULL, NULL),
(23, 1, 'credit', 4760553.00, 57.48, 'NOT OPTIMAL MAN POWER', 'revenue', 'Daily Revenue H-1', '', '', '2026-01-31', '2026-01-31 00:00:00', 17, NULL, NULL, NULL, NULL),
(24, 1, 'debit', 2883571.43, NULL, NULL, 'payroll', 'Auto Payroll Deduction H-1', '', '', '2026-02-01', '2026-02-01 00:00:00', 17, NULL, NULL, NULL, NULL),
(25, 1, 'credit', 4348557.00, 66.31, 'NOT OPTIMAL MAN POWER', 'revenue', 'Daily Revenue H-1', '', '', '2026-02-01', '2026-02-01 00:00:00', 17, NULL, NULL, NULL, NULL),
(26, 1, 'debit', 2883571.43, NULL, NULL, 'payroll', 'Auto Payroll Deduction H-1', '', '', '2026-02-02', '2026-02-02 00:00:00', 17, NULL, NULL, NULL, NULL),
(27, 1, 'credit', 2829949.00, 101.89, 'NOT OPTIMAL MAN POWER', 'revenue', 'Daily Revenue H-1', '', '', '2026-02-02', '2026-02-02 00:00:00', 17, NULL, NULL, NULL, NULL),
(28, 1, 'debit', 2773571.43, NULL, NULL, 'payroll', 'Auto Payroll Deduction H-1', '', '', '2026-02-03', '2026-02-03 00:00:00', 17, NULL, NULL, NULL, NULL),
(29, 1, 'credit', 776506.00, 357.19, 'NOT OPTIMAL MAN POWER', 'revenue', 'Daily Revenue H-1', '', '', '2026-02-03', '2026-02-03 00:00:00', 17, NULL, NULL, NULL, NULL),
(30, 1, 'debit', 2883571.43, NULL, NULL, 'payroll', 'Auto Payroll Deduction H-1', '', '', '2026-02-04', '2026-02-04 00:00:00', 17, NULL, NULL, NULL, NULL),
(31, 1, 'credit', 1458440.00, 197.72, 'NOT OPTIMAL MAN POWER', 'revenue', 'Daily Revenue H-1', '', '', '2026-02-04', '2026-02-04 00:00:00', 17, NULL, NULL, NULL, NULL),
(32, 1, 'debit', 2983571.43, NULL, NULL, 'payroll', 'Auto Payroll Deduction H-1', '', '', '2026-02-05', '2026-02-05 00:00:00', 17, NULL, NULL, NULL, NULL),
(33, 1, 'credit', 981798.00, 303.89, 'NOT OPTIMAL MAN POWER', 'revenue', 'Daily Revenue H-1', '', '', '2026-02-05', '2026-02-05 00:00:00', 17, NULL, NULL, NULL, NULL),
(34, 1, 'debit', 3090714.29, NULL, NULL, 'payroll', 'Auto Payroll Deduction H-1', '', '', '2026-02-06', '2026-02-06 00:00:00', 17, NULL, NULL, NULL, NULL),
(35, 1, 'credit', 5118914.00, 60.38, 'NOT OPTIMAL MAN POWER', 'revenue', 'Daily Revenue H-1', '', '', '2026-02-06', '2026-02-06 00:00:00', 17, NULL, NULL, NULL, NULL),
(36, 1, 'debit', 3090714.29, NULL, NULL, 'payroll', 'Auto Payroll Deduction H-1', '', '', '2026-02-07', '2026-02-07 00:00:00', 17, NULL, NULL, NULL, NULL),
(37, 1, 'credit', 42272030.00, 7.31, 'GOOD', 'revenue', 'Daily Revenue H-1', '', '', '2026-02-07', '2026-02-07 00:00:00', 17, NULL, NULL, NULL, NULL),
(38, 1, 'debit', 3305000.00, NULL, NULL, 'payroll', 'Auto Payroll Deduction H-1', '', '', '2026-02-08', '2026-02-08 00:00:00', 17, NULL, NULL, NULL, NULL),
(39, 1, 'credit', 1210393.00, 273.05, 'NOT OPTIMAL MAN POWER', 'revenue', 'Daily Revenue H-1', '', '', '2026-02-08', '2026-02-08 00:00:00', 17, NULL, NULL, NULL, NULL),
(40, 1, 'debit', 2990714.29, NULL, NULL, 'payroll', 'Auto Payroll Deduction H-1', '', '', '2026-02-09', '2026-02-09 00:00:00', 17, NULL, NULL, NULL, NULL),
(41, 1, 'credit', 516529.00, 579.00, 'NOT OPTIMAL MAN POWER', 'revenue', 'Daily Revenue H-1', '', '', '2026-02-09', '2026-02-09 00:00:00', 17, NULL, NULL, NULL, NULL),
(42, 1, 'debit', 3090714.29, NULL, NULL, 'payroll', 'Auto Payroll Deduction H-1', '', '', '2026-02-10', '2026-02-10 00:00:00', 17, NULL, NULL, NULL, NULL),
(43, 1, 'credit', 1294553.00, 238.75, 'NOT OPTIMAL MAN POWER', 'revenue', 'Daily Revenue H-1', '', '', '2026-02-10', '2026-02-10 00:00:00', 17, NULL, NULL, NULL, NULL),
(44, 1, 'debit', 2980714.29, NULL, NULL, 'payroll', 'Auto Payroll Deduction H-1', '', '', '2026-02-11', '2026-02-11 00:00:00', 17, NULL, NULL, NULL, NULL),
(45, 1, 'credit', 15083058.00, 19.76, 'NOT OPTIMAL MAN POWER', 'revenue', 'Daily Revenue H-1', '', '', '2026-02-11', '2026-02-11 00:00:00', 17, NULL, NULL, NULL, NULL),
(46, 1, 'debit', 3090714.29, NULL, NULL, 'payroll', 'Auto Payroll Deduction H-1', '', '', '2026-02-12', '2026-02-12 00:00:00', 17, NULL, NULL, NULL, NULL),
(47, 1, 'credit', 3401991.00, 90.85, 'NOT OPTIMAL MAN POWER', 'revenue', 'Daily Revenue H-1', '', '', '2026-02-12', '2026-02-12 00:00:00', 17, NULL, NULL, NULL, NULL),
(48, 1, 'debit', 3305000.00, NULL, NULL, 'payroll', 'Auto Payroll Deduction H-1', '', '', '2026-02-13', '2026-02-13 00:00:00', 17, NULL, NULL, NULL, NULL),
(49, 1, 'credit', 12848189.00, 25.72, 'NOT OPTIMAL MAN POWER', 'revenue', 'Daily Revenue H-1', '', '', '2026-02-13', '2026-02-13 00:00:00', 17, NULL, NULL, NULL, NULL),
(50, 1, 'debit', 3305000.00, NULL, NULL, 'payroll', 'Auto Payroll Deduction H-1', '', '', '2026-02-14', '2026-02-14 00:00:00', 17, NULL, NULL, NULL, NULL),
(51, 1, 'credit', 12090701.00, 27.34, 'NOT OPTIMAL MAN POWER', 'revenue', 'Daily Revenue H-1', '', '', '2026-02-14', '2026-02-14 00:00:00', 17, NULL, NULL, NULL, NULL),
(52, 1, 'debit', 3090714.29, NULL, NULL, 'payroll', 'Auto Payroll Deduction H-1', '', '', '2026-02-15', '2026-02-15 00:00:00', 17, NULL, NULL, NULL, NULL),
(53, 1, 'credit', 6392596.00, 48.35, 'NOT OPTIMAL MAN POWER', 'revenue', 'Daily Revenue H-1', '', '', '2026-02-15', '2026-02-15 00:00:00', 17, NULL, NULL, NULL, NULL),
(54, 1, 'debit', 3195000.00, NULL, NULL, 'payroll', 'Auto Payroll Deduction H-1', '', '', '2026-02-16', '2026-02-16 00:00:00', 17, NULL, NULL, NULL, NULL),
(55, 1, 'credit', 5945155.00, 53.74, 'NOT OPTIMAL MAN POWER', 'revenue', 'Daily Revenue H-1', '', '', '2026-02-16', '2026-02-16 00:00:00', 17, NULL, NULL, NULL, NULL),
(56, 1, 'debit', 2990714.29, NULL, NULL, 'payroll', 'Auto Payroll Deduction H-1', '', '', '2026-02-17', '2026-02-17 00:00:00', 17, NULL, NULL, NULL, NULL),
(57, 1, 'credit', 2309752.00, 129.48, 'NOT OPTIMAL MAN POWER', 'revenue', 'Daily Revenue H-1', '', '', '2026-02-17', '2026-02-17 00:00:00', 17, NULL, NULL, NULL, NULL),
(58, 1, 'debit', 3090714.29, NULL, NULL, 'payroll', 'Auto Payroll Deduction H-1', '', '', '2026-02-18', '2026-02-18 00:00:00', 17, NULL, NULL, NULL, NULL),
(59, 1, 'credit', 0.00, 0.00, 'NO DATA', 'revenue', 'Daily Revenue H-1', '', '', '2026-02-18', '2026-02-18 00:00:00', 17, NULL, NULL, NULL, NULL),
(60, 1, 'debit', 3305000.00, NULL, NULL, 'payroll', 'Auto Payroll Deduction H-1', '', '', '2026-02-19', '2026-02-19 00:00:00', 17, NULL, NULL, NULL, NULL),
(61, 1, 'credit', 1487603.00, 222.17, 'NOT OPTIMAL MAN POWER', 'revenue', 'Daily Revenue H-1', '', '', '2026-02-19', '2026-02-19 00:00:00', 17, NULL, NULL, NULL, NULL),
(62, 1, 'debit', 2890714.29, NULL, NULL, 'payroll', 'Auto Payroll Deduction H-1', '', '', '2026-02-20', '2026-02-20 00:00:00', 17, NULL, NULL, NULL, NULL),
(63, 1, 'credit', 1697365.00, 170.31, 'NOT OPTIMAL MAN POWER', 'revenue', 'Daily Revenue H-1', '', '', '2026-02-20', '2026-02-20 00:00:00', 17, NULL, NULL, NULL, NULL),
(64, 1, 'debit', 3214285.71, NULL, NULL, 'payroll', 'Auto Payroll Deduction H-1', '', '', '2026-02-21', '2026-02-21 17:59:28', 17, NULL, NULL, NULL, NULL),
(65, 1, 'credit', 5515260.00, 58.28, 'NOT OPTIMAL MAN POWER', 'revenue', 'Daily Revenue H-1', '', '', '2026-02-21', '2026-02-21 17:59:28', 17, NULL, NULL, NULL, NULL),
(66, 1, 'debit', 3214285.71, NULL, NULL, 'payroll', 'Auto Payroll Deduction H-1', '', '', '2026-02-22', '2026-02-22 17:59:53', 17, NULL, NULL, NULL, NULL),
(67, 1, 'credit', 1884298.00, 170.58, 'NOT OPTIMAL MAN POWER', 'revenue', 'Daily Revenue H-1', '', '', '2026-02-22', '2026-02-22 17:59:53', 17, NULL, NULL, NULL, NULL),
(68, 1, 'debit', 3214285.71, NULL, NULL, 'payroll', 'Auto Payroll Deduction H-1', '', '', '2026-02-23', '2026-02-23 18:00:12', 17, NULL, NULL, NULL, NULL),
(69, 1, 'credit', 6933888.00, 46.36, 'NOT OPTIMAL MAN POWER', 'revenue', 'Daily Revenue H-1', '', '', '2026-02-23', '2026-02-23 18:00:12', 17, NULL, NULL, NULL, NULL),
(70, 1, 'debit', 3428571.43, NULL, NULL, 'payroll', 'Auto Payroll Deduction H-1', '', '', '2026-02-24', '2026-02-24 13:54:09', 17, NULL, NULL, NULL, NULL),
(71, 1, 'credit', 4991736.00, 68.68, 'NOT OPTIMAL MAN POWER', 'revenue', 'Daily Revenue H-1', '', '', '2026-02-24', '2026-02-24 13:54:09', 17, NULL, NULL, NULL, NULL),
(72, 1, 'debit', 3035714.29, NULL, NULL, 'payroll', 'Auto Payroll Deduction H-1', '', '', '2026-02-25', '2026-02-25 18:02:36', 17, NULL, NULL, NULL, NULL),
(73, 1, 'credit', 3223140.00, 94.18, 'NOT OPTIMAL MAN POWER', 'revenue', 'Daily Revenue H-1', '', '', '2026-02-25', '2026-02-25 18:02:36', 17, NULL, NULL, NULL, NULL),
(74, 1, 'debit', 3355714.29, NULL, NULL, 'payroll', 'Auto Payroll Deduction H-1', '', '', '2026-02-26', '2026-02-26 00:00:00', 17, NULL, NULL, NULL, NULL),
(75, 1, 'credit', 9867769.00, 34.01, 'NOT OPTIMAL MAN POWER', 'revenue', 'Daily Revenue H-1', '', '', '2026-02-26', '2026-02-26 00:00:00', 17, NULL, NULL, NULL, NULL),
(76, 1, 'debit', 125000.00, NULL, NULL, 'payroll', 'Auto Payroll Deduction H-1', '', '', '2026-02-27', '2026-02-27 00:00:00', 17, '2026-03-01 18:01:31', 17, NULL, NULL),
(77, 1, 'credit', 9933884.00, 0.93, 'NO DATA', 'revenue', 'Daily Revenue H-1', '', '', '2026-02-27', '2026-02-27 00:00:00', 17, '2026-02-28 00:00:00', 17, NULL, NULL),
(78, 1, 'debit', 125000.00, NULL, NULL, 'payroll', 'Auto Payroll Deduction H-1', '', '', '2026-02-28', '2026-02-28 00:00:00', 17, NULL, NULL, NULL, NULL),
(79, 1, 'credit', 13496063.00, 0.93, 'NO DATA', 'revenue', 'Daily Revenue H-1', '', '', '2026-02-28', '2026-02-28 00:00:00', 17, NULL, NULL, NULL, NULL),
(80, 1, 'debit', 2916774.19, NULL, NULL, 'payroll', 'Auto Payroll Deduction H-1', '', '', '2026-03-01', '2026-03-01 00:00:00', 17, '2026-03-05 17:49:45', 17, NULL, NULL),
(81, 1, 'credit', 2000000.00, 145.84, 'NOT OPTIMAL MAN POWER', 'revenue', 'Daily Revenue H-1', '', '', '2026-03-01', '2026-03-01 00:00:00', 17, '2026-03-04 00:00:00', 17, NULL, NULL),
(82, 1, 'debit', 2916774.19, NULL, NULL, 'payroll', 'Auto Payroll Deduction H-1', '', '', '2026-03-02', '2026-03-02 00:00:00', 17, NULL, NULL, NULL, NULL),
(83, 1, 'credit', 2280992.00, 127.87, 'NOT OPTIMAL MAN POWER', 'revenue', 'Daily Revenue H-1', '', '', '2026-03-02', '2026-03-02 00:00:00', 17, NULL, NULL, NULL, NULL),
(84, 1, 'debit', 2916774.19, NULL, NULL, 'payroll', 'Auto Payroll Deduction H-1', '', '', '2026-03-03', '2026-03-03 00:00:00', 17, NULL, NULL, NULL, NULL),
(85, 1, 'credit', 16209922.00, 17.99, 'NOT OPTIMAL MAN POWER', 'revenue', 'Daily Revenue H-1', '', '', '2026-03-03', '2026-03-03 00:00:00', 17, NULL, NULL, NULL, NULL),
(86, 1, 'debit', 2916774.19, NULL, NULL, 'payroll', 'Auto Payroll Deduction H-1', '', '', '2026-03-04', '2026-03-04 00:00:00', 17, NULL, NULL, NULL, NULL),
(87, 1, 'credit', 8891317.00, 32.80, 'NOT OPTIMAL MAN POWER', 'revenue', 'Daily Revenue H-1', '', '', '2026-03-04', '2026-03-04 00:00:00', 17, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `invoices`
--

CREATE TABLE `invoices` (
  `id` int(11) NOT NULL,
  `invoice_number` varchar(50) NOT NULL,
  `hotel_id` int(11) NOT NULL,
  `billing_start` date NOT NULL,
  `billing_end` date NOT NULL,
  `total_amount` decimal(15,2) NOT NULL,
  `paid_amount` decimal(15,2) DEFAULT 0.00,
  `status` enum('unbilled','billed','partial','paid','overdue','cancelled') NOT NULL DEFAULT 'unbilled',
  `due_date` date DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `invoice_items`
--

CREATE TABLE `invoice_items` (
  `id` int(11) NOT NULL,
  `invoice_id` int(11) NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `application_id` int(11) DEFAULT NULL,
  `attendance_date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `invoice_payments`
--

CREATE TABLE `invoice_payments` (
  `id` int(11) NOT NULL,
  `invoice_id` int(11) NOT NULL,
  `hotel_id` int(11) NOT NULL,
  `amount` decimal(15,2) NOT NULL,
  `payment_method` enum('bank_transfer','cash','virtual_account','crypto','other') DEFAULT 'bank_transfer',
  `payment_reference` varchar(100) DEFAULT NULL,
  `payment_date` date NOT NULL,
  `proof_file` varchar(255) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` int(1) NOT NULL,
  `hotel_id` int(11) NOT NULL,
  `position` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `job_date_start` date NOT NULL,
  `job_date_end` date NOT NULL,
  `category` enum('daily_worker','casual','corporate') CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT 'daily_worker',
  `fee` int(1) NOT NULL,
  `location` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `description` text CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `requirement_skill` text CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `status` enum('open','closed') CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT 'open',
  `created_at` datetime DEFAULT NULL,
  `created_by` int(1) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `jobs`
--

INSERT INTO `jobs` (`id`, `hotel_id`, `position`, `job_date_start`, `job_date_end`, `category`, `fee`, `location`, `description`, `requirement_skill`, `status`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
(1, 1, 'Information Technology', '2025-09-05', '2026-09-04', 'corporate', 0, 'Bogor, West Java', 'Pengelolaan infrastruktur, pengembangan perangkat lunak, keamanan data dan dukungan teknis untuk memastikan operasional perusahaan berjalan lancar', 'Network configuration, Hardware deployment & Operating system knowledge', 'open', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(2, 1, 'HK Attandent', '2025-11-19', '2026-11-18', 'corporate', 0, 'Bogor, West Java', 'cleans, sanitizes, and organizes guest rooms and public areas to meet high hospitality standards', 'high physical stamina, exceptional attention to detail and strong time-management skills', 'open', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(3, 1, 'FB Manager', '2025-11-20', '2026-11-19', 'corporate', 0, 'Bogor, West Java', 'oversees all dining operations, including restaurants, bars, banquets, and room service, to ensure high-quality service, profitability, and compliance with health regulations', 'cost control, menu engineering, inventory management, and high-level customer service', 'open', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(4, 1, 'Executive Housekeeper', '2025-11-20', '2026-11-19', 'corporate', 0, 'Bogor, West Java', 'manages all housekeeping operations, staff, and budgets to maintain spotless guest rooms and public areas, ensuring high hygiene and comfort standards', 'strong leadership, organizational, and financial management skills', 'open', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(5, 1, 'Director of sales marketing', '2025-11-24', '2026-11-23', 'corporate', 0, 'Bogor, West Java', 'leads, develops, and implements strategic plans to drive revenue growth, enhance brand awareness, and increase market share', 'proficiency in CRM software, data analysis, revenue growth strategies, and excellent communication skills', 'open', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(6, 1, 'Graphics design', '2025-11-24', '2026-11-23', 'corporate', 0, 'Bogor, West Java', 'creates visual concepts using computer software or by hand to communicate ideas that inspire, inform, or captivate consumers', 'technical proficiency in software (Adobe Creative Suite, Figma) with core design principles like typography, color theory, and layout composition', 'open', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(7, 1, 'Senior Waiter', '2025-11-26', '2026-11-25', 'corporate', 0, 'Bogor, West Java', 'leads the service team to ensure exceptional dining experiences, acting as a mentor to junior staff and a point of escalation for guest concerns', 'advanced technical skills with strong leadership', 'open', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(8, 1, 'Supervisor Housekeeping', '2025-11-28', '2026-11-27', 'corporate', 0, 'Bogor, West Java', NULL, NULL, 'open', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(9, 1, 'AR/AP', '2025-12-02', '2026-12-01', 'corporate', 0, 'Bogor, West Java', NULL, NULL, 'open', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(10, 1, 'Chief Accounting', '2025-12-04', '2026-12-03', 'corporate', 0, 'Bogor, West Java', NULL, NULL, 'open', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(11, 1, 'Head Chef', '2025-12-04', '2026-12-03', 'corporate', 0, 'Bogor, West Java', NULL, NULL, 'open', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(12, 1, 'Front Office Manager', '2025-12-11', '2026-12-10', 'corporate', 0, 'Bogor, West Java', '', NULL, 'open', '2026-02-21 07:56:00', 1, '2026-02-25 01:12:51', 17, NULL, NULL),
(13, 1, 'Maintenance Staff', '2025-12-14', '2026-12-13', 'corporate', 0, 'Bogor, West Java', NULL, NULL, 'closed', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(14, 1, 'Chief Engineering', '2025-12-23', '2026-12-22', 'corporate', 0, 'Bogor, West Java', NULL, NULL, 'open', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(15, 1, 'HR Manager', '2025-12-27', '2026-12-26', 'corporate', 0, 'Bogor, West Java', NULL, NULL, 'open', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(16, 1, 'Chef De Partie', '2025-12-28', '2026-12-27', 'corporate', 0, 'Bogor, West Java', NULL, NULL, 'open', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(17, 1, 'Sales Executive', '2026-01-05', '2027-01-04', 'corporate', 0, 'Bogor, West Java', NULL, NULL, 'open', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(18, 1, 'Senior Sales Marketing', '2026-01-07', '2027-01-06', 'corporate', 0, 'Bogor, West Java', NULL, NULL, 'open', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(19, 1, 'Cook', '2026-01-12', '2027-01-11', 'corporate', 0, 'Bogor, West Java', NULL, NULL, 'open', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(20, 1, 'Sales Manager', '2026-01-14', '2027-01-13', 'corporate', 0, 'Bogor, West Java', NULL, NULL, 'open', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(21, 1, 'FDA', '2026-02-06', '2027-02-05', 'corporate', 0, 'Bogor, West Java', NULL, NULL, 'open', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(22, 1, 'Business Development', '2025-12-09', '2026-06-08', 'corporate', 0, 'Bogor, West Java', NULL, NULL, 'open', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(23, 1, 'Security Guard', '2025-12-02', '2026-12-01', 'corporate', 0, 'Bogor, West Java', NULL, NULL, 'open', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(24, 1, 'Housekeeping', '2026-01-21', '2026-02-20', 'casual', 100000, 'Bogor, West Java', 'maintains cleanliness and sanitation in residential or commercial spaces by performing tasks like sweeping, vacuuming, mopping, dusting, cleaning bathrooms, and changing linens', 'surface care and equipment handling, alongside key soft skills like time management, attention to detail, and discretion', 'closed', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(25, 1, 'Front Office', '2026-01-21', '2026-02-20', 'daily_worker', 110000, 'Bogor, West Java', 'acts as the company\'s first point of contact, providing exceptional customer service by greeting visitors, managing phone calls, and handling administrative tasks', 'strong communication, interpersonal, and multitasking skills', 'closed', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(26, 1, 'Cook', '2026-01-21', '2026-02-20', 'daily_worker', 100000, 'Bogor, West Java', 'prepares, seasons, and cooks a variety of foods, including soups, salads, and entrees, while ensuring quality, taste, and presentation standards are met', 'proficiency in knife handling, mastery of cooking techniques (sautéing, roasting, grilling), strict adherence to food safety and sanitation standards, and flavor balancing', 'closed', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(27, 1, 'Front Office', '2026-01-21', '2026-02-20', 'daily_worker', 120000, 'Bogor, West Java', 'acts as the company\'s first point of contact, providing exceptional customer service by greeting visitors, managing phone calls, and handling administrative tasks', 'strong communication, interpersonal, and multitasking skills', 'closed', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(28, 1, 'Housekeeping', '2026-02-21', '2026-03-20', 'casual', 100000, 'Bogor, West Java', 'maintains cleanliness and sanitation in residential or commercial spaces by performing tasks like sweeping, vacuuming, mopping, dusting, cleaning bathrooms, and changing linens', 'surface care and equipment handling, alongside key soft skills like time management, attention to detail, and discretion', 'closed', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(29, 1, 'Cook', '2026-02-21', '2026-03-20', 'daily_worker', 100000, 'Bogor, West Java', 'prepares, seasons, and cooks a variety of foods, including soups, salads, and entrees, while ensuring quality, taste, and presentation standards are met', 'proficiency in knife handling, mastery of cooking techniques (sautéing, roasting, grilling), strict adherence to food safety and sanitation standards, and flavor balancing', 'closed', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(30, 1, 'Front Office', '2026-02-21', '2026-03-20', 'daily_worker', 120000, 'Bogor, West Java', 'acts as the company\'s first point of contact, providing exceptional customer service by greeting visitors, managing phone calls, and handling administrative tasks', 'strong communication, interpersonal, and multitasking skills', 'closed', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(31, 1, 'Waiter', '2026-01-21', '2026-02-20', 'casual', 100000, 'Bogor, West Java', 'acts as the company\'s first point of contact, providing exceptional customer service by greeting visitors, managing phone calls, and handling administrative tasks', 'strong communication, interpersonal, and multitasking skills', 'closed', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(32, 1, 'Maintenance Staff', '2026-01-20', '2027-02-21', 'casual', 0, 'Bogor, West Java', NULL, NULL, 'closed', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(33, 1, 'Cook', '2026-01-21', '2026-02-20', 'casual', 100000, 'Bogor, West Java', 'prepares, seasons, and cooks a variety of foods, including soups, salads, and entrees, while ensuring quality, taste, and presentation standards are met', 'proficiency in knife handling, mastery of cooking techniques (sautéing, roasting, grilling), strict adherence to food safety and sanitation standards, and flavor balancing', 'closed', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(34, 1, 'Driver', '2026-01-21', '2026-02-20', 'casual', 100000, 'Bogor, West Java', NULL, NULL, 'closed', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `job_applications`
--

CREATE TABLE `job_applications` (
  `id` int(1) NOT NULL,
  `job_id` int(1) NOT NULL,
  `user_id` int(1) NOT NULL,
  `status` enum('pending','accepted','rejected','completed') CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT 'pending',
  `applied_at` datetime DEFAULT NULL,
  `accepted_at` datetime DEFAULT NULL,
  `accepted_by` int(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `job_applications`
--

INSERT INTO `job_applications` (`id`, `job_id`, `user_id`, `status`, `applied_at`, `accepted_at`, `accepted_by`, `deleted_at`) VALUES
(1, 1, 2, 'accepted', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(2, 2, 3, 'accepted', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(3, 3, 4, 'accepted', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(4, 4, 5, 'accepted', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(5, 5, 6, 'accepted', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(6, 6, 7, 'accepted', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(7, 7, 8, 'accepted', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(8, 8, 9, 'accepted', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(9, 9, 10, 'accepted', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(10, 10, 11, 'accepted', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(11, 11, 12, 'accepted', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(12, 12, 13, 'accepted', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(13, 13, 14, 'accepted', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(14, 13, 15, 'accepted', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(15, 14, 16, 'accepted', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(16, 15, 17, 'accepted', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(17, 16, 18, 'accepted', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(18, 17, 19, 'accepted', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(19, 18, 20, 'accepted', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(20, 19, 21, 'accepted', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(21, 20, 22, 'accepted', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(22, 21, 23, 'accepted', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(23, 22, 24, 'accepted', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(24, 6, 25, 'accepted', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(25, 23, 26, 'accepted', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(26, 23, 27, 'accepted', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(28, 23, 28, 'accepted', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(29, 23, 29, 'accepted', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(30, 23, 30, 'accepted', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(31, 28, 31, 'accepted', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(32, 28, 32, 'accepted', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(33, 28, 33, 'accepted', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(34, 27, 34, 'completed', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(35, 26, 35, 'completed', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(36, 26, 36, 'completed', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(37, 24, 37, 'completed', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(38, 25, 38, 'completed', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(39, 28, 37, 'accepted', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(40, 29, 35, 'accepted', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(41, 29, 36, 'accepted', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(42, 30, 34, 'completed', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(43, 24, 32, 'completed', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(44, 24, 33, 'completed', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(45, 24, 31, 'completed', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(46, 31, 39, 'completed', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(47, 31, 40, 'completed', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(48, 31, 41, 'completed', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(49, 31, 42, 'completed', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(50, 31, 43, 'completed', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(51, 31, 44, 'completed', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(52, 31, 45, 'completed', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(53, 31, 46, 'completed', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(54, 31, 47, 'completed', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(55, 24, 48, 'completed', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(56, 33, 49, 'completed', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(58, 33, 50, 'completed', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(59, 32, 51, 'completed', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(60, 33, 53, 'completed', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL),
(61, 34, 52, 'completed', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `job_attendances`
--

CREATE TABLE `job_attendances` (
  `id` int(11) NOT NULL,
  `job_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `transaction_id` int(1) DEFAULT NULL,
  `type` enum('checkin','checkout') NOT NULL,
  `latitude` decimal(10,7) NOT NULL,
  `longitude` decimal(10,7) NOT NULL,
  `photo_path` varchar(250) DEFAULT NULL,
  `device_info` varchar(250) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `created_by` int(1) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `job_attendances`
--

INSERT INTO `job_attendances` (`id`, `job_id`, `application_id`, `user_id`, `transaction_id`, `type`, `latitude`, `longitude`, `photo_path`, `device_info`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
(354, 27, 34, 34, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-21 08:03:29', 34, NULL, NULL, NULL, NULL),
(355, 28, 31, 31, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-21 08:08:53', 31, NULL, NULL, NULL, NULL),
(356, 28, 32, 32, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-21 09:00:00', 32, NULL, NULL, NULL, NULL),
(357, 29, 40, 35, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-21 10:42:42', 35, NULL, NULL, NULL, NULL),
(358, 22, 22, 24, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-21 11:48:25', 24, NULL, NULL, NULL, NULL),
(359, 28, 33, 33, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-21 11:51:27', 33, NULL, NULL, NULL, NULL),
(360, 29, 41, 36, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-21 12:01:14', 36, NULL, NULL, NULL, NULL),
(361, 28, 33, 33, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-21 20:25:45', 33, NULL, NULL, NULL, NULL),
(362, 28, 31, 31, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-21 17:08:53', 31, NULL, NULL, NULL, NULL),
(363, 29, 40, 35, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-21 19:42:42', 35, NULL, NULL, NULL, NULL),
(364, 28, 32, 32, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-21 18:00:00', 32, NULL, NULL, NULL, NULL),
(365, 29, 41, 36, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-22 21:02:31', 36, NULL, NULL, NULL, NULL),
(366, 28, 32, 32, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-22 09:00:00', 32, NULL, NULL, NULL, NULL),
(367, 29, 41, 36, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-22 12:02:31', 36, NULL, NULL, NULL, NULL),
(368, 28, 31, 31, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-22 21:06:40', 31, NULL, NULL, NULL, NULL),
(369, 28, 32, 32, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-22 18:00:00', 32, NULL, NULL, NULL, NULL),
(370, 29, 41, 36, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-23 21:13:54', 36, NULL, NULL, NULL, NULL),
(371, 30, 42, 34, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-22 23:18:32', 34, NULL, NULL, NULL, NULL),
(372, 30, 42, 34, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-23 08:18:32', 34, NULL, NULL, NULL, NULL),
(373, 28, 31, 31, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-23 08:00:00', 31, NULL, NULL, NULL, NULL),
(374, 22, 22, 24, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-23 09:41:42', 24, NULL, NULL, NULL, NULL),
(375, 29, 40, 35, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-23 10:45:46', 35, NULL, NULL, NULL, NULL),
(376, 28, 33, 33, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-23 11:38:31', 33, NULL, NULL, NULL, NULL),
(377, 29, 41, 36, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-23 12:13:54', 36, NULL, NULL, NULL, NULL),
(378, 28, 31, 31, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-23 17:00:00', 31, NULL, NULL, NULL, NULL),
(379, 28, 32, 32, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-23 18:00:00', 32, NULL, NULL, NULL, NULL),
(380, 29, 40, 35, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-23 19:45:46', 35, NULL, NULL, NULL, NULL),
(381, 28, 33, 33, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-24 00:04:07', 33, NULL, NULL, NULL, NULL),
(382, 29, 41, 36, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-24 21:00:00', 36, NULL, NULL, NULL, NULL),
(383, 30, 42, 34, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-24 08:05:48', 34, NULL, NULL, NULL, NULL),
(384, 28, 31, 31, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-24 07:53:17', 31, NULL, NULL, NULL, NULL),
(385, 22, 22, 24, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-24 08:30:45', 24, NULL, NULL, NULL, NULL),
(386, 28, 32, 32, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-24 09:00:00', 32, NULL, NULL, NULL, NULL),
(387, 29, 40, 35, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-24 10:52:10', 35, NULL, NULL, NULL, NULL),
(388, 28, 33, 33, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-24 12:24:28', 33, NULL, NULL, NULL, NULL),
(389, 29, 41, 36, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-24 12:00:00', 36, NULL, NULL, NULL, NULL),
(390, 28, 39, 37, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-22 11:56:00', 37, NULL, NULL, NULL, NULL),
(391, 28, 39, 37, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-22 20:56:00', 37, '2026-02-22 19:56:00', 37, NULL, NULL),
(392, 28, 39, 37, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-24 09:05:11', 37, NULL, NULL, NULL, NULL),
(393, 28, 39, 37, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-24 18:05:11', 37, '2026-02-24 17:05:11', 37, NULL, NULL),
(400, 30, 42, 34, NULL, 'checkin', -6.6008118, 106.7938935, 'uploads/attendance/checkin_25_34_1772111390.jpg', 'Mozilla/5.0 (Linux; Android 13; 2209116AG Build/TKQ1.221114.001; wv) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/145.0.7632.79 Mobile Safari/537.36', '2026-02-26 20:09:50', 34, NULL, NULL, NULL, NULL),
(402, 25, 38, 38, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-21 07:00:00', 38, NULL, NULL, NULL, NULL),
(403, 25, 38, 38, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-21 16:00:00', 38, NULL, NULL, NULL, NULL),
(404, 25, 38, 38, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-22 07:00:00', 38, NULL, NULL, NULL, NULL),
(405, 25, 38, 38, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-22 16:00:00', 38, NULL, NULL, NULL, NULL),
(406, 25, 38, 38, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-23 07:00:00', 38, NULL, NULL, NULL, NULL),
(407, 25, 38, 38, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-23 16:00:00', 38, NULL, NULL, NULL, NULL),
(408, 25, 38, 38, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-24 07:00:00', 38, NULL, NULL, NULL, NULL),
(409, 25, 38, 38, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-24 16:00:00', 38, NULL, NULL, NULL, NULL),
(410, 25, 38, 38, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-25 07:00:00', 38, NULL, NULL, NULL, NULL),
(411, 25, 38, 38, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-25 16:00:00', 38, NULL, NULL, NULL, NULL),
(412, 25, 38, 38, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-27 07:00:00', 38, NULL, NULL, NULL, NULL),
(413, 25, 38, 38, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-27 16:00:00', 38, NULL, NULL, NULL, NULL),
(414, 25, 38, 38, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-30 07:00:00', 38, NULL, NULL, NULL, NULL),
(415, 25, 38, 38, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-30 16:00:00', 38, NULL, NULL, NULL, NULL),
(416, 25, 38, 38, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-31 07:00:00', 38, NULL, NULL, NULL, NULL),
(417, 25, 38, 38, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-31 16:00:00', 38, NULL, NULL, NULL, NULL),
(418, 25, 38, 38, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-01 07:00:00', 38, NULL, NULL, NULL, NULL),
(419, 25, 38, 38, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-01 16:00:00', 38, NULL, NULL, NULL, NULL),
(420, 25, 38, 38, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-02 07:00:00', 38, NULL, NULL, NULL, NULL),
(421, 25, 38, 38, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-02 16:00:00', 38, NULL, NULL, NULL, NULL),
(422, 25, 38, 38, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-04 07:00:00', 38, NULL, NULL, NULL, NULL),
(423, 25, 38, 38, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-04 16:00:00', 38, NULL, NULL, NULL, NULL),
(424, 25, 38, 38, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-05 07:00:00', 38, NULL, NULL, NULL, NULL),
(425, 25, 38, 38, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-05 16:00:00', 38, NULL, NULL, NULL, NULL),
(426, 25, 38, 38, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-06 07:00:00', 38, NULL, NULL, NULL, NULL),
(427, 25, 38, 38, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-06 16:00:00', 38, NULL, NULL, NULL, NULL),
(428, 25, 38, 38, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-07 07:00:00', 38, NULL, NULL, NULL, NULL),
(429, 25, 38, 38, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-07 16:00:00', 38, NULL, NULL, NULL, NULL),
(430, 25, 38, 38, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-08 07:00:00', 38, NULL, NULL, NULL, NULL),
(431, 25, 38, 38, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-08 16:00:00', 38, NULL, NULL, NULL, NULL),
(432, 25, 38, 38, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-09 07:00:00', 38, NULL, NULL, NULL, NULL),
(433, 25, 38, 38, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-09 16:00:00', 38, NULL, NULL, NULL, NULL),
(434, 25, 38, 38, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-10 07:00:00', 38, NULL, NULL, NULL, NULL),
(435, 25, 38, 38, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-10 16:00:00', 38, NULL, NULL, NULL, NULL),
(436, 25, 38, 38, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-12 07:00:00', 38, NULL, NULL, NULL, NULL),
(437, 25, 38, 38, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-12 16:00:00', 38, NULL, NULL, NULL, NULL),
(438, 25, 38, 38, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-13 07:00:00', 38, NULL, NULL, NULL, NULL),
(439, 25, 38, 38, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-13 16:00:00', 38, NULL, NULL, NULL, NULL),
(440, 25, 38, 38, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-14 13:00:00', 38, NULL, NULL, NULL, NULL),
(441, 25, 38, 38, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-14 22:00:00', 38, NULL, NULL, NULL, NULL),
(442, 25, 38, 38, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-15 13:00:00', 38, NULL, NULL, NULL, NULL),
(443, 25, 38, 38, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-15 22:00:00', 38, NULL, NULL, NULL, NULL),
(444, 25, 38, 38, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-17 13:00:00', 38, NULL, NULL, NULL, NULL),
(445, 25, 38, 38, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-17 22:00:00', 38, NULL, NULL, NULL, NULL),
(446, 25, 38, 38, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-18 13:00:00', 38, NULL, NULL, NULL, NULL),
(447, 25, 38, 38, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-18 22:00:00', 38, NULL, NULL, NULL, NULL),
(448, 25, 38, 38, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-19 13:00:00', 38, NULL, NULL, NULL, NULL),
(449, 25, 38, 38, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-19 22:00:00', 38, NULL, NULL, NULL, NULL),
(450, 25, 38, 38, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-20 08:00:00', 38, NULL, NULL, NULL, NULL),
(451, 25, 38, 38, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-20 17:00:00', 38, NULL, NULL, NULL, NULL),
(452, 27, 34, 34, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-21 19:00:00', 34, NULL, NULL, NULL, NULL),
(453, 27, 34, 34, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-22 04:00:00', 34, NULL, NULL, NULL, NULL),
(454, 27, 34, 34, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-22 19:00:00', 34, NULL, NULL, NULL, NULL),
(455, 27, 34, 34, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-23 04:00:00', 34, NULL, NULL, NULL, NULL),
(456, 27, 34, 34, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-24 19:00:00', 34, NULL, NULL, NULL, NULL),
(457, 27, 34, 34, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-25 04:00:00', 34, NULL, NULL, NULL, NULL),
(458, 27, 34, 34, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-25 19:00:00', 34, NULL, NULL, NULL, NULL),
(459, 27, 34, 34, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-26 04:00:00', 34, NULL, NULL, NULL, NULL),
(460, 27, 34, 34, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-26 19:00:00', 34, NULL, NULL, NULL, NULL),
(461, 27, 34, 34, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-27 04:00:00', 34, NULL, NULL, NULL, NULL),
(462, 27, 34, 34, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-27 19:00:00', 34, NULL, NULL, NULL, NULL),
(463, 27, 34, 34, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-28 04:00:00', 34, NULL, NULL, NULL, NULL),
(464, 27, 34, 34, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-28 19:00:00', 34, NULL, NULL, NULL, NULL),
(465, 27, 34, 34, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-29 04:00:00', 34, NULL, NULL, NULL, NULL),
(466, 27, 34, 34, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-29 19:00:00', 34, NULL, NULL, NULL, NULL),
(467, 27, 34, 34, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-30 04:00:00', 34, NULL, NULL, NULL, NULL),
(468, 27, 34, 34, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-31 19:00:00', 34, NULL, NULL, NULL, NULL),
(469, 27, 34, 34, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-01 04:00:00', 34, NULL, NULL, NULL, NULL),
(470, 27, 34, 34, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-01 19:00:00', 34, NULL, NULL, NULL, NULL),
(471, 27, 34, 34, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-02 04:00:00', 34, NULL, NULL, NULL, NULL),
(472, 27, 34, 34, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-03 19:00:00', 34, NULL, NULL, NULL, NULL),
(473, 27, 34, 34, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-04 04:00:00', 34, NULL, NULL, NULL, NULL),
(474, 27, 34, 34, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-04 19:00:00', 34, NULL, NULL, NULL, NULL),
(475, 27, 34, 34, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-05 04:00:00', 34, NULL, NULL, NULL, NULL),
(476, 27, 34, 34, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-06 19:00:00', 34, NULL, NULL, NULL, NULL),
(477, 27, 34, 34, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-07 04:00:00', 34, NULL, NULL, NULL, NULL),
(478, 27, 34, 34, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-07 19:00:00', 34, NULL, NULL, NULL, NULL),
(479, 27, 34, 34, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-08 04:00:00', 34, NULL, NULL, NULL, NULL),
(480, 27, 34, 34, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-08 19:00:00', 34, NULL, NULL, NULL, NULL),
(481, 27, 34, 34, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-09 04:00:00', 34, NULL, NULL, NULL, NULL),
(482, 27, 34, 34, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-10 19:00:00', 34, NULL, NULL, NULL, NULL),
(483, 27, 34, 34, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-11 04:00:00', 34, NULL, NULL, NULL, NULL),
(484, 27, 34, 34, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-11 19:00:00', 34, NULL, NULL, NULL, NULL),
(485, 27, 34, 34, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-12 04:00:00', 34, NULL, NULL, NULL, NULL),
(486, 27, 34, 34, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-12 19:00:00', 34, NULL, NULL, NULL, NULL),
(487, 27, 34, 34, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-13 04:00:00', 34, NULL, NULL, NULL, NULL),
(488, 27, 34, 34, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-13 19:00:00', 34, NULL, NULL, NULL, NULL),
(489, 27, 34, 34, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-14 04:00:00', 34, NULL, NULL, NULL, NULL),
(490, 27, 34, 34, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-15 22:00:00', 34, NULL, NULL, NULL, NULL),
(491, 27, 34, 34, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-16 07:00:00', 34, NULL, NULL, NULL, NULL),
(492, 27, 34, 34, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-16 19:00:00', 34, NULL, NULL, NULL, NULL),
(493, 27, 34, 34, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-17 04:00:00', 34, NULL, NULL, NULL, NULL),
(494, 27, 34, 34, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-17 22:00:00', 34, NULL, NULL, NULL, NULL),
(495, 27, 34, 34, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-18 07:00:00', 34, NULL, NULL, NULL, NULL),
(496, 27, 34, 34, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-18 22:00:00', 34, NULL, NULL, NULL, NULL),
(497, 27, 34, 34, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-19 07:00:00', 34, NULL, NULL, NULL, NULL),
(498, 27, 34, 34, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-19 22:00:00', 34, NULL, NULL, NULL, NULL),
(499, 27, 34, 34, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-20 07:00:00', 34, NULL, NULL, NULL, NULL),
(500, 27, 34, 34, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-20 20:00:00', 34, NULL, NULL, NULL, NULL),
(501, 27, 34, 34, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-21 05:00:00', 34, NULL, NULL, NULL, NULL),
(510, 26, 36, 36, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-21 06:00:00', 36, NULL, NULL, NULL, NULL),
(511, 26, 36, 36, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-21 15:00:00', 36, NULL, NULL, NULL, NULL),
(512, 26, 36, 36, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-22 06:00:00', 36, NULL, NULL, NULL, NULL),
(513, 26, 36, 36, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-22 15:00:00', 36, NULL, NULL, NULL, NULL),
(514, 26, 36, 36, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-24 09:00:00', 36, NULL, NULL, NULL, NULL),
(515, 26, 36, 36, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-24 18:00:00', 36, NULL, NULL, NULL, NULL),
(516, 26, 36, 36, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-25 07:00:00', 36, NULL, NULL, NULL, NULL),
(517, 26, 36, 36, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-25 16:00:00', 36, NULL, NULL, NULL, NULL),
(518, 26, 36, 36, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-26 06:00:00', 36, NULL, NULL, NULL, NULL),
(519, 26, 36, 36, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-26 15:00:00', 36, NULL, NULL, NULL, NULL),
(520, 26, 36, 36, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-27 06:00:00', 36, NULL, NULL, NULL, NULL),
(521, 26, 36, 36, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-27 15:00:00', 36, NULL, NULL, NULL, NULL),
(522, 26, 36, 36, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-28 07:00:00', 36, NULL, NULL, NULL, NULL),
(523, 26, 36, 36, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-28 16:00:00', 36, NULL, NULL, NULL, NULL),
(524, 26, 36, 36, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-30 06:00:00', 36, NULL, NULL, NULL, NULL),
(525, 26, 36, 36, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-30 15:00:00', 36, NULL, NULL, NULL, NULL),
(526, 26, 36, 36, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-31 06:00:00', 36, NULL, NULL, NULL, NULL),
(527, 26, 36, 36, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-31 15:00:00', 36, NULL, NULL, NULL, NULL),
(528, 26, 36, 36, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-01 06:00:00', 36, NULL, NULL, NULL, NULL),
(529, 26, 36, 36, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-01 15:00:00', 36, NULL, NULL, NULL, NULL),
(530, 26, 36, 36, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-02 06:00:00', 36, NULL, NULL, NULL, NULL),
(531, 26, 36, 36, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-02 15:00:00', 36, NULL, NULL, NULL, NULL),
(532, 26, 36, 36, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-03 06:00:00', 36, NULL, NULL, NULL, NULL),
(533, 26, 36, 36, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-03 15:00:00', 36, NULL, NULL, NULL, NULL),
(534, 26, 36, 36, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-05 06:00:00', 36, NULL, NULL, NULL, NULL),
(535, 26, 36, 36, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-05 15:00:00', 36, NULL, NULL, NULL, NULL),
(536, 26, 36, 36, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-06 07:00:00', 36, NULL, NULL, NULL, NULL),
(537, 26, 36, 36, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-06 16:00:00', 36, NULL, NULL, NULL, NULL),
(538, 26, 36, 36, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-07 12:00:00', 36, NULL, NULL, NULL, NULL),
(539, 26, 36, 36, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-07 21:00:00', 36, NULL, NULL, NULL, NULL),
(540, 26, 36, 36, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-08 11:00:00', 36, NULL, NULL, NULL, NULL),
(541, 26, 36, 36, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-08 20:00:00', 36, NULL, NULL, NULL, NULL),
(542, 26, 36, 36, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-10 07:00:00', 36, NULL, NULL, NULL, NULL),
(543, 26, 36, 36, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-10 16:00:00', 36, NULL, NULL, NULL, NULL),
(544, 26, 36, 36, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-11 07:00:00', 36, NULL, NULL, NULL, NULL),
(545, 26, 36, 36, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-11 16:00:00', 36, NULL, NULL, NULL, NULL),
(546, 26, 36, 36, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-12 07:00:00', 36, NULL, NULL, NULL, NULL),
(547, 26, 36, 36, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-12 16:00:00', 36, NULL, NULL, NULL, NULL),
(548, 26, 36, 36, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-13 07:00:00', 36, NULL, NULL, NULL, NULL),
(549, 26, 36, 36, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-13 16:00:00', 36, NULL, NULL, NULL, NULL),
(550, 26, 36, 36, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-14 17:00:00', 36, NULL, NULL, NULL, NULL),
(551, 26, 36, 36, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-15 02:00:00', 36, NULL, NULL, NULL, NULL),
(552, 26, 36, 36, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-15 17:00:00', 36, NULL, NULL, NULL, NULL),
(553, 26, 36, 36, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-16 02:00:00', 36, NULL, NULL, NULL, NULL),
(554, 26, 36, 36, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-16 17:00:00', 36, NULL, NULL, NULL, NULL),
(555, 26, 36, 36, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-17 02:00:00', 36, NULL, NULL, NULL, NULL),
(556, 26, 36, 36, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-17 17:00:00', 36, NULL, NULL, NULL, NULL),
(557, 26, 36, 36, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-18 02:00:00', 36, NULL, NULL, NULL, NULL),
(558, 26, 36, 36, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-19 09:00:00', 36, NULL, NULL, NULL, NULL),
(559, 26, 36, 36, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-19 18:00:00', 36, NULL, NULL, NULL, NULL),
(561, 26, 37, 35, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-22 11:00:00', 35, NULL, NULL, NULL, NULL),
(562, 26, 37, 35, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-22 20:00:00', 35, NULL, NULL, NULL, NULL),
(563, 26, 37, 35, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-23 14:00:00', 35, NULL, NULL, NULL, NULL),
(564, 26, 37, 35, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-23 23:00:00', 35, NULL, NULL, NULL, NULL),
(565, 26, 37, 35, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-24 14:00:00', 35, NULL, NULL, NULL, NULL),
(566, 26, 37, 35, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-24 23:00:00', 35, NULL, NULL, NULL, NULL),
(567, 26, 37, 35, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-25 11:00:00', 35, NULL, NULL, NULL, NULL),
(568, 26, 37, 35, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-25 20:00:00', 35, NULL, NULL, NULL, NULL),
(569, 26, 37, 35, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-26 11:00:00', 35, NULL, NULL, NULL, NULL),
(570, 26, 37, 35, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-26 20:00:00', 35, NULL, NULL, NULL, NULL),
(571, 26, 37, 35, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-27 11:00:00', 35, NULL, NULL, NULL, NULL),
(572, 26, 37, 35, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-27 20:00:00', 35, NULL, NULL, NULL, NULL),
(573, 26, 37, 35, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-28 11:00:00', 35, NULL, NULL, NULL, NULL),
(574, 26, 37, 35, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-28 20:00:00', 35, NULL, NULL, NULL, NULL),
(575, 26, 37, 35, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-29 11:00:00', 35, NULL, NULL, NULL, NULL),
(576, 26, 37, 35, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-29 20:00:00', 35, NULL, NULL, NULL, NULL),
(577, 26, 37, 35, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-30 14:00:00', 35, NULL, NULL, NULL, NULL),
(578, 26, 37, 35, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-30 23:00:00', 35, NULL, NULL, NULL, NULL),
(579, 26, 37, 35, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-31 14:00:00', 35, NULL, NULL, NULL, NULL),
(580, 26, 37, 35, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-31 23:00:00', 35, NULL, NULL, NULL, NULL),
(581, 26, 37, 35, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-04 11:00:00', 35, NULL, NULL, NULL, NULL),
(582, 26, 37, 35, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-04 20:00:00', 35, NULL, NULL, NULL, NULL),
(583, 26, 37, 35, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-05 14:00:00', 35, NULL, NULL, NULL, NULL),
(584, 26, 37, 35, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-05 23:00:00', 35, NULL, NULL, NULL, NULL),
(585, 26, 37, 35, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-06 10:00:00', 35, NULL, NULL, NULL, NULL),
(586, 26, 37, 35, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-06 19:00:00', 35, NULL, NULL, NULL, NULL),
(587, 26, 37, 35, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-07 07:00:00', 35, NULL, NULL, NULL, NULL),
(588, 26, 37, 35, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-07 16:00:00', 35, NULL, NULL, NULL, NULL),
(589, 26, 37, 35, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-08 07:00:00', 35, NULL, NULL, NULL, NULL),
(590, 26, 37, 35, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-08 16:00:00', 35, NULL, NULL, NULL, NULL),
(591, 26, 37, 35, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-09 07:00:00', 35, NULL, NULL, NULL, NULL),
(592, 26, 37, 35, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-09 16:00:00', 35, NULL, NULL, NULL, NULL),
(593, 26, 37, 35, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-10 07:00:00', 35, NULL, NULL, NULL, NULL),
(594, 26, 37, 35, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-10 16:00:00', 35, NULL, NULL, NULL, NULL),
(595, 26, 37, 35, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-11 07:00:00', 35, NULL, NULL, NULL, NULL),
(596, 26, 37, 35, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-11 16:00:00', 35, NULL, NULL, NULL, NULL),
(597, 26, 37, 35, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-12 07:00:00', 35, NULL, NULL, NULL, NULL),
(598, 26, 37, 35, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-12 16:00:00', 35, NULL, NULL, NULL, NULL),
(599, 26, 37, 35, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-13 07:00:00', 35, NULL, NULL, NULL, NULL),
(600, 26, 37, 35, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-13 16:00:00', 35, NULL, NULL, NULL, NULL),
(601, 26, 37, 35, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-14 07:00:00', 35, NULL, NULL, NULL, NULL),
(602, 26, 37, 35, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-14 16:00:00', 35, NULL, NULL, NULL, NULL),
(603, 26, 37, 35, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-15 07:00:00', 35, NULL, NULL, NULL, NULL),
(604, 26, 37, 35, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-15 16:00:00', 35, NULL, NULL, NULL, NULL),
(605, 26, 37, 35, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-16 06:00:00', 35, NULL, NULL, NULL, NULL),
(606, 26, 37, 35, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-16 15:00:00', 35, NULL, NULL, NULL, NULL),
(607, 26, 37, 35, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-18 09:00:00', 35, NULL, NULL, NULL, NULL),
(608, 26, 37, 35, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-18 18:00:00', 35, NULL, NULL, NULL, NULL),
(609, 26, 37, 35, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-19 11:00:00', 35, NULL, NULL, NULL, NULL),
(610, 26, 37, 35, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-19 20:00:00', 35, NULL, NULL, NULL, NULL),
(611, 24, 37, 37, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-21 07:00:00', 37, NULL, NULL, NULL, NULL),
(612, 24, 37, 37, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-21 16:00:00', 37, NULL, NULL, NULL, NULL),
(613, 24, 37, 37, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-22 07:00:00', 37, NULL, NULL, NULL, NULL),
(614, 24, 37, 37, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-22 16:00:00', 37, NULL, NULL, NULL, NULL),
(615, 24, 37, 37, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-23 06:00:00', 37, NULL, NULL, NULL, NULL),
(616, 24, 37, 37, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-23 15:00:00', 37, NULL, NULL, NULL, NULL),
(617, 24, 37, 37, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-24 07:00:00', 37, NULL, NULL, NULL, NULL),
(618, 24, 37, 37, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-24 16:00:00', 37, NULL, NULL, NULL, NULL),
(619, 24, 37, 37, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-25 06:00:00', 37, NULL, NULL, NULL, NULL),
(620, 24, 37, 37, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-25 15:00:00', 37, NULL, NULL, NULL, NULL),
(621, 24, 37, 37, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-27 15:00:00', 37, NULL, NULL, NULL, NULL),
(622, 24, 37, 37, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-28 02:00:00', 37, NULL, NULL, NULL, NULL),
(623, 24, 37, 37, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-28 06:00:00', 37, NULL, NULL, NULL, NULL),
(624, 24, 37, 37, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-28 15:00:00', 37, NULL, NULL, NULL, NULL),
(625, 24, 37, 37, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-29 06:00:00', 37, NULL, NULL, NULL, NULL),
(626, 24, 37, 37, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-29 15:00:00', 37, NULL, NULL, NULL, NULL),
(627, 24, 37, 37, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-30 06:00:00', 37, NULL, NULL, NULL, NULL),
(628, 24, 37, 37, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-30 15:00:00', 37, NULL, NULL, NULL, NULL),
(629, 24, 37, 37, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-31 06:00:00', 37, NULL, NULL, NULL, NULL),
(630, 24, 37, 37, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-31 15:00:00', 37, NULL, NULL, NULL, NULL),
(631, 24, 37, 37, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-01 15:00:00', 37, NULL, NULL, NULL, NULL),
(632, 24, 37, 37, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-03 00:00:00', 37, NULL, NULL, NULL, NULL),
(633, 24, 37, 37, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-04 06:00:00', 37, NULL, NULL, NULL, NULL),
(634, 24, 37, 37, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-04 15:00:00', 37, NULL, NULL, NULL, NULL),
(635, 24, 37, 37, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-05 06:00:00', 37, NULL, NULL, NULL, NULL),
(636, 24, 37, 37, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-05 15:00:00', 37, NULL, NULL, NULL, NULL),
(637, 24, 37, 37, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-06 15:00:00', 37, NULL, NULL, NULL, NULL),
(638, 24, 37, 37, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-07 02:00:00', 37, NULL, NULL, NULL, NULL),
(639, 24, 37, 37, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-07 06:00:00', 37, NULL, NULL, NULL, NULL),
(640, 24, 37, 37, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-07 15:00:00', 37, NULL, NULL, NULL, NULL),
(641, 24, 37, 37, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-08 06:00:00', 37, NULL, NULL, NULL, NULL),
(642, 24, 37, 37, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-08 15:00:00', 37, NULL, NULL, NULL, NULL),
(643, 24, 37, 37, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-10 06:00:00', 37, NULL, NULL, NULL, NULL),
(644, 24, 37, 37, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-10 15:00:00', 37, NULL, NULL, NULL, NULL),
(645, 24, 37, 37, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-11 06:00:00', 37, NULL, NULL, NULL, NULL),
(646, 24, 37, 37, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-11 15:00:00', 37, NULL, NULL, NULL, NULL),
(647, 24, 37, 37, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-12 12:00:00', 37, NULL, NULL, NULL, NULL),
(648, 24, 37, 37, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-12 21:00:00', 37, NULL, NULL, NULL, NULL),
(649, 24, 37, 37, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-13 12:00:00', 37, NULL, NULL, NULL, NULL),
(650, 24, 37, 37, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-13 21:00:00', 37, NULL, NULL, NULL, NULL),
(651, 24, 37, 37, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-14 12:00:00', 37, NULL, NULL, NULL, NULL),
(652, 24, 37, 37, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-14 21:00:00', 37, NULL, NULL, NULL, NULL),
(653, 24, 37, 37, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-15 12:00:00', 37, NULL, NULL, NULL, NULL),
(654, 24, 37, 37, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-15 21:00:00', 37, NULL, NULL, NULL, NULL),
(655, 24, 37, 37, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-17 06:00:00', 37, NULL, NULL, NULL, NULL),
(656, 24, 37, 37, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-17 15:00:00', 37, NULL, NULL, NULL, NULL),
(657, 24, 37, 37, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-18 06:00:00', 37, NULL, NULL, NULL, NULL),
(658, 24, 37, 37, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-18 15:00:00', 37, NULL, NULL, NULL, NULL),
(659, 24, 37, 37, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-19 12:00:00', 37, NULL, NULL, NULL, NULL),
(660, 24, 37, 37, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-19 21:00:00', 37, NULL, NULL, NULL, NULL),
(661, 24, 37, 37, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-20 12:00:00', 37, NULL, NULL, NULL, NULL),
(662, 24, 37, 37, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-20 21:00:00', 37, NULL, NULL, NULL, NULL),
(675, 27, 34, 34, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-20 23:03:29', 34, NULL, NULL, NULL, NULL),
(677, 30, 42, 34, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-23 23:05:48', 34, NULL, NULL, NULL, NULL),
(681, 24, 43, 32, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-15 09:00:00', 32, NULL, NULL, NULL, NULL),
(682, 24, 43, 32, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-15 18:00:00', 32, NULL, NULL, NULL, NULL),
(683, 24, 43, 32, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-16 09:00:00', 32, NULL, NULL, NULL, NULL),
(684, 24, 43, 32, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-16 18:00:00', 32, NULL, NULL, NULL, NULL),
(685, 24, 43, 32, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-17 07:00:00', 32, NULL, NULL, NULL, NULL),
(686, 24, 43, 32, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-17 16:00:00', 32, NULL, NULL, NULL, NULL),
(687, 24, 34, 32, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-18 09:00:00', 32, NULL, NULL, NULL, NULL),
(688, 24, 34, 32, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-18 18:00:00', 32, NULL, NULL, NULL, NULL),
(689, 24, 43, 32, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-19 08:00:00', 32, NULL, NULL, NULL, NULL),
(692, 24, 44, 33, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-28 11:00:00', 33, NULL, NULL, NULL, NULL),
(693, 24, 44, 33, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-28 20:00:00', 33, NULL, NULL, NULL, NULL),
(694, 24, 44, 33, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-29 10:00:00', 33, NULL, NULL, NULL, NULL),
(695, 24, 44, 33, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-29 19:00:00', 33, NULL, NULL, NULL, NULL),
(696, 24, 44, 33, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-30 08:00:00', 33, NULL, NULL, NULL, NULL),
(697, 24, 44, 33, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-30 17:00:00', 33, NULL, NULL, NULL, NULL),
(698, 24, 44, 33, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-31 09:00:00', 33, NULL, NULL, NULL, NULL),
(699, 24, 44, 33, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-31 18:00:00', 33, NULL, NULL, NULL, NULL),
(700, 24, 44, 33, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-01 07:00:00', 33, NULL, NULL, NULL, NULL),
(701, 24, 44, 33, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-01 16:00:00', 33, NULL, NULL, NULL, NULL),
(702, 24, 44, 33, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-02 09:00:00', 33, NULL, NULL, NULL, NULL),
(703, 24, 44, 33, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-02 18:00:00', 33, NULL, NULL, NULL, NULL),
(704, 24, 44, 33, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-04 09:00:00', 33, NULL, NULL, NULL, NULL),
(705, 24, 44, 33, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-04 18:00:00', 33, NULL, NULL, NULL, NULL),
(706, 24, 44, 33, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-05 09:00:00', 33, NULL, NULL, NULL, NULL),
(707, 24, 44, 33, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-05 18:00:00', 33, NULL, NULL, NULL, NULL),
(708, 24, 44, 33, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-06 09:00:00', 33, NULL, NULL, NULL, NULL),
(709, 24, 44, 33, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-06 18:00:00', 33, NULL, NULL, NULL, NULL),
(710, 24, 44, 33, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-07 09:00:00', 33, NULL, NULL, NULL, NULL),
(711, 24, 44, 33, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-07 18:00:00', 33, NULL, NULL, NULL, NULL),
(712, 24, 44, 33, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-08 09:00:00', 33, NULL, NULL, NULL, NULL),
(713, 24, 44, 33, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-08 18:00:00', 33, NULL, NULL, NULL, NULL),
(714, 24, 44, 33, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-09 12:00:00', 33, NULL, NULL, NULL, NULL),
(715, 24, 44, 33, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-09 21:00:00', 33, NULL, NULL, NULL, NULL),
(716, 24, 44, 33, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-11 07:00:00', 33, NULL, NULL, NULL, NULL),
(717, 24, 44, 33, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-11 16:00:00', 33, NULL, NULL, NULL, NULL),
(718, 24, 44, 33, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-12 17:00:00', 33, NULL, NULL, NULL, NULL),
(719, 24, 44, 33, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-13 02:00:00', 33, NULL, NULL, NULL, NULL),
(720, 24, 44, 33, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-13 06:00:00', 33, NULL, NULL, NULL, NULL),
(721, 24, 44, 33, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-13 15:00:00', 33, NULL, NULL, NULL, NULL),
(722, 24, 44, 33, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-14 12:00:00', 33, NULL, NULL, NULL, NULL),
(723, 24, 44, 33, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-14 21:00:00', 33, NULL, NULL, NULL, NULL),
(724, 24, 44, 33, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-15 12:00:00', 33, NULL, NULL, NULL, NULL),
(725, 24, 44, 33, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-15 21:00:00', 33, NULL, NULL, NULL, NULL),
(726, 24, 44, 33, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-16 12:00:00', 33, NULL, NULL, NULL, NULL),
(727, 24, 44, 33, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-16 21:00:00', 33, NULL, NULL, NULL, NULL),
(728, 24, 44, 33, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-18 09:00:00', 33, NULL, NULL, NULL, NULL),
(729, 24, 44, 33, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-18 18:00:00', 33, NULL, NULL, NULL, NULL),
(731, 28, 31, 31, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-22 12:06:40', 31, NULL, NULL, NULL, NULL),
(734, 24, 45, 31, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-21 07:00:00', 31, NULL, NULL, NULL, NULL),
(735, 24, 45, 31, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-21 16:00:00', 31, NULL, NULL, NULL, NULL),
(736, 24, 45, 31, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-23 07:00:00', 31, NULL, NULL, NULL, NULL),
(737, 24, 45, 31, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-23 16:00:00', 31, NULL, NULL, NULL, NULL),
(738, 24, 45, 31, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-24 07:00:00', 31, NULL, NULL, NULL, NULL),
(739, 24, 45, 31, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-24 16:00:00', 31, NULL, NULL, NULL, NULL),
(740, 24, 45, 31, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-25 07:00:00', 31, NULL, NULL, NULL, NULL),
(741, 24, 45, 31, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-25 16:00:00', 31, NULL, NULL, NULL, NULL),
(742, 24, 45, 31, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-26 07:00:00', 31, NULL, NULL, NULL, NULL),
(743, 24, 45, 31, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-26 16:00:00', 31, NULL, NULL, NULL, NULL),
(744, 24, 45, 31, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-27 07:00:00', 31, NULL, NULL, NULL, NULL),
(745, 24, 45, 31, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-27 16:00:00', 31, NULL, NULL, NULL, NULL),
(746, 24, 45, 31, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-28 07:00:00', 31, NULL, NULL, NULL, NULL),
(747, 24, 45, 31, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-28 16:00:00', 31, NULL, NULL, NULL, NULL),
(748, 24, 45, 31, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-01 07:00:00', 31, NULL, NULL, NULL, NULL),
(749, 24, 45, 31, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-01 16:00:00', 31, NULL, NULL, NULL, NULL),
(750, 24, 45, 31, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-02 08:00:00', 31, NULL, NULL, NULL, NULL),
(751, 24, 45, 31, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-02 17:00:00', 31, NULL, NULL, NULL, NULL),
(752, 24, 45, 31, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-03 08:00:00', 31, NULL, NULL, NULL, NULL),
(753, 24, 45, 31, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-03 17:00:00', 31, NULL, NULL, NULL, NULL),
(754, 24, 45, 31, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-04 08:00:00', 31, NULL, NULL, NULL, NULL),
(755, 24, 45, 31, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-04 17:00:00', 31, NULL, NULL, NULL, NULL),
(756, 24, 45, 31, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-05 08:00:00', 31, NULL, NULL, NULL, NULL),
(757, 24, 45, 31, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-05 17:00:00', 31, NULL, NULL, NULL, NULL),
(758, 24, 45, 31, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-07 07:00:00', 31, NULL, NULL, NULL, NULL),
(759, 24, 45, 31, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-07 16:00:00', 31, NULL, NULL, NULL, NULL),
(760, 24, 45, 31, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-08 08:00:00', 31, NULL, NULL, NULL, NULL),
(761, 24, 45, 31, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-08 17:00:00', 31, NULL, NULL, NULL, NULL),
(762, 24, 45, 31, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-09 08:00:00', 31, NULL, NULL, NULL, NULL),
(763, 24, 45, 31, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-09 17:00:00', 31, NULL, NULL, NULL, NULL),
(764, 24, 45, 31, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-10 08:00:00', 31, NULL, NULL, NULL, NULL),
(765, 24, 45, 31, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-10 17:00:00', 31, NULL, NULL, NULL, NULL),
(766, 24, 45, 31, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-12 08:00:00', 31, NULL, NULL, NULL, NULL),
(767, 24, 45, 31, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-12 17:00:00', 31, NULL, NULL, NULL, NULL),
(768, 24, 45, 31, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-13 08:00:00', 31, NULL, NULL, NULL, NULL),
(769, 24, 45, 31, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-13 17:00:00', 31, NULL, NULL, NULL, NULL),
(770, 24, 45, 31, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-14 08:00:00', 31, NULL, NULL, NULL, NULL),
(771, 24, 45, 31, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-14 17:00:00', 31, NULL, NULL, NULL, NULL),
(772, 24, 45, 31, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-15 08:00:00', 31, NULL, NULL, NULL, NULL),
(773, 24, 45, 31, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-15 17:00:00', 31, NULL, NULL, NULL, NULL),
(774, 24, 45, 31, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-16 08:00:00', 31, NULL, NULL, NULL, NULL),
(775, 24, 45, 31, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-16 17:00:00', 31, NULL, NULL, NULL, NULL),
(776, 24, 45, 31, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-18 08:00:00', 31, NULL, NULL, NULL, NULL),
(777, 24, 45, 31, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-18 17:00:00', 31, NULL, NULL, NULL, NULL),
(778, 24, 45, 31, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-19 08:00:00', 31, NULL, NULL, NULL, NULL),
(779, 24, 45, 31, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-19 17:00:00', 31, NULL, NULL, NULL, NULL),
(780, 31, 46, 39, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-23 14:00:00', 39, NULL, NULL, NULL, NULL),
(781, 31, 46, 39, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-23 23:00:00', 39, NULL, NULL, NULL, NULL),
(782, 31, 46, 39, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-24 14:00:00', 39, NULL, NULL, NULL, NULL),
(783, 31, 46, 39, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-24 23:00:00', 39, NULL, NULL, NULL, NULL),
(784, 31, 46, 39, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-25 14:00:00', 39, NULL, NULL, NULL, NULL),
(785, 31, 46, 39, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-25 23:00:00', 39, NULL, NULL, NULL, NULL),
(786, 31, 46, 39, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-26 14:00:00', 39, NULL, NULL, NULL, NULL),
(787, 31, 46, 39, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-26 23:00:00', 39, NULL, NULL, NULL, NULL),
(788, 31, 46, 39, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-27 14:00:00', 39, NULL, NULL, NULL, NULL),
(789, 31, 46, 39, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-27 23:00:00', 39, NULL, NULL, NULL, NULL),
(790, 31, 47, 40, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-28 06:00:00', 40, NULL, NULL, NULL, NULL),
(791, 31, 47, 40, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-28 15:00:00', 40, NULL, NULL, NULL, NULL),
(792, 31, 47, 40, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-29 06:00:00', 40, NULL, NULL, NULL, NULL),
(793, 31, 47, 40, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-29 15:00:00', 40, NULL, NULL, NULL, NULL),
(794, 31, 47, 40, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-31 10:00:00', 40, NULL, NULL, NULL, NULL);
INSERT INTO `job_attendances` (`id`, `job_id`, `application_id`, `user_id`, `transaction_id`, `type`, `latitude`, `longitude`, `photo_path`, `device_info`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
(795, 31, 47, 40, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-31 19:00:00', 40, NULL, NULL, NULL, NULL),
(796, 31, 47, 40, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-01 14:00:00', 40, NULL, NULL, NULL, NULL),
(797, 31, 47, 40, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-01 23:00:00', 40, NULL, NULL, NULL, NULL),
(798, 31, 47, 40, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-02 07:00:00', 40, NULL, NULL, NULL, NULL),
(799, 31, 47, 40, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-02 16:00:00', 40, NULL, NULL, NULL, NULL),
(800, 31, 47, 40, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-05 06:00:00', 40, NULL, NULL, NULL, NULL),
(801, 31, 47, 40, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-05 15:00:00', 40, NULL, NULL, NULL, NULL),
(802, 31, 48, 41, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-28 06:00:00', 41, NULL, NULL, NULL, NULL),
(803, 31, 48, 41, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-28 15:00:00', 41, NULL, NULL, NULL, NULL),
(804, 31, 48, 41, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-29 06:00:00', 41, NULL, NULL, NULL, NULL),
(805, 31, 48, 41, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-29 15:00:00', 41, NULL, NULL, NULL, NULL),
(806, 31, 48, 41, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-01 14:00:00', 41, NULL, NULL, NULL, NULL),
(807, 31, 48, 41, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-01 23:00:00', 41, NULL, NULL, NULL, NULL),
(808, 31, 48, 41, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-02 11:00:00', 41, NULL, NULL, NULL, NULL),
(809, 31, 48, 41, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-02 20:00:00', 41, NULL, NULL, NULL, NULL),
(810, 31, 48, 41, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-03 07:00:00', 41, NULL, NULL, NULL, NULL),
(811, 31, 48, 41, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-03 16:00:00', 41, NULL, NULL, NULL, NULL),
(812, 31, 48, 41, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-04 10:00:00', 41, NULL, NULL, NULL, NULL),
(813, 31, 48, 41, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-04 19:00:00', 41, NULL, NULL, NULL, NULL),
(814, 31, 48, 41, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-05 08:00:00', 41, NULL, NULL, NULL, NULL),
(815, 31, 48, 41, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-05 17:00:00', 41, NULL, NULL, NULL, NULL),
(816, 31, 48, 41, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-06 07:00:00', 41, NULL, NULL, NULL, NULL),
(817, 31, 48, 41, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-06 16:00:00', 41, NULL, NULL, NULL, NULL),
(818, 31, 48, 41, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-09 08:00:00', 41, NULL, NULL, NULL, NULL),
(819, 31, 48, 41, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-09 17:00:00', 41, NULL, NULL, NULL, NULL),
(820, 31, 48, 41, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-10 06:00:00', 41, NULL, NULL, NULL, NULL),
(821, 31, 48, 41, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-10 15:00:00', 41, NULL, NULL, NULL, NULL),
(822, 31, 49, 42, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-23 07:00:00', 42, NULL, NULL, NULL, NULL),
(823, 31, 49, 42, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-23 16:00:00', 42, NULL, NULL, NULL, NULL),
(824, 31, 49, 42, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-25 07:00:00', 42, NULL, NULL, NULL, NULL),
(825, 31, 49, 42, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-25 16:00:00', 42, NULL, NULL, NULL, NULL),
(826, 31, 49, 42, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-26 07:00:00', 42, NULL, NULL, NULL, NULL),
(827, 31, 49, 42, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-26 16:00:00', 42, NULL, NULL, NULL, NULL),
(828, 31, 50, 43, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-31 07:00:00', 43, NULL, NULL, NULL, NULL),
(829, 31, 50, 43, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-31 16:00:00', 43, NULL, NULL, NULL, NULL),
(830, 31, 50, 43, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-01 14:00:00', 43, NULL, NULL, NULL, NULL),
(831, 31, 50, 43, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-01 23:00:00', 43, NULL, NULL, NULL, NULL),
(832, 31, 50, 43, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-02 10:00:00', 43, NULL, NULL, NULL, NULL),
(833, 31, 50, 43, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-02 19:00:00', 43, NULL, NULL, NULL, NULL),
(834, 31, 50, 43, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-03 07:00:00', 43, NULL, NULL, NULL, NULL),
(835, 31, 50, 43, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-03 16:00:00', 43, NULL, NULL, NULL, NULL),
(836, 31, 50, 43, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-04 10:00:00', 43, NULL, NULL, NULL, NULL),
(837, 31, 50, 43, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-04 19:00:00', 43, NULL, NULL, NULL, NULL),
(838, 31, 50, 43, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-05 08:00:00', 43, NULL, NULL, NULL, NULL),
(839, 31, 50, 43, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-05 17:00:00', 43, NULL, NULL, NULL, NULL),
(840, 31, 51, 44, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-01 07:00:00', 44, NULL, NULL, NULL, NULL),
(841, 31, 51, 44, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-01 16:00:00', 44, NULL, NULL, NULL, NULL),
(842, 31, 51, 44, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-02 14:00:00', 44, NULL, NULL, NULL, NULL),
(843, 31, 51, 44, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-02 23:00:00', 44, NULL, NULL, NULL, NULL),
(844, 31, 51, 44, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-03 10:00:00', 44, NULL, NULL, NULL, NULL),
(845, 31, 51, 44, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-03 19:00:00', 44, NULL, NULL, NULL, NULL),
(846, 31, 51, 44, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-04 07:00:00', 44, NULL, NULL, NULL, NULL),
(847, 31, 51, 44, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-04 16:00:00', 44, NULL, NULL, NULL, NULL),
(848, 31, 51, 44, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-05 10:00:00', 44, NULL, NULL, NULL, NULL),
(849, 31, 51, 44, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-05 19:00:00', 44, NULL, NULL, NULL, NULL),
(850, 31, 51, 44, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-06 08:00:00', 44, NULL, NULL, NULL, NULL),
(851, 31, 51, 44, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-06 17:00:00', 44, NULL, NULL, NULL, NULL),
(852, 31, 52, 45, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-31 10:00:00', 45, NULL, NULL, NULL, NULL),
(853, 31, 52, 45, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-31 19:00:00', 45, NULL, NULL, NULL, NULL),
(854, 31, 52, 45, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-03 08:00:00', 45, NULL, NULL, NULL, NULL),
(855, 31, 52, 45, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-03 17:00:00', 45, NULL, NULL, NULL, NULL),
(856, 31, 52, 45, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-04 08:00:00', 45, NULL, NULL, NULL, NULL),
(857, 31, 52, 45, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-04 17:00:00', 45, NULL, NULL, NULL, NULL),
(858, 31, 52, 45, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-07 08:00:00', 45, NULL, NULL, NULL, NULL),
(859, 31, 52, 45, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-07 17:00:00', 45, NULL, NULL, NULL, NULL),
(860, 31, 53, 46, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-31 10:00:00', 46, NULL, NULL, NULL, NULL),
(861, 31, 53, 46, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-31 19:00:00', 46, NULL, NULL, NULL, NULL),
(862, 31, 53, 46, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-01 10:00:00', 46, NULL, NULL, NULL, NULL),
(863, 31, 53, 46, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-01 19:00:00', 46, NULL, NULL, NULL, NULL),
(864, 31, 54, 47, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-31 10:00:00', 47, NULL, NULL, NULL, NULL),
(865, 31, 54, 47, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-31 19:00:00', 47, NULL, NULL, NULL, NULL),
(866, 31, 54, 47, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-01 10:00:00', 47, NULL, NULL, NULL, NULL),
(867, 31, 54, 47, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-01 19:00:00', 47, NULL, NULL, NULL, NULL),
(869, 24, 37, 37, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-02 15:00:00', 37, NULL, NULL, NULL, NULL),
(870, 24, 55, 48, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-26 14:00:00', 48, NULL, NULL, NULL, NULL),
(871, 24, 55, 48, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-26 23:00:00', 48, NULL, NULL, NULL, NULL),
(872, 24, 55, 48, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-27 10:00:00', 48, NULL, NULL, NULL, NULL),
(873, 24, 55, 48, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-27 19:00:00', 48, NULL, NULL, NULL, NULL),
(875, 24, 43, 32, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-14 18:00:00', 32, NULL, NULL, NULL, NULL),
(876, 24, 43, 32, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-14 09:00:00', 32, NULL, NULL, NULL, NULL),
(878, 33, 60, 53, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-29 08:00:00', 53, NULL, NULL, NULL, NULL),
(879, 33, 60, 53, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-29 17:00:00', 53, NULL, NULL, NULL, NULL),
(880, 33, 60, 53, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-30 06:00:00', 53, NULL, NULL, NULL, NULL),
(881, 33, 60, 53, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-30 15:00:00', 53, NULL, NULL, NULL, NULL),
(882, 33, 60, 53, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-31 11:00:00', 53, NULL, NULL, NULL, NULL),
(883, 33, 60, 53, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-31 20:00:00', 53, NULL, NULL, NULL, NULL),
(884, 33, 60, 53, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-01 11:00:00', 53, NULL, NULL, NULL, NULL),
(885, 33, 60, 53, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-01 20:00:00', 53, NULL, NULL, NULL, NULL),
(886, 33, 60, 53, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-03 06:00:00', 53, NULL, NULL, NULL, NULL),
(887, 33, 60, 53, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-03 15:00:00', 53, NULL, NULL, NULL, NULL),
(888, 33, 60, 53, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-04 07:00:00', 53, NULL, NULL, NULL, NULL),
(889, 33, 60, 53, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-04 16:00:00', 53, NULL, NULL, NULL, NULL),
(890, 33, 60, 53, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-05 06:00:00', 53, NULL, NULL, NULL, NULL),
(891, 33, 60, 53, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-05 15:00:00', 53, NULL, NULL, NULL, NULL),
(892, 33, 60, 53, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-06 07:00:00', 53, NULL, NULL, NULL, NULL),
(893, 33, 60, 53, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-06 16:00:00', 53, NULL, NULL, NULL, NULL),
(894, 33, 60, 53, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-07 07:00:00', 53, NULL, NULL, NULL, NULL),
(895, 33, 60, 53, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-07 16:00:00', 53, NULL, NULL, NULL, NULL),
(896, 33, 60, 53, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-08 07:00:00', 53, NULL, NULL, NULL, NULL),
(897, 33, 60, 53, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-08 16:00:00', 53, NULL, NULL, NULL, NULL),
(898, 33, 60, 53, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-09 07:00:00', 53, NULL, NULL, NULL, NULL),
(899, 33, 60, 53, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-09 16:00:00', 53, NULL, NULL, NULL, NULL),
(900, 33, 60, 53, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-10 07:00:00', 53, NULL, NULL, NULL, NULL),
(901, 33, 60, 53, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-10 16:00:00', 53, NULL, NULL, NULL, NULL),
(902, 33, 60, 53, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-11 07:00:00', 53, NULL, NULL, NULL, NULL),
(903, 33, 60, 53, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-11 16:00:00', 53, NULL, NULL, NULL, NULL),
(904, 33, 60, 53, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-12 07:00:00', 53, NULL, NULL, NULL, NULL),
(905, 33, 60, 53, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-12 16:00:00', 53, NULL, NULL, NULL, NULL),
(906, 33, 60, 53, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-13 07:00:00', 53, NULL, NULL, NULL, NULL),
(907, 33, 60, 53, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-13 16:00:00', 53, NULL, NULL, NULL, NULL),
(908, 33, 60, 53, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-14 07:00:00', 53, NULL, NULL, NULL, NULL),
(909, 33, 60, 53, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-14 16:00:00', 53, NULL, NULL, NULL, NULL),
(910, 33, 60, 53, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-15 06:00:00', 53, NULL, NULL, NULL, NULL),
(911, 33, 60, 53, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-15 15:00:00', 53, NULL, NULL, NULL, NULL),
(912, 33, 60, 53, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-17 09:00:00', 53, NULL, NULL, NULL, NULL),
(913, 33, 60, 53, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-17 18:00:00', 53, NULL, NULL, NULL, NULL),
(914, 33, 56, 49, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-21 11:00:00', 49, NULL, NULL, NULL, NULL),
(915, 33, 56, 49, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-21 20:00:00', 49, NULL, NULL, NULL, NULL),
(916, 33, 56, 49, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-24 07:00:00', 49, NULL, NULL, NULL, NULL),
(917, 33, 56, 49, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-24 16:00:00', 49, NULL, NULL, NULL, NULL),
(918, 33, 58, 50, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-01 07:00:00', 50, NULL, NULL, NULL, NULL),
(919, 33, 58, 50, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-01 16:00:00', 50, NULL, NULL, NULL, NULL),
(920, 33, 58, 50, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-03 14:00:00', 50, NULL, NULL, NULL, NULL),
(921, 33, 58, 50, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-03 23:00:00', 50, NULL, NULL, NULL, NULL),
(922, 33, 58, 50, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-04 14:00:00', 50, NULL, NULL, NULL, NULL),
(923, 33, 58, 50, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-04 23:00:00', 50, NULL, NULL, NULL, NULL),
(924, 33, 58, 50, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-05 14:00:00', 50, NULL, NULL, NULL, NULL),
(925, 33, 58, 50, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-05 23:00:00', 50, NULL, NULL, NULL, NULL),
(926, 33, 58, 50, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-06 14:00:00', 50, NULL, NULL, NULL, NULL),
(927, 33, 58, 50, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-06 23:00:00', 50, NULL, NULL, NULL, NULL),
(928, 32, 59, 51, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-08 09:00:00', 51, NULL, NULL, NULL, NULL),
(929, 32, 59, 51, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-08 18:00:00', 51, NULL, NULL, NULL, NULL),
(930, 34, 61, 52, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-29 09:00:00', 52, NULL, NULL, NULL, NULL),
(931, 34, 61, 52, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-29 18:00:00', 52, NULL, NULL, NULL, NULL),
(949, 35, 62, 38, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-21 07:00:00', 38, NULL, NULL, NULL, NULL),
(950, 35, 62, 38, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-21 16:00:00', 38, NULL, NULL, NULL, NULL),
(951, 35, 62, 38, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-22 07:00:00', 38, NULL, NULL, NULL, NULL),
(952, 35, 62, 38, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-22 16:00:00', 38, NULL, NULL, NULL, NULL),
(953, 35, 62, 38, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-23 07:00:00', 38, NULL, NULL, NULL, NULL),
(954, 35, 62, 38, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-23 16:00:00', 38, NULL, NULL, NULL, NULL),
(955, 35, 62, 38, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-24 07:00:00', 38, NULL, NULL, NULL, NULL),
(956, 35, 62, 38, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-24 16:00:00', 38, NULL, NULL, NULL, NULL),
(957, 35, 62, 38, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-26 08:00:00', 38, NULL, NULL, NULL, NULL),
(958, 35, 62, 38, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-26 17:00:00', 38, NULL, NULL, NULL, NULL),
(959, 35, 62, 38, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-27 08:00:00', 38, NULL, NULL, NULL, NULL),
(960, 35, 62, 38, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-27 17:00:00', 38, NULL, NULL, NULL, NULL),
(961, 29, 40, 35, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-25 11:00:00', 35, NULL, NULL, NULL, NULL),
(962, 29, 40, 35, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-25 20:00:00', 35, NULL, NULL, NULL, NULL),
(963, 29, 40, 35, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-26 11:00:00', 35, NULL, NULL, NULL, NULL),
(964, 29, 40, 35, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-26 20:00:00', 35, NULL, NULL, NULL, NULL),
(965, 29, 40, 35, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-27 11:00:00', 35, NULL, NULL, NULL, NULL),
(966, 29, 40, 35, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-27 20:00:00', 35, NULL, NULL, NULL, NULL),
(967, 36, 63, 35, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-28 11:00:00', 35, NULL, NULL, NULL, NULL),
(968, 36, 63, 35, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-28 20:00:00', 35, NULL, NULL, NULL, NULL),
(969, 36, 63, 35, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-03-01 11:00:00', 35, NULL, NULL, NULL, NULL),
(970, 36, 63, 35, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-03-01 20:00:00', 35, NULL, NULL, NULL, NULL),
(971, 36, 63, 35, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-03-03 12:00:00', 35, NULL, NULL, NULL, NULL),
(972, 36, 63, 35, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-03-03 21:00:00', 35, NULL, NULL, NULL, NULL),
(973, 36, 63, 35, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-03-04 17:00:00', 35, NULL, NULL, NULL, NULL),
(974, 36, 63, 35, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-03-05 02:00:00', 35, NULL, NULL, NULL, NULL),
(975, 36, 63, 35, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-03-05 17:00:00', 35, NULL, NULL, NULL, NULL),
(976, 36, 63, 35, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-03-06 02:00:00', 35, NULL, NULL, NULL, NULL),
(978, 37, 64, 38, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-28 13:00:00', 38, NULL, NULL, NULL, NULL),
(979, 37, 64, 38, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-28 22:00:00', 38, NULL, NULL, NULL, NULL),
(980, 37, 64, 38, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-03-01 13:00:00', 38, NULL, NULL, NULL, NULL),
(981, 37, 64, 38, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-03-01 22:00:00', 38, NULL, NULL, NULL, NULL),
(982, 37, 64, 38, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-03-02 13:00:00', 38, NULL, NULL, NULL, NULL),
(983, 37, 64, 38, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-03-02 22:00:00', 38, NULL, NULL, NULL, NULL),
(984, 37, 64, 38, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-03-03 13:00:00', 38, NULL, NULL, NULL, NULL),
(985, 37, 64, 38, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-03-03 22:00:00', 38, NULL, NULL, NULL, NULL),
(986, 29, 41, 36, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-26 21:00:00', 36, NULL, NULL, NULL, NULL),
(987, 29, 41, 36, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-26 12:00:00', 36, NULL, NULL, NULL, NULL),
(988, 36, 65, 36, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-03-01 11:00:00', 36, NULL, NULL, NULL, NULL),
(989, 36, 65, 36, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-03-01 20:00:00', 36, NULL, NULL, NULL, NULL),
(990, 36, 65, 36, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-03-02 17:00:00', 36, NULL, NULL, NULL, NULL),
(991, 36, 65, 36, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-03-03 02:00:00', 36, NULL, NULL, NULL, NULL),
(992, 36, 65, 36, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-03-03 17:00:00', 36, NULL, NULL, NULL, NULL),
(993, 36, 65, 36, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-03-04 02:00:00', 36, NULL, NULL, NULL, NULL),
(994, 36, 65, 36, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-03-04 17:00:00', 36, NULL, NULL, NULL, NULL),
(995, 36, 65, 36, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-03-05 02:00:00', 36, NULL, NULL, NULL, NULL),
(997, 28, 31, 31, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-26 08:00:00', 31, NULL, NULL, NULL, NULL),
(998, 28, 31, 31, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-26 17:00:00', 31, NULL, NULL, NULL, NULL),
(999, 28, 31, 31, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-27 08:00:00', 31, NULL, NULL, NULL, NULL),
(1000, 28, 31, 31, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-27 17:00:00', 31, NULL, NULL, NULL, NULL),
(1001, 38, 66, 31, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-28 08:00:00', 31, NULL, NULL, NULL, NULL),
(1002, 38, 66, 31, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-28 17:00:00', 31, NULL, NULL, NULL, NULL),
(1003, 38, 66, 31, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-03-01 12:00:00', 31, NULL, NULL, NULL, NULL),
(1004, 38, 66, 31, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-03-01 21:00:00', 31, NULL, NULL, NULL, NULL),
(1005, 38, 66, 31, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-03-02 09:00:00', 31, NULL, NULL, NULL, NULL),
(1006, 38, 66, 31, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-03-02 18:00:00', 31, NULL, NULL, NULL, NULL),
(1007, 38, 66, 31, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-03-03 09:00:00', 31, NULL, NULL, NULL, NULL),
(1008, 38, 66, 31, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-03-03 18:00:00', 31, NULL, NULL, NULL, NULL),
(1009, 38, 66, 31, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-03-05 09:00:00', 31, NULL, NULL, NULL, NULL),
(1010, 38, 66, 31, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-03-05 18:00:00', 31, NULL, NULL, NULL, NULL),
(1014, 29, 20, 21, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-26 09:00:00', 21, NULL, NULL, NULL, NULL),
(1015, 29, 20, 21, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-26 18:00:00', 21, NULL, NULL, NULL, NULL),
(1016, 29, 20, 21, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-27 09:00:00', 21, NULL, NULL, NULL, NULL),
(1017, 29, 20, 21, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-02-27 18:00:00', 21, NULL, NULL, NULL, NULL),
(1018, 28, 32, 32, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-02-23 09:00:00', 32, NULL, NULL, NULL, NULL),
(1019, 30, 42, 34, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-01 19:00:00', 34, NULL, NULL, NULL, NULL),
(1022, 30, 42, 34, NULL, 'checkout', -6.6011188, 106.7941239, NULL, NULL, '2026-01-02 04:00:00', 34, NULL, NULL, NULL, NULL),
(1028, 30, 42, 34, NULL, 'checkin', -6.6011188, 106.7941239, NULL, NULL, '2026-01-02 19:00:00', 34, NULL, NULL, NULL, NULL),
(1341, 25, 38, 38, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-01-21 15:00:00', NULL, NULL, NULL, NULL, NULL),
(1342, 25, 38, 38, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-01-22 15:00:00', NULL, NULL, NULL, NULL, NULL),
(1343, 25, 38, 38, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-01-23 15:00:00', NULL, NULL, NULL, NULL, NULL),
(1344, 25, 38, 38, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-01-24 15:00:00', NULL, NULL, NULL, NULL, NULL),
(1345, 25, 38, 38, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-01-25 15:00:00', NULL, NULL, NULL, NULL, NULL),
(1346, 25, 38, 38, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-01-27 15:00:00', NULL, NULL, NULL, NULL, NULL),
(1347, 25, 38, 38, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-01-30 15:00:00', NULL, NULL, NULL, NULL, NULL),
(1348, 25, 38, 38, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-01-31 15:00:00', NULL, NULL, NULL, NULL, NULL),
(1349, 31, 46, 39, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-01-23 22:00:00', NULL, NULL, NULL, NULL, NULL),
(1350, 31, 46, 39, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-01-24 22:00:00', NULL, NULL, NULL, NULL, NULL),
(1351, 31, 46, 39, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-01-25 22:00:00', NULL, NULL, NULL, NULL, NULL),
(1352, 31, 46, 39, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-01-26 22:00:00', NULL, NULL, NULL, NULL, NULL),
(1353, 31, 46, 39, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-01-27 22:00:00', NULL, NULL, NULL, NULL, NULL),
(1354, 31, 47, 40, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-01-31 14:00:00', NULL, NULL, NULL, NULL, NULL),
(1355, 31, 47, 40, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-01 14:00:00', NULL, NULL, NULL, NULL, NULL),
(1356, 31, 47, 40, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-05 18:00:00', NULL, NULL, NULL, NULL, NULL),
(1357, 30, 42, 34, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-01-03 04:00:00', NULL, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `job_extend_attendances`
--

CREATE TABLE `job_extend_attendances` (
  `id` int(11) NOT NULL,
  `extend_request_id` int(11) NOT NULL,
  `job_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `type` enum('checkin','checkout') NOT NULL,
  `latitude` decimal(10,7) NOT NULL,
  `longitude` decimal(10,7) NOT NULL,
  `photo_path` varchar(250) NOT NULL,
  `device_info` varchar(250) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_extend_requests`
--

CREATE TABLE `job_extend_requests` (
  `id` int(11) NOT NULL,
  `job_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `requested_by` int(11) NOT NULL,
  `original_end_time` datetime NOT NULL,
  `requested_end_time` datetime NOT NULL,
  `requested_minutes` int(11) NOT NULL,
  `estimated_fee` decimal(15,2) DEFAULT 0.00,
  `final_fee` decimal(15,2) DEFAULT NULL,
  `status` enum('pending','approved','rejected','expired') DEFAULT 'pending',
  `responded_at` datetime DEFAULT NULL,
  `responded_by` int(11) DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ratings`
--

CREATE TABLE `ratings` (
  `id` int(1) NOT NULL,
  `job_id` int(1) NOT NULL,
  `application_id` int(1) NOT NULL,
  `worker_id` int(1) NOT NULL,
  `rating` tinyint(4) NOT NULL,
  `review` text CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ratio_rules`
--

CREATE TABLE `ratio_rules` (
  `id` int(11) NOT NULL,
  `hotel_id` int(11) DEFAULT NULL,
  `department_category` varchar(255) DEFAULT NULL,
  `min_value` decimal(10,2) NOT NULL,
  `max_value` decimal(10,2) NOT NULL,
  `label` varchar(100) NOT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `sort_order` int(11) DEFAULT 1,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ratio_rules`
--

INSERT INTO `ratio_rules` (`id`, `hotel_id`, `department_category`, `min_value`, `max_value`, `label`, `is_active`, `sort_order`, `created_at`, `updated_at`) VALUES
(1, 1, NULL, 0.00, 0.00, 'NO DATA', 1, 1, '2026-02-24 03:40:13', NULL),
(2, 1, NULL, 0.00, 1.00, 'GOOD', 1, 2, '2026-02-24 03:40:13', NULL),
(3, 1, NULL, 1.00, 4.00, 'AVERAGE', 1, 3, '2026-02-24 03:40:13', NULL),
(4, 1, NULL, 4.00, 6.00, 'OVER', 1, 4, '2026-02-24 03:40:13', NULL),
(5, 1, NULL, 6.00, 999.00, 'NOT OPTIMAL MAN POWER', 1, 5, '2026-02-24 03:40:13', NULL),
(6, 1, 'Finance', 0.00, 7.00, 'OVER', 1, 1, '2026-02-24 03:40:13', NULL),
(7, 1, 'Finance', 7.00, 14.00, 'AVERAGE', 1, 2, '2026-02-24 03:40:13', NULL),
(8, 1, 'Finance', 14.00, 999.00, 'GOOD', 1, 3, '2026-02-24 03:40:13', NULL),
(9, 1, 'Sales & Marketing Multiple', 0.00, 7.00, 'OVER', 1, 1, '2026-02-24 03:40:13', NULL),
(10, 1, 'Sales & Marketing Multiple', 7.00, 14.00, 'AVERAGE', 1, 2, '2026-02-24 03:40:13', NULL),
(11, 1, 'Sales & Marketing Multiple', 14.00, 22.00, 'GOOD', 1, 3, '2026-02-24 03:40:13', NULL),
(12, 1, 'Front Office', 0.00, 2.00, 'GOOD', 1, 1, '2026-02-27 11:32:52', NULL),
(13, 1, 'Front Office', 3.00, 4.00, 'AVERAGE', 1, 1, '2026-02-27 11:32:52', NULL),
(14, 1, 'Front Office', 4.00, 999.00, 'OVER', 1, 1, '2026-02-27 11:32:52', NULL),
(15, 1, 'Housekeeping', 0.00, 3.00, 'GOOD', 1, 1, '2026-02-27 11:32:52', NULL),
(16, 1, 'Housekeeping', 3.00, 5.00, 'AVERAGE', 1, 1, '2026-02-27 11:32:52', NULL),
(17, 1, 'Housekeeping', 5.00, 999.00, 'OVER', 1, 1, '2026-02-27 11:32:52', NULL),
(18, 1, 'Food & Beverage Service', 0.00, 2.00, 'GOOD', 1, 1, '2026-02-27 11:32:52', NULL),
(19, 1, 'Food & Beverage Service', 2.00, 4.00, 'AVERAGE', 1, 1, '2026-02-27 11:32:52', NULL),
(20, 1, 'Food & Beverage Service', 4.00, 999.00, 'OVER', 1, 1, '2026-02-27 11:32:52', NULL),
(21, 1, 'Kitchen / Culinary', 0.00, 3.00, 'GOOD', 1, 1, '2026-02-27 11:32:52', NULL),
(22, 1, 'Kitchen / Culinary', 3.00, 6.00, 'AVERAGE', 1, 1, '2026-02-27 11:32:52', NULL),
(23, 1, 'Kitchen / Culinary', 6.00, 999.00, 'OVER', 1, 1, '2026-02-27 11:32:52', NULL),
(24, 1, 'Finance', 0.00, 1.00, 'GOOD', 1, 1, '2026-02-27 11:32:52', NULL),
(25, 1, 'Finance', 1.00, 3.00, 'AVERAGE', 1, 1, '2026-02-27 11:32:52', NULL),
(26, 1, 'Finance', 3.00, 999.00, 'OVER', 1, 1, '2026-02-27 11:32:52', NULL),
(27, 1, 'Human Resources', 0.00, 1.00, 'GOOD', 1, 1, '2026-02-27 11:32:52', NULL),
(28, 1, 'Human Resources', 1.00, 4.00, 'AVERAGE', 1, 1, '2026-02-27 11:32:52', NULL),
(29, 1, 'Human Resources', 4.00, 999.00, 'OVER', 1, 1, '2026-02-27 11:32:52', NULL),
(30, 1, 'Engineering', 0.00, 1.00, 'GOOD', 1, 1, '2026-02-27 11:32:52', NULL),
(31, 1, 'Engineering', 1.00, 3.00, 'AVERAGE', 1, 1, '2026-02-27 11:32:52', NULL),
(32, 1, 'Engineering', 3.00, 999.00, 'OVER', 1, 1, '2026-02-27 11:32:52', NULL),
(33, 1, 'Sales & Marketing', 0.00, 3.00, 'GOOD', 1, 1, '2026-02-24 03:40:13', NULL),
(34, 1, 'Sales & Marketing', 3.00, 6.00, 'AVERAGE', 1, 2, '2026-02-24 03:40:13', NULL),
(35, 1, 'Sales & Marketing', 6.00, 999.00, 'OVER', 1, 3, '2026-02-24 03:40:13', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `refresh_tokens`
--

CREATE TABLE `refresh_tokens` (
  `id` int(1) NOT NULL,
  `user_id` int(1) NOT NULL,
  `token` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `expires_at` datetime NOT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `refresh_tokens`
--

INSERT INTO `refresh_tokens` (`id`, `user_id`, `token`, `expires_at`, `created_at`) VALUES
(1, 1, 'f2b96d8e451b4e87d783e42b6dd2916c6f11285da4cdd9c15ff791a7b3b09f115aee2ac56012dea0fdc281c7835df9bb5bf6fdfbdb50f5a4ba9b955854bbf5ae', '2026-03-26 00:37:13', '2026-02-24 00:37:13'),
(2, 13, '6b676708dc588beb5686121933cb3cbde216eea99c05b1bd34c7d6872873304e6e150a219dbcacb94d4dbd923cf3467b14d37d2cf922f30e2cf292050572ff16', '2026-03-26 00:40:24', '2026-02-24 00:40:24'),
(3, 11, '820db38a2dfaa85ee1972d8f7d809da5fcebb2e123ad9066253c4dd16dcc7c9286b277b42ad6b8ea850954ccd7a7ae3aab7d4c5f0b7d26b08d982d25c72feead', '2026-03-26 00:42:09', '2026-02-24 00:42:09'),
(4, 15, '2f333c689897d52b22b1868cbe715ae732a2189bb1d391f760cf119f332b474ed3b41e48153f494e028ab3eb5b57344223182b6d6a5945745c7f5a42736c5335', '2026-03-26 00:43:12', '2026-02-24 00:43:12'),
(5, 11, '8ac6a6e8df5f9390089a7b2d7726ff4ba85dae328ce81eb3b71c6b0f134521d386daf64ef5937a2c3de8d76593d2cc53b00a1d9abb1eddb15c264ef364cdf414', '2026-03-26 00:43:28', '2026-02-24 00:43:28'),
(6, 11, '79c389cb2c58f2b803476eb7268e6b6482de08b11dcc90cc11ea26470ca549a692dbdcc6ff9b9205f10738040cace27de7f439fe1126be56f4a13844095da6f6', '2026-03-26 00:46:52', '2026-02-24 00:46:52'),
(7, 11, 'dcf949bde9105861a1f0d91e0d70fae36f8738c22165d54c9e78f90fb048b63544b22e73669cffdadead22fea3a0afab3e289bb4912e960b30f03e2c3f336806', '2026-03-26 00:51:24', '2026-02-24 00:51:24'),
(8, 11, '0d57205df30973e9c37bed03a598c696c432af46b34ded46c5f34a96c820afb950e851e4676eaefeaf944082a4c099b08c403e8e9dc2427075cef48931254ea4', '2026-03-26 00:52:59', '2026-02-24 00:52:59'),
(9, 11, 'e76aa746b577fdaee4bf813a5f9375acda7648bd26253525f2d413cbd0f1ae1aba022ab4512864342e69d61f84db7df41f582d9139bc152695abc6ae7fb8486f', '2026-03-26 00:54:52', '2026-02-24 00:54:52'),
(10, 11, '91f9b31eebb24e259faed68b4f5b37d4df157d8f7935f3c33fab6732b7f72e9b7c68c5a26626e273923d2eed71918d017b5dc404c49983fe36bb042af2d35d62', '2026-03-26 00:55:35', '2026-02-24 00:55:35'),
(11, 11, 'f68f8572eff06202f8791d6d29e5c3471dc658993af427a9a6af224ce299a46e2d9408da81c59362422a8fb94fe81c2d2d6335eee8c265c28508c8cf46540935', '2026-03-26 00:56:13', '2026-02-24 00:56:13'),
(12, 13, '3bb2991042429294a9ba13c0f919160e26a65c2e205499268b1e8b5ea0305547cb5fb707720647657ab4d540259cdc1ee6856f0feca644a92ff2a2b0d057e77d', '2026-03-26 16:34:29', '2026-02-24 16:34:29'),
(13, 13, 'f3e2543357973ada9d48784ec03e63ae67ab15c4c39f80dced523bb85d43b0809eecdaa016011c6d282045ae3374ba90285c3e562c7886267b5b942dcce4c7a6', '2026-03-26 16:38:31', '2026-02-24 16:38:31'),
(14, 13, '7a2380306b30ac291e7b74c83d1f2bb1e97bc5c88b8582e9c5d464bb9052b6ead24a3417a857e88a6dbe59d133d41ca86e379873090eeee8fcd08128ef8ea28a', '2026-03-26 16:38:49', '2026-02-24 16:38:49'),
(15, 1, 'a16a3209999241c80e81f4cf88e14c5105d717b30435ad4b8ee45e5f8be18c2d1dd0c2769feb3dc01ee814e6365f2396d29c3406878cd29730c8fc0bee12dde9', '2026-03-26 16:45:46', '2026-02-24 16:45:46'),
(16, 1, 'cf4682bbe74aa3de0e3f025cc79840ed3eef4562b848c119133ffed3783c3107d8d3b5bcfdd66ab828299081cff385d7471b372456c24a5217c5d913079905b4', '2026-03-26 16:46:12', '2026-02-24 16:46:12'),
(17, 20, '479ad369635e8cc1b08fc53f84781a2c517532cf7e6931758601e71886e1ca471af908f3196bc27c0270b1e804696bf4a56914fa998476cef84c3a9292e80a2a', '2026-03-26 16:50:17', '2026-02-24 16:50:17'),
(18, 7, '13d211ca508c2c5b0c4b6127a183f8195ca31ca9fa20a430d2c2dfd764f2a76d8057d64b616ea223496c101c51a9ef6beecf5f95506d9ebc9dfe8d730783554a', '2026-03-26 16:57:05', '2026-02-24 16:57:05'),
(19, 22, '67b455f3eaa1225ea8019215b86ac67e5089faeaa7d29d2580cf76cb3eb094ca220368b949f48bc5211c3d2afbe0110597a49aa1490657387218d9283492420b', '2026-03-26 16:58:37', '2026-02-24 16:58:37'),
(20, 13, 'e79b8f787033c6ac2a05480cb612c8e53c2cd1699185ec4c60e9ac3e6ad6b9990b356705d8c454914c89b95136d7da1dcffb70c2e6c1d640524dde71985c63b8', '2026-03-27 01:17:23', '2026-02-25 01:17:23'),
(21, 13, 'c51556340cf2aae120a0cb7cd3ae577078df35f5893ac56ce208615f8962f070a7881b7ab23f7f20fdea70f9f2656f16ec17c97d35e23bb3769ec2cad3c758ee', '2026-03-27 17:11:42', '2026-02-25 17:11:42'),
(22, 13, 'c3732151bfdd5b64592f353a1d4127fc99cb2061f3b06e8c0f9be5763aa81a421ffab1fafbf9d3175e99d7d765ebba920055c0565f4c4c92a6963feb28e5ea89', '2026-03-27 17:16:39', '2026-02-25 17:16:39'),
(23, 13, 'd1868096abfeaf039e5e894cfee49be78ac94deb3c80f6202ba868f40cb969ac7e3880e39a61a2607f6eece842649fa86858dd4a598db9e33818d1bb00839092', '2026-03-27 17:26:17', '2026-02-25 17:26:17'),
(24, 13, '9372fd2c0ff5a826cbd84f9743658b817025fa8465f1c1af673109c5e676ba40463d89123b21113b0c2ebc3e1f507d379c4a2a9b13a14cd771b624ca8e2bb258', '2026-03-27 18:09:23', '2026-02-25 18:09:23'),
(25, 34, 'f642ad7e112d39a156bc823c0b6b1ec089e1b04e8b3f99782546e92f089d55ddc72e633dcb398913eae7e1cd477a26df8290aaef61c5c4ffa7a1ae270783d220', '2026-03-29 15:58:00', '2026-02-27 15:58:00'),
(26, 34, '3674b22880c7f6b1af4c634dda2469fb845ee9395cd4f2e7abbb316ff430a02621f264004180b24178555be97b6d2f68bbf93753dc3835a67a0abf1387911368', '2026-03-29 16:00:42', '2026-02-27 16:00:42'),
(27, 34, 'bd1c75fa8450403dba6bcefc3ad1817e043aeb52668468059e136f328419b5353bfd2788798be811b9d0877f510c4572159949fedd692470115b1363917a4305', '2026-03-29 16:01:40', '2026-02-27 16:01:40'),
(28, 34, 'f57765e30ec491a3fda104284b368ced2ee2731f2c34187e67625a22413a0325be5e023d05d6113f79b4738d4389cbbaf86553232890d912e47ef8b9cc0d786d', '2026-03-29 16:02:07', '2026-02-27 16:02:07'),
(29, 34, '007b1ec700850fcc5cf6e378d30cb92bca885609aa15d434b0f90921934ed946d1b46a13bf8620e259fe49215af55e059f08e1a13b639e878a2f9ecfdf3812ba', '2026-03-29 16:05:45', '2026-02-27 16:05:45'),
(30, 34, '1204399683514efd9475674026edfa29e45c81b634768e9e1e3ba6cb7c0766524a9c33b92160d31e55c2a018f519d780d072b45241594e557e22b41a0af336b8', '2026-03-29 16:06:44', '2026-02-27 16:06:44'),
(31, 34, '9004c9d5c7d1bc7500d7c92c5321af851ece8da42da6e4dc753f77245c1bf0f0bc224cd6e83ccb7a5fe4e167d5b25451c8f420563c59d25dbccf5e8ae8a7c991', '2026-03-29 16:07:57', '2026-02-27 16:07:57'),
(32, 34, '0034005eceb8968221d68456c767a649a56a4ba9b3bf5b035891cb4393f026415ef1e5a6cbcf88c1651640f06900b61b597ccc26cb1196b3c4b769c7342cca97', '2026-03-29 16:08:43', '2026-02-27 16:08:43'),
(33, 34, '2ee8c2518ae9ade4dbfa52bb5ac1e5cbcd7099a941685fcdfb95b5080c2fbeb917befaec45b68b7d1e46023d0367c98672fbd3fdb8a5b6fc0e68b6ee0ffa3c87', '2026-03-29 16:52:46', '2026-02-27 16:52:46'),
(34, 34, '842c7131d285302854eda4af49181355118474e2bdd2eea981e75ac744518f4753d9424523f6de8ad97825a385abb8e8999d4e6589cfbfbf68ec35253185b820', '2026-03-29 16:52:59', '2026-02-27 16:52:59'),
(35, 34, '246062a56a7646a9e7b67d5eb4825bf13ab98bdddfcf7d2d321eb1b3fd641df87a1f88b8d0d9563ae183dab79b441a953ae6fbaf9e8ec39e3204e9a909843e18', '2026-03-29 16:53:22', '2026-02-27 16:53:22'),
(36, 34, 'd4594ae30031bead3d40eb904cdae689d619c9e387683b8125172fb97d20a9b3538e4377576b7620124ac8d5e37290d047d56235df72d16e330e8245cfb590f7', '2026-03-29 16:56:21', '2026-02-27 16:56:21'),
(37, 34, 'b08eff4c5ff6bd4d3b0f783504e345dd0eb2001eb2a53c014fe9a6d83a83d80d5c512e1cb33447de4bcfa5815940f932e45ba8f9b601fa72806d251c9086b3c8', '2026-03-29 16:57:32', '2026-02-27 16:57:32'),
(38, 34, 'eacb6c9f11f1ce6772569e0d34984b1c6429556b49a7497bc3e3c6c684ca972e59dc8f81e4ef266db432ee6ebf2ffa2dee8fd41bb4d71516a62820df74c7360a', '2026-03-29 16:58:17', '2026-02-27 16:58:17'),
(39, 34, '13a1b211a08269250818d86d68f822011e2b69570f6d15d5096b92c590c61b5f7cf1b1fc6b069c59988167e552f071d9231e74650d9e4b3d599bb4bfb276afa5', '2026-03-29 16:59:09', '2026-02-27 16:59:09'),
(40, 34, '60d34e6058bf5861d642c6384cd70fe8af1d240ce140b8044ed5b1a695238b078609255700534dc49d93d3fe50cdccbea9fbaa6decf1e0967cf8442375b1f94f', '2026-03-29 17:00:24', '2026-02-27 17:00:24'),
(41, 34, '8748d60f231d05481c91e6d5617c3bbc4d0eb53fe9a5765f549c2d6fca2d538ea16507259b0bed894c5f3ff367d9701a7870e3c70c807af2bec26522c8efeb2b', '2026-03-29 17:00:50', '2026-02-27 17:00:50'),
(42, 34, '8d8dff7d7c6287a04fc79dce415fc0b4e4b3faeaa4253a4aca45e68d80a88f980d2dba3e00a54796a788726358f9e4f54dd2a4708695e1cc4f525d0ea9be2ac2', '2026-03-29 17:01:10', '2026-02-27 17:01:10'),
(43, 34, '3f8b6c7720401304a7a0e8e8dd7de0cb3155406f71cc74e6280628870a7d5ecb88bf20a0aa7030a92adb08766a3262524e2a78d1a033a14a7b9ac53efc0f9b97', '2026-03-29 17:02:04', '2026-02-27 17:02:04'),
(44, 8, 'fdcf1fe31f7137c85624c092f0ce4b8183fda75446d80114c9f11f85c49c2960da5db5b8b7924d9171fb337781fb424fb735789ea33f9236efa9c264d8e8843a', '2026-03-30 17:45:28', '2026-02-28 17:45:28'),
(45, 8, 'dabc79ae4e5c6e2a5dd64bf43f54ceb6b1341fa852c01cf8a7f8eb1323e00773bed0f31b1474bfb371722da2b484ed830d46ccadd40e7f34b90629919fa1b4f1', '2026-03-30 17:45:45', '2026-02-28 17:45:45'),
(46, 8, '00f89777c87513a5efdad88b819ebf52417b30fda4e6bdb8568c9e0384f1e9cf86a63e8a862a47f10bda2d3b88a944b2d0aa3758f0dee73c0be7e32a815431d1', '2026-03-30 17:47:28', '2026-02-28 17:47:28'),
(47, 8, '6cae9e1b45f024e8b20b4f1f1b2cc09ea398f9f2778995a6747c575c5e3ff3b0366428a819d355f1be2947b807e00c65b4f46b2baca632f74ff61c5e926d4d2f', '2026-03-30 17:48:10', '2026-02-28 17:48:10'),
(48, 8, '4b318693ec74f9742edbeb33d218ae84889627c5166ac89f0420b962ea77b75944ae2d2d7893bc44ea481e071cae085c2293f343942a9e2ed7a9adacf7598e20', '2026-03-30 17:49:29', '2026-02-28 17:49:29'),
(49, 8, '901fefb03aa6215d5492ea42bd2c0feff1b34052e6d05c104ee727343b8b8896ed8fe07f8108a7bd49a1c2db0a42db7feb2fc5be26a32275b53de627c6f6bb58', '2026-03-31 18:00:02', '2026-03-01 18:00:02'),
(50, 8, 'e072b0b7c64c86b36b8226cc3d76d2983322b3448f9ceddbaa3f7c471d98a179a9088a71ec9125d0506a3d5332461b8c5839088906dc2eb0dfcaf4249bdfa02b', '2026-03-31 18:00:37', '2026-03-01 18:00:37'),
(51, 8, 'b165ac533340a4d2e6938f7da54d0972528be9bf2c389e642c5eda86d60407e6eb6c9dd7bb0fdde62cd8badcd553ffb7b1d8fa2d833e507fd13ae32c2cc7c4d1', '2026-03-31 18:02:10', '2026-03-01 18:02:10'),
(52, 8, '5f9a0c65269129b835d28d7619c14fedc70576ab5047e1a61d4e567f4a5ff95516e6f540cf0e7e4a7292f2ab7a86fcec97671e4a50fbbf505971884ce9ae9c6e', '2026-03-31 18:02:26', '2026-03-01 18:02:26'),
(53, 8, 'b85b2725cdd8da417140da805dc5daaac94be0735175f38a454254116243b150a17f80396e2954722b065c26d94c5ac24e30d1981bbc8ee4904d1302b7e198dc', '2026-03-31 20:46:34', '2026-03-01 20:46:34'),
(54, 8, 'f3af809709883d8238176761afe96abe2f7af319ac187f264d4fa8252e45a0fe9b5067a5837eb9478f49269f347324aeed4a34f835b9a570d9c20a2a363051e2', '2026-03-31 21:01:01', '2026-03-01 21:01:01'),
(55, 8, 'd726385ffbe900be4d1e9c720f407b6d8a4dfb5fc7ef9759d81788b634e8ee3b02849b4dccd4759fedda24577ddf5028b5e17a5409e79cbb1af28a047b2b52ed', '2026-03-31 22:36:10', '2026-03-01 22:36:10'),
(56, 8, '69327a73a2e5104bc6aa81afb39482872adff1443f8127fb99ac80ce4c60000ea9cda7ed59c72f05efffe08bb1e8cfe248bfe650825b9dcfc53dd3a1868516f5', '2026-03-31 22:37:17', '2026-03-01 22:37:17'),
(57, 8, '58682ba771d6a2996edff16c468c719a0d9e19fbbe3c1e667254669a62c010d1a7290ffb567cb60ed1f12fcda75908c4592b79997799d3d42b3bf4108a1fd362', '2026-03-31 22:49:29', '2026-03-01 22:49:29'),
(58, 34, 'c2220d703f3faa207d576eb31fdedae5039c7cbbc4405b11e18a293aaac8add54da3838cd6ec0b381f7036bf2a1a7b51ecf8c4e21d4f972b117bcb8b964c5603', '2026-04-01 00:53:22', '2026-03-02 00:53:22'),
(59, 34, 'f751b5e7bd4a79b76df2b6c092e2bec68c9521fd18fd99c4e2dac44086c5f98767777ca9cc368140c4c13350afde6913d41b4e3b3a9c9cb02e48c3b319bee45b', '2026-04-01 00:53:44', '2026-03-02 00:53:44'),
(60, 34, '84f968b7d55b1ffd4b3ed5e293ada2cadc88bc8c3f695e068b38e3f22b7dec1962752909f5093a831eb8c74d10323b5be0e28e47d6dc96774fa4d3d7b848cab0', '2026-04-01 00:56:21', '2026-03-02 00:56:21'),
(61, 34, '4dec030ecc2d43f98eb291e161d3f257a2b9e9c1b381d4245dc7f74fa91bdc8e2853e703f96a834fd7413e2b90b172590ce781e03d2aaf65538df6321f8d48c2', '2026-04-01 00:56:54', '2026-03-02 00:56:54'),
(62, 34, 'fbcd9b86ed57117f4fa786d799af4bc912c5099fc3f067e954b6a5d5f4979644dc1b8d74ae0d55ecb472c1e22e7eb2624414805309563019bd2f86754e34702f', '2026-04-01 00:59:43', '2026-03-02 00:59:43'),
(63, 34, '21aa793b249cd9bd83dc19d3a5bbdf965a469ba46e273656390e535736251aa5b121b0a353ac3969c7d2e46ce0bd797a474a29f46a710c99606fcbb16562ec34', '2026-04-01 01:06:38', '2026-03-02 01:06:38');

-- --------------------------------------------------------

--
-- Table structure for table `schedule_days`
--

CREATE TABLE `schedule_days` (
  `id` int(11) NOT NULL,
  `schedule_plan_id` int(11) NOT NULL,
  `shift_date` date NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `schedule_days`
--

INSERT INTO `schedule_days` (`id`, `schedule_plan_id`, `shift_date`, `created_at`) VALUES
(1, 1, '2026-01-01', '2026-03-02 20:52:00'),
(2, 1, '2026-01-02', '2026-03-02 20:52:00'),
(3, 1, '2026-01-03', '2026-03-02 20:52:00'),
(4, 1, '2026-01-04', '2026-03-02 20:52:00'),
(5, 1, '2026-01-05', '2026-03-02 20:52:00'),
(6, 1, '2026-01-06', '2026-03-02 20:52:00'),
(7, 1, '2026-01-07', '2026-03-02 20:52:00'),
(8, 1, '2026-01-08', '2026-03-02 20:52:00'),
(9, 1, '2026-01-09', '2026-03-02 20:52:00'),
(10, 1, '2026-01-10', '2026-03-02 20:52:00'),
(11, 1, '2026-01-11', '2026-03-02 20:52:00'),
(12, 1, '2026-01-12', '2026-03-02 20:52:00'),
(13, 1, '2026-01-13', '2026-03-02 20:52:00'),
(14, 1, '2026-01-14', '2026-03-02 20:52:00'),
(15, 1, '2026-01-15', '2026-03-02 20:52:00'),
(16, 1, '2026-01-16', '2026-03-02 20:52:00'),
(17, 1, '2026-01-17', '2026-03-02 20:52:00'),
(18, 1, '2026-01-18', '2026-03-02 20:52:00'),
(19, 1, '2026-01-19', '2026-03-02 20:52:00'),
(20, 1, '2026-01-20', '2026-03-02 20:52:00'),
(21, 1, '2026-01-21', '2026-03-02 20:52:00'),
(22, 1, '2026-01-22', '2026-03-02 20:52:00'),
(23, 1, '2026-01-23', '2026-03-02 20:52:00'),
(24, 1, '2026-01-24', '2026-03-02 20:52:00'),
(25, 1, '2026-01-25', '2026-03-02 20:52:00'),
(26, 1, '2026-01-26', '2026-03-02 20:52:00'),
(27, 1, '2026-01-27', '2026-03-02 20:52:00'),
(28, 1, '2026-01-28', '2026-03-02 20:52:00'),
(29, 1, '2026-01-29', '2026-03-02 20:52:00'),
(30, 1, '2026-01-30', '2026-03-02 20:52:00'),
(31, 1, '2026-01-31', '2026-03-02 20:52:00'),
(32, 2, '2026-02-01', '2026-03-02 20:52:00'),
(33, 2, '2026-02-02', '2026-03-02 20:52:00'),
(34, 2, '2026-02-03', '2026-03-02 20:52:00'),
(35, 2, '2026-02-04', '2026-03-02 20:52:00'),
(36, 2, '2026-02-05', '2026-03-02 20:52:00'),
(37, 2, '2026-02-06', '2026-03-02 20:52:00'),
(38, 2, '2026-02-07', '2026-03-02 20:52:00'),
(39, 2, '2026-02-08', '2026-03-02 20:52:00'),
(40, 2, '2026-02-09', '2026-03-02 20:52:00'),
(41, 2, '2026-02-10', '2026-03-02 20:52:00'),
(42, 2, '2026-02-11', '2026-03-02 20:52:00'),
(43, 2, '2026-02-12', '2026-03-02 20:52:00'),
(44, 2, '2026-02-13', '2026-03-02 20:52:00'),
(45, 2, '2026-02-14', '2026-03-02 20:52:00'),
(46, 2, '2026-02-15', '2026-03-02 20:52:00'),
(47, 2, '2026-02-16', '2026-03-02 20:52:00'),
(48, 2, '2026-02-17', '2026-03-02 20:52:00'),
(49, 2, '2026-02-18', '2026-03-02 20:52:00'),
(50, 2, '2026-02-19', '2026-03-02 20:52:00'),
(51, 2, '2026-02-20', '2026-03-02 20:52:00'),
(52, 3, '2026-01-01', '2026-03-02 23:47:03'),
(53, 3, '2026-01-02', '2026-03-02 23:47:03'),
(54, 3, '2026-01-03', '2026-03-02 23:47:03'),
(55, 3, '2026-01-04', '2026-03-02 23:47:03'),
(56, 3, '2026-01-05', '2026-03-02 23:47:03'),
(57, 3, '2026-01-06', '2026-03-02 23:47:03'),
(58, 3, '2026-01-07', '2026-03-02 23:47:03'),
(59, 3, '2026-01-08', '2026-03-02 23:47:03'),
(60, 3, '2026-01-09', '2026-03-02 23:47:03'),
(61, 3, '2026-01-10', '2026-03-02 23:47:03'),
(62, 3, '2026-01-11', '2026-03-02 23:47:03'),
(63, 3, '2026-01-12', '2026-03-02 23:47:03'),
(64, 3, '2026-01-13', '2026-03-02 23:47:03'),
(65, 3, '2026-01-14', '2026-03-02 23:47:03'),
(66, 3, '2026-01-15', '2026-03-02 23:47:03'),
(67, 3, '2026-01-16', '2026-03-02 23:47:03'),
(68, 3, '2026-01-17', '2026-03-02 23:47:03'),
(69, 3, '2026-01-18', '2026-03-02 23:47:03'),
(70, 3, '2026-01-19', '2026-03-02 23:47:03'),
(71, 3, '2026-01-20', '2026-03-02 23:47:03'),
(72, 3, '2026-01-21', '2026-03-02 23:47:03'),
(73, 3, '2026-01-22', '2026-03-02 23:47:03'),
(74, 3, '2026-01-23', '2026-03-02 23:47:03'),
(75, 3, '2026-01-24', '2026-03-02 23:47:03'),
(76, 3, '2026-01-25', '2026-03-02 23:47:03'),
(77, 3, '2026-01-26', '2026-03-02 23:47:03'),
(78, 3, '2026-01-27', '2026-03-02 23:47:03'),
(79, 3, '2026-01-28', '2026-03-02 23:47:03'),
(80, 3, '2026-01-29', '2026-03-02 23:47:03'),
(81, 3, '2026-01-30', '2026-03-02 23:47:03'),
(82, 3, '2026-01-31', '2026-03-02 23:47:03');

-- --------------------------------------------------------

--
-- Table structure for table `schedule_plans`
--

CREATE TABLE `schedule_plans` (
  `id` int(11) NOT NULL,
  `hotel_id` int(11) NOT NULL,
  `department` varchar(100) NOT NULL,
  `month` tinyint(4) NOT NULL,
  `year` smallint(6) NOT NULL,
  `status` enum('draft','pending','approved','rejected','revised') DEFAULT 'draft',
  `requested_by` int(11) NOT NULL,
  `approved_by` int(11) DEFAULT NULL,
  `approved_at` datetime DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `schedule_plans`
--

INSERT INTO `schedule_plans` (`id`, `hotel_id`, `department`, `month`, `year`, `status`, `requested_by`, `approved_by`, `approved_at`, `notes`, `created_at`, `updated_at`) VALUES
(1, 1, 'Food & Beverage Service', 1, 2026, 'approved', 4, 17, '2026-03-02 21:12:56', NULL, '2026-03-02 20:52:00', '2026-03-02 21:12:56'),
(2, 1, 'Food & Beverage Service', 2, 2026, 'approved', 4, 17, '2026-03-02 21:37:33', NULL, '2026-03-02 20:52:00', '2026-03-02 21:37:33'),
(3, 1, 'Front Office', 1, 2026, 'approved', 13, 17, '2026-03-02 23:58:53', NULL, '2026-03-02 23:47:03', '2026-03-02 23:58:53');

-- --------------------------------------------------------

--
-- Table structure for table `schedule_revisions`
--

CREATE TABLE `schedule_revisions` (
  `id` int(11) NOT NULL,
  `schedule_plan_id` int(11) NOT NULL,
  `revision_number` int(11) NOT NULL,
  `requested_by` int(11) NOT NULL,
  `status` enum('pending','approved','rejected') DEFAULT 'pending',
  `approved_by` int(11) DEFAULT NULL,
  `approved_at` datetime DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `schedule_revision_shifts`
--

CREATE TABLE `schedule_revision_shifts` (
  `id` int(11) NOT NULL,
  `revision_id` int(11) NOT NULL,
  `schedule_day_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `old_start` time DEFAULT NULL,
  `old_end` time DEFAULT NULL,
  `new_start` time DEFAULT NULL,
  `new_end` time DEFAULT NULL,
  `old_type` enum('regular','off','leave','overtime') DEFAULT NULL,
  `new_type` enum('regular','off','leave','overtime') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `schedule_shifts`
--

CREATE TABLE `schedule_shifts` (
  `id` int(11) NOT NULL,
  `schedule_day_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `shift_type` enum('regular','off','leave','overtime') DEFAULT 'regular',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `job_id` int(11) DEFAULT NULL,
  `application_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `schedule_shifts`
--

INSERT INTO `schedule_shifts` (`id`, `schedule_day_id`, `user_id`, `start_time`, `end_time`, `shift_type`, `created_at`, `updated_at`, `job_id`, `application_id`) VALUES
(1, 31, 41, '06:00:00', '14:00:00', 'regular', '2026-03-02 20:56:33', NULL, NULL, NULL),
(2, 31, 40, '06:00:00', '14:00:00', 'regular', '2026-03-02 20:56:33', '2026-03-02 21:12:56', 31, 47),
(3, 21, 39, '00:00:00', '00:01:00', 'off', '2026-03-02 21:07:21', NULL, NULL, NULL),
(4, 22, 39, '00:00:00', '00:01:00', 'off', '2026-03-02 21:07:21', NULL, NULL, NULL),
(5, 23, 39, '14:00:00', '22:00:00', 'regular', '2026-03-02 21:08:42', '2026-03-02 21:12:56', 31, 46),
(6, 24, 39, '14:00:00', '22:00:00', 'regular', '2026-03-02 21:08:42', '2026-03-02 21:12:56', 31, 46),
(7, 25, 39, '14:00:00', '22:00:00', 'regular', '2026-03-02 21:08:42', '2026-03-02 21:12:56', 31, 46),
(8, 26, 39, '14:00:00', '22:00:00', 'regular', '2026-03-02 21:08:42', '2026-03-02 21:12:56', 31, 46),
(9, 27, 39, '14:00:00', '22:00:00', 'regular', '2026-03-02 21:08:42', '2026-03-02 21:12:56', 31, 46),
(10, 23, 42, '07:00:00', '15:00:00', 'regular', '2026-03-02 21:10:21', NULL, NULL, NULL),
(11, 25, 42, '07:00:00', '15:00:00', 'regular', '2026-03-02 21:10:43', NULL, NULL, NULL),
(12, 26, 42, '07:00:00', '15:00:00', 'regular', '2026-03-02 21:10:43', NULL, NULL, NULL),
(13, 32, 41, '06:00:00', '14:00:00', 'regular', '2026-03-02 21:19:10', NULL, NULL, NULL),
(14, 32, 40, '06:00:00', '14:00:00', 'regular', '2026-03-02 21:19:21', '2026-03-02 21:37:33', 31, 47),
(16, 36, 40, '10:00:00', '18:00:00', 'regular', '2026-03-02 21:21:19', '2026-03-02 21:37:33', 31, 47),
(17, 37, 40, '14:00:00', '22:00:00', 'regular', '2026-03-02 21:21:54', '2026-03-02 21:37:33', 31, 47),
(18, 38, 40, '07:00:00', '15:00:00', 'regular', '2026-03-02 21:22:15', '2026-03-02 21:37:33', 31, 47),
(19, 46, 40, '06:00:00', '14:00:00', 'regular', '2026-03-02 21:23:51', '2026-03-02 21:37:33', 31, 47),
(20, 37, 41, '14:00:00', '22:00:00', 'regular', '2026-03-02 21:24:34', NULL, NULL, NULL),
(21, 38, 41, '11:00:00', '19:00:00', 'regular', '2026-03-02 21:25:27', NULL, NULL, NULL),
(22, 39, 41, '07:00:00', '15:00:00', 'regular', '2026-03-02 21:25:46', NULL, NULL, NULL),
(23, 41, 41, '08:00:00', '16:00:00', 'regular', '2026-03-02 21:26:04', '2026-03-02 21:28:43', NULL, NULL),
(24, 40, 41, '10:00:00', '18:00:00', 'regular', '2026-03-02 21:27:12', NULL, NULL, NULL),
(25, 42, 41, '11:00:00', '19:00:00', 'regular', '2026-03-02 21:29:20', NULL, NULL, NULL),
(26, 45, 41, '08:00:00', '16:00:00', 'regular', '2026-03-02 21:29:47', NULL, NULL, NULL),
(27, 46, 41, '06:00:00', '14:00:00', 'regular', '2026-03-02 21:30:06', NULL, NULL, NULL),
(28, 36, 43, '07:00:00', '15:00:00', 'regular', '2026-03-02 21:31:40', NULL, NULL, NULL),
(29, 37, 43, '14:00:00', '22:00:00', 'regular', '2026-03-02 21:31:57', NULL, NULL, NULL),
(30, 41, 43, '10:00:00', '18:00:00', 'regular', '2026-03-02 21:32:20', NULL, NULL, NULL),
(31, 39, 43, '07:00:00', '15:00:00', 'regular', '2026-03-02 21:32:36', NULL, NULL, NULL),
(32, 40, 43, '10:00:00', '18:00:00', 'regular', '2026-03-02 21:33:18', NULL, NULL, NULL),
(33, 38, 44, '07:00:00', '15:00:00', 'regular', '2026-03-02 21:33:46', NULL, NULL, NULL),
(34, 39, 44, '10:00:00', '18:00:00', 'regular', '2026-03-02 21:34:03', NULL, NULL, NULL),
(35, 41, 44, '08:00:00', '16:00:00', 'regular', '2026-03-02 21:34:22', NULL, NULL, NULL),
(36, 42, 44, '07:00:00', '15:00:00', 'regular', '2026-03-02 21:34:41', NULL, NULL, NULL),
(37, 43, 44, '10:00:00', '18:00:00', 'regular', '2026-03-02 21:35:02', NULL, NULL, NULL),
(38, 46, 44, '06:00:00', '14:00:00', 'regular', '2026-03-02 21:35:20', NULL, NULL, NULL),
(39, 81, 52, '09:00:00', '17:00:00', 'regular', '2026-03-02 23:48:29', '2026-03-02 23:58:53', 34, 61),
(40, 72, 38, '07:00:00', '15:00:00', 'regular', '2026-03-02 23:50:26', '2026-03-02 23:58:26', 25, 38),
(41, 73, 38, '07:00:00', '15:00:00', 'regular', '2026-03-02 23:50:38', '2026-03-02 23:58:28', 25, 38),
(42, 74, 38, '07:00:00', '15:00:00', 'regular', '2026-03-02 23:50:48', '2026-03-02 23:58:30', 25, 38),
(43, 75, 38, '07:00:00', '15:00:00', 'regular', '2026-03-02 23:50:53', '2026-03-02 23:58:32', 25, 38),
(44, 76, 38, '07:00:00', '15:00:00', 'regular', '2026-03-02 23:50:59', '2026-03-02 23:58:34', 25, 38),
(45, 77, 38, '00:00:00', '00:05:00', 'off', '2026-03-02 23:51:27', '2026-03-02 23:58:36', 25, 38),
(46, 78, 38, '07:00:00', '15:00:00', 'regular', '2026-03-02 23:52:14', '2026-03-02 23:58:37', 25, 38),
(47, 81, 38, '07:00:00', '15:00:00', 'regular', '2026-03-02 23:52:37', '2026-03-02 23:58:39', 25, 38),
(48, 82, 38, '07:00:00', '15:00:00', 'regular', '2026-03-02 23:52:43', '2026-03-02 23:57:59', 25, 38),
(49, 52, 34, '19:00:00', '04:00:00', 'regular', '2026-03-06 02:17:57', '2026-03-06 02:38:11', 30, 42),
(50, 53, 34, '19:00:00', '04:00:00', 'regular', '2026-03-06 02:58:29', '2026-03-06 03:38:11', 30, 42);

-- --------------------------------------------------------

--
-- Table structure for table `skills`
--

CREATE TABLE `skills` (
  `id` int(1) NOT NULL,
  `name` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `category` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` int(1) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `skills`
--

INSERT INTO `skills` (`id`, `name`, `category`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
(1, 'Front Office', 'Front Office', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(2, 'Receptionist', 'Front Office', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(3, 'Guest Service Agent', 'Front Office', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(4, 'Concierge', 'Front Office', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(5, 'Bellboy', 'Front Office', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(6, 'Reservation Staff', 'Front Office', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(7, 'Telephone Operator', 'Front Office', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(8, 'Housekeeping Supervisor', 'Housekeeping', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(9, 'Room Attendant', 'Housekeeping', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(10, 'Public Area', 'Housekeeping', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(11, 'Laundry Staff', 'Housekeeping', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(12, 'Housekeeping', 'Housekeeping', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(13, 'Waiter', 'Food & Beverage Service', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(14, 'Waitress', 'Food & Beverage Service', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(15, 'Restaurant Supervisor', 'Food & Beverage Service', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(16, 'Captain Service', 'Food & Beverage Service', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(17, 'Barista', 'Food & Beverage Service', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(18, 'Bartender', 'Food & Beverage Service', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(19, 'Room Service Staff', 'Food & Beverage Service', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(20, 'Cook Helper', 'Kitchen / Culinary', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(21, 'Cook', 'Kitchen / Culinary', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(22, 'Chef de Partie', 'Kitchen / Culinary', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(23, 'Sous Chef', 'Kitchen / Culinary', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(24, 'Executive Chef', 'Kitchen / Culinary', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(25, 'Pastry Chef', 'Kitchen / Culinary', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(26, 'Steward', 'Kitchen / Culinary', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(27, 'Engineering Supervisor', 'Engineering', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(28, 'Maintenance Staff', 'Engineering', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(29, 'Technician Electrical', 'Engineering', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(30, 'Technician AC', 'Engineering', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(31, 'Technician Plumbing', 'Engineering', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(32, 'Security Guard', 'Human Resources', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(33, 'Security Supervisor', 'Human Resources', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(34, 'Sales Executive', 'Sales & Marketing', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(35, 'Sales Manager', 'Sales & Marketing', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(36, 'Marketing Staff', 'Sales & Marketing', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(37, 'Human Resources Staff', 'Human Resources', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(38, 'Accounting Staff', 'Finance', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(39, 'Purchasing Staff', 'Finance', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(40, 'Hotel Manager', 'Management', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(41, 'Operation Manager', 'Management', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(42, 'General Manager', 'Management', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(43, 'Food & Beverage Manager', 'Management', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(44, 'Information Technology', 'Finance', '2026-02-21 00:54:00', 1, '2026-02-21 08:44:58', 1, NULL, NULL),
(45, 'Front Office Manager', 'Management', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(46, 'Graphics Design', 'Sales & Marketing', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(47, 'Senior Waiter', 'Food & Beverage Service', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(48, 'Sales Director', 'Sales & Marketing', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(49, 'Chief Engineering', 'Engineering', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(50, 'Human Resources Manager', 'Human Resources', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(51, 'Sales Senior', 'Sales & Marketing', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(52, 'Front Desk Agent', 'Front Office', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(53, 'Business Development', 'Human Resources', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(54, 'Chief Accounting', 'Finance', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(55, 'Driver', 'Front Office', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(56, 'AR/AP', 'Finance', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `training_days`
--

CREATE TABLE `training_days` (
  `id` int(11) NOT NULL,
  `training_plan_id` int(11) NOT NULL,
  `training_date` date NOT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `training_days`
--

INSERT INTO `training_days` (`id`, `training_plan_id`, `training_date`, `created_at`) VALUES
(1, 1, '2026-03-01', '2026-03-05 04:51:42'),
(2, 1, '2026-03-02', '2026-03-05 04:51:42'),
(3, 1, '2026-03-03', '2026-03-05 04:51:42'),
(4, 1, '2026-03-04', '2026-03-05 04:51:42'),
(5, 1, '2026-03-05', '2026-03-05 04:51:42'),
(6, 1, '2026-03-06', '2026-03-05 04:51:42'),
(7, 1, '2026-03-07', '2026-03-05 04:51:42'),
(8, 1, '2026-03-08', '2026-03-05 04:51:42'),
(9, 1, '2026-03-09', '2026-03-05 04:51:42'),
(10, 1, '2026-03-10', '2026-03-05 04:51:42'),
(11, 1, '2026-03-11', '2026-03-05 04:51:42'),
(12, 1, '2026-03-12', '2026-03-05 04:51:42'),
(13, 1, '2026-03-13', '2026-03-05 04:51:42'),
(14, 1, '2026-03-14', '2026-03-05 04:51:42'),
(15, 1, '2026-03-15', '2026-03-05 04:51:42'),
(16, 1, '2026-03-16', '2026-03-05 04:51:42'),
(17, 1, '2026-03-17', '2026-03-05 04:51:42'),
(18, 1, '2026-03-18', '2026-03-05 04:51:42'),
(19, 1, '2026-03-19', '2026-03-05 04:51:42'),
(20, 1, '2026-03-20', '2026-03-05 04:51:42'),
(21, 1, '2026-03-21', '2026-03-05 04:51:42'),
(22, 1, '2026-03-22', '2026-03-05 04:51:42'),
(23, 1, '2026-03-23', '2026-03-05 04:51:42'),
(24, 1, '2026-03-24', '2026-03-05 04:51:42'),
(25, 1, '2026-03-25', '2026-03-05 04:51:42'),
(26, 1, '2026-03-26', '2026-03-05 04:51:42'),
(27, 1, '2026-03-27', '2026-03-05 04:51:42'),
(28, 1, '2026-03-28', '2026-03-05 04:51:42'),
(29, 1, '2026-03-29', '2026-03-05 04:51:42'),
(30, 1, '2026-03-30', '2026-03-05 04:51:42'),
(31, 1, '2026-03-31', '2026-03-05 04:51:42');

-- --------------------------------------------------------

--
-- Table structure for table `training_participants`
--

CREATE TABLE `training_participants` (
  `id` int(11) NOT NULL,
  `training_day_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `attendance_status` enum('scheduled','attended','absent','late') DEFAULT 'scheduled',
  `score` decimal(5,2) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `training_plans`
--

CREATE TABLE `training_plans` (
  `id` int(11) NOT NULL,
  `hotel_id` int(11) NOT NULL,
  `department` varchar(100) DEFAULT NULL,
  `title` varchar(255) NOT NULL,
  `description` text DEFAULT NULL,
  `trainer_id` int(11) DEFAULT NULL,
  `month` tinyint(4) NOT NULL,
  `year` smallint(6) NOT NULL,
  `status` enum('draft','pending','approved','rejected','revised') DEFAULT 'draft',
  `requested_by` int(11) NOT NULL,
  `approved_by` int(11) DEFAULT NULL,
  `approved_at` datetime DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `training_plans`
--

INSERT INTO `training_plans` (`id`, `hotel_id`, `department`, `title`, `description`, `trainer_id`, `month`, `year`, `status`, `requested_by`, `approved_by`, `approved_at`, `notes`, `created_at`, `updated_at`) VALUES
(1, 1, 'Housekeeping', 'Room Attendance', 'Membuat kamar menjadi layak inap', 9, 3, 2026, 'pending', 17, NULL, NULL, NULL, '2026-03-05 04:51:42', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `training_revisions`
--

CREATE TABLE `training_revisions` (
  `id` int(11) NOT NULL,
  `training_plan_id` int(11) NOT NULL,
  `revision_number` int(11) NOT NULL,
  `requested_by` int(11) NOT NULL,
  `status` enum('pending','approved','rejected') DEFAULT 'pending',
  `approved_by` int(11) DEFAULT NULL,
  `approved_at` datetime DEFAULT NULL,
  `reason` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `training_revision_participants`
--

CREATE TABLE `training_revision_participants` (
  `id` int(11) NOT NULL,
  `revision_id` int(11) NOT NULL,
  `training_day_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `action` enum('added','removed','changed') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `training_shifts`
--

CREATE TABLE `training_shifts` (
  `id` int(11) NOT NULL,
  `training_day_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `shift_type` enum('regular','off','leave','overtime') DEFAULT 'regular',
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `job_id` int(11) DEFAULT NULL,
  `application_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(1) NOT NULL,
  `hotel_id` int(1) NOT NULL,
  `role` enum('worker','hotel_hr','hotel_fo','hotel_hk','hotel_fnb_service','hotel_fnb_production','hotel_fna','hotel_eng','hotel_sales','hotel_gm','admin') CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT 'worker',
  `name` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `email` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `phone` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `password` varchar(250) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `gender` enum('Female','Male') DEFAULT NULL,
  `provider` enum('local','google','facebook') CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT 'local',
  `provider_id` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `photo` varchar(250) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `is_verified` tinyint(4) DEFAULT 0,
  `is_active` enum('active','inactive') CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT 'active',
  `created_at` datetime DEFAULT NULL,
  `created_by` int(1) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `hotel_id`, `role`, `name`, `email`, `phone`, `password`, `gender`, `provider`, `provider_id`, `photo`, `is_verified`, `is_active`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
(1, 0, 'admin', 'Admin Hey Work', 'admin@admin.com', '81234567890', '$2y$10$TYZN8k0YxaB.jxCtqA4sl.JnllEeN3/UF9oGYK5.LTvbGlCe7HE82', NULL, 'local', NULL, 'uploads/profiles/profile_2_1768811928.png', 0, 'active', '2026-01-18 12:25:53', 1, '2026-01-18 12:25:53', 1, NULL, NULL),
(2, 1, 'worker', 'Muhamad Ridwan Munawar', 'ridwanmunawar2607@gmail.com', '85171040347', '$2y$10$SuliPMeUvm3ggsgEYsBXYuX52cEW0QSV9dTDv3EwuYcPw7J8BTKG.', NULL, 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:53', 1, '2026-02-21 08:16:16', 1, NULL, NULL),
(3, 1, 'worker', 'Taufik Kurnia', 'dantiratu8@gmail.com', '812', '$2y$10$SuliPMeUvm3ggsgEYsBXYuX52cEW0QSV9dTDv3EwuYcPw7J8BTKG.', NULL, 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:53', 1, '2026-02-25 00:44:15', 1, NULL, NULL),
(4, 1, 'hotel_fnb_service', 'Rahadian Perdana', 'rahadian.rivelino@gmail.com', '88802308136', '$2y$10$4hUzmX0B1FP9xsk7VRCczeN5KPp2DAnBrNgEY1Z5qLNAv.SE0XOee', NULL, 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:53', 1, '2026-02-25 23:59:33', 17, NULL, NULL),
(5, 1, 'hotel_hk', 'Renaldy Herlando', 'rey.herlando@gmail.com', '81255800626', '$2y$10$SuliPMeUvm3ggsgEYsBXYuX52cEW0QSV9dTDv3EwuYcPw7J8BTKG.', NULL, 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:53', 1, '2026-02-26 03:22:54', 17, NULL, NULL),
(6, 1, 'worker', 'Tri Setiyawati', 'celineq683@gmail.com', '87880006558', '$2y$10$SuliPMeUvm3ggsgEYsBXYuX52cEW0QSV9dTDv3EwuYcPw7J8BTKG.', NULL, 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:53', 1, '2026-02-22 23:21:54', 1, NULL, NULL),
(7, 1, 'worker', 'Raafi Teguh Septianto', 'raafiteguh73@gmail.com', '895711102828', '$2y$10$SuliPMeUvm3ggsgEYsBXYuX52cEW0QSV9dTDv3EwuYcPw7J8BTKG.', NULL, 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:53', 1, '2026-02-22 23:21:54', 1, NULL, NULL),
(8, 1, 'worker', 'Jan Pelupessy', 'janhawajasmine14@gmail.com', '81212790875', '$2y$10$SuliPMeUvm3ggsgEYsBXYuX52cEW0QSV9dTDv3EwuYcPw7J8BTKG.', NULL, 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-22 23:21:00', 1, NULL, NULL),
(9, 1, 'worker', 'Adi Alfian Surahman', 'Adialfian83@gmail.com', '83811404011', '$2y$10$mLCPGE.cz6Z1tUEL7PI/ouTl3a8bbr8THP65KFbhXrjIkrcsJWsw6', NULL, 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-26 03:42:42', 17, NULL, NULL),
(10, 1, 'worker', 'Dini Wulandari', 'Dinilandari18@gmail.com', '8987795834', '$2y$10$SuliPMeUvm3ggsgEYsBXYuX52cEW0QSV9dTDv3EwuYcPw7J8BTKG.', NULL, 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-22 23:21:00', 1, NULL, NULL),
(11, 1, 'worker', 'Didik Febriawan', 'didikj4dul@gmail.com', '81298096880', '$2y$10$SuliPMeUvm3ggsgEYsBXYuX52cEW0QSV9dTDv3EwuYcPw7J8BTKG.', NULL, 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-24 00:42:06', 1, NULL, NULL),
(12, 1, 'worker', 'Muji priyanto', 'mujipriyanto445@gmail.com', '82139111259', '$2y$10$SuliPMeUvm3ggsgEYsBXYuX52cEW0QSV9dTDv3EwuYcPw7J8BTKG.', NULL, 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-22 23:21:00', 1, NULL, NULL),
(13, 1, 'hotel_fo', 'Syahwal Ramadhan', 'syahwal.86@gmail.com', '87711210850', '$2y$10$SuliPMeUvm3ggsgEYsBXYuX52cEW0QSV9dTDv3EwuYcPw7J8BTKG.', NULL, 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-24 00:40:20', 1, NULL, NULL),
(14, 1, 'worker', 'Ijang Sulaeman', 'ijangsulaeman3@gmail.com', '81317087778', '$2y$10$SuliPMeUvm3ggsgEYsBXYuX52cEW0QSV9dTDv3EwuYcPw7J8BTKG.', NULL, 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-22 23:21:00', 1, NULL, NULL),
(15, 1, 'worker', 'Faisal Bahri', 'salbahri43@gmail.com', '85283872224', '$2y$10$SuliPMeUvm3ggsgEYsBXYuX52cEW0QSV9dTDv3EwuYcPw7J8BTKG.', NULL, 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-24 00:43:07', 1, NULL, NULL),
(16, 1, 'worker', 'Eka panji asmoro', 'panjiasmoro1786@gmail.com', '82130884044', '$2y$10$SuliPMeUvm3ggsgEYsBXYuX52cEW0QSV9dTDv3EwuYcPw7J8BTKG.', NULL, 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-22 23:21:00', 1, NULL, NULL),
(17, 1, 'hotel_hr', 'Yend Hendriyana', 'yend.hendriyana@gmail.com', '81519992334', '$2y$10$SuliPMeUvm3ggsgEYsBXYuX52cEW0QSV9dTDv3EwuYcPw7J8BTKG.', NULL, 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-25 01:05:39', 1, NULL, NULL),
(18, 1, 'worker', 'M Aji Maulana', 'muhamadajimaulana557@gmail.com', '89630707971', '$2y$10$SuliPMeUvm3ggsgEYsBXYuX52cEW0QSV9dTDv3EwuYcPw7J8BTKG.', NULL, 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-22 23:21:00', 1, NULL, NULL),
(19, 1, 'worker', 'Syahla Rahayu Munandar', 'syahlarahayu98@gmail.com', '85811547147', '$2y$10$SuliPMeUvm3ggsgEYsBXYuX52cEW0QSV9dTDv3EwuYcPw7J8BTKG.', NULL, 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-22 23:21:00', 1, NULL, NULL),
(20, 1, 'worker', 'Rima Lestari Sonneville', 'rima.sonneville.89@gmail.com', '88211521716', '$2y$10$SuliPMeUvm3ggsgEYsBXYuX52cEW0QSV9dTDv3EwuYcPw7J8BTKG.', NULL, 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-22 23:21:00', 1, NULL, NULL),
(21, 1, 'worker', 'Mohtar Bimantoro', 'sofiabimantoro1@gmail.com', '83165994287', '$2y$10$SuliPMeUvm3ggsgEYsBXYuX52cEW0QSV9dTDv3EwuYcPw7J8BTKG.', NULL, 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-22 23:21:00', 1, NULL, NULL),
(22, 1, 'worker', 'Hani yuniarti', 'haniyuniarti1306@gmail.com', '85691659516', '$2y$10$SuliPMeUvm3ggsgEYsBXYuX52cEW0QSV9dTDv3EwuYcPw7J8BTKG.', 'Female', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-22 23:21:00', 1, NULL, NULL),
(23, 1, 'worker', 'Qhalia putri', 'halloqhalia@gmail.com', '85775264566', '$2y$10$SuliPMeUvm3ggsgEYsBXYuX52cEW0QSV9dTDv3EwuYcPw7J8BTKG.', 'Female', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-22 23:21:00', 1, NULL, NULL),
(24, 1, 'worker', 'Faishal Tri Aditama', 'faishaltriaditama@gmail.com', '81295724744', '$2y$10$SuliPMeUvm3ggsgEYsBXYuX52cEW0QSV9dTDv3EwuYcPw7J8BTKG.', 'Male', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-23 22:47:14', 1, NULL, NULL),
(25, 1, 'worker', 'Hilwa Salsabila Ahesa', 'ahesa.hilwa@gmail.com', '87897532333', '$2y$10$SuliPMeUvm3ggsgEYsBXYuX52cEW0QSV9dTDv3EwuYcPw7J8BTKG.', 'Female', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-23 22:49:29', 1, NULL, NULL),
(26, 1, 'worker', 'Bambang Setiawan', 'bambangsetiawan0681@gmail.com', '8996601717', '$2y$10$SuliPMeUvm3ggsgEYsBXYuX52cEW0QSV9dTDv3EwuYcPw7J8BTKG.', 'Male', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-23 22:49:29', 1, NULL, NULL),
(27, 1, 'worker', 'Firmansyah', 'firmansyahfirmansyah934@gmail.com', '85777166572', '$2y$10$SuliPMeUvm3ggsgEYsBXYuX52cEW0QSV9dTDv3EwuYcPw7J8BTKG.', 'Male', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-23 22:49:29', 1, NULL, NULL),
(28, 1, 'worker', 'Jarkasih', 'jarkasihuntung4@gmail.com', '85775588443', '$2y$10$SuliPMeUvm3ggsgEYsBXYuX52cEW0QSV9dTDv3EwuYcPw7J8BTKG.', 'Male', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-23 22:49:29', 1, NULL, NULL),
(29, 1, 'worker', 'Cecep dikdik Kurniawan ', 'cecepdikdikkurniawan@gmail.com', '85719251910', '$2y$10$SuliPMeUvm3ggsgEYsBXYuX52cEW0QSV9dTDv3EwuYcPw7J8BTKG.', 'Male', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-23 22:49:29', 1, NULL, NULL),
(30, 1, 'worker', 'Dadan Mulyana', 'cipitung78@gmail.com', '85716638004', '$2y$10$SuliPMeUvm3ggsgEYsBXYuX52cEW0QSV9dTDv3EwuYcPw7J8BTKG.', 'Male', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-23 22:49:29', 1, NULL, NULL),
(31, 1, 'worker', 'Vita Andini', 'vita@gmail.com', '812', '$2y$10$OK0bKQ5ygM7Ok2h69ZYPOuKvHSHI3gK3gOq77HkMHh2Olw8CwS4m6', 'Female', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-25 14:49:36', 1, NULL, NULL),
(32, 1, 'worker', 'M. Paldan', 'paldan@gmail.com', '812', '$2y$10$OK0bKQ5ygM7Ok2h69ZYPOuKvHSHI3gK3gOq77HkMHh2Olw8CwS4m6', 'Male', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-25 14:49:36', 1, NULL, NULL),
(33, 1, 'worker', 'Tedi Sukmana', 'tedi@gmail.com', '812', '$2y$10$OK0bKQ5ygM7Ok2h69ZYPOuKvHSHI3gK3gOq77HkMHh2Olw8CwS4m6', 'Male', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-25 14:49:36', 1, NULL, NULL),
(34, 1, 'worker', 'Aldo Aldiansyah', 'aldo@gmail.com', '812', '$2y$10$OK0bKQ5ygM7Ok2h69ZYPOuKvHSHI3gK3gOq77HkMHh2Olw8CwS4m6', 'Male', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-25 14:49:36', 1, NULL, NULL),
(35, 1, 'worker', 'Aldi', 'aldi@gmail.com', '812', '$2y$10$y8CwPY/0vDGjxwbOjKj6BeS1m4HJAzIuO183qWg0Q3HPrEQ5.YMIu', 'Male', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-26 04:28:05', 17, NULL, NULL),
(36, 1, 'worker', 'Azizi Falaqi Rahman', 'vanofam596@gmail.com', '812', '$2y$10$RZ5tGAQZek8r862a4mtkpOjo9YKZyySUp5u3gMqhLeVGVsG/L.0Gu', 'Male', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-25 23:11:04', 1, NULL, NULL),
(37, 1, 'worker', 'Muhamad Fadhli', 'fadilajjah2345@gmail.com', '895406355514', '$2y$10$OK0bKQ5ygM7Ok2h69ZYPOuKvHSHI3gK3gOq77HkMHh2Olw8CwS4m6', 'Male', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-25 14:49:36', 1, NULL, NULL),
(38, 1, 'worker', 'Dahayu Nariswari', 'nariswaridahayu@gmail.com', '8135339143', '$2y$10$CuPJYvOxuMlNGQigYIRhxeSHT9jjZzZ69RupgcCqvw6rNy7znHguK', 'Female', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-25 23:06:16', 1, NULL, NULL),
(39, 1, 'worker', 'Kafka', 'fafka@gmail.com', '812', '$2y$10$CuPJYvOxuMlNGQigYIRhxeSHT9jjZzZ69RupgcCqvw6rNy7znHguK', 'Male', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-25 23:06:16', 1, NULL, NULL),
(40, 1, 'worker', 'Dzaki', 'dzaki@gmail.com', '812', '$2y$10$CuPJYvOxuMlNGQigYIRhxeSHT9jjZzZ69RupgcCqvw6rNy7znHguK', 'Male', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-25 23:06:16', 1, NULL, NULL),
(41, 1, 'worker', 'Alwi', 'alwi@gmail.com', '812', '$2y$10$CuPJYvOxuMlNGQigYIRhxeSHT9jjZzZ69RupgcCqvw6rNy7znHguK', 'Male', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-25 23:06:16', 1, NULL, NULL),
(42, 1, 'worker', 'Siti', 'siti@gmail.com', '812', '$2y$10$CuPJYvOxuMlNGQigYIRhxeSHT9jjZzZ69RupgcCqvw6rNy7znHguK', 'Female', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-25 23:06:16', 1, NULL, NULL),
(43, 1, 'worker', 'Sandi', 'sandi@gmail.com', '812', '$2y$10$CuPJYvOxuMlNGQigYIRhxeSHT9jjZzZ69RupgcCqvw6rNy7znHguK', 'Male', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-25 23:06:16', 1, NULL, NULL),
(44, 1, 'worker', 'Alung', 'alung@gmail.com', '812', '$2y$10$CuPJYvOxuMlNGQigYIRhxeSHT9jjZzZ69RupgcCqvw6rNy7znHguK', 'Male', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-25 23:06:16', 1, NULL, NULL),
(45, 1, 'worker', 'Rasya', 'rasya@gmail.com', '812', '$2y$10$CuPJYvOxuMlNGQigYIRhxeSHT9jjZzZ69RupgcCqvw6rNy7znHguK', 'Female', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-25 23:06:16', 1, NULL, NULL),
(46, 1, 'worker', 'Varel', 'varel@gmail.com', '812', '$2y$10$CuPJYvOxuMlNGQigYIRhxeSHT9jjZzZ69RupgcCqvw6rNy7znHguK', 'Male', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-25 23:06:16', 1, NULL, NULL),
(47, 1, 'worker', 'Rival', 'rival@gmail.com', '812', '$2y$10$CuPJYvOxuMlNGQigYIRhxeSHT9jjZzZ69RupgcCqvw6rNy7znHguK', 'Male', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-25 23:06:16', 1, NULL, NULL),
(48, 1, 'worker', 'Fatih', 'fatih@gmail.com', '812', '$2y$10$CuPJYvOxuMlNGQigYIRhxeSHT9jjZzZ69RupgcCqvw6rNy7znHguK', 'Female', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-25 23:06:16', 1, NULL, NULL),
(49, 1, 'worker', 'Yanto', 'yanto@gmail.com', '812', '$2y$10$CuPJYvOxuMlNGQigYIRhxeSHT9jjZzZ69RupgcCqvw6rNy7znHguK', 'Male', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-25 23:06:16', 1, NULL, NULL),
(50, 1, 'worker', 'Agung', 'agung@gmail.com', '812', '$2y$10$CuPJYvOxuMlNGQigYIRhxeSHT9jjZzZ69RupgcCqvw6rNy7znHguK', 'Male', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-25 23:06:16', 1, NULL, NULL),
(51, 1, 'worker', 'Ridwan Anwar', 'ridwananwar@gmail.com', '812', '$2y$10$CuPJYvOxuMlNGQigYIRhxeSHT9jjZzZ69RupgcCqvw6rNy7znHguK', 'Male', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-25 23:06:16', 1, NULL, NULL),
(52, 1, 'worker', 'Rizki', 'rizki@gmail.com', '812', '$2y$10$CuPJYvOxuMlNGQigYIRhxeSHT9jjZzZ69RupgcCqvw6rNy7znHguK', 'Male', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-25 23:06:16', 1, NULL, NULL),
(53, 1, 'worker', 'Fadil M', 'fadil.m@gmail.com', '812', '$2y$10$CuPJYvOxuMlNGQigYIRhxeSHT9jjZzZ69RupgcCqvw6rNy7znHguK', 'Male', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-25 23:06:16', 1, NULL, NULL),
(54, 1, 'hotel_gm', 'Prabu', 'prabunad@salamdjourney.com', '812', '$2y$10$LrfF4v78K0G7DeW4cY74COr5fu1hcRmQpWbzoAzRaNQF4a/HAq3lq', 'Male', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-03-03 00:08:36', 17, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `worker_child`
--

CREATE TABLE `worker_child` (
  `id` int(1) NOT NULL,
  `user_id` int(1) NOT NULL,
  `child` varchar(250) DEFAULT NULL,
  `child_gender` varchar(10) DEFAULT NULL,
  `child_birth_place` varchar(50) DEFAULT NULL,
  `child_birth_date` date DEFAULT NULL,
  `child_last_edu` varchar(20) DEFAULT NULL,
  `child_job` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` int(1) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `worker_child`
--

INSERT INTO `worker_child` (`id`, `user_id`, `child`, `child_gender`, `child_birth_place`, `child_birth_date`, `child_last_edu`, `child_job`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
(1, 1, 'Muhamad Sahrul Arifin', 'male', 'Bogor', '2019-12-13', NULL, NULL, '2026-02-22 22:48:31', 1, '2026-02-22 22:48:31', 1, NULL, NULL),
(2, 5, 'Liona Putri Vallerie', 'female', NULL, '2025-11-13', NULL, NULL, '2026-02-22 22:47:38', 1, '2026-02-22 22:47:38', 1, NULL, NULL),
(3, 6, 'Shevira mutiarani', 'female', 'Purbalingga', '2000-01-03', 'Sarjana', 'Karyawati', '2026-02-22 22:47:38', 1, '2026-02-22 22:47:38', 1, NULL, NULL),
(4, 8, 'Felicia', 'female', NULL, NULL, NULL, NULL, '2026-02-22 22:48:00', 1, '2026-02-22 22:48:00', 1, NULL, NULL),
(5, 9, 'Rafa abizar nurahman', 'male', NULL, '2019-05-24', 'Sd kelas 1', NULL, '2026-02-22 22:47:00', 1, '2026-02-22 22:47:00', 1, NULL, NULL),
(6, 11, 'M. Firjatullah Alifiawan', 'male', 'Jakarta', '2000-05-04', 'mahasiswa', 'konten kreator', '2026-02-22 22:48:00', 1, '2026-02-22 22:48:00', 1, NULL, NULL),
(7, 12, 'Sasqia renay melliyani', 'female', 'Bekasi', '2007-05-14', 'Pelajar', NULL, '2026-02-22 22:47:00', 1, '2026-02-22 22:47:00', 1, NULL, NULL),
(8, 13, 'Keenan Gilmour Arasya', 'male', 'Bogor', '2025-09-10', NULL, NULL, '2026-02-22 22:47:00', 1, '2026-02-22 22:47:00', 1, NULL, NULL),
(9, 14, 'Ira Resi Nur Oktaviani', 'female', 'Cianjur', '2000-10-18', 'SLTA', 'Ibu Rumah Tangga', '2026-02-22 22:48:00', 1, '2026-02-22 22:48:00', 1, NULL, NULL),
(10, 16, 'Renaldi Apriansyah', 'male', 'Jakarta', '2005-04-13', 'SMK', 'Pegawai swasta', '2026-02-22 22:47:00', 1, '2026-02-22 22:47:00', 1, NULL, NULL),
(11, 17, 'Hilwa Salsabila Ahesa', 'female', 'Jakarta', '2005-05-23', 'Masih Berkuliah', 'Desain Grafis supporting marcomm', '2026-02-22 22:48:00', 1, '2026-02-22 22:48:00', 1, NULL, NULL),
(12, 21, 'Jihan fachiroh bimantoro', 'female', 'Surabaya', '2021-09-30', 'Tk', NULL, '2026-02-22 22:47:00', 1, '2026-02-22 22:47:00', 1, NULL, NULL),
(13, 22, 'Haikal', 'male', 'Bogor', '2019-03-25', 'Sd', NULL, '2026-02-22 22:47:00', 1, '2026-02-22 22:47:00', 1, NULL, NULL),
(14, 11, 'M. Abril', 'male', 'Tangerang', '2007-10-19', 'SMK', 'masih sekolah', '2026-02-22 22:48:00', 1, '2026-02-22 22:48:00', 1, NULL, NULL),
(15, 14, 'M Aria Resa Ramadlan', 'male', 'Cianjur', '2004-07-07', 'SLTA', 'Wiraswasta', '2026-02-22 22:48:00', 1, '2026-02-22 22:48:00', 1, NULL, NULL),
(16, 16, 'Kiandra aldya ark', 'male', 'Jakarta', '2009-11-13', 'STM', 'Pelajar', '2026-02-22 22:47:00', 1, '2026-02-22 22:47:00', 1, NULL, NULL),
(17, 17, 'Ukasya Hail Fattah Ahesa', 'male', 'Jakarta', '2012-01-31', 'SMP', 'Pelajar', '2026-02-22 22:48:00', 1, '2026-02-22 22:48:00', 1, NULL, NULL),
(18, 11, 'M. Athar Al-Farizky', 'male', 'Tangerang', '2014-09-01', 'SD', 'Pelajar', '2026-02-22 22:48:00', 1, '2026-02-22 22:48:00', 1, NULL, NULL),
(19, 14, 'M Revaldhi', 'male', 'Cianjur', '2012-12-29', 'SD', 'Pelajar', '2026-02-22 22:48:00', 1, '2026-02-22 22:48:00', 1, NULL, NULL),
(20, 16, 'Aldan panji arka', 'male', 'Jakarta', '2015-11-15', 'SD', 'Pelajar', '2026-02-22 22:48:00', 1, '2026-02-22 22:48:00', 1, NULL, NULL),
(21, 14, 'Akbar Maulana', 'male', 'Cianjur', '2015-06-28', 'SD', 'Pelajar', '2026-02-22 22:48:00', 1, '2026-02-22 22:48:00', 1, NULL, NULL),
(22, 26, 'Lutfi Setiawan ', 'male', 'Bogor', '2008-10-25', 'SMA', 'Pelajar', '2026-02-22 22:48:00', 1, '2026-02-22 22:48:00', 1, NULL, NULL),
(23, 27, 'CANTIKA FIRTIANSYAH', 'female', 'Bogor', '2005-11-12', 'SMA', 'Pelajar', '2026-02-22 22:48:00', 1, '2026-02-22 22:48:00', 1, NULL, NULL),
(24, 28, 'Amanda meydian azka', 'female', 'Bogor', '2014-05-02', NULL, 'Pelajar', '2026-02-22 22:48:00', 1, '2026-02-22 22:48:00', 1, NULL, NULL),
(25, 29, 'Syabila putri Kurniawan', 'female', 'Ciamis', '2018-04-24', NULL, 'Pelajar', '2026-02-22 22:48:00', 1, '2026-02-22 22:48:00', 1, NULL, NULL),
(26, 30, 'Muhamad Hamdan Harit Syah', 'male', 'Bogor', '2022-02-15', NULL, NULL, '2026-02-22 22:48:00', 1, '2026-02-22 22:48:00', 1, NULL, NULL),
(27, 26, 'Riffat Fahlevi setiawan', 'male', 'Bogor', '2015-08-12', 'SD', 'Pelajar', '2026-02-22 22:48:00', 1, '2026-02-22 22:48:00', 1, NULL, NULL),
(28, 27, 'AZKA ALDRIANSYAH', 'male', 'Bogor', '2014-03-11', 'SD', 'Pelajar', '2026-02-22 22:48:00', 1, '2026-02-22 22:48:00', 1, NULL, NULL),
(29, 28, 'Hafizh bariq ardiazka', 'male', 'Bogor', '2018-01-20', NULL, 'Pelajar', '2026-02-22 22:48:00', 1, '2026-02-22 22:48:00', 1, NULL, NULL),
(30, 28, 'Arclya zihan azkana', 'female', 'Bogor', '2022-03-03', NULL, NULL, '2026-02-22 22:48:00', 1, '2026-02-22 22:48:00', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `worker_contracts`
--

CREATE TABLE `worker_contracts` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `contract_type` enum('daily_worker','casual','corporate','internship') NOT NULL DEFAULT 'daily_worker',
  `contract_number` varchar(100) DEFAULT NULL,
  `start_date` date NOT NULL,
  `end_date` date DEFAULT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  `salary_type` enum('daily','monthly','hourly') DEFAULT 'daily',
  `base_salary` decimal(15,2) DEFAULT 0.00,
  `overtime_rate` decimal(15,2) DEFAULT 0.00,
  `contract_file` varchar(255) DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `created_by` int(11) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `updated_by` int(11) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `worker_contracts`
--

INSERT INTO `worker_contracts` (`id`, `user_id`, `contract_type`, `contract_number`, `start_date`, `end_date`, `is_active`, `salary_type`, `base_salary`, `overtime_rate`, `contract_file`, `notes`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
(1, 2, 'corporate', NULL, '2024-09-05', '2025-09-04', 1, 'monthly', 5000000.00, 0.00, NULL, NULL, '2026-02-21 08:16:44', 1, '2026-02-21 08:16:44', NULL, NULL, NULL),
(2, 3, 'corporate', NULL, '2025-11-19', '2026-11-18', 1, 'monthly', 3500000.00, 0.00, NULL, NULL, '2026-02-21 08:16:44', 1, '2026-02-22 00:44:18', NULL, NULL, NULL),
(3, 4, 'corporate', NULL, '2025-11-20', '2026-11-19', 1, 'monthly', 5000000.00, 0.00, NULL, NULL, '2026-02-21 08:16:44', 1, '2026-02-22 00:44:18', NULL, NULL, NULL),
(4, 5, 'corporate', NULL, '2025-11-24', '2026-11-23', 1, 'monthly', 6000000.00, 0.00, NULL, NULL, '2026-02-21 08:16:44', 1, '2026-02-22 00:44:18', NULL, NULL, NULL),
(5, 6, 'corporate', NULL, '2025-11-24', '2026-11-23', 1, 'monthly', 6000000.00, 0.00, NULL, NULL, '2026-02-21 08:16:44', 1, '2026-02-22 00:44:18', NULL, NULL, NULL),
(6, 7, 'corporate', NULL, '2025-11-24', '2026-11-23', 1, 'monthly', 3000000.00, 0.00, NULL, NULL, '2026-02-21 08:16:44', 1, '2026-02-22 00:44:18', NULL, NULL, NULL),
(7, 8, 'corporate', NULL, '2025-11-26', '2026-11-25', 1, 'monthly', 3500000.00, 0.00, NULL, NULL, '2026-02-21 08:16:00', 1, '2026-02-22 00:44:00', NULL, NULL, NULL),
(8, 9, 'corporate', NULL, '2025-11-28', '2026-11-27', 1, 'monthly', 3500000.00, 0.00, NULL, NULL, '2026-02-21 08:16:00', 1, '2026-02-22 00:44:00', NULL, NULL, NULL),
(9, 10, 'corporate', NULL, '2025-12-02', '2026-12-01', 1, 'monthly', 3500000.00, 0.00, NULL, NULL, '2026-02-21 08:16:00', 1, '2026-02-22 00:44:00', NULL, NULL, NULL),
(10, 11, 'corporate', NULL, '2025-12-04', '2026-12-03', 1, 'monthly', 5500000.00, 0.00, NULL, NULL, '2026-02-21 08:16:00', 1, '2026-02-22 00:44:00', NULL, NULL, NULL),
(11, 12, 'corporate', NULL, '2025-12-04', '2026-12-03', 1, 'monthly', 8000000.00, 0.00, NULL, NULL, '2026-02-21 08:16:00', 1, '2026-02-22 00:44:00', NULL, NULL, NULL),
(12, 13, 'corporate', NULL, '2025-12-11', '2026-12-10', 1, 'monthly', 4500000.00, 0.00, NULL, NULL, '2026-02-21 08:16:00', 1, '2026-02-22 00:44:00', NULL, NULL, NULL),
(13, 14, 'corporate', NULL, '2025-12-14', '2026-12-13', 1, 'monthly', 3500000.00, 0.00, NULL, NULL, '2026-02-21 08:16:00', 1, '2026-02-22 00:44:00', NULL, NULL, NULL),
(14, 15, 'corporate', NULL, '2025-12-15', '2026-12-14', 1, 'monthly', 3500000.00, 0.00, NULL, NULL, '2026-02-21 08:16:00', 1, '2026-02-22 00:44:00', NULL, NULL, NULL),
(15, 16, 'corporate', NULL, '2025-12-23', '2026-12-22', 1, 'monthly', 4000000.00, 0.00, NULL, NULL, '2026-02-21 08:16:00', 1, '2026-02-22 00:44:00', NULL, NULL, NULL),
(16, 17, 'corporate', NULL, '2025-12-27', '2027-12-26', 1, 'monthly', 5000000.00, 0.00, NULL, NULL, '2026-02-21 08:16:00', 1, '2026-02-22 00:44:00', NULL, NULL, NULL),
(17, 18, 'corporate', NULL, '2025-12-28', '2026-12-27', 1, 'monthly', 4500000.00, 0.00, NULL, NULL, '2026-02-21 08:16:00', 1, '2026-02-22 00:44:00', NULL, NULL, NULL),
(18, 19, 'corporate', NULL, '2026-01-05', '2027-01-04', 1, 'monthly', 3500000.00, 0.00, NULL, NULL, '2026-02-21 08:16:00', 1, '2026-02-22 00:44:00', NULL, NULL, NULL),
(19, 20, 'corporate', NULL, '2026-01-07', '2027-01-06', 1, 'monthly', 4500000.00, 0.00, NULL, NULL, '2026-02-21 08:16:00', 1, '2026-02-22 00:44:00', NULL, NULL, NULL),
(20, 21, 'corporate', NULL, '2026-01-12', '2027-01-11', 1, 'monthly', 3000000.00, 0.00, NULL, NULL, '2026-02-21 08:16:00', 1, '2026-02-22 00:44:00', NULL, NULL, NULL),
(21, 22, 'corporate', NULL, '2026-01-14', '2027-01-13', 1, 'monthly', 4000000.00, 0.00, NULL, NULL, '2026-02-21 08:16:00', 1, '2026-02-22 00:44:00', NULL, NULL, NULL),
(22, 23, 'corporate', NULL, '2026-02-06', '2027-02-05', 1, 'monthly', 3000000.00, 0.00, NULL, NULL, '2026-02-21 08:16:00', 1, '2026-02-22 00:44:00', NULL, NULL, NULL),
(23, 24, 'corporate', NULL, '2025-12-09', '2026-12-08', 1, 'monthly', 2500000.00, 0.00, NULL, NULL, '2026-02-21 08:16:00', 1, '2026-02-22 00:44:00', NULL, NULL, NULL),
(24, 25, 'corporate', NULL, '2026-01-12', '2027-01-11', 1, 'monthly', NULL, 0.00, NULL, NULL, '2026-02-21 08:16:00', 1, '2026-02-22 00:44:00', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `worker_documents`
--

CREATE TABLE `worker_documents` (
  `id` int(1) NOT NULL,
  `user_id` int(1) NOT NULL,
  `type` enum('ktp','certificate','other') CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT 'other',
  `file_path` varchar(250) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `worker_educations`
--

CREATE TABLE `worker_educations` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `level` varchar(20) NOT NULL,
  `title` varchar(100) DEFAULT NULL,
  `instituted_name` varchar(255) NOT NULL,
  `start_date` varchar(7) DEFAULT NULL,
  `end_date` varchar(7) DEFAULT NULL,
  `is_current` tinyint(1) NOT NULL,
  `gpa_value` decimal(4,2) DEFAULT NULL,
  `sort_order` int(1) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `created_by` int(1) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `updated_by` int(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `worker_educations`
--

INSERT INTO `worker_educations` (`id`, `user_id`, `level`, `title`, `instituted_name`, `start_date`, `end_date`, `is_current`, `gpa_value`, `sort_order`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
(1, 2, 'SD', '', 'SDN SUKAMAJU', '2003-07', '2009-06', 0, NULL, 0, '2026-02-21 08:24:31', 1, '2026-02-21 08:30:24', 1, NULL, NULL),
(2, 2, 'SMP', '', 'SMP PGRI 1 CIAWI', '2009-07', '2012-06', 0, NULL, 0, '2026-02-21 08:24:31', 1, '2026-02-21 08:30:24', 1, NULL, NULL),
(3, 2, 'SMK', 'Teknik Komputer dan Jaringan', 'SMK WIKRAMA BOGOR', '2012-07', '2015-06', 0, NULL, 0, '2026-02-21 08:24:31', 1, '2026-02-21 08:32:50', 1, NULL, NULL),
(4, 3, 'SD', '', 'SDN Sukajadi', '2003-07', '2008-06', 0, NULL, 0, '2026-02-22 00:15:30', 1, '2026-02-22 00:17:08', 1, NULL, NULL),
(5, 3, 'MTS', '', 'Mts Manarul Huda', '2009-07', '2010-06', 0, 8.50, 0, '2026-02-22 00:15:30', 1, '2026-02-22 23:07:27', 1, NULL, NULL),
(6, 3, 'SMK', 'Akomodasi perhotelan', 'SMK perhotelan cianjur', '2013-07', '2014-06', 0, 8.50, 0, '2026-02-22 00:15:30', 1, '2026-02-22 23:07:14', 1, NULL, NULL),
(7, 5, 'D3', 'Room Division Management', 'Sangkuriang Maritim Institute', '2023-07', '2024-06', 0, 3.45, 0, '2026-02-22 00:15:30', 1, '2026-02-22 23:06:49', 1, NULL, NULL),
(8, 6, 'SD', NULL, 'SD negri Mangunegara 2 Purbalingga', '1982-07', '1988-06', 0, NULL, 0, '2026-02-22 00:15:30', 1, '2026-02-22 23:30:52', 1, NULL, NULL),
(9, 6, 'SMP', NULL, 'SMP Mrebet Purbalingga', '1988-07', '1991-06', 0, NULL, 0, '2026-02-22 00:15:30', 1, '2026-02-22 23:30:56', 1, NULL, NULL),
(10, 6, 'SMA', 'SOS', 'SMA muhammadiyah purbalingga', '1991-07', '1994-06', 0, NULL, 0, '2026-02-22 00:15:30', 1, '2026-02-22 23:31:52', 1, NULL, NULL),
(11, 6, 'D3', NULL, 'Veteran Purwokerto', '1994-07', '1998-06', 0, NULL, 0, '2026-02-22 00:15:30', 1, '2026-02-22 23:31:52', 1, NULL, NULL),
(12, 7, 'SD', NULL, 'SDN Pengadilan 1', '2008-07', '2014-06', 0, NULL, 0, '2026-02-22 00:15:30', 1, '2026-02-22 23:31:52', 1, NULL, NULL),
(13, 7, 'SMP', NULL, 'SMP Negeri 7 Bogor', '2014-07', '2017-06', 0, NULL, 0, '2026-02-22 00:15:30', 1, '2026-02-22 23:57:54', 1, NULL, NULL),
(14, 7, 'SMA', 'IPS', 'SMA Negeri 9 Bogor', '2017-07', '2000-06', 0, NULL, 0, '2026-02-22 00:15:30', 1, '2026-02-22 23:57:49', 1, NULL, NULL),
(15, 7, 'S1', 'Ilmu Komunikasi', 'Universitas Gunadarma', '2020-07', '2024-06', 0, 3.44, 0, '2026-02-22 00:15:30', 1, '2026-02-22 23:57:49', 1, NULL, NULL),
(16, 9, 'SD', NULL, 'Sd babakan dramaga 1', '1995-07', '2001-06', 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:20:41', 1, NULL, NULL),
(17, 10, 'SD', NULL, 'SDN PASIRLAJA 4', '2003-07', '2009-06', 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:20:47', 1, NULL, NULL),
(18, 11, 'SD', NULL, 'SDN 03pg', NULL, '1986-06', 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:20:50', 1, NULL, NULL),
(19, 12, 'SD', NULL, 'SDN 03 KARANGSALAM', NULL, NULL, 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:20:53', 1, NULL, NULL),
(20, 13, 'SD', NULL, 'Sd negri tanah sareal 1', '2008-07', '2009-06', 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:20:56', 1, NULL, NULL),
(21, 14, 'SD', NULL, 'SDN Cintaresmi', '1989-07', '1990-06', 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:20:59', 1, NULL, NULL),
(22, 15, 'SD', NULL, 'SDN Balumbang jaya 03', '2002-07', '2008-06', 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:21:02', 1, NULL, NULL),
(23, 16, 'SD', NULL, 'SDN 05', NULL, NULL, 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:21:06', 1, NULL, NULL),
(24, 18, 'SD', NULL, 'SDN KOPO 02', '2015-07', '2016-06', 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:21:09', 1, NULL, NULL),
(25, 19, 'SD', NULL, 'SDN CIHERANG 01', '2004-07', '2010-06', 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:21:12', 1, NULL, NULL),
(26, 20, 'SD', NULL, 'SDN POLISI 1 BOGOR', '1995-07', '2001-06', 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:21:18', 1, NULL, NULL),
(27, 22, 'SD', NULL, 'Pengadilan 1', NULL, '1996-06', 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:21:21', 1, NULL, NULL),
(28, 23, 'SD', NULL, 'Sdn sukasari kota bogor', NULL, NULL, 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:21:25', 1, NULL, NULL),
(29, 9, 'SMP', NULL, 'Insan kamil', '2001-07', '2003-06', 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:21:28', 1, NULL, NULL),
(30, 10, 'SMP', NULL, 'SMP PUTRA PAKUAN BOGOR', '2010-07', '2013-06', 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:21:33', 1, NULL, NULL),
(31, 11, 'SMP', NULL, 'SMPN 173', NULL, '1989-06', 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:21:37', 1, NULL, NULL),
(32, 12, 'SMP', NULL, 'SMP N 1 SUSSKAN', '1997-07', '1999-06', 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:21:40', 1, NULL, NULL),
(33, 13, 'SMP', NULL, 'Smp negri 8 bogor', '2011-07', '2012-06', 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:21:43', 1, NULL, NULL),
(34, 14, 'SMP', NULL, 'MTS Mathiyyatul Ulum', '1993-07', '1994-06', 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:21:46', 1, NULL, NULL),
(35, 15, 'SMP', NULL, 'SMP Sejahtera 04', '2008-07', '2011-06', 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:21:49', 1, NULL, NULL),
(36, 16, 'SMP', NULL, 'SMP budaya', NULL, NULL, 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:21:51', 1, NULL, NULL),
(37, 18, 'SMP', NULL, 'SMP ISLAM DARUL WASILAH', '2017-07', '2019-06', 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:21:54', 1, NULL, NULL),
(38, 19, 'SMP', NULL, 'SMP Majmaul Bahrain', '2010-07', '2013-06', 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:21:57', 1, NULL, NULL),
(39, 20, 'SMP', NULL, 'SMPN 7 BOGOR', '2001-07', '2004-06', 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:22:00', 1, NULL, NULL),
(40, 22, 'SMP', NULL, 'Rimba teruna', NULL, NULL, 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:22:06', 1, NULL, NULL),
(41, 23, 'SMP', NULL, 'Smpn 13 kota bogor', NULL, NULL, 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:22:10', 1, NULL, NULL),
(42, 9, 'SMK', 'Listrik', 'Smk pgri 2', '2004-07', '2006-06', 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:22:13', 1, NULL, NULL),
(43, 10, 'SMK', 'AKUNTANSI', 'SMK PGRI 3 BOGOR', '2013-07', '2016-06', 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:22:16', 1, NULL, NULL),
(44, 11, 'SMA', 'IPS', 'SMAN 72', NULL, '1992-06', 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:22:18', 1, NULL, NULL),
(45, 12, 'SMK', 'Mekanik otomotif', 'SMK \"75\"2 purwokerto', '1999-07', '2001-06', 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:22:22', 1, NULL, NULL),
(46, 13, 'SMK', 'Pemasaran', 'Smk negri 1 bogor', '2013-07', '2014-06', 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:22:28', 1, NULL, NULL),
(47, 14, 'MAN', 'Akuntansi', 'MAN Cianjur', '1996-07', '1997-06', 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:22:31', 1, NULL, NULL),
(48, 15, 'SMK', 'Teknik kendaraan ringan', 'SMK Negeri 1 Ciomas', '2011-07', '2014-06', 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:22:34', 1, NULL, NULL),
(49, 16, 'SMK', 'Teknik', 'SMK taruna', NULL, '2004-06', 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:22:36', 1, NULL, NULL),
(50, 18, 'SMK', 'TATA BOGA', 'SMK N 1 PUNCAK CISARUA', '2021-07', '2022-06', 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:22:39', 1, NULL, NULL),
(51, 19, 'SMA', 'Ips', 'SMA Pesat Bogor', '2013-07', '2016-06', 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:22:48', 1, NULL, NULL),
(52, 20, 'SMA', NULL, 'SMA PGRI 1 BOGOR', '2004-07', '2007-06', 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:22:51', 1, NULL, NULL),
(53, 22, 'SMK', NULL, 'Pgri 1', NULL, NULL, 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:22:54', 1, NULL, NULL),
(54, 23, 'SMK', 'Farmasi', 'Smk tarum negara bogor', NULL, '2022-06', 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:22:57', 1, NULL, NULL),
(55, 9, 'D1', 'Perhotelan', 'Wisakti (D1)', '2008-07', '2009-06', 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:23:01', 1, NULL, NULL),
(56, 17, 'D3', 'Finance of Banking', 'D3 Universitas Borobudur', '1993-07', '1996-06', 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:23:06', 1, NULL, NULL),
(57, 19, 'D4', 'Hotel Management', 'STP Bogor BHI D4', '2016-07', '2020-06', 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:23:09', 1, NULL, NULL),
(58, 20, 'D1', 'ROOM DIVISION', 'DIPLOMA 1', '2007-07', '2008-06', 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:23:12', 1, NULL, NULL),
(59, 10, 'S1', 'MANAJEMEN KEUANGAN', 'STIE KESATUAN BOGOR', '2016-07', '2020-06', 0, 3.48, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:23:15', 1, NULL, NULL),
(60, 24, 'SD', NULL, 'SDIP YLPI', '2008-07', '2014-06', 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:23:15', 1, NULL, NULL),
(61, 25, 'SD', NULL, 'Mentari Ar-ridho islamic school', '2010-07', '2016-06', 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:23:15', 1, NULL, NULL),
(62, 24, 'SMP', NULL, 'Insan Kamil', '2014-07', '2017-06', 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:23:15', 1, NULL, NULL),
(63, 25, 'SMP', NULL, 'SMPIT UMMUL QURO BOGOR', '2017-07', '2019-06', 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:23:15', 1, NULL, NULL),
(64, 24, 'SMA', 'IPS', 'SMAN 7 Bogor', '2017-07', '2020-06', 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:26:48', 1, NULL, NULL),
(65, 25, 'SMA', 'IPS', 'SMAIT UMMUL QURO BOGOR', '2020-07', '2023-06', 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:26:48', 1, NULL, NULL),
(66, 24, 'S1', 'Manajemen', 'Universitas Jenderal Soedirman\r\n', '2020-07', '2025-06', 0, 3.00, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:26:48', 1, NULL, NULL),
(67, 25, 'S1', 'ILMU KOMUNIKASI', 'UNIVERSITAS PANCASILA', '2024-07', '2027-06', 0, 3.68, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:26:48', 1, NULL, NULL),
(68, 26, 'SD', NULL, 'SDN kota batu 02', NULL, NULL, 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:26:48', 1, NULL, NULL),
(69, 27, 'SD', NULL, 'SDN CIBALAGUNG 3 BOGOR', NULL, NULL, 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:26:48', 1, NULL, NULL),
(70, 28, 'MI', NULL, 'Mi manbaululum', '1994-07', '2000-06', 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:26:48', 1, NULL, NULL),
(71, 29, 'SD', NULL, 'SDN tajur 2', '1991-07', '1997-06', 0, 30.40, 0, '2026-02-22 00:15:00', 1, '2026-02-24 01:15:01', 1, NULL, NULL),
(72, 26, 'SMP', NULL, 'Sltpn 1 ciomas', NULL, NULL, 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:26:48', 1, NULL, NULL),
(73, 27, 'SMP', NULL, 'SMP RIMBA TERUNA BOGOR', NULL, NULL, 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:26:48', 1, NULL, NULL),
(74, 28, 'SMP', NULL, 'Yks 5', '2000-07', '2003-06', 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:26:48', 1, NULL, NULL),
(75, 29, 'SMP', NULL, 'SMP negeri 2 ciawi', '1997-07', '2000-06', 0, 28.25, 0, '2026-02-22 00:15:00', 1, '2026-02-24 01:15:01', 1, NULL, NULL),
(76, 26, 'SMA', 'IPS', 'SMA rimba madya', NULL, NULL, 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:26:48', 1, NULL, NULL),
(77, 27, 'SMA', NULL, 'SMK TARUNA BANGSA BOGOR', NULL, NULL, 0, NULL, 0, '2026-02-22 00:15:00', 1, '2026-02-23 23:26:48', 1, NULL, NULL),
(78, 28, 'SMA', 'SK', 'Smk yktb', '2003-07', '2006-06', 0, 28.11, 0, '2026-02-22 00:15:00', 1, '2026-02-24 01:21:55', 1, NULL, NULL),
(79, 29, 'SMA', 'IPS', 'SMA', '2003-07', '2006-06', 0, 61.97, 0, '2026-02-22 00:15:00', 1, '2026-02-24 01:21:55', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `worker_emergency`
--

CREATE TABLE `worker_emergency` (
  `id` int(1) NOT NULL,
  `user_id` int(1) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `address` varchar(250) DEFAULT NULL,
  `relation` varchar(100) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `created_by` int(1) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `worker_emergency`
--

INSERT INTO `worker_emergency` (`id`, `user_id`, `name`, `phone`, `address`, `relation`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
(1, 5, 'Cindi Dewi', '81388758806', 'Jl.cibeureum sunting no.14 mulyaharja Bogor Selatan', NULL, '2026-02-22 00:00:00', 1, '2026-02-22 00:00:00', 1, NULL, NULL),
(2, 6, 'Shevira Mutiarani', '87711102424', 'Jl baung No 37 Rt 04 Rw 02 kebagusan jakarta selatan', 'Anak', '2026-02-22 00:00:00', 1, '2026-02-22 00:00:00', 1, NULL, NULL),
(3, 7, 'Tyo', '81385089859', 'Kebun Raya Residence blok v no 11, Kabupaten Bogor, Kecamatan Ciomas, Desa Mekarjaya, 16610', 'Kakak', '2026-02-22 00:00:00', 1, '2026-02-22 00:00:00', 1, NULL, NULL),
(4, 7, 'Retno', NULL, 'Kebun Raya Residence blok v no 11, Kabupaten Bogor, Kecamatan Ciomas, Desa Mekarjaya, 16610', 'Ibu', '2026-02-22 00:00:00', 1, '2026-02-22 00:00:00', 1, NULL, NULL),
(5, 7, 'Reri', NULL, 'Panaragan Pojok', 'Kakak', '2026-02-22 00:00:00', 1, '2026-02-22 00:00:00', 1, NULL, NULL),
(6, 7, 'Fasha', NULL, 'Cilebut', 'Teman', '2026-02-22 00:00:00', 1, '2026-02-22 00:00:00', 1, NULL, NULL),
(7, 7, 'Rapip', NULL, 'kebun raya residence blok ab 3', 'Teman', '2026-02-22 00:00:00', 1, '2026-02-22 00:00:00', 1, NULL, NULL),
(8, 9, 'Siti nur aeni', '887433000000', 'Jalan pabuaran tengah rt04/rw06 kelurahan mulyaharja kecamatan bogor selatan kota bogor', 'istri', '2026-02-22 00:00:00', 1, '2026-02-22 00:00:00', 1, NULL, NULL),
(9, 10, 'Tegar Randitya', '82123231806', 'DESA CIJUJUNG TENGAH RT2 RW4, KEC SUKARAJA KAB.BOGOR', NULL, '2026-02-22 00:00:00', 1, '2026-02-22 00:00:00', 1, NULL, NULL),
(10, 11, 'Fifi', '87819225260', 'idem', NULL, '2026-02-22 00:00:00', 1, '2026-02-22 00:00:00', 1, NULL, NULL),
(11, 13, 'Natasyha Aprillia Sabatani', '89516217856', 'Jl. A yani 2 no. 13 rt 06/04', NULL, '2026-02-22 00:00:00', 1, '2026-02-22 00:00:00', 1, NULL, NULL),
(12, 15, 'Nilam Sari', '895415000000', 'Cilubang RT 003/004 Kel. Balumbang jaya kota Bogor Barat', 'Kakak', '2026-02-22 00:00:00', 1, '2026-02-22 00:00:00', 1, NULL, NULL),
(13, 16, 'Novi purwaningsih', '895339000000', 'Prumahan villa mutiara Bogor 2 blok B5 no.2', NULL, '2026-02-22 00:00:00', 1, '2026-02-22 00:00:00', 1, NULL, NULL),
(14, 17, 'Ida Herliza', '87818062004', 'Perumahan Bogor Raya Permai blok fd1 no4', 'Istri', '2026-02-22 00:00:00', 1, '2026-02-22 00:00:00', 1, NULL, NULL),
(15, 18, 'ANISA', '89649833786', 'KP CIDOKOM RT 02 RW 12 DESA KOPI KEC CISARUA', 'Kakak', '2026-02-22 00:00:00', 1, '2026-02-22 00:00:00', 1, NULL, NULL),
(16, 19, 'Sari mulyani', '85880301642', 'Ciherang hegarsari rt 003/001', 'Ibu', '2026-02-22 00:00:00', 1, '2026-02-22 00:00:00', 1, NULL, NULL),
(17, 20, 'HARRY SETIADI', '81703321786', 'Jerokutakaum RT 02/RW 16, No.5 Bondongan Bogor Selatan 16131', NULL, '2026-02-22 00:00:00', 1, '2026-02-22 00:00:00', 1, NULL, NULL),
(18, 22, 'Ibu', '85882361773', 'Jl ardio gg 1', 'Ibu', '2026-02-22 00:00:00', 1, '2026-02-22 00:00:00', 1, NULL, NULL),
(19, 23, 'Ehen juhendi', '85780234507', 'Kp. bungur rt 3 rw 5', 'Ayah', '2026-02-22 00:00:00', 1, '2026-02-22 00:00:00', 1, NULL, NULL),
(20, 10, 'Angga prasetya', '89514549885', 'DESA CIJUJUNG TENGAH RT2 RW4, KEC SUKARAJA KAB.BOGOR', 'Kakak', '2026-02-22 00:00:00', 1, '2026-02-22 00:00:00', 1, NULL, NULL),
(21, 17, 'Hilwa Salsabila Ahesa', NULL, 'Perumahan Bogor Raya Permai', 'Anak', '2026-02-22 00:00:00', 1, '2026-02-22 00:00:00', 1, NULL, NULL),
(22, 23, 'Ani', NULL, 'Kp. Bungur rt 3 rw 5', 'Ibu', '2026-02-22 00:00:00', 1, '2026-02-22 00:00:00', 1, NULL, NULL),
(23, 23, 'Sandy', NULL, 'Kp. Bungur rt 3 rw 5', 'Saudara kandung', '2026-02-22 00:00:00', 1, '2026-02-22 00:00:00', 1, NULL, NULL),
(24, 15, 'Fitra Fadillah', NULL, 'Kemayoran', 'Teman', '2026-02-22 00:00:00', 1, '2026-02-22 00:00:00', 1, NULL, NULL),
(25, 23, 'Galang', NULL, 'Kp. Bungur rt 3 rw 5', 'Saudara kandung', '2026-02-22 00:00:00', 1, '2026-02-22 00:00:00', 1, NULL, NULL),
(26, 23, 'Ani', NULL, 'Kp. Bungur rt 3 rw 5', 'Ibu', '2026-02-22 00:00:00', 1, '2026-02-22 00:00:00', 1, NULL, NULL),
(27, 24, 'Ike', '8126764520', 'Kebun Raya Residence Blok T. No 26', 'Ibu', '2026-02-22 00:00:00', 1, '2026-02-22 00:00:00', 1, NULL, NULL),
(28, 26, 'Yeye irma', '89627684497', 'Jln kapten Yusuf GG bebas RT 01 RW 08 kota batu Ciapus bogor', 'Istri', '2026-02-22 00:00:00', 1, '2026-02-22 00:00:00', 1, NULL, NULL),
(29, 27, 'NURTASIPA', '81289844190', 'KP.CIOMAS KABANDUNGAN RT.001/006 DESA SIRNAGALIH KEC.TAMANSARI KAB.BOGOR', NULL, '2026-02-22 00:00:00', 1, '2026-02-22 00:00:00', 1, NULL, NULL),
(30, 28, 'Irmawati', '81219849708', 'Kp cimanggu rt/rw 01/04', NULL, '2026-02-22 00:00:00', 1, '2026-02-22 00:00:00', 1, NULL, NULL),
(31, 29, 'Titin agustina', '85693191213', 'Kp.tajur rt01rw04 desa/Kel muarasari kec.bogor selatan kab/kota kota Bogor provinsi Jawa Barat 16137', NULL, '2026-02-22 00:00:00', 1, '2026-02-22 00:00:00', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `worker_experiences`
--

CREATE TABLE `worker_experiences` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `company_name` varchar(150) NOT NULL,
  `company_business` varchar(150) DEFAULT NULL,
  `job_title` varchar(100) DEFAULT NULL,
  `department` varchar(100) DEFAULT NULL,
  `location` varchar(150) DEFAULT NULL,
  `start_date` varchar(7) DEFAULT NULL,
  `end_date` varchar(7) DEFAULT NULL,
  `salary` decimal(15,2) DEFAULT NULL,
  `is_current` tinyint(1) DEFAULT 0,
  `supervisor_name` varchar(100) DEFAULT NULL,
  `reason_leaving` varchar(150) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `sort_order` int(1) DEFAULT 0,
  `created_at` datetime DEFAULT current_timestamp(),
  `created_by` int(1) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL ON UPDATE current_timestamp(),
  `updated_by` int(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `worker_experiences`
--

INSERT INTO `worker_experiences` (`id`, `user_id`, `company_name`, `company_business`, `job_title`, `department`, `location`, `start_date`, `end_date`, `salary`, `is_current`, `supervisor_name`, `reason_leaving`, `description`, `sort_order`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
(1, 2, 'The Sahira Hotel', 'Hotel', 'SPV \n', 'IT', 'Bogor, West Java', NULL, NULL, 5000000.00, 0, NULL, NULL, NULL, 0, '2026-02-21 08:30:46', 1, '2026-02-22 00:37:51', 1, NULL, NULL),
(2, 2, 'Chevilly Resort & Camp', 'Resort', 'Staff IT', 'IT', 'Bogor, West Java', '2021-01', '2024-12', 5200000.00, 0, 'Rivan Sulung Fitriadi', NULL, NULL, 0, '2026-02-21 08:30:46', 1, '2026-02-22 23:16:28', 1, NULL, NULL),
(3, 3, 'Sakura park hotel and residence', 'Hotel', NULL, NULL, 'Deltamas, Bekasi ', '2015-01', '2021-12', 5500000.00, 0, NULL, 'Habis kontrak', NULL, 0, '2026-02-21 08:30:46', 1, '2026-02-22 00:41:24', 1, NULL, NULL),
(4, 5, 'Aston Bogor', 'Hotel', 'Public Area Atd', NULL, 'Bogor Nirwana Residence', '2013-01', '2025-11', 6000000.00, 0, 'Abdul Rohman', 'Break Contract', NULL, 0, '2026-02-21 08:30:46', 1, '2026-02-22 23:14:58', 1, NULL, NULL),
(5, 5, 'Marriott Hotel', 'Hotel', 'Room atd', NULL, 'Mega kuninga, Jakarta', '2013-01', '2025-11', NULL, 0, 'Abdul Rohman', NULL, NULL, 0, '2026-02-21 08:30:46', 1, '2026-02-23 00:02:01', 1, NULL, NULL),
(6, 6, 'PT Thamrin Bulevard Aari', NULL, 'Senior sales Manager', NULL, 'Thamrin jakarta pusat', NULL, NULL, NULL, 0, 'Ridwan', NULL, NULL, 0, '2026-02-21 08:30:46', 1, '2026-02-23 00:02:03', 1, NULL, NULL),
(7, 6, 'Hotel Mega Anggrek', 'Hotel', 'Sales Manager', NULL, NULL, NULL, NULL, NULL, 0, 'Dona', NULL, NULL, 0, '2026-02-21 08:30:46', 1, '2026-02-23 00:02:04', 1, NULL, NULL),
(8, 7, 'Fotografi Universitas Gunadarma', NULL, 'Assisten Lab', NULL, 'Kampus G, Universitas Gunadarma, Jl. Akses UI, Kelapa Dua – Cimanggis', '2022', '2024', 1000000.00, 0, 'Yusuf', 'periode berakhir', NULL, 0, '2026-02-21 08:30:46', 1, '2026-02-23 00:02:06', 1, NULL, NULL),
(9, 7, 'Alan Creative', NULL, 'Social Media Specialist', NULL, 'Jl. Utama No.19, Tugu, Kec. Cimanggis, Kota Depok, Jawa Barat 16451, Depok City, West Java 11530', '2022', '2024', 1500000.00, 0, 'Ahmad Alimuddin', 'Tidak perpanjang kontrak', NULL, 0, '2026-02-21 08:30:46', 1, '2026-02-23 00:02:06', 1, NULL, NULL),
(10, 7, 'Cherise by Azzura', NULL, 'Social Media Specialist', NULL, 'no. 21 B, Jl. Raya Pajajaran No.16153, Bantarjati, Kec. Bogor Utara, Kota Bogor, Jawa Barat 16153', '2025', '2025', 2000000.00, 0, 'Haedir', 'Tidak perpanjang kontrak', NULL, 0, '2026-02-21 08:30:46', 1, '2026-02-23 00:02:06', 1, NULL, NULL),
(11, 10, 'MIMARU HOTEL JAKARTA', 'Hotel', 'Account Receivable', NULL, 'jl. Raya mangga besar No.144', '2024-11', '2025-10', 4200000.00, 0, 'Shariva ayuni', 'Karena jauh dari rumah', NULL, 0, '2026-02-21 08:30:00', 1, '2026-02-23 00:02:00', 1, NULL, NULL),
(12, 11, 'Samarta Swarga Antara', NULL, 'audit', NULL, 'lampung', '2022-01', '2025-12', NULL, 0, 'Ali Imran R.R.', 'mengundurkan diri', NULL, 0, '2026-02-21 08:30:00', 1, '2026-02-23 00:02:00', 1, NULL, NULL),
(13, 12, 'Allegra resto', 'Resto', 'Manager kitchen', NULL, 'Jl bali no 27 Gubeng suraaya', '2022-01', '2025-12', 8000000.00, 0, 'Bambang Cipto wijaya', 'Pindah yg Deket kampung halaman', NULL, 0, '2026-02-21 08:30:00', 1, '2026-02-23 00:02:00', 1, NULL, NULL),
(14, 13, 'The Sahira Hotel', 'Hotel', 'Room Attendant', NULL, 'Jl. A yani no.17-23', '2015-01', '2023-12', 4200000.00, 0, 'Andin', 'Mencoba suasana baru, pengalaman baru', NULL, 0, '2026-02-21 08:30:00', 1, '2026-02-23 00:02:00', 1, NULL, NULL),
(15, 14, 'PT GAIA Catering', NULL, 'Staff Engineering', NULL, 'Jl KH Ahmad Dahlan no 47 jakarta selatan', '2023-01', '2025-12', 8000000.00, 0, 'Hj Diane Crystalia', 'Resign', NULL, 0, '2026-02-21 08:30:00', 1, '2026-02-23 00:02:00', 1, NULL, NULL),
(16, 15, 'Hotel Neo+ Airport Jakarta', 'Hotel', 'Mechanical engineering', NULL, 'Tower PQR, Jl. Cengkareng Business City Jl. Atang Sanjaya No.21 Lot 5, Kota Tangerang, Banten 15125', '2025-04', '2025-11', 5700000.00, 0, 'Rizky Syahrizal', 'Resign pindah kerja', NULL, 0, '2026-02-21 08:30:00', 1, '2026-02-23 00:02:00', 1, NULL, NULL),
(17, 18, 'SANUBARI PT KREASI ALAM HAYATI', NULL, 'CHEF DE PARTIE', NULL, 'SARUA MAKMUR BLOK VI NO1 SARUA - CIPUTAT TANGERANG SELATAN', '2025-01', '2026-12', 4900000.00, 0, 'CHEF DUIE', 'KONTRAK HABIS', NULL, 0, '2026-02-21 08:30:00', 1, '2026-02-23 00:02:00', 1, NULL, NULL),
(18, 19, 'Adira tajur 1', NULL, 'Taller', NULL, 'Jl raya tajur', '2023-01', '2026-12', 11000000.00, 0, 'Yune siskayanti', 'Pindah sahira paledang', NULL, 0, '2026-02-21 08:30:00', 1, '2026-02-23 00:02:00', 1, NULL, NULL),
(19, 20, 'JAMBULUWUK RESORT & CONVENTION', 'Resort', 'sales executive', NULL, 'Jalan Raya Tapos No. 63, Ciawi, Bogor', '2022-01', '2025-12', 5800000.00, 0, 'Bp Cahyadi', 'MUST MOVE TO JAKARTA', NULL, 0, '2026-02-21 08:30:00', 1, '2026-02-23 00:02:00', 1, NULL, NULL),
(20, 23, 'Ftl gym pajajaran bogor', NULL, 'Marketing', NULL, 'Pajajaran bogor', '2025-04', '2025-09', 4300000.00, 0, 'Rizal', 'Pengembangan karir', NULL, 0, '2026-02-21 08:30:00', 1, '2026-02-23 00:02:00', 1, NULL, NULL),
(21, 9, 'Hotel Aston bogor', 'Hotel', 'Room attendant', NULL, 'Jl. Dreded No. 19, Bogor Nirwana Residence, Bogor, Jawa Barat 16132', NULL, NULL, 13000000.00, 0, NULL, 'Habis kontrak', NULL, 0, '2026-02-21 08:30:00', 1, '2026-02-23 00:02:00', 1, NULL, NULL),
(22, 10, 'Sahira butik hotel paledang', 'Hotel', 'Account payable & general cashier', NULL, 'Jl. Paledang No.53', NULL, NULL, 3800000.00, 0, 'Didik febriawan', 'Karena dapat pekerjaan di tempat baru', NULL, 0, '2026-02-21 08:30:00', 1, '2026-02-23 00:02:00', 1, NULL, NULL),
(23, 12, 'Newboss bar and resto', 'Resto', 'Head chef', NULL, 'Jl Ir Soekarno no 400,Kedung Baruk kec.rungkut Surabaya Jawa timur', NULL, NULL, 7000000.00, 0, 'Therry andreas', 'Tutup', NULL, 0, '2026-02-21 08:30:00', 1, '2026-02-23 00:02:00', 1, NULL, NULL),
(24, 13, 'Asta Management Grouo', NULL, 'Sales executive', NULL, 'Jl. Padjadjaran no 21', NULL, NULL, 6000000.00, 0, 'Prabu Nur Adam', NULL, NULL, 0, '2026-02-21 08:30:00', 1, '2026-02-23 00:02:00', 1, NULL, NULL),
(25, 14, 'Sahira Butik Hotel', 'Hotel', 'Staff Engineering', NULL, 'Jl Paledang 53', NULL, NULL, 7000000.00, 0, 'H. Saleh saaf', 'Resign', NULL, 0, '2026-02-21 08:30:00', 1, '2026-02-23 00:02:00', 1, NULL, NULL),
(26, 15, 'Hotel Cluster Ibisstyles & Ibis budget jakarta airport', 'Hotel', 'Technician Staff', NULL, 'Jl. Raya Bandara Soekarno-Hatta, Benda, Kec. Benda, Kota Tangerang, Banten 15125', NULL, NULL, 5000000.00, 0, 'Feri Fajri', 'Resign pindah kerja', NULL, 0, '2026-02-21 08:30:00', 1, '2026-02-23 00:02:00', 1, NULL, NULL),
(27, 17, 'PT. Saung Dolken Group', NULL, 'General Manager Group', NULL, NULL, NULL, NULL, NULL, 0, NULL, NULL, NULL, 0, '2026-02-21 08:30:00', 1, '2026-02-23 00:02:00', 1, NULL, NULL),
(28, 18, 'JEP SETATION INDOESIA', NULL, 'DAILYWORKER', NULL, 'PASIR MUNCANG KEC MEGAMENDUNG NO 5', NULL, NULL, 4800000.00, 0, 'YUSUF TAUJRI', 'KONTRAK HABIS', NULL, 0, '2026-02-21 08:30:00', 1, '2026-02-23 00:02:00', 1, NULL, NULL),
(29, 23, 'Colorbox', NULL, 'Sales associate', NULL, 'Aeon sentul', NULL, NULL, 4800000.00, 0, 'Rega', 'Terlalu jauh dari rumah', NULL, 0, '2026-02-21 08:30:00', 1, '2026-02-23 00:02:00', 1, NULL, NULL),
(30, 9, 'Marriot jakarta', 'Hotel', 'Room attendant', NULL, 'Jalan DR Ide Anak Agung Gde Agung Kav E.1.2 No 1&2, Kawasan Mega Kuningan, Jakarta Selatan, 12950', NULL, '2008-01', NULL, 0, NULL, NULL, NULL, 0, '2026-02-21 08:30:00', 1, '2026-02-23 00:02:00', 1, NULL, NULL),
(31, 12, 'Hotel lotus subang', 'Hotel', 'Head chef', NULL, 'Jl letjent suprapto No.31,Cigadung,kec.subang,kab.subang Jawa barat', '2015-01', '2017-12', 5000000.00, 0, 'Bu Vina', 'Pindah ke surabaya', NULL, 0, '2026-02-21 08:30:00', 1, '2026-02-23 00:02:00', 1, NULL, NULL),
(32, 15, 'Ibisstyles Jakarta Tanah Abang', 'Hotel', 'Engineering staff', NULL, 'Jl. H. Fachrudin No.22, Kp. Bali, Jakarta Pusat 10250', '2019-08', '2020-05', 5000000.00, 0, 'Bayu C Prasetyo', 'Pandemic Covid 19', NULL, 0, '2026-02-21 08:30:00', 1, '2026-02-23 00:02:00', 1, NULL, NULL),
(33, 23, 'Matahari department store', NULL, 'Sales associate', NULL, 'Aeon deltamas cikarang', NULL, NULL, 5200000.00, 0, 'Oky', 'Cari kerja daerah bogor', NULL, 0, '2026-02-21 08:30:00', 1, '2026-02-23 00:02:00', 1, NULL, NULL),
(34, 24, 'PT Pegadaian Internship', NULL, 'Marketing', NULL, 'Jl. Jenderal Sudirman No. 299, Purwokerto.', NULL, NULL, 2000000.00, 0, 'Irma', 'Kontrak Magang Selesai', NULL, 0, '2026-02-21 08:30:00', 1, '2026-02-23 00:02:00', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `worker_language`
--

CREATE TABLE `worker_language` (
  `id` int(1) NOT NULL,
  `user_id` int(1) NOT NULL,
  `language` varchar(50) DEFAULT NULL,
  `hearing` varchar(50) DEFAULT NULL,
  `reading` varchar(50) DEFAULT NULL,
  `speaking` varchar(50) DEFAULT NULL,
  `writing` varchar(50) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `created_by` int(1) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `worker_language`
--

INSERT INTO `worker_language` (`id`, `user_id`, `language`, `hearing`, `reading`, `speaking`, `writing`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
(1, 3, 'Bahasa Inggris', 'Good', 'Good', 'Good', 'Good', '2026-02-22 00:00:00', 1, '2026-02-22 00:00:00', 1, NULL, NULL),
(2, 5, 'Bahasa Inggris', 'Good', 'Good', 'Good', 'Good', '2026-02-22 00:00:00', 1, '2026-02-22 00:00:00', 1, NULL, NULL),
(3, 6, 'Bahasa Inggris', 'Good', 'Good', 'Good', 'Good', '2026-02-22 00:00:00', 1, '2026-02-22 00:00:00', 1, NULL, NULL),
(4, 7, 'Bahasa Inggris', 'Good', 'Good', 'Good', 'Good', '2026-02-22 00:00:00', 1, '2026-02-22 00:00:00', 1, NULL, NULL),
(5, 9, 'Bahasa Inggris', 'Good', 'Good', 'Good', 'Good', '2026-02-22 00:00:00', 1, '2026-02-22 00:00:00', 1, NULL, NULL),
(6, 10, 'Bahasa Inggris', 'Good', 'Good', 'Good', 'Good', '2026-02-22 00:00:00', 1, '2026-02-22 00:00:00', 1, NULL, NULL),
(7, 11, 'Bahasa Inggris', 'Good', 'Good', 'Good', NULL, '2026-02-22 00:00:00', 1, '2026-02-22 00:00:00', 1, NULL, NULL),
(8, 12, 'Mandarin', 'Poor', NULL, 'Poor', NULL, '2026-02-22 00:00:00', 1, '2026-02-22 00:00:00', 1, NULL, NULL),
(9, 13, 'Bahasa Inggris', 'Good', 'Good', 'Good', 'Good', '2026-02-22 00:00:00', 1, '2026-02-22 00:00:00', 1, NULL, NULL),
(10, 15, 'Bahasa Inggris', 'Poor', 'Poor', 'Poor', 'Poor', '2026-02-22 00:00:00', 1, '2026-02-22 00:00:00', 1, NULL, NULL),
(11, 17, 'Bahasa Inggris', 'Good', 'Good', 'Excelent', 'Excelent', '2026-02-22 00:00:00', 1, '2026-02-22 00:00:00', 1, NULL, NULL),
(12, 18, 'Bahasa Inggris', 'Good', 'Good', 'Good', 'Poor', '2026-02-22 00:00:00', 1, '2026-02-22 00:00:00', 1, NULL, NULL),
(13, 19, 'Bahasa Inggris', 'Good', 'Good', 'Good', 'Good', '2026-02-22 00:00:00', 1, '2026-02-22 00:00:00', 1, NULL, NULL),
(14, 20, 'Bahasa Inggris', 'Good', 'Good', 'Good', 'Good', '2026-02-22 00:00:00', 1, '2026-02-22 00:00:00', 1, NULL, NULL),
(15, 23, 'Bahasa Inggris', 'Poor', 'Good', 'Poor', 'Poor', '2026-02-22 00:00:00', 1, '2026-02-22 00:00:00', 1, NULL, NULL),
(16, 24, 'Bahasa Inggris', 'Excelent', 'Excelent', 'Good', 'Excelent', '2026-02-22 00:00:00', 1, '2026-02-22 00:00:00', 1, NULL, NULL),
(17, 25, 'Bahasa Inggris', 'Good', 'Excelent', 'Excelent', 'Excelent', '2026-02-22 00:00:00', 1, '2026-02-22 00:00:00', 1, NULL, NULL),
(18, 28, 'Bahasa Inggris', 'Poor', 'Poor', 'Poor', 'Poor', '2026-02-22 00:00:00', 1, '2026-02-22 00:00:00', 1, NULL, NULL),
(19, 29, 'Bahasa Inggris', 'Good', 'Good', 'Good', 'Good', '2026-02-22 00:00:00', 1, '2026-02-22 00:00:00', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `worker_links`
--

CREATE TABLE `worker_links` (
  `id` int(1) NOT NULL,
  `user_id` int(1) NOT NULL,
  `name` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `url` varchar(250) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` int(1) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `worker_parents`
--

CREATE TABLE `worker_parents` (
  `id` int(1) NOT NULL,
  `user_id` int(1) NOT NULL,
  `fathers_name` varchar(100) DEFAULT NULL,
  `fathers_birth_place` varchar(50) DEFAULT NULL,
  `fathers_birth_date` date DEFAULT NULL,
  `fathers_edu` varchar(20) DEFAULT NULL,
  `fathers_job` varchar(100) DEFAULT NULL,
  `mothers_name` varchar(100) DEFAULT NULL,
  `mothers_birth_place` varchar(50) DEFAULT NULL,
  `mothers_birth_date` date DEFAULT NULL,
  `mothers_edu` varchar(20) DEFAULT NULL,
  `mothers_job` varchar(100) DEFAULT NULL,
  `address_parents` text DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `created_by` int(1) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `worker_parents`
--

INSERT INTO `worker_parents` (`id`, `user_id`, `fathers_name`, `fathers_birth_place`, `fathers_birth_date`, `fathers_edu`, `fathers_job`, `mothers_name`, `mothers_birth_place`, `mothers_birth_date`, `mothers_edu`, `mothers_job`, `address_parents`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
(1, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Kp. Cibolang RT/RW 01/05 Desa Banjarwangi, kecamatan Ciawi, Kabupaten Bogor 16720', '2026-02-21 10:05:18', 1, '2026-02-21 10:06:04', 1, NULL, NULL),
(2, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Jl.didi prawira Kusumah kab Cianjur 43215', '2026-02-22 00:09:05', 1, '2026-02-22 00:09:05', 1, NULL, NULL),
(3, 4, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Pulogebang permai Jakarta Timur', '2026-02-22 00:09:05', 1, '2026-02-22 00:09:05', 1, NULL, NULL),
(4, 5, 'Djuli Saebi', 'Bogor', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Jl.Golf Rt 004/008 Ciriung Cibinong', '2026-02-22 00:09:05', 1, '2026-02-22 00:09:05', 1, NULL, NULL),
(5, 6, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Jl baung no 37 rt04 rw 02 kebagusan pasar minggu jakarta selatan', '2026-02-22 00:09:05', 1, '2026-02-22 00:09:05', 1, NULL, NULL),
(6, 7, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Kebun Raya Residence blok v no 11, Kabupaten Bogor, Kecamatan Ciomas, Desa Mekarjaya, 16610', '2026-02-22 00:09:05', 1, '2026-02-22 00:09:05', 1, NULL, NULL),
(7, 8, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Ambon', '2026-02-22 00:09:00', 1, '2026-02-22 00:09:00', 1, NULL, NULL),
(8, 9, 'Atang supriatna', 'Bogor', '1970-11-25', 'S1', 'Pns', 'Pipih alpiah', 'Bogor', '1972-04-16', 'SMA', 'IRT', 'Jalan pabuaran tengah rt 04/rw06 kelurahan paledang kecamatan bogor selatan kota bogor 16135', '2026-02-22 00:09:00', 1, '2026-02-22 00:09:00', 1, NULL, NULL),
(9, 10, 'Hasanuddin', 'Bogor', NULL, NULL, NULL, 'Rika Purnama', NULL, NULL, NULL, NULL, 'DESA CIJUJUNG TENGAH RT2 RW4, KEC SUKARAJA KAB.BOGOR', '2026-02-22 00:09:00', 1, '2026-02-22 00:09:00', 1, NULL, NULL),
(10, 11, 'M. Djai S.', 'Kupang', '1941-12-24', 'SMA', 'Pensiunan Pegawai Negeri', 'Djuminah', 'Semarang', '1936-06-24', 'SMA', 'IRT', 'depok', '2026-02-22 00:09:00', 1, '2026-02-22 00:09:00', 1, NULL, NULL),
(11, 12, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Banjarnegara desa karangsalam rt04/04 kec.susukan kab.banjar negara Jawa tengah', '2026-02-22 00:09:00', 1, '2026-02-22 00:09:00', 1, NULL, NULL),
(12, 13, 'Achmad gunadi', 'Palangkaraya', '1973-11-27', 'D3', 'Tdk bekerja', 'Nurleni', 'Bogor', '1976-05-13', 'Slta', 'IRT', 'Jl. A Yani 2 no.13 rt 06/04', '2026-02-22 00:09:00', 1, '2026-02-22 00:09:00', 1, NULL, NULL),
(13, 14, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Kp Lanjung RT 003 RW 003 Sukajadi Karang Tengah Cianjur 43281', '2026-02-22 00:09:00', 1, '2026-02-22 00:09:00', 1, NULL, NULL),
(14, 15, 'Saniih', 'Bogor', '1964-09-20', 'SMA', 'Wirausaha', 'Rohana ', 'Bogor', '1969-03-07', 'SMA', 'IRT', 'Cilubang RT 003/004 Kel. Balumbang jaya kota Bogor Barat. 16116', '2026-02-22 00:09:00', 1, '2026-02-22 00:09:00', 1, NULL, NULL),
(15, 16, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Jalan kampung tanah koja 2 RT 04 RW 02 no.2 kelurahan Jatinegara kaum kec pulogadung', '2026-02-22 00:09:00', 1, '2026-02-22 00:09:00', 1, NULL, NULL),
(16, 17, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Perumahan Green Garden Jakarta Utara', '2026-02-22 00:09:00', 1, '2026-02-22 00:09:00', 1, NULL, NULL),
(17, 18, 'DEPE SUARDI', NULL, NULL, 'SD', 'BURUH', 'EEM', NULL, NULL, 'SD', 'IRT', 'kp anyar rt 02 rw 12 desa kopo kec cisarua', '2026-02-22 00:09:00', 1, '2026-02-22 00:09:00', 1, NULL, NULL),
(18, 19, 'Munandar', 'Bogor', '1972-05-02', 'SMA / SGO', 'Wiraswasta', 'Sari mulyani', 'Bogor', '1977-02-20', 'SMA', 'IRT', 'Ciherang hegarsari rt 003/001', '2026-02-22 00:09:00', 1, '2026-02-22 00:09:00', 1, NULL, NULL),
(19, 20, 'HASAN SONNEVILLE', 'BOGOR', '1945-07-15', 'S1', 'HR CORP SWASTA', 'SUMARYATUN', 'BOGOR', NULL, 'SMA', 'IRT', 'Jerokutakaum RT 02/RW 16, No.5 Bondongan Bogor Selatan 16131', '2026-02-22 00:09:00', 1, '2026-02-22 00:09:00', 1, NULL, NULL),
(20, 21, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Jl. Sawahpulo 45', '2026-02-22 00:09:00', 1, '2026-02-22 00:09:00', 1, NULL, NULL),
(21, 22, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 'Jl ardio gg 1', '2026-02-22 00:09:00', 1, '2026-02-22 00:09:00', 1, NULL, NULL),
(22, 23, 'Ehen juhendi', NULL, NULL, NULL, 'Wiraswasta', 'Ani anggraeni', NULL, NULL, NULL, 'IRT', 'Kp. Bungur rt 3 rw 5, desa tajur halang, kecamatan cijeruk, kabupaten bogor', '2026-02-22 00:09:00', 1, '2026-02-22 00:09:00', 1, NULL, NULL),
(23, 24, 'Alm. Akhmad Hanifudin', 'Purwokerto', '1968-02-23', 'S1', 'Pegawai BUMN (Pensiun)', 'Ike Wilawati', 'Pematang Siantar', '1971-08-12', 'S1', 'Ibu Rumah Tangga', 'Kebun Raya Residence Blok T No.26 004/009, kel Pasir Kuda, Bogor Barat. 16119.', '2026-02-22 00:09:00', 1, '2026-02-22 00:09:00', 1, NULL, NULL),
(24, 26, 'Dasta Sasmita', 'Bogor', NULL, 'SMA', NULL, 'Diah', 'Bogor', NULL, 'SMA', NULL, 'Kota batu rt01 rw08 desa kota batu kec Ciomas Bogor 16610', '2026-02-22 00:09:00', 1, '2026-02-22 00:09:00', 1, NULL, NULL),
(25, 27, 'ALM.BPK.SAMIN', 'Bogor', NULL, 'SMA', NULL, 'ALM.IBU ICIH', 'Bogor', '1948-05-04', NULL, NULL, 'Kp.Ciomas Kabandungan Rt.003/007 Desa Sirnagalih Kec.Tamansari Kab.Bogor Kode Pos 16610', '2026-02-22 00:09:00', 1, '2026-02-22 00:09:00', 1, NULL, NULL),
(26, 28, 'Acep', 'Bogor', '1954-01-22', 'SMP', 'Wirasuasta', 'Rohayeh', 'Bogor', '1960-03-07', 'SMP', 'Ibu rumah tangga', 'Kp ciampea  rt/rw 005/006', '2026-02-22 00:09:00', 1, '2026-02-22 00:09:00', 1, NULL, NULL),
(27, 29, 'Bambang cahyono ', 'Ciamis ', NULL, 'SMP', NULL, 'Wiwin nurliah', 'Ciamis', '1965-01-16', 'SMP', 'Ibu rumah tangga', 'Kp tajur rt01rw04 desa/Kel muarasari kec.bogor selatan kab/kota kota Bogor provinsi Jawa Barat 16137', '2026-02-22 00:09:00', 1, '2026-02-22 00:09:00', 1, NULL, NULL),
(28, 30, NULL, NULL, NULL, NULL, NULL, 'Nanah maryanah', 'Bogor', NULL, NULL, NULL, 'Jln A yani Gg sapin Rt 03 Rw 02 Tanah sareal Bogor 16161', '2026-02-22 00:09:00', 1, '2026-02-22 00:09:00', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `worker_profiles`
--

CREATE TABLE `worker_profiles` (
  `id` int(1) NOT NULL,
  `user_id` int(1) NOT NULL,
  `gender` enum('male','female') CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `birth_place` varchar(50) DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `address` text CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `staffing_level` int(1) DEFAULT NULL,
  `religion` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `no_ktp` varchar(50) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `blood_type` varchar(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `citizenship` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `hobby` varchar(250) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `marital_status` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `bio` text CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` int(1) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `worker_profiles`
--

INSERT INTO `worker_profiles` (`id`, `user_id`, `gender`, `birth_place`, `birth_date`, `address`, `staffing_level`, `religion`, `no_ktp`, `blood_type`, `citizenship`, `hobby`, `marital_status`, `bio`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
(1, 2, 'male', 'Bogor', '2019-12-13', 'Kp. Cibolang RT/RW 01/05 Desa Banjarwangi, kecamatan Ciawi, Kabupaten Bogor \r\n16720', 5, 'Islam', '13249507000859 (SIM)', NULL, 'Indonesia', 'Futsal dan sepak bola \n', 'Menikah', NULL, '2026-02-21 08:41:24', 1, '2026-02-21 08:41:24', 1, NULL, NULL),
(2, 3, 'male', 'Bogor', '2000-08-05', 'Jl.kh Abdul saleh cemplang kab.bogor 16630', 1, 'Islam', '3203071509950006', 'AB', 'Indonesia', 'Bermain musik metal dan vokal scream', 'Menikah', NULL, '2026-02-22 00:08:32', 1, '2026-02-22 00:08:44', 1, NULL, NULL),
(3, 4, 'male', 'Jakarta', '1978-04-09', 'Mess Sahira Hotel Paledang', 7, 'Islam', '3175060704780007', 'AB', 'Indonesia', 'Olahraga', 'Duda', NULL, '2026-02-22 22:22:45', 1, '2026-02-22 22:22:45', 1, NULL, NULL),
(4, 5, 'male', NULL, NULL, 'Jl.Cibeureum Sunting no.14 Mulyaharja-Bogor Selatan', 7, 'Kong Hu Chu', '3201013011920003', 'B', 'Indonesia', 'Berkebun', 'Menikah', NULL, '2026-02-22 22:22:45', 1, '2026-02-22 22:22:45', 1, NULL, NULL),
(5, 6, 'female', 'Purbalingga', '1977-01-24', 'Jl baung no 37 rt 04 rw 02 kebagusan pasar minggu jakarta selatan', 7, 'Islam', '3175036404770009', 'O', 'Indonesia', 'Traveling', 'Janda', NULL, '2026-02-22 22:22:45', 1, '2026-02-22 22:22:45', 1, NULL, NULL),
(6, 7, 'male', NULL, NULL, 'Kebun Raya Residence blok v no 11, Kabupaten Bogor, Kecamatan Ciomas, Desa Mekarjaya, 16610', 5, 'Islam', '3201290609010000', 'A', 'Indonesia', 'Badminton, ngedit, voice over or dubbing', 'Belum Menikah', NULL, '2026-02-22 22:22:45', 1, '2026-02-22 22:22:45', 1, NULL, NULL),
(7, 8, 'male', NULL, NULL, 'Lenteng agung 12610', 4, 'Protestan', '3174100506860003', 'O', 'Indonesia', 'Football', 'Menikah', NULL, '2026-02-22 22:22:00', 1, '2026-02-22 22:22:00', 1, NULL, NULL),
(8, 9, 'male', NULL, NULL, 'Jalan pabuaran tengah rt 04/rw06 kelurahan paledang kecamatan bogor selatan kota bogor 16135', 5, 'Islam', '3271032906890007', 'O', 'Indonesia', 'Sepak bola', 'Menikah', NULL, '2026-02-22 22:22:00', 1, '2026-02-22 22:22:00', 1, NULL, NULL),
(9, 10, 'female', NULL, NULL, 'DESA CIJUJUNG TENGAH RT2 RW4, KEC SUKARAJA KAB.BOGOR', 5, 'Islam', '3201045807980002', 'O', 'Indonesia', 'Tidur, liburan', 'Menikah', NULL, '2026-02-22 22:22:00', 1, '2026-02-22 22:22:00', 1, NULL, NULL),
(10, 11, 'male', NULL, '1974-02-24', 'jl. anggrek V atas No.33 RT06 RW05 Benda Baru, Pamulang - TangSel', 7, 'Islam', '3674062402740004', 'O', 'Indonesia', 'Futsal', 'Menikah', NULL, '2026-02-22 22:22:00', 1, '2026-02-22 22:22:00', 1, NULL, NULL),
(11, 12, 'male', 'Banjarnegara', '1983-03-04', 'Jl gedung neros RT 02/07 kel.palefang kec.bojong neros Bogor jawabarat', 7, 'Islam', '3304010401830000', 'AB', 'Indonesia', 'Bersepeda', 'Menikah', NULL, '2026-02-22 22:22:00', 1, '2026-02-22 22:22:00', 1, NULL, NULL),
(12, 13, 'male', NULL, NULL, 'Jl. A Yani 2 no.13 rt 06/04', 7, 'Islam', '3271060802970011', 'AB', 'Indonesia', NULL, 'Menikah', NULL, '2026-02-22 22:22:00', 1, '2026-02-22 22:22:00', 1, NULL, NULL),
(13, 14, 'male', NULL, NULL, 'Jl Paledang no 53 Bogor Tengah kota Bogor 16122', 2, 'Islam', '3203070804760005', 'A', 'Indonesia', 'Berkarya', 'Menikah', NULL, '2026-02-22 22:22:00', 1, '2026-02-22 22:22:00', 1, NULL, NULL),
(14, 15, 'male', NULL, NULL, 'Cilubang RT 003/004 kel.balumbang jaya . Kota Bogor Barat 16116', 2, 'Islam', '3271040403970009', 'O', 'Indonesia', 'Hiking, Futsal', 'Belum Menikah', NULL, '2026-02-22 22:22:00', 1, '2026-02-22 22:22:00', 1, NULL, NULL),
(15, 16, 'male', NULL, NULL, 'Perumahan villa mutiara Bogor 2 blok 5 no 2', 7, 'Islam', '3175021708860016', 'A', 'Indonesia', 'Sepak bola', 'Menikah', NULL, '2026-02-22 22:22:00', 1, '2026-02-22 22:22:00', 1, NULL, NULL),
(16, 17, 'male', 'Jakarta', '1974-12-03', 'Perumahan Bogor Raya Permai blok FD1 No4', 7, 'Islam', '3172040312740000', 'A', 'Indonesia', 'Riding Motorcycle, Skirmish/Airsoft, Traveling', 'Menikah', NULL, '2026-02-22 22:22:00', 1, '2026-02-22 22:22:00', 1, NULL, NULL),
(17, 18, 'male', NULL, NULL, 'kp anyar RT 02 RW 12 DESA KOPO KEC CISARUA KAB BOGOR', 5, 'Islam', '3201252309020001', 'O', 'Indonesia', 'BADMINTON', 'Belum Menikah', NULL, '2026-02-22 22:22:00', 1, '2026-02-22 22:22:00', 1, NULL, NULL),
(18, 19, 'female', 'Bogor', '1998-01-27', 'Ciherang hegarsari rt 003/001', 5, 'Islam', '3201306701980000', 'B', 'Indonesia', 'Hunting food, travelling, movie time', 'Janda', NULL, '2026-02-22 22:22:00', 1, '2026-02-22 22:22:00', 1, NULL, NULL),
(19, 20, 'female', 'Bogor', '1989-09-19', 'Jerokutakaum RT 02/RW 16, No.5 Bondongan Bogor Selatan 16131', 6, 'Islam', '3271015909890010', 'AB', 'Indonesia', 'YOGA & TRAVELLING', 'Menikah', NULL, '2026-02-22 22:22:00', 1, '2026-02-22 22:22:00', 1, NULL, NULL),
(20, 21, 'male', 'JEMBER', '1997-05-21', 'Jl. Paledang 5', 2, 'Islam', '3509172105970000', 'A', 'Indonesia', 'Sepakbola', 'Menikah', NULL, '2026-02-22 22:22:00', 1, '2026-02-22 22:22:00', 1, NULL, NULL),
(21, 22, 'female', 'Bogor', '1990-06-13', 'Pwrumahan nuansa indah ciomas blokc4 no2', 6, 'Islam', '3271035306900000', 'O', 'Indonesia', 'Baking kue', 'Janda', NULL, '2026-02-22 22:22:00', 1, '2026-02-22 22:22:00', 1, NULL, NULL),
(22, 23, 'female', 'Bogor', '2003-12-02', 'Kp. Bungur rt 3 rw 5, desa tajur halang, kecamatan cijeruk, kabupaten bogor', 2, 'Islam', '3271035212030000', 'B', 'Indonesia', 'Renang, menulis', 'Belum Menikah', NULL, '2026-02-22 22:22:00', 1, '2026-02-22 22:22:00', 1, NULL, NULL),
(23, 24, 'male', 'Pekanbaru', '2002-03-07', 'Kebun Raya Residence Blok T No.26 004/009, kel Pasir Kuda, Bogor Barat. 16119.', 1, 'Islam', '1471090000000000', 'AB', 'Indonesia', 'Badminton', 'Belum Menikah', NULL, '2026-02-22 22:22:00', 1, '2026-02-22 22:22:00', 1, NULL, NULL),
(24, 25, 'female', 'Jakarta', '2005-05-23', 'Perumahan Bogor Raya Permain blok FD1 No4', 1, 'Islam', '3172050000000000', 'A', 'Indonesia', 'melukis, membaca buku, travelling', 'Belum Menikah', NULL, '2026-02-22 22:22:00', 1, '2026-02-22 22:22:00', 1, NULL, NULL),
(25, 26, 'male', NULL, NULL, 'Kota batu rt01 rw08 desa kota batu kecamatan Ciomas kab Bogor 16610', NULL, 'Islam', '3201290606810005', 'AB', 'Indonesia', NULL, 'Menikah', NULL, '2026-02-22 22:22:00', 1, '2026-02-22 22:22:00', 1, NULL, NULL),
(26, 27, 'male', NULL, NULL, 'Kp.Ciomas Kabandungan Rt.003/007 Desa.Sirnagalih Kec.Tamansari Kab.Bogor Kode Pos 16610', NULL, 'Islam', '3201311802830003', 'O', 'Indonesia', NULL, 'Menikah', NULL, '2026-02-22 22:22:00', 1, '2026-02-22 22:22:00', 1, NULL, NULL),
(27, 28, 'male', NULL, NULL, 'Kp sindang pala rt/rw 003/005', NULL, 'Islam', '3201152211880003', 'O', 'Indonesia', 'Bola dan lari', 'Menikah', NULL, '2026-02-22 22:22:00', 1, '2026-02-22 22:22:00', 1, NULL, NULL),
(28, 29, 'male', NULL, NULL, 'Kp.tajur rt01rw04 desa/Kel muarasari kec.bogor selatan kab/kota kota Bogor provinsi Jawa Barat 16137', NULL, 'Islam', '3271012805850006', 'A', 'Indonesia', 'Mancing dan lari', 'Menikah', NULL, '2026-02-22 22:22:00', 1, '2026-02-22 22:22:00', 1, NULL, NULL),
(29, 30, 'male', NULL, NULL, 'Jln A yani Gg sapin Rt 03 Rw 02 Tanah sareal Bogor kp 16161', NULL, 'Islam', '327106251076003', 'O', 'Indonesia', 'Maen Bola', 'Menikah', NULL, '2026-02-22 22:22:00', 1, '2026-02-22 22:22:00', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `worker_ratings`
--

CREATE TABLE `worker_ratings` (
  `id` int(1) NOT NULL,
  `user_id` int(1) DEFAULT NULL,
  `job_id` int(1) NOT NULL,
  `comments` varchar(255) NOT NULL,
  `punctuality` int(1) NOT NULL,
  `apperance` int(1) NOT NULL,
  `knowledge` int(1) NOT NULL,
  `durability` int(1) NOT NULL,
  `ethics` int(1) NOT NULL,
  `date` date DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `created_by` int(1) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `worker_ratings`
--

INSERT INTO `worker_ratings` (`id`, `user_id`, `job_id`, `comments`, `punctuality`, `apperance`, `knowledge`, `durability`, `ethics`, `date`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
(1, 29, 23, 'GOOD', 5, 5, 5, 5, 5, '2026-02-24', '2026-02-25 17:56:49', 4, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `worker_reviews`
--

CREATE TABLE `worker_reviews` (
  `id` int(1) NOT NULL,
  `user_id` int(1) DEFAULT NULL,
  `comments` int(1) NOT NULL,
  `stars` int(1) DEFAULT NULL,
  `created_at` datetime NOT NULL,
  `created_by` int(1) NOT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `worker_sibling`
--

CREATE TABLE `worker_sibling` (
  `id` int(11) NOT NULL,
  `user_id` int(1) NOT NULL,
  `name` varchar(100) NOT NULL,
  `sibling_order` int(1) DEFAULT NULL,
  `gender` enum('male','female') NOT NULL,
  `birth_place` varchar(100) DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `educations` varchar(20) DEFAULT NULL,
  `jobs` varchar(50) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` int(1) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `worker_sibling`
--

INSERT INTO `worker_sibling` (`id`, `user_id`, `name`, `sibling_order`, `gender`, `birth_place`, `birth_date`, `educations`, `jobs`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
(1, 24, 'Andika Falah Himawan', 1, 'male', 'Pekanbaru', '1997-09-16', 'S1', 'PNS', '2026-02-23 23:13:46', 1, '2026-02-23 23:13:46', 1, NULL, NULL),
(2, 24, 'Dwi Ananda Rizqullah', 2, 'male', 'Pekanbaru', '2000-01-15', 'S1', 'Pegawai BUMN', '2026-02-23 23:13:46', 1, '2026-02-23 23:13:46', 1, NULL, NULL),
(3, 24, 'Faishal Tri Aditama', 3, 'male', 'Pekanbaru', '2002-03-07', 'S1', 'Karyawan Swasta', '2026-02-23 23:13:46', 1, '2026-02-23 23:13:46', 1, NULL, NULL),
(4, 24, 'Rafie Nugraha Al Hanif', 4, 'male', 'Pekanbaru', '2010-06-10', 'SMP', 'Pelajar', '2026-02-23 23:13:46', 1, '2026-02-23 23:13:46', 1, NULL, NULL),
(5, 28, 'Ade diana', 1, 'female', 'Bogor', '1983-09-10', 'SMA', 'Ibu rumah tangga', '2026-02-23 23:13:46', 1, '2026-02-23 23:13:46', 1, NULL, NULL),
(6, 28, 'Irwa wati', 2, 'female', 'Bogor', '1986-04-02', 'SMA', 'Ibu rumah tangga', '2026-02-23 23:13:46', 1, '2026-02-23 23:13:46', 1, NULL, NULL),
(7, 28, 'Jarkasih', 3, 'male', 'Bogor', '1988-11-22', 'SMA', 'Karyawan swasta', '2026-02-23 23:13:46', 1, '2026-02-23 23:13:46', 1, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `worker_skills`
--

CREATE TABLE `worker_skills` (
  `id` int(1) NOT NULL,
  `user_id` int(1) NOT NULL,
  `skill_id` int(1) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` int(1) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `worker_skills`
--

INSERT INTO `worker_skills` (`id`, `user_id`, `skill_id`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
(1, 2, 44, '2026-02-21 08:44:09', 1, '2026-02-21 08:44:09', 1, NULL, NULL),
(2, 3, 9, '2026-02-21 08:44:09', 1, '2026-02-21 08:44:09', 1, NULL, NULL),
(3, 4, 43, '2026-02-21 08:44:09', 1, '2026-02-21 08:44:09', 1, NULL, NULL),
(4, 5, 8, '2026-02-21 08:44:09', 1, '2026-02-21 08:44:09', 1, NULL, NULL),
(5, 6, 48, '2026-02-21 08:44:09', 1, '2026-02-21 08:44:09', 1, NULL, NULL),
(6, 7, 46, '2026-02-21 08:44:00', 1, '2026-02-21 08:44:00', 1, NULL, NULL),
(7, 8, 47, '2026-02-21 08:44:00', 1, '2026-02-21 08:44:00', 1, NULL, NULL),
(8, 9, 8, '2026-02-21 08:44:00', 1, '2026-02-21 08:44:00', 1, NULL, NULL),
(9, 10, 38, '2026-02-21 08:44:00', 1, '2026-02-21 08:44:00', 1, NULL, NULL),
(10, 11, 54, '2026-02-21 08:44:00', 1, '2026-02-21 08:44:00', 1, NULL, NULL),
(11, 12, 24, '2026-02-21 08:44:00', 1, '2026-02-21 08:44:00', 1, NULL, NULL),
(13, 14, 28, '2026-02-21 08:44:00', 1, '2026-02-21 08:44:00', 1, NULL, NULL),
(14, 15, 28, '2026-02-21 08:44:00', 1, '2026-02-21 08:44:00', 1, NULL, NULL),
(15, 16, 49, '2026-02-21 08:44:00', 1, '2026-02-21 08:44:00', 1, NULL, NULL),
(16, 17, 50, '2026-02-21 08:44:00', 1, '2026-02-21 08:44:00', 1, NULL, NULL),
(17, 18, 22, '2026-02-21 08:44:00', 1, '2026-02-21 08:44:00', 1, NULL, NULL),
(18, 19, 34, '2026-02-21 08:44:00', 1, '2026-02-21 08:44:00', 1, NULL, NULL),
(19, 20, 51, '2026-02-21 08:44:00', 1, '2026-02-21 08:44:00', 1, NULL, NULL),
(20, 21, 21, '2026-02-21 08:44:00', 1, '2026-02-21 08:44:00', 1, NULL, NULL),
(21, 22, 35, '2026-02-21 08:44:00', 1, '2026-02-21 08:44:00', 1, NULL, NULL),
(22, 23, 52, '2026-02-21 08:44:00', 1, '2026-02-21 08:44:00', 1, NULL, NULL),
(23, 24, 53, '2026-02-21 08:44:00', 1, '2026-02-21 08:44:00', 1, NULL, NULL),
(24, 25, 46, '2026-02-21 08:44:00', 1, '2026-02-21 08:44:00', 1, NULL, NULL),
(25, 26, 32, '2026-02-21 08:44:00', 1, '2026-02-21 08:44:00', 1, NULL, NULL),
(26, 27, 32, '2026-02-21 08:44:00', 1, '2026-02-21 08:44:00', 1, NULL, NULL),
(27, 28, 32, '2026-02-21 08:44:00', 1, '2026-02-21 08:44:00', 1, NULL, NULL),
(28, 29, 32, '2026-02-21 08:44:00', 1, '2026-02-21 08:44:00', 1, NULL, NULL),
(29, 30, 32, '2026-02-21 08:44:00', 1, '2026-02-21 08:44:00', 1, NULL, NULL),
(33, 13, 45, '2026-02-25 17:26:23', 13, '2026-02-25 17:26:23', NULL, NULL, NULL),
(34, 34, 1, '2026-02-27 16:52:54', 34, '2026-02-27 16:52:54', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `worker_spouse`
--

CREATE TABLE `worker_spouse` (
  `id` int(1) NOT NULL,
  `user_id` int(1) NOT NULL,
  `spouse_name` varchar(100) DEFAULT NULL,
  `spouse_gender` enum('male','female') DEFAULT NULL,
  `spouse_birth_place` varchar(50) DEFAULT NULL,
  `spouse_birth_date` date DEFAULT NULL,
  `spouse_last_edu` varchar(20) DEFAULT NULL,
  `spouse_job` varchar(100) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` int(1) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `worker_spouse`
--

INSERT INTO `worker_spouse` (`id`, `user_id`, `spouse_name`, `spouse_gender`, `spouse_birth_place`, `spouse_birth_date`, `spouse_last_edu`, `spouse_job`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
(1, 2, 'Siti Robiah', NULL, NULL, '2019-12-13', NULL, NULL, '2026-02-21 10:01:10', 1, '2026-02-21 10:01:18', 1, NULL, NULL),
(2, 3, 'Ratu Paradanti', 'female', 'Bogor', '2000-08-05', 'SMA \n', 'Ibu rumah tangga', '2026-02-22 00:11:25', 1, '2026-02-22 00:11:25', 1, NULL, NULL),
(3, 5, 'Cindi Pratama Dewi', 'female', NULL, NULL, NULL, NULL, '2026-02-22 00:11:25', 1, '2026-02-22 00:11:25', 1, NULL, NULL),
(4, 8, 'Shafira Nur Islamytha', 'female', NULL, NULL, NULL, NULL, '2026-02-22 00:11:00', 1, '2026-02-22 00:11:00', 1, NULL, NULL),
(5, 9, 'Siti nur aeni', 'female', NULL, NULL, NULL, NULL, '2026-02-22 00:11:00', 1, '2026-02-22 00:11:00', 1, NULL, NULL),
(6, 10, 'Tegar Randitya', 'male', NULL, NULL, NULL, NULL, '2026-02-22 00:11:00', 1, '2026-02-22 00:11:00', 1, NULL, NULL),
(7, 11, 'Fifi Erfiani', 'female', NULL, NULL, NULL, NULL, '2026-02-22 00:11:00', 1, '2026-02-22 00:11:00', 1, NULL, NULL),
(8, 13, 'Natasyha Aprillia Sabatani', 'female', NULL, NULL, NULL, NULL, '2026-02-22 00:11:00', 1, '2026-02-22 00:11:00', 1, NULL, NULL),
(9, 14, 'Ai Siti Aisyah', 'female', NULL, NULL, NULL, NULL, '2026-02-22 00:11:00', 1, '2026-02-22 00:11:00', 1, NULL, NULL),
(10, 16, 'Novi purwaningsih', 'female', NULL, NULL, NULL, NULL, '2026-02-22 00:11:00', 1, '2026-02-22 00:11:00', 1, NULL, NULL),
(11, 17, 'Ida Herliza Siddik', 'female', NULL, NULL, NULL, NULL, '2026-02-22 00:11:00', 1, '2026-02-22 00:11:00', 1, NULL, NULL),
(12, 20, 'HARRY SETIADI', 'male', NULL, NULL, NULL, NULL, '2026-02-22 00:11:00', 1, '2026-02-22 00:11:00', 1, NULL, NULL),
(13, 21, 'Sofia', 'female', NULL, NULL, NULL, NULL, '2026-02-22 00:11:00', 1, '2026-02-22 00:11:00', 1, NULL, NULL),
(14, 26, 'Yeye irma', 'female', NULL, NULL, NULL, NULL, '2026-02-22 00:11:00', 1, '2026-02-22 00:11:00', 1, NULL, NULL),
(15, 27, 'MULYATI', 'female', NULL, NULL, NULL, NULL, '2026-02-22 00:11:00', 1, '2026-02-22 00:11:00', 1, NULL, NULL),
(16, 28, 'ayuna lia sari', 'female', NULL, NULL, NULL, NULL, '2026-02-22 00:11:00', 1, '2026-02-22 00:11:00', 1, NULL, NULL),
(17, 30, 'Rifah alfiah alibasya', 'female', NULL, NULL, NULL, NULL, '2026-02-22 00:11:00', 1, '2026-02-22 00:11:00', 1, NULL, NULL);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `hotels`
--
ALTER TABLE `hotels`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `hotel_transactions`
--
ALTER TABLE `hotel_transactions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_hotel` (`hotel_id`),
  ADD KEY `idx_type` (`type`),
  ADD KEY `idx_created` (`created_at`);

--
-- Indexes for table `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `invoice_items`
--
ALTER TABLE `invoice_items`
  ADD PRIMARY KEY (`id`),
  ADD KEY `invoice_id` (`invoice_id`);

--
-- Indexes for table `invoice_payments`
--
ALTER TABLE `invoice_payments`
  ADD PRIMARY KEY (`id`),
  ADD KEY `invoice_id` (`invoice_id`),
  ADD KEY `hotel_id` (`hotel_id`);

--
-- Indexes for table `jobs`
--
ALTER TABLE `jobs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `job_applications`
--
ALTER TABLE `job_applications`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `job_id` (`job_id`,`user_id`);

--
-- Indexes for table `job_attendances`
--
ALTER TABLE `job_attendances`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_attendance_pair` (`application_id`,`job_id`,`type`,`created_at`);

--
-- Indexes for table `job_extend_attendances`
--
ALTER TABLE `job_extend_attendances`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_extend` (`extend_request_id`),
  ADD KEY `idx_user` (`user_id`);

--
-- Indexes for table `job_extend_requests`
--
ALTER TABLE `job_extend_requests`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_worker` (`user_id`),
  ADD KEY `idx_job` (`job_id`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `ratings`
--
ALTER TABLE `ratings`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `application_id` (`application_id`);

--
-- Indexes for table `ratio_rules`
--
ALTER TABLE `ratio_rules`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_hotel` (`hotel_id`),
  ADD KEY `idx_department` (`department_category`),
  ADD KEY `idx_range` (`min_value`,`max_value`);

--
-- Indexes for table `refresh_tokens`
--
ALTER TABLE `refresh_tokens`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `schedule_days`
--
ALTER TABLE `schedule_days`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_day` (`schedule_plan_id`,`shift_date`),
  ADD KEY `idx_plan` (`schedule_plan_id`);

--
-- Indexes for table `schedule_plans`
--
ALTER TABLE `schedule_plans`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_schedule` (`hotel_id`,`department`,`month`,`year`),
  ADD KEY `idx_hotel` (`hotel_id`),
  ADD KEY `idx_status` (`status`);

--
-- Indexes for table `schedule_revisions`
--
ALTER TABLE `schedule_revisions`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_plan` (`schedule_plan_id`);

--
-- Indexes for table `schedule_revision_shifts`
--
ALTER TABLE `schedule_revision_shifts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_revision` (`revision_id`);

--
-- Indexes for table `schedule_shifts`
--
ALTER TABLE `schedule_shifts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_regular_per_day` (`schedule_day_id`,`user_id`,`shift_type`),
  ADD KEY `idx_user` (`user_id`);

--
-- Indexes for table `skills`
--
ALTER TABLE `skills`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `training_days`
--
ALTER TABLE `training_days`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_day` (`training_plan_id`,`training_date`),
  ADD KEY `idx_plan` (`training_plan_id`);

--
-- Indexes for table `training_participants`
--
ALTER TABLE `training_participants`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `training_plans`
--
ALTER TABLE `training_plans`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `training_revisions`
--
ALTER TABLE `training_revisions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `training_revision_participants`
--
ALTER TABLE `training_revision_participants`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `training_shifts`
--
ALTER TABLE `training_shifts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_regular_per_day` (`training_day_id`,`user_id`,`shift_type`),
  ADD KEY `idx_user` (`user_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `worker_child`
--
ALTER TABLE `worker_child`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `worker_contracts`
--
ALTER TABLE `worker_contracts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_active` (`is_active`);

--
-- Indexes for table `worker_documents`
--
ALTER TABLE `worker_documents`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `worker_educations`
--
ALTER TABLE `worker_educations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `worker_emergency`
--
ALTER TABLE `worker_emergency`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `worker_experiences`
--
ALTER TABLE `worker_experiences`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_sort` (`sort_order`);

--
-- Indexes for table `worker_language`
--
ALTER TABLE `worker_language`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `worker_links`
--
ALTER TABLE `worker_links`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Indexes for table `worker_parents`
--
ALTER TABLE `worker_parents`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `worker_profiles`
--
ALTER TABLE `worker_profiles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

--
-- Indexes for table `worker_ratings`
--
ALTER TABLE `worker_ratings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `worker_reviews`
--
ALTER TABLE `worker_reviews`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `worker_sibling`
--
ALTER TABLE `worker_sibling`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `worker_skills`
--
ALTER TABLE `worker_skills`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`,`skill_id`);

--
-- Indexes for table `worker_spouse`
--
ALTER TABLE `worker_spouse`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `hotels`
--
ALTER TABLE `hotels`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `hotel_transactions`
--
ALTER TABLE `hotel_transactions`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=88;

--
-- AUTO_INCREMENT for table `invoices`
--
ALTER TABLE `invoices`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `invoice_items`
--
ALTER TABLE `invoice_items`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `invoice_payments`
--
ALTER TABLE `invoice_payments`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `job_applications`
--
ALTER TABLE `job_applications`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=62;

--
-- AUTO_INCREMENT for table `job_attendances`
--
ALTER TABLE `job_attendances`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1358;

--
-- AUTO_INCREMENT for table `job_extend_attendances`
--
ALTER TABLE `job_extend_attendances`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `job_extend_requests`
--
ALTER TABLE `job_extend_requests`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ratings`
--
ALTER TABLE `ratings`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ratio_rules`
--
ALTER TABLE `ratio_rules`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `refresh_tokens`
--
ALTER TABLE `refresh_tokens`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=64;

--
-- AUTO_INCREMENT for table `schedule_days`
--
ALTER TABLE `schedule_days`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=83;

--
-- AUTO_INCREMENT for table `schedule_plans`
--
ALTER TABLE `schedule_plans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `schedule_revisions`
--
ALTER TABLE `schedule_revisions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `schedule_revision_shifts`
--
ALTER TABLE `schedule_revision_shifts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `schedule_shifts`
--
ALTER TABLE `schedule_shifts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=51;

--
-- AUTO_INCREMENT for table `skills`
--
ALTER TABLE `skills`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=57;

--
-- AUTO_INCREMENT for table `training_days`
--
ALTER TABLE `training_days`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `training_participants`
--
ALTER TABLE `training_participants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `training_plans`
--
ALTER TABLE `training_plans`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `training_revisions`
--
ALTER TABLE `training_revisions`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `training_revision_participants`
--
ALTER TABLE `training_revision_participants`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `training_shifts`
--
ALTER TABLE `training_shifts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT for table `worker_child`
--
ALTER TABLE `worker_child`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `worker_contracts`
--
ALTER TABLE `worker_contracts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `worker_documents`
--
ALTER TABLE `worker_documents`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `worker_educations`
--
ALTER TABLE `worker_educations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=80;

--
-- AUTO_INCREMENT for table `worker_emergency`
--
ALTER TABLE `worker_emergency`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `worker_experiences`
--
ALTER TABLE `worker_experiences`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `worker_language`
--
ALTER TABLE `worker_language`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `worker_links`
--
ALTER TABLE `worker_links`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `worker_parents`
--
ALTER TABLE `worker_parents`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `worker_profiles`
--
ALTER TABLE `worker_profiles`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `worker_ratings`
--
ALTER TABLE `worker_ratings`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `worker_reviews`
--
ALTER TABLE `worker_reviews`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `worker_sibling`
--
ALTER TABLE `worker_sibling`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `worker_skills`
--
ALTER TABLE `worker_skills`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=35;

--
-- AUTO_INCREMENT for table `worker_spouse`
--
ALTER TABLE `worker_spouse`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `schedule_days`
--
ALTER TABLE `schedule_days`
  ADD CONSTRAINT `schedule_days_ibfk_1` FOREIGN KEY (`schedule_plan_id`) REFERENCES `schedule_plans` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `schedule_revisions`
--
ALTER TABLE `schedule_revisions`
  ADD CONSTRAINT `schedule_revisions_ibfk_1` FOREIGN KEY (`schedule_plan_id`) REFERENCES `schedule_plans` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `schedule_revision_shifts`
--
ALTER TABLE `schedule_revision_shifts`
  ADD CONSTRAINT `schedule_revision_shifts_ibfk_1` FOREIGN KEY (`revision_id`) REFERENCES `schedule_revisions` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `schedule_shifts`
--
ALTER TABLE `schedule_shifts`
  ADD CONSTRAINT `schedule_shifts_ibfk_1` FOREIGN KEY (`schedule_day_id`) REFERENCES `schedule_days` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `worker_contracts`
--
ALTER TABLE `worker_contracts`
  ADD CONSTRAINT `fk_worker_contract_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
