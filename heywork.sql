-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Feb 18, 2026 at 03:27 AM
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

INSERT INTO `hotels` (`id`, `hotel_name`, `location`, `latitude`, `longitude`, `website`, `description`, `founded`, `size`, `logo`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
(1, 'Sahira Butik Hotel Paledang', 'Bogor, West Java', -6.6011188, 106.7941239, 'paledang.sahirahotelsgroup.com', 'Sahira Butik Hotel Paledang adalah hotel di lokasi yang baik, tepatnya berada di Juanda. Resepsionis siap 24 jam untuk melayani proses check-in, check-out dan kebutuhan Anda yang lain. Jangan ragu untuk menghubungi resepsionis, kami siap melayani Anda. WiFi tersedia di seluruh area publik properti untuk membantu Anda tetap terhubung dengan keluarga dan teman.', '2005', 100, 'images/sbh-color.png', '2026-01-26 07:28:33', 1, '2026-02-04 14:28:11', 3, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `hotel_transactions`
--

CREATE TABLE `hotel_transactions` (
  `id` int(1) NOT NULL,
  `hotel_id` int(11) NOT NULL,
  `type` enum('debit','credit') NOT NULL DEFAULT 'credit',
  `amount` decimal(15,2) NOT NULL,
  `dw_ratio` decimal(5,2) DEFAULT NULL,
  `dw_label` varchar(50) DEFAULT NULL,
  `category` enum('topup','revenue','payroll','extend','adjustment') DEFAULT NULL,
  `description` varchar(255) NOT NULL,
  `reference_id` varchar(50) NOT NULL,
  `reference_type` varchar(50) NOT NULL,
  `date` date NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` int(1) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `hotel_transactions`
--

INSERT INTO `hotel_transactions` (`id`, `hotel_id`, `type`, `amount`, `dw_ratio`, `dw_label`, `category`, `description`, `reference_id`, `reference_type`, `date`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
(1, 1, 'debit', 250000.00, NULL, NULL, 'payroll', 'Auto Payroll Deduction H-1', '', '', '2026-02-16', '2026-02-17 18:58:22', 3, NULL, NULL, NULL, NULL),
(2, 1, 'credit', 3125000.00, 8.00, 'GOOD', 'revenue', 'Daily Revenue H-1', '', '', '2026-02-16', '2026-02-17 18:58:22', 3, NULL, NULL, NULL, NULL),
(3, 1, 'debit', 250000.00, NULL, NULL, 'payroll', 'Auto Payroll Deduction H-1', '', '', '2026-02-17', '2026-02-18 01:20:12', 3, NULL, NULL, NULL, NULL),
(4, 1, 'credit', 740000.00, 33.78, 'NOT OPTIMAL MAN POWER', 'revenue', 'Daily Revenue H-1', '', '', '2026-02-17', '2026-02-18 01:20:12', 3, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` int(1) NOT NULL,
  `hotel_id` int(11) NOT NULL,
  `position` varchar(100) NOT NULL,
  `job_date_start` date NOT NULL,
  `job_date_end` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `category` enum('daily_worker','casual') DEFAULT 'daily_worker',
  `fee` int(1) NOT NULL,
  `location` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `requirement_skill` text DEFAULT NULL,
  `status` enum('open','closed') DEFAULT 'open',
  `created_at` datetime DEFAULT NULL,
  `created_by` int(1) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `jobs`
--

INSERT INTO `jobs` (`id`, `hotel_id`, `position`, `job_date_start`, `job_date_end`, `start_time`, `end_time`, `category`, `fee`, `location`, `description`, `requirement_skill`, `status`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
(1, 1, 'Room Attendant', '2026-02-17', '2026-02-18', '07:30:00', '20:30:00', 'daily_worker', 100000, 'Bogor West Java', NULL, NULL, 'open', NULL, NULL, NULL, NULL, NULL, NULL),
(2, 1, 'Public Area', '2026-02-18', '2026-02-19', '07:30:00', '20:30:00', 'daily_worker', 150000, 'Bogor West Java', NULL, NULL, 'open', NULL, NULL, NULL, NULL, NULL, NULL),
(3, 1, 'Front Office', '2026-02-19', '2026-02-20', '07:30:00', '19:30:00', 'daily_worker', 200000, 'Bogor West Java', '', '', 'open', '2026-01-26 01:35:59', NULL, NULL, NULL, NULL, NULL),
(4, 1, 'FnB Service', '2026-02-20', '2026-02-21', '07:30:00', '21:30:00', 'daily_worker', 250000, 'Bogor West Java', '', '', 'open', '2026-01-26 01:36:37', NULL, NULL, NULL, NULL, NULL),
(5, 1, 'FnB Product', '2026-02-21', '2026-02-22', '07:30:00', '17:30:00', 'daily_worker', 300000, 'Bogor West Java', '', '', 'open', '2026-01-26 01:36:47', NULL, NULL, NULL, NULL, NULL),
(6, 1, 'Security', '2026-02-22', '2026-02-23', '07:30:00', '17:30:00', 'daily_worker', 350000, 'Bogor West Java', '', '', 'open', '2026-01-26 02:07:23', NULL, NULL, NULL, NULL, NULL),
(7, 1, 'Marketing', '2026-02-23', '2026-02-24', '07:30:00', '17:30:00', 'daily_worker', 400000, 'Bogor West Java', '', '', 'open', '2026-01-26 02:07:55', NULL, NULL, NULL, NULL, NULL),
(8, 1, 'Bellboy', '2026-02-24', '2026-02-25', '07:30:00', '20:30:00', 'daily_worker', 400000, 'Bogor West Java', '', '', 'open', '2026-01-26 02:07:55', NULL, NULL, NULL, NULL, NULL),
(9, 1, 'Barista', '2026-02-25', '2026-02-26', '07:30:00', '17:30:00', 'daily_worker', 120000, 'Bogor, Jawa Barat', 'Melayani dan memasak untuk tamu hotel', '', 'open', '2026-02-05 20:21:58', 3, NULL, NULL, NULL, NULL),
(10, 1, 'Bartender', '2026-02-26', '2026-02-27', '07:30:00', '17:30:00', 'daily_worker', 120000, 'Bogor, Jawa Barat', 'Melayani dan memasak untuk tamu hotel', '', 'open', '2026-02-05 20:21:58', 3, NULL, NULL, NULL, NULL),
(11, 1, 'Cook', '2026-02-27', '2026-02-28', '07:30:00', '17:30:00', 'daily_worker', 120000, 'Bogor, Jawa Barat', 'Melayani dan memasak untuk tamu hotel', '', 'open', '2026-02-05 20:21:58', 3, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `job_applications`
--

CREATE TABLE `job_applications` (
  `id` int(1) NOT NULL,
  `job_id` int(1) NOT NULL,
  `user_id` int(1) NOT NULL,
  `status` enum('pending','accepted','rejected','completed') DEFAULT 'pending',
  `applied_at` datetime DEFAULT NULL,
  `accepted_at` datetime DEFAULT NULL,
  `accepted_by` int(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `job_applications`
--

INSERT INTO `job_applications` (`id`, `job_id`, `user_id`, `status`, `applied_at`, `accepted_at`, `accepted_by`, `deleted_at`) VALUES
(1, 1, 1, 'accepted', '2026-02-17 16:43:49', '2026-02-17 16:45:28', 3, NULL),
(2, 2, 1, 'accepted', '2026-02-17 16:44:02', '2026-02-17 17:28:56', 3, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `job_attendances`
--

CREATE TABLE `job_attendances` (
  `id` int(11) NOT NULL,
  `job_id` int(11) NOT NULL,
  `application_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `transaction_id` int(1) NOT NULL,
  `type` enum('checkin','checkout') NOT NULL,
  `latitude` decimal(10,7) NOT NULL,
  `longitude` decimal(10,7) NOT NULL,
  `photo_path` varchar(250) NOT NULL,
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
(1, 1, 1, 1, 1, 'checkin', -6.6012142, 106.7939121, 'uploads/attendance/checkin_1_1_1771321924.jpg', 'Mozilla/5.0 (Linux; Android 13; SM-G981B) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36 Edg/145.0.0.0', '2026-02-16 16:52:04', 1, NULL, NULL, NULL, NULL),
(2, 2, 2, 1, 1, 'checkin', -6.6012142, 106.7939121, 'uploads/attendance/checkin_2_1_1771324175.jpg', 'Mozilla/5.0 (Linux; Android 13; SM-G981B) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36 Edg/145.0.0.0', '2026-02-16 17:29:35', 1, NULL, NULL, NULL, NULL),
(4, 2, 2, 1, 3, 'checkin', -6.6012142, 106.7939121, 'uploads/attendance/checkin_2_1_1771411981.jpg', 'Mozilla/5.0 (Linux; Android 13; SM-G981B) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36 Edg/145.0.0.0', '2026-02-17 17:53:01', 1, NULL, NULL, NULL, NULL),
(5, 1, 1, 1, 3, 'checkin', -6.6012142, 106.7939121, 'uploads/attendance/checkin_1_1_1771411988.jpg', 'Mozilla/5.0 (Linux; Android 13; SM-G981B) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36 Edg/145.0.0.0', '2026-02-17 17:53:08', 1, NULL, NULL, NULL, NULL),
(6, 2, 2, 1, 1, 'checkin', -6.6012142, 106.7939121, 'uploads/attendance/checkin_2_1_1771411981.jpg', 'Mozilla/5.0 (Linux; Android 13; SM-G981B) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36 Edg/145.0.0.0', '2026-02-18 17:53:01', 1, NULL, NULL, NULL, NULL),
(7, 1, 1, 1, 1, 'checkin', -6.6012142, 106.7939121, 'uploads/attendance/checkin_1_1_1771411988.jpg', 'Mozilla/5.0 (Linux; Android 13; SM-G981B) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Mobile Safari/537.36 Edg/145.0.0.0', '2026-02-18 17:53:08', 1, NULL, NULL, NULL, NULL);

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
  `review` text DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `refresh_tokens`
--

CREATE TABLE `refresh_tokens` (
  `id` int(1) NOT NULL,
  `user_id` int(1) NOT NULL,
  `token` varchar(255) NOT NULL,
  `expires_at` datetime NOT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `refresh_tokens`
--

INSERT INTO `refresh_tokens` (`id`, `user_id`, `token`, `expires_at`, `created_at`) VALUES
(1, 3, '7da6b5a3ee00c73e24db217acb53d13d5d96a5421e551c68b787a339e7b113884ee0c6ed17810208e251b099ad1c280ab68791639ac5f79795f075f467b78f00', '2026-03-19 16:41:41', '2026-02-17 16:41:41'),
(2, 1, '995b3e6a93dc95c0b5ae3b0b958222857d0ca7457ea3bf07cc139d0f9dafa2ee415fc21df9aefc944d5ee6f441102333d227fbab12cf9c75a3e1128759822e2c', '2026-03-19 16:41:57', '2026-02-17 16:41:57'),
(3, 1, 'c889ebd55f3cece5deaea4177c9f827716f31496815104bd987e9df9fcd5965eef67f301be8562230c0e70ffbf32d5ac85acb0b618447194cf748a6b7a8235c5', '2026-03-19 16:44:42', '2026-02-17 16:44:42'),
(4, 1, '75a7ad9ae3310329cef4d735b468d3cedca33576a6af16c19e072cf6f04fd2a2888c334ebbc1d72a7027e2f6b41dfe283f086900b6231d79abe26c347538c336', '2026-03-19 16:45:36', '2026-02-17 16:45:36'),
(5, 1, 'e71a1677726f040dd78ac540bad8e10e738d9d9ba736e2c2eefde9deef0180e174b7b3f4ce879167826c37c6a57fba70a48ba3b1a14cb593e2e81f3a5cbd011a', '2026-03-19 16:48:12', '2026-02-17 16:48:12'),
(6, 1, 'b44b1978e979ab83db7e73a94475f47eef39b1716dc27672b9dfd65d6c25e993a8afc1a4a161a5eb8f95b96885a1f5b11ae4cd62cb1ffb20308a6c972beb511c', '2026-03-19 16:48:51', '2026-02-17 16:48:51'),
(7, 1, 'a0367347ced51240acb4305e00d4ad63aedf143eb53754f3f22d93efda9911eda02751c86bc7b1b1c84d54b4dea776d42cb010bd88dada151958b5d95237befe', '2026-03-19 17:29:14', '2026-02-17 17:29:14'),
(8, 1, '3c4ae7462cd65c011e8dedf0ef291ae792b4d548f56e47a63648bd02e69213f16d35741b0a637e7948449a375951650dc237c00de64a0232e434b2f2d7148bad', '2026-03-20 17:51:57', '2026-02-18 17:51:57'),
(9, 1, '68f98f0097a0bc1e9e4732d00ae2c8c9b6ceb6e35822c589bd6522316daad3237f21216c0328738fcbf8c856cbca6e58f9c6097b43d17a57525f8e93df1e423e', '2026-03-20 17:52:52', '2026-02-18 17:52:52'),
(10, 1, 'd86fcd19bd505ba442c8f5310a35db35b65d7ecfb4d288148823a75481e3ea3a3eb7664a044946dbd7375ac829177c70f9b1058fac40477fdeabec915d77dcb9', '2026-03-21 18:20:38', '2026-02-19 18:20:38');

-- --------------------------------------------------------

--
-- Table structure for table `skills`
--

CREATE TABLE `skills` (
  `id` int(1) NOT NULL,
  `name` varchar(100) NOT NULL,
  `category` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` int(1) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

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
(12, 'Linen Attendant', 'Housekeeping', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
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
(39, 'Purchasing Staff', 'Purchasing', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(40, 'Hotel Manager', 'Management', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(41, 'Operation Manager', 'Management', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(42, 'General Manager', 'Management', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(43, 'Food & Beverage Manager', 'Management', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(1) NOT NULL,
  `hotel_id` int(1) NOT NULL,
  `role` enum('worker','hotel_hr','hotel_fo','hotel_hk','hotel_fnb_service','hotel_fnb_production','admin') DEFAULT 'worker',
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `password` varchar(250) DEFAULT NULL,
  `provider` enum('local','google','facebook') DEFAULT 'local',
  `provider_id` varchar(100) DEFAULT NULL,
  `photo` varchar(250) DEFAULT NULL,
  `is_verified` tinyint(4) DEFAULT 0,
  `is_active` enum('active','inactive') DEFAULT 'active',
  `created_at` datetime DEFAULT NULL,
  `created_by` int(1) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `hotel_id`, `role`, `name`, `email`, `phone`, `password`, `provider`, `provider_id`, `photo`, `is_verified`, `is_active`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
(1, 0, 'worker', 'Mick Jagger', 'admin@admin.com', '0812', '$2y$10$TYZN8k0YxaB.jxCtqA4sl.JnllEeN3/UF9oGYK5.LTvbGlCe7HE82', 'local', NULL, NULL, 0, 'active', '2026-01-18 12:25:53', 1, NULL, NULL, NULL, NULL),
(2, 1, 'hotel_hr', 'Arya Seftian', 'yerblues6@gmail.com', '895330907220', '$2y$10$ziaDpWwWk3gBjVGu6XqmoebCqmePQwtuwaRGY5ggXBpOI/.Wubhq.', 'local', NULL, 'uploads/profiles/profile_2_1768811928.png', 0, 'active', '2026-01-18 18:59:55', NULL, '2026-01-19 08:38:48', NULL, NULL, NULL),
(3, 1, 'hotel_hr', 'Muhammad', 'muhammad@gmail.com', '99988776', '$2y$10$relLlluCofLYvJKJDW65zuxFadTF4X4A.mCur9V2uEbiZVW8vGhaa', 'local', NULL, 'uploads/profiles/profile_3_1768820480.png', 0, 'active', '2026-01-19 10:53:08', NULL, '2026-02-03 10:39:03', NULL, NULL, NULL),
(4, 1, 'hotel_fnb_service', 'Muhammad', 'worker@gmail.com', '99988776', '$2y$10$relLlluCofLYvJKJDW65zuxFadTF4X4A.mCur9V2uEbiZVW8vGhaa', 'local', NULL, 'uploads/profiles/profile_3_1768820480.png', 0, 'active', '2026-01-19 10:53:08', NULL, '2026-02-03 10:39:03', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `worker_documents`
--

CREATE TABLE `worker_documents` (
  `id` int(1) NOT NULL,
  `user_id` int(1) NOT NULL,
  `type` enum('ktp','certificate','other') DEFAULT 'other',
  `file_path` varchar(250) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `worker_documents`
--

INSERT INTO `worker_documents` (`id`, `user_id`, `type`, `file_path`, `created_at`, `created_by`) VALUES
(2, 3, 'ktp', 'uploads/documents/doc_3_1770021829.jpeg', NULL, NULL),
(3, 3, 'other', 'uploads/documents/doc_3_1770363336.pdf', NULL, NULL),
(4, 3, 'certificate', 'uploads/documents/doc_3_1770364097.pdf', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `worker_educations`
--

CREATE TABLE `worker_educations` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `level` varchar(20) NOT NULL,
  `title` varchar(100) NOT NULL,
  `instituted_name` varchar(255) NOT NULL,
  `start_date` varchar(7) NOT NULL,
  `end_date` varchar(7) NOT NULL,
  `is_current` tinyint(1) NOT NULL,
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

INSERT INTO `worker_educations` (`id`, `user_id`, `level`, `title`, `instituted_name`, `start_date`, `end_date`, `is_current`, `sort_order`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
(1, 3, 'S1', 'Sarjana Informatika', 'Universitas Nusa Mandiri', '2025-01', '2026-01', 0, 0, '2026-02-02 16:29:38', 3, '2026-02-02 16:41:01', 0, NULL, NULL),
(2, 3, 'S2', 'Ilmu Komputer', 'Universitas Nusa Mandiri', '2026-01', '', 1, 0, '2026-02-02 16:29:38', 3, NULL, 0, NULL, NULL);

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
  `is_current` tinyint(1) DEFAULT 0,
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

INSERT INTO `worker_experiences` (`id`, `user_id`, `company_name`, `company_business`, `job_title`, `department`, `location`, `start_date`, `end_date`, `is_current`, `description`, `sort_order`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
(1, 3, 'Lorem', 'Ipsum', 'Dolor', 'Sit', 'Amet', '2026-01', NULL, 1, 'Oke', 0, '2026-02-02 09:29:15', 3, '2026-02-02 09:29:15', NULL, NULL, NULL),
(2, 3, 'Sahira', 'Hotel', 'SE', 'IT', 'Bogor', '2025-01', '2026-01', 0, 'Oke', 0, '2026-02-02 09:29:15', 3, '2026-02-02 16:35:02', NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `worker_links`
--

CREATE TABLE `worker_links` (
  `id` int(1) NOT NULL,
  `user_id` int(1) NOT NULL,
  `name` varchar(50) NOT NULL,
  `url` varchar(250) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` int(1) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `worker_links`
--

INSERT INTO `worker_links` (`id`, `user_id`, `name`, `url`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
(1, 3, 'Perkenalan Diri', 'https://www.youtube.com/watch?v=gLDUZpPUcXA', '2026-02-06 14:26:13', 3, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `worker_profiles`
--

CREATE TABLE `worker_profiles` (
  `id` int(1) NOT NULL,
  `user_id` int(1) NOT NULL,
  `gender` enum('male','female') DEFAULT NULL,
  `birth_date` date DEFAULT NULL,
  `address` text DEFAULT NULL,
  `bio` text DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` int(1) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `worker_profiles`
--

INSERT INTO `worker_profiles` (`id`, `user_id`, `gender`, `birth_date`, `address`, `bio`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
(1, 1, 'male', '2026-01-18', 'Bogor', 'Profile', '2026-01-18 16:47:54', 1, NULL, NULL, NULL, NULL);

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
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `worker_skills`
--

INSERT INTO `worker_skills` (`id`, `user_id`, `skill_id`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
(28, 3, 13, '2026-02-05 18:08:00', 3, '2026-02-05 18:08:00', NULL, NULL, NULL),
(29, 3, 5, '2026-02-05 18:08:00', 3, '2026-02-05 18:08:00', NULL, NULL, NULL),
(30, 3, 9, '2026-02-05 18:08:00', 3, '2026-02-05 18:08:00', NULL, NULL, NULL),
(31, 1, 1, '2026-02-17 16:42:45', 1, '2026-02-17 16:42:45', NULL, NULL, NULL),
(32, 1, 10, '2026-02-17 16:42:45', 1, '2026-02-17 16:42:45', NULL, NULL, NULL),
(33, 1, 9, '2026-02-17 16:42:45', 1, '2026-02-17 16:42:45', NULL, NULL, NULL);

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
  ADD PRIMARY KEY (`id`);

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
-- Indexes for table `refresh_tokens`
--
ALTER TABLE `refresh_tokens`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `skills`
--
ALTER TABLE `skills`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

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
-- Indexes for table `worker_experiences`
--
ALTER TABLE `worker_experiences`
  ADD PRIMARY KEY (`id`),
  ADD KEY `idx_user` (`user_id`),
  ADD KEY `idx_sort` (`sort_order`);

--
-- Indexes for table `worker_links`
--
ALTER TABLE `worker_links`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

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
-- Indexes for table `worker_skills`
--
ALTER TABLE `worker_skills`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`,`skill_id`);

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
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `job_applications`
--
ALTER TABLE `job_applications`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `job_attendances`
--
ALTER TABLE `job_attendances`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

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
-- AUTO_INCREMENT for table `refresh_tokens`
--
ALTER TABLE `refresh_tokens`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `skills`
--
ALTER TABLE `skills`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `worker_documents`
--
ALTER TABLE `worker_documents`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `worker_educations`
--
ALTER TABLE `worker_educations`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `worker_experiences`
--
ALTER TABLE `worker_experiences`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `worker_links`
--
ALTER TABLE `worker_links`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `worker_profiles`
--
ALTER TABLE `worker_profiles`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `worker_ratings`
--
ALTER TABLE `worker_ratings`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `worker_reviews`
--
ALTER TABLE `worker_reviews`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `worker_skills`
--
ALTER TABLE `worker_skills`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
