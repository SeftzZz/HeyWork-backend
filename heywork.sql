-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Feb 25, 2026 at 04:58 PM
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
(1, 'Sahira Butik Hotel Paledang', 'Bogor, West Java', -6.6011450, 106.7941260, 'www.sahirahotelsgroup.com', '', '2005', 100, 'images/sbh-color.png', '2026-02-21 07:56:34', 1, '2026-02-24 00:52:46', 1, NULL, NULL);

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
(13, 1, 'debit', 3214285.71, NULL, NULL, 'payroll', 'Auto Payroll Deduction H-1', '', '', '2026-02-21', '2026-02-22 17:59:28', 17, NULL, NULL, NULL, NULL),
(14, 1, 'credit', 5515260.00, 58.28, 'NOT OPTIMAL MAN POWER', 'revenue', 'Daily Revenue H-1', '', '', '2026-02-21', '2026-02-22 17:59:28', 17, NULL, NULL, NULL, NULL),
(15, 1, 'debit', 3214285.71, NULL, NULL, 'payroll', 'Auto Payroll Deduction H-1', '', '', '2026-02-22', '2026-02-23 17:59:53', 17, NULL, NULL, NULL, NULL),
(16, 1, 'credit', 1884298.00, 170.58, 'NOT OPTIMAL MAN POWER', 'revenue', 'Daily Revenue H-1', '', '', '2026-02-22', '2026-02-23 17:59:53', 17, NULL, NULL, NULL, NULL),
(17, 1, 'debit', 3214285.71, NULL, NULL, 'payroll', 'Auto Payroll Deduction H-1', '', '', '2026-02-23', '2026-02-24 18:00:12', 17, NULL, NULL, NULL, NULL),
(18, 1, 'credit', 6933888.00, 46.36, 'NOT OPTIMAL MAN POWER', 'revenue', 'Daily Revenue H-1', '', '', '2026-02-23', '2026-02-24 18:00:12', 17, NULL, NULL, NULL, NULL),
(19, 1, 'debit', 3428571.43, NULL, NULL, 'payroll', 'Auto Payroll Deduction H-1', '', '', '2026-02-24', '2026-02-25 13:54:09', 17, NULL, NULL, NULL, NULL),
(20, 1, 'credit', 4991736.00, 68.68, 'NOT OPTIMAL MAN POWER', 'revenue', 'Daily Revenue H-1', '', '', '2026-02-24', '2026-02-25 13:54:09', 17, NULL, NULL, NULL, NULL);

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
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
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

INSERT INTO `jobs` (`id`, `hotel_id`, `position`, `job_date_start`, `job_date_end`, `start_time`, `end_time`, `category`, `fee`, `location`, `description`, `requirement_skill`, `status`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
(1, 1, 'Information Technology', '2025-09-05', '2026-09-04', '09:00:00', '18:00:00', 'corporate', 0, 'Bogor, West Java', 'Pengelolaan infrastruktur, pengembangan perangkat lunak, keamanan data dan dukungan teknis untuk memastikan operasional perusahaan berjalan lancar', 'Network configuration, Hardware deployment & Operating system knowledge', 'open', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(2, 1, 'HK Attandent', '2025-11-19', '2026-11-18', '09:00:00', '18:00:00', 'corporate', 0, 'Bogor, West Java', 'cleans, sanitizes, and organizes guest rooms and public areas to meet high hospitality standards', 'high physical stamina, exceptional attention to detail and strong time-management skills', 'open', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(3, 1, 'FB Manager', '2025-11-20', '2026-11-19', '09:00:00', '18:00:00', 'corporate', 0, 'Bogor, West Java', 'oversees all dining operations, including restaurants, bars, banquets, and room service, to ensure high-quality service, profitability, and compliance with health regulations', 'cost control, menu engineering, inventory management, and high-level customer service', 'open', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(4, 1, 'Executive Housekeeper', '2025-11-20', '2026-11-19', '09:00:00', '18:00:00', 'corporate', 0, 'Bogor, West Java', 'manages all housekeeping operations, staff, and budgets to maintain spotless guest rooms and public areas, ensuring high hygiene and comfort standards', 'strong leadership, organizational, and financial management skills', 'open', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(5, 1, 'Director of sales marketing', '2025-11-24', '2026-11-23', '09:00:00', '18:00:00', 'corporate', 0, 'Bogor, West Java', 'leads, develops, and implements strategic plans to drive revenue growth, enhance brand awareness, and increase market share', 'proficiency in CRM software, data analysis, revenue growth strategies, and excellent communication skills', 'open', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(6, 1, 'Graphics design', '2025-11-24', '2026-11-23', '09:00:00', '18:00:00', 'corporate', 0, 'Bogor, West Java', 'creates visual concepts using computer software or by hand to communicate ideas that inspire, inform, or captivate consumers', 'technical proficiency in software (Adobe Creative Suite, Figma) with core design principles like typography, color theory, and layout composition', 'open', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(7, 1, 'Senior Waiter', '2025-11-26', '2026-11-25', '09:00:00', '18:00:00', 'corporate', 0, 'Bogor, West Java', 'leads the service team to ensure exceptional dining experiences, acting as a mentor to junior staff and a point of escalation for guest concerns', 'advanced technical skills with strong leadership', 'open', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(8, 1, 'Supervisor Housekeeping', '2025-11-28', '2026-11-27', '09:00:00', '18:00:00', 'corporate', 0, 'Bogor, West Java', NULL, NULL, 'open', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(9, 1, 'AR/AP', '2025-12-02', '2026-12-01', '09:00:00', '18:00:00', 'corporate', 0, 'Bogor, West Java', NULL, NULL, 'open', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(10, 1, 'Chief Accounting', '2025-12-04', '2026-12-03', '00:00:00', '00:55:00', 'corporate', 0, 'Bogor, West Java', NULL, NULL, 'open', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(11, 1, 'Head Chef', '2025-12-04', '2026-12-03', '09:00:00', '18:00:00', 'corporate', 0, 'Bogor, West Java', NULL, NULL, 'open', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(12, 1, 'Front Office Manager', '2025-12-11', '2026-12-10', '01:20:00', '01:29:00', 'corporate', 0, 'Bogor, West Java', '', NULL, 'open', '2026-02-21 07:56:00', 1, '2026-02-25 01:18:21', 17, NULL, NULL),
(13, 1, 'Engineering', '2025-12-14', '2026-12-13', '09:00:00', '18:00:00', 'corporate', 0, 'Bogor, West Java', NULL, NULL, 'open', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(14, 1, 'Chief Engineering', '2025-12-23', '2026-12-22', '09:00:00', '18:00:00', 'corporate', 0, 'Bogor, West Java', NULL, NULL, 'open', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(15, 1, 'HR Manager', '2025-12-27', '2026-12-26', '09:00:00', '18:00:00', 'corporate', 0, 'Bogor, West Java', NULL, NULL, 'open', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(16, 1, 'Chef De Partie', '2025-12-28', '2026-12-27', '09:00:00', '18:00:00', 'corporate', 0, 'Bogor, West Java', NULL, NULL, 'open', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(17, 1, 'Sales Executive', '2026-01-05', '2027-01-04', '09:00:00', '18:00:00', 'corporate', 0, 'Bogor, West Java', NULL, NULL, 'open', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(18, 1, 'Senior Sales Marketing', '2026-01-07', '2027-01-06', '09:00:00', '16:55:00', 'corporate', 0, 'Bogor, West Java', NULL, NULL, 'open', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(19, 1, 'Cook', '2026-01-12', '2027-01-11', '09:00:00', '18:00:00', 'corporate', 0, 'Bogor, West Java', NULL, NULL, 'open', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(20, 1, 'Sales Manager', '2026-01-14', '2027-01-13', '09:00:00', '17:05:00', 'corporate', 0, 'Bogor, West Java', NULL, NULL, 'open', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(21, 1, 'FDA', '2026-02-06', '2027-02-05', '09:00:00', '18:00:00', 'corporate', 0, 'Bogor, West Java', NULL, NULL, 'open', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(22, 1, 'Business Development', '2025-12-09', '2026-06-08', '09:00:00', '18:00:00', 'corporate', 0, 'Bogor, West Java', NULL, NULL, 'open', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(23, 1, 'Security Guard', '2025-12-02', '2026-12-01', '09:00:00', '18:00:00', 'corporate', 0, 'Bogor, West Java', NULL, NULL, 'open', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL),
(24, 1, 'General Manager', '2025-12-02', '2026-12-01', '09:00:00', '18:00:00', 'corporate', 0, 'Bogor, West Java', NULL, NULL, 'open', '2026-02-21 07:56:00', 1, '2026-02-21 07:56:00', 1, NULL, NULL);

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
(30, 23, 30, 'accepted', '2026-01-01 08:05:00', '2026-01-01 08:05:00', 1, NULL);

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
(13, 1, 1, 2, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_1_2_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-21 09:00:00', 2, NULL, NULL, NULL, NULL),
(14, 1, 1, 2, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_1_2_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-22 09:00:00', 2, NULL, NULL, NULL, NULL),
(15, 1, 1, 2, 17, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_1_2_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-23 09:00:00', 2, NULL, NULL, NULL, NULL),
(16, 1, 1, 2, 19, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_1_2_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-24 09:00:00', 2, NULL, NULL, NULL, NULL),
(17, 2, 2, 3, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_2_3_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-21 09:00:00', 3, NULL, NULL, NULL, NULL),
(18, 2, 2, 3, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_2_3_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-22 09:00:00', 3, NULL, NULL, NULL, NULL),
(19, 2, 2, 3, 17, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_2_3_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-23 09:00:00', 3, NULL, NULL, NULL, NULL),
(20, 2, 2, 3, 19, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_2_3_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-24 09:00:00', 3, NULL, NULL, NULL, NULL),
(21, 3, 3, 4, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_3_4_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-21 09:00:00', 4, NULL, NULL, NULL, NULL),
(22, 3, 3, 4, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_3_4_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-22 09:00:00', 4, NULL, NULL, NULL, NULL),
(23, 3, 3, 4, 17, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_3_4_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-23 09:00:00', 4, NULL, NULL, NULL, NULL),
(24, 3, 3, 4, 19, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_3_4_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-24 09:00:00', 4, NULL, NULL, NULL, NULL),
(25, 4, 4, 5, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_4_5_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-21 09:00:00', 5, NULL, NULL, NULL, NULL),
(26, 4, 4, 5, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_4_5_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-22 09:00:00', 5, NULL, NULL, NULL, NULL),
(27, 4, 4, 5, 17, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_4_5_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-23 09:00:00', 5, NULL, NULL, NULL, NULL),
(28, 4, 4, 5, 19, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_4_5_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-24 09:00:00', 5, NULL, NULL, NULL, NULL),
(29, 5, 5, 6, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_5_6_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-21 09:00:00', 6, NULL, NULL, NULL, NULL),
(30, 5, 5, 6, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_5_6_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-22 09:00:00', 6, NULL, NULL, NULL, NULL),
(31, 5, 5, 6, 17, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_5_6_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-23 09:00:00', 6, NULL, NULL, NULL, NULL),
(32, 5, 5, 6, 19, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_5_6_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-24 09:00:00', 6, NULL, NULL, NULL, NULL),
(33, 6, 6, 7, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_6_7_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-21 09:00:00', 7, NULL, NULL, NULL, NULL),
(34, 6, 6, 7, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_6_7_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-22 09:00:00', 7, NULL, NULL, NULL, NULL),
(35, 6, 6, 7, 17, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_6_7_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-23 09:00:00', 7, NULL, NULL, NULL, NULL),
(36, 6, 6, 7, 19, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_6_7_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-24 09:00:00', 7, NULL, NULL, NULL, NULL),
(37, 7, 7, 8, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_7_8_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-21 09:00:00', 8, NULL, NULL, NULL, NULL),
(38, 7, 7, 8, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_7_8_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-22 09:00:00', 8, NULL, NULL, NULL, NULL),
(39, 7, 7, 8, 17, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_7_8_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-23 09:00:00', 8, NULL, NULL, NULL, NULL),
(40, 7, 7, 8, 19, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_7_8_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-24 09:00:00', 8, NULL, NULL, NULL, NULL),
(41, 8, 8, 9, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_8_9_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-21 09:00:00', 9, NULL, NULL, NULL, NULL),
(42, 8, 8, 9, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_8_9_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-22 09:00:00', 9, NULL, NULL, NULL, NULL),
(43, 8, 8, 9, 17, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_8_9_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-23 09:00:00', 9, NULL, NULL, NULL, NULL),
(44, 8, 8, 9, 19, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_8_9_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-24 09:00:00', 9, NULL, NULL, NULL, NULL),
(45, 9, 9, 10, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_9_10_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-21 09:00:00', 10, NULL, NULL, NULL, NULL),
(46, 9, 9, 10, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_9_10_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-22 09:00:00', 10, NULL, NULL, NULL, NULL),
(47, 9, 9, 10, 17, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_9_10_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-23 09:00:00', 10, NULL, NULL, NULL, NULL),
(48, 9, 9, 10, 19, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_9_10_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-24 09:00:00', 10, NULL, NULL, NULL, NULL),
(49, 10, 10, 11, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_10_11_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-21 00:00:00', 11, NULL, NULL, NULL, NULL),
(50, 10, 10, 11, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_10_11_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-22 00:00:00', 11, NULL, NULL, NULL, NULL),
(51, 10, 10, 11, 17, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_10_11_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-23 00:00:00', 11, NULL, NULL, NULL, NULL),
(52, 10, 10, 11, 19, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_10_11_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-24 00:00:00', 11, NULL, NULL, NULL, NULL),
(53, 11, 11, 12, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_11_12_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-21 09:00:00', 12, NULL, NULL, NULL, NULL),
(54, 11, 11, 12, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_11_12_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-22 09:00:00', 12, NULL, NULL, NULL, NULL),
(55, 11, 11, 12, 17, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_11_12_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-23 09:00:00', 12, NULL, NULL, NULL, NULL),
(56, 11, 11, 12, 19, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_11_12_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-24 09:00:00', 12, NULL, NULL, NULL, NULL),
(57, 12, 12, 13, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_12_13_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-21 09:00:00', 13, NULL, NULL, NULL, NULL),
(58, 12, 12, 13, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_12_13_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-22 09:00:00', 13, NULL, NULL, NULL, NULL),
(59, 12, 12, 13, 17, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_12_13_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-23 09:00:00', 13, NULL, NULL, NULL, NULL),
(60, 12, 12, 13, 19, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_12_13_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-24 09:00:00', 13, NULL, NULL, NULL, NULL),
(61, 13, 13, 14, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_13_14_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-21 09:00:00', 14, NULL, NULL, NULL, NULL),
(62, 13, 13, 14, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_13_14_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-22 09:00:00', 14, NULL, NULL, NULL, NULL),
(63, 13, 13, 14, 17, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_13_14_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-23 09:00:00', 14, NULL, NULL, NULL, NULL),
(64, 13, 13, 14, 19, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_13_14_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-24 09:00:00', 14, NULL, NULL, NULL, NULL),
(65, 13, 14, 15, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_13_15_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-21 09:00:00', 15, NULL, NULL, NULL, NULL),
(66, 13, 14, 15, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_13_15_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-22 09:00:00', 15, NULL, NULL, NULL, NULL),
(67, 13, 14, 15, 17, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_13_15_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-23 09:00:00', 15, NULL, NULL, NULL, NULL),
(68, 13, 14, 15, 19, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_13_15_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-24 09:00:00', 15, NULL, NULL, NULL, NULL),
(69, 14, 15, 16, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_14_16_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-21 09:00:00', 16, NULL, NULL, NULL, NULL),
(70, 14, 15, 16, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_14_16_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-22 09:00:00', 16, NULL, NULL, NULL, NULL),
(71, 14, 15, 16, 17, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_14_16_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-23 09:00:00', 16, NULL, NULL, NULL, NULL),
(72, 14, 15, 16, 19, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_14_16_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-24 09:00:00', 16, NULL, NULL, NULL, NULL),
(73, 16, 17, 18, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_16_18_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-21 09:00:00', 18, NULL, NULL, NULL, NULL),
(74, 16, 17, 18, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_16_18_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-22 09:00:00', 18, NULL, NULL, NULL, NULL),
(75, 16, 17, 18, 17, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_16_18_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-23 09:00:00', 18, NULL, NULL, NULL, NULL),
(76, 16, 17, 18, 19, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_16_18_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-24 09:00:00', 18, NULL, NULL, NULL, NULL),
(77, 17, 18, 19, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_17_19_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-21 09:00:00', 19, NULL, NULL, NULL, NULL),
(78, 17, 18, 19, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_17_19_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-22 09:00:00', 19, NULL, NULL, NULL, NULL),
(79, 17, 18, 19, 17, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_17_19_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-23 09:00:00', 19, NULL, NULL, NULL, NULL),
(80, 17, 18, 19, 19, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_17_19_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-24 09:00:00', 19, NULL, NULL, NULL, NULL),
(81, 18, 19, 20, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_18_20_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-21 09:00:00', 20, NULL, NULL, NULL, NULL),
(82, 18, 19, 20, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_18_20_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-22 09:00:00', 20, NULL, NULL, NULL, NULL),
(83, 18, 19, 20, 17, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_18_20_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-23 09:00:00', 20, NULL, NULL, NULL, NULL),
(84, 18, 19, 20, 19, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_18_20_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-24 09:00:00', 20, NULL, NULL, NULL, NULL),
(85, 19, 20, 21, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_19_21_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-21 09:00:00', 21, NULL, NULL, NULL, NULL),
(86, 19, 20, 21, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_19_21_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-22 09:00:00', 21, NULL, NULL, NULL, NULL),
(87, 19, 20, 21, 17, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_19_21_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-23 09:00:00', 21, NULL, NULL, NULL, NULL),
(88, 19, 20, 21, 19, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_19_21_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-24 09:00:00', 21, NULL, NULL, NULL, NULL),
(89, 20, 21, 22, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_20_22_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-21 09:00:00', 22, NULL, NULL, NULL, NULL),
(90, 20, 21, 22, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_20_22_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-22 09:00:00', 22, NULL, NULL, NULL, NULL),
(91, 20, 21, 22, 17, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_20_22_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-23 09:00:00', 22, NULL, NULL, NULL, NULL),
(92, 20, 21, 22, 19, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_20_22_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-24 09:00:00', 22, NULL, NULL, NULL, NULL),
(93, 21, 22, 23, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_21_23_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-21 09:00:00', 23, NULL, NULL, NULL, NULL),
(94, 21, 22, 23, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_21_23_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-22 09:00:00', 23, NULL, NULL, NULL, NULL),
(95, 21, 22, 23, 17, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_21_23_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-23 09:00:00', 23, NULL, NULL, NULL, NULL),
(96, 21, 22, 23, 19, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_21_23_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-24 09:00:00', 23, NULL, NULL, NULL, NULL),
(97, 22, 23, 24, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_22_24_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-21 09:00:00', 24, NULL, NULL, NULL, NULL),
(98, 22, 23, 24, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_22_24_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-22 09:00:00', 24, NULL, NULL, NULL, NULL),
(99, 22, 23, 24, 17, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_22_24_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-23 09:00:00', 24, NULL, NULL, NULL, NULL),
(100, 22, 23, 24, 19, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_22_24_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-24 09:00:00', 24, NULL, NULL, NULL, NULL),
(101, 6, 24, 25, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_6_25_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-21 09:00:00', 25, NULL, NULL, NULL, NULL),
(102, 6, 24, 25, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_6_25_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-22 09:00:00', 25, NULL, NULL, NULL, NULL),
(103, 6, 24, 25, 17, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_6_25_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-23 09:00:00', 25, NULL, NULL, NULL, NULL),
(104, 6, 24, 25, 19, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_6_25_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-24 09:00:00', 25, NULL, NULL, NULL, NULL),
(105, 23, 25, 26, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_23_26_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-21 09:00:00', 26, NULL, NULL, NULL, NULL),
(106, 23, 25, 26, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_23_26_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-22 09:00:00', 26, NULL, NULL, NULL, NULL),
(107, 23, 25, 26, 17, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_23_26_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-23 09:00:00', 26, NULL, NULL, NULL, NULL),
(108, 23, 25, 26, 19, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_23_26_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-24 09:00:00', 26, NULL, NULL, NULL, NULL),
(109, 23, 26, 27, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_23_27_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-21 09:00:00', 27, NULL, NULL, NULL, NULL),
(110, 23, 26, 27, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_23_27_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-22 09:00:00', 27, NULL, NULL, NULL, NULL),
(111, 23, 26, 27, 17, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_23_27_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-23 09:00:00', 27, NULL, NULL, NULL, NULL),
(112, 23, 26, 27, 19, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_23_27_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-24 09:00:00', 27, NULL, NULL, NULL, NULL),
(113, 23, 28, 28, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_23_28_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-21 09:00:00', 28, NULL, NULL, NULL, NULL),
(114, 23, 28, 28, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_23_28_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-22 09:00:00', 28, NULL, NULL, NULL, NULL),
(115, 23, 28, 28, 17, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_23_28_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-23 09:00:00', 28, NULL, NULL, NULL, NULL),
(116, 23, 28, 28, 19, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_23_28_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-24 09:00:00', 28, NULL, NULL, NULL, NULL),
(117, 23, 29, 29, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_23_29_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-21 09:00:00', 29, NULL, NULL, NULL, NULL),
(118, 23, 29, 29, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_23_29_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-22 09:00:00', 29, NULL, NULL, NULL, NULL),
(119, 23, 29, 29, 17, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_23_29_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-23 09:00:00', 29, NULL, NULL, NULL, NULL),
(120, 23, 29, 29, 19, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_23_29_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-24 09:00:00', 29, NULL, NULL, NULL, NULL),
(121, 23, 30, 30, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_23_30_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-21 09:00:00', 30, NULL, NULL, NULL, NULL),
(122, 23, 30, 30, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_23_30_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-22 09:00:00', 30, NULL, NULL, NULL, NULL),
(123, 23, 30, 30, 17, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_23_30_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-23 09:00:00', 30, NULL, NULL, NULL, NULL),
(124, 23, 30, 30, 19, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_23_30_1771930654.jpg', 'AUTO SYSTEM GENERATED', '2026-02-24 09:00:00', 30, NULL, NULL, NULL, NULL),
(140, 1, 1, 2, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(141, 1, 1, 2, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(142, 1, 1, 2, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(143, 2, 2, 3, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(144, 2, 2, 3, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(145, 2, 2, 3, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(146, 3, 3, 4, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(147, 3, 3, 4, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(148, 3, 3, 4, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(149, 4, 4, 5, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(150, 4, 4, 5, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(151, 4, 4, 5, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(152, 5, 5, 6, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(153, 5, 5, 6, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(154, 5, 5, 6, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(155, 6, 6, 7, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(156, 6, 6, 7, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(157, 6, 6, 7, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(158, 7, 7, 8, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(159, 7, 7, 8, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(160, 7, 7, 8, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(161, 8, 8, 9, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(162, 8, 8, 9, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(163, 8, 8, 9, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(164, 9, 9, 10, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(165, 9, 9, 10, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(166, 9, 9, 10, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(167, 10, 10, 11, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(168, 10, 10, 11, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(169, 10, 10, 11, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(170, 10, 10, 11, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(171, 11, 11, 12, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(172, 11, 11, 12, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(173, 11, 11, 12, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(174, 12, 12, 13, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(175, 12, 12, 13, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(176, 12, 12, 13, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(177, 13, 13, 14, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(178, 13, 13, 14, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(179, 13, 13, 14, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(180, 13, 14, 15, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(181, 13, 14, 15, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(182, 13, 14, 15, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(183, 14, 15, 16, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(184, 14, 15, 16, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(185, 14, 15, 16, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(186, 16, 17, 18, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(187, 16, 17, 18, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(188, 16, 17, 18, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(189, 17, 18, 19, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(190, 17, 18, 19, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(191, 17, 18, 19, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(192, 18, 19, 20, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(193, 18, 19, 20, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(194, 18, 19, 20, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(195, 18, 19, 20, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(196, 19, 20, 21, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(197, 19, 20, 21, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(198, 19, 20, 21, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(199, 20, 21, 22, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(200, 20, 21, 22, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(201, 20, 21, 22, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(202, 20, 21, 22, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(203, 21, 22, 23, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(204, 21, 22, 23, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(205, 21, 22, 23, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(206, 22, 23, 24, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(207, 22, 23, 24, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(208, 22, 23, 24, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(209, 6, 24, 25, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(210, 6, 24, 25, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(211, 6, 24, 25, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(212, 23, 25, 26, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(213, 23, 25, 26, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(214, 23, 25, 26, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(215, 23, 26, 27, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(216, 23, 26, 27, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(217, 23, 26, 27, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(218, 23, 28, 28, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(219, 23, 28, 28, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(220, 23, 28, 28, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(221, 23, 29, 29, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(222, 23, 29, 29, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(223, 23, 29, 29, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(224, 23, 30, 30, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(225, 23, 30, 30, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(226, 23, 30, 30, 19, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-24 17:57:55', NULL, NULL, NULL, NULL, NULL),
(227, 1, 1, 2, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-21 18:00:00', NULL, NULL, NULL, NULL, NULL),
(228, 1, 1, 2, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-22 18:00:00', NULL, NULL, NULL, NULL, NULL),
(229, 1, 1, 2, 17, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-23 18:00:00', NULL, NULL, NULL, NULL, NULL),
(230, 2, 2, 3, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-21 18:00:00', NULL, NULL, NULL, NULL, NULL),
(231, 2, 2, 3, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-22 18:00:00', NULL, NULL, NULL, NULL, NULL),
(232, 2, 2, 3, 17, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-23 18:00:00', NULL, NULL, NULL, NULL, NULL),
(233, 3, 3, 4, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-21 18:00:00', NULL, NULL, NULL, NULL, NULL),
(234, 3, 3, 4, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-22 18:00:00', NULL, NULL, NULL, NULL, NULL),
(235, 3, 3, 4, 17, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-23 18:00:00', NULL, NULL, NULL, NULL, NULL),
(236, 4, 4, 5, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-21 18:00:00', NULL, NULL, NULL, NULL, NULL),
(237, 4, 4, 5, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-22 18:00:00', NULL, NULL, NULL, NULL, NULL),
(238, 4, 4, 5, 17, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-23 18:00:00', NULL, NULL, NULL, NULL, NULL),
(239, 5, 5, 6, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-21 18:00:00', NULL, NULL, NULL, NULL, NULL),
(240, 5, 5, 6, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-22 18:00:00', NULL, NULL, NULL, NULL, NULL),
(241, 5, 5, 6, 17, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-23 18:00:00', NULL, NULL, NULL, NULL, NULL),
(242, 6, 6, 7, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-21 18:00:00', NULL, NULL, NULL, NULL, NULL),
(243, 6, 6, 7, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-22 18:00:00', NULL, NULL, NULL, NULL, NULL),
(244, 6, 6, 7, 17, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-23 18:00:00', NULL, NULL, NULL, NULL, NULL),
(245, 7, 7, 8, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-21 18:00:00', NULL, NULL, NULL, NULL, NULL),
(246, 7, 7, 8, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-22 18:00:00', NULL, NULL, NULL, NULL, NULL),
(247, 7, 7, 8, 17, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-23 18:00:00', NULL, NULL, NULL, NULL, NULL),
(248, 8, 8, 9, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-21 18:00:00', NULL, NULL, NULL, NULL, NULL),
(249, 8, 8, 9, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-22 18:00:00', NULL, NULL, NULL, NULL, NULL),
(250, 8, 8, 9, 17, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-23 18:00:00', NULL, NULL, NULL, NULL, NULL),
(251, 9, 9, 10, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-21 18:00:00', NULL, NULL, NULL, NULL, NULL),
(252, 9, 9, 10, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-22 18:00:00', NULL, NULL, NULL, NULL, NULL),
(253, 9, 9, 10, 17, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-23 18:00:00', NULL, NULL, NULL, NULL, NULL),
(254, 10, 10, 11, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-21 00:55:00', NULL, NULL, NULL, NULL, NULL),
(255, 10, 10, 11, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-22 00:55:00', NULL, NULL, NULL, NULL, NULL),
(256, 10, 10, 11, 17, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-23 00:55:00', NULL, NULL, NULL, NULL, NULL),
(257, 11, 11, 12, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-21 18:00:00', NULL, NULL, NULL, NULL, NULL),
(258, 11, 11, 12, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-22 18:00:00', NULL, NULL, NULL, NULL, NULL),
(259, 11, 11, 12, 17, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-23 18:00:00', NULL, NULL, NULL, NULL, NULL),
(260, 12, 12, 13, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-21 18:00:00', NULL, NULL, NULL, NULL, NULL),
(261, 12, 12, 13, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-22 18:00:00', NULL, NULL, NULL, NULL, NULL),
(262, 12, 12, 13, 17, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-23 18:00:00', NULL, NULL, NULL, NULL, NULL),
(263, 13, 13, 14, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-21 18:00:00', NULL, NULL, NULL, NULL, NULL),
(264, 13, 13, 14, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-22 18:00:00', NULL, NULL, NULL, NULL, NULL),
(265, 13, 13, 14, 17, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-23 18:00:00', NULL, NULL, NULL, NULL, NULL),
(266, 13, 14, 15, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-21 18:00:00', NULL, NULL, NULL, NULL, NULL),
(267, 13, 14, 15, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-22 18:00:00', NULL, NULL, NULL, NULL, NULL),
(268, 13, 14, 15, 17, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-23 18:00:00', NULL, NULL, NULL, NULL, NULL),
(269, 14, 15, 16, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-21 18:00:00', NULL, NULL, NULL, NULL, NULL),
(270, 14, 15, 16, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-22 18:00:00', NULL, NULL, NULL, NULL, NULL),
(271, 14, 15, 16, 17, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-23 18:00:00', NULL, NULL, NULL, NULL, NULL),
(272, 16, 17, 18, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-21 18:00:00', NULL, NULL, NULL, NULL, NULL),
(273, 16, 17, 18, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-22 18:00:00', NULL, NULL, NULL, NULL, NULL),
(274, 16, 17, 18, 17, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-23 18:00:00', NULL, NULL, NULL, NULL, NULL),
(275, 17, 18, 19, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-21 18:00:00', NULL, NULL, NULL, NULL, NULL),
(276, 17, 18, 19, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-22 18:00:00', NULL, NULL, NULL, NULL, NULL),
(277, 17, 18, 19, 17, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-23 18:00:00', NULL, NULL, NULL, NULL, NULL),
(278, 18, 19, 20, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-21 16:55:00', NULL, NULL, NULL, NULL, NULL),
(279, 18, 19, 20, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-22 16:55:00', NULL, NULL, NULL, NULL, NULL),
(280, 18, 19, 20, 17, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-23 16:55:00', NULL, NULL, NULL, NULL, NULL),
(281, 19, 20, 21, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-21 18:00:00', NULL, NULL, NULL, NULL, NULL),
(282, 19, 20, 21, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-22 18:00:00', NULL, NULL, NULL, NULL, NULL),
(283, 19, 20, 21, 17, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-23 18:00:00', NULL, NULL, NULL, NULL, NULL),
(284, 20, 21, 22, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-21 17:05:00', NULL, NULL, NULL, NULL, NULL),
(285, 20, 21, 22, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-22 17:05:00', NULL, NULL, NULL, NULL, NULL),
(286, 20, 21, 22, 17, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-23 17:05:00', NULL, NULL, NULL, NULL, NULL),
(287, 21, 22, 23, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-21 18:00:00', NULL, NULL, NULL, NULL, NULL),
(288, 21, 22, 23, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-22 18:00:00', NULL, NULL, NULL, NULL, NULL),
(289, 21, 22, 23, 17, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-23 18:00:00', NULL, NULL, NULL, NULL, NULL),
(290, 22, 23, 24, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-21 18:00:00', NULL, NULL, NULL, NULL, NULL),
(291, 22, 23, 24, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-22 18:00:00', NULL, NULL, NULL, NULL, NULL),
(292, 22, 23, 24, 17, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-23 18:00:00', NULL, NULL, NULL, NULL, NULL),
(293, 6, 24, 25, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-21 18:00:00', NULL, NULL, NULL, NULL, NULL),
(294, 6, 24, 25, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-22 18:00:00', NULL, NULL, NULL, NULL, NULL),
(295, 6, 24, 25, 17, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-23 18:00:00', NULL, NULL, NULL, NULL, NULL),
(296, 23, 25, 26, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-21 18:00:00', NULL, NULL, NULL, NULL, NULL),
(297, 23, 25, 26, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-22 18:00:00', NULL, NULL, NULL, NULL, NULL),
(298, 23, 25, 26, 17, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-23 18:00:00', NULL, NULL, NULL, NULL, NULL),
(299, 23, 26, 27, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-21 18:00:00', NULL, NULL, NULL, NULL, NULL),
(300, 23, 26, 27, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-22 18:00:00', NULL, NULL, NULL, NULL, NULL),
(301, 23, 26, 27, 17, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-23 18:00:00', NULL, NULL, NULL, NULL, NULL),
(302, 23, 28, 28, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-21 18:00:00', NULL, NULL, NULL, NULL, NULL),
(303, 23, 28, 28, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-22 18:00:00', NULL, NULL, NULL, NULL, NULL),
(304, 23, 28, 28, 17, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-23 18:00:00', NULL, NULL, NULL, NULL, NULL),
(305, 23, 29, 29, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-21 18:00:00', NULL, NULL, NULL, NULL, NULL),
(306, 23, 29, 29, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-22 18:00:00', NULL, NULL, NULL, NULL, NULL),
(307, 23, 29, 29, 17, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-23 18:00:00', NULL, NULL, NULL, NULL, NULL),
(308, 23, 30, 30, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-21 18:00:00', NULL, NULL, NULL, NULL, NULL),
(309, 23, 30, 30, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-22 18:00:00', NULL, NULL, NULL, NULL, NULL),
(310, 23, 30, 30, 17, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-23 18:00:00', NULL, NULL, NULL, NULL, NULL);

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
(2, 1, NULL, 0.00, 2.00, 'GOOD', 1, 2, '2026-02-24 03:40:13', NULL),
(3, 1, NULL, 2.00, 4.00, 'AVERAGE', 1, 3, '2026-02-24 03:40:13', NULL),
(4, 1, NULL, 4.00, 6.00, 'BAD', 1, 4, '2026-02-24 03:40:13', NULL),
(5, 1, NULL, 6.00, 999.00, 'NOT OPTIMAL MAN POWER', 1, 5, '2026-02-24 03:40:13', NULL),
(6, 1, 'Finance', 0.00, 7.00, 'BAD', 1, 1, '2026-02-24 03:40:13', NULL),
(7, 1, 'Finance', 7.00, 14.00, 'AVERAGE', 1, 2, '2026-02-24 03:40:13', NULL),
(8, 1, 'Finance', 14.00, 999.00, 'GOOD', 1, 3, '2026-02-24 03:40:13', NULL),
(9, 1, 'Sales & Marketing', 0.00, 7.00, 'BAD', 1, 1, '2026-02-24 03:40:13', NULL),
(10, 1, 'Sales & Marketing', 7.00, 14.00, 'AVERAGE', 1, 2, '2026-02-24 03:40:13', NULL),
(11, 1, 'Sales & Marketing', 14.00, 22.00, 'GOOD', 1, 3, '2026-02-24 03:40:13', NULL);

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
(20, 13, 'e79b8f787033c6ac2a05480cb612c8e53c2cd1699185ec4c60e9ac3e6ad6b9990b356705d8c454914c89b95136d7da1dcffb70c2e6c1d640524dde71985c63b8', '2026-03-27 01:17:23', '2026-02-25 01:17:23');

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
(43, 'Food & Beverage Manager', 'Management', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(44, 'Information Technology', 'IT', '2026-02-21 00:54:00', 1, '2026-02-21 08:44:58', 1, NULL, NULL),
(45, 'Front Office Manager', 'Management', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(46, 'Graphics Design', 'Sales & Marketing', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(47, 'Senior Waiter', 'Food & Beverage Service', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(48, 'Sales Director', 'Sales & Marketing', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(49, 'Chief Engineering', 'Engineering', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(50, 'Human Resources Manager', 'Human Resources', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(51, 'Sales Senior', 'Sales & Marketing', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(52, 'Front Desk Agent', 'Front Office', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(53, 'Business Development', 'Human Resources', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(54, 'Chief Accounting', 'Finance', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(1) NOT NULL,
  `hotel_id` int(1) NOT NULL,
  `role` enum('worker','hotel_hr','hotel_fo','hotel_hk','hotel_fnb_service','hotel_fnb_production','admin') CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT 'worker',
  `name` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `email` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `phone` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
  `password` varchar(250) CHARACTER SET latin1 COLLATE latin1_swedish_ci DEFAULT NULL,
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

INSERT INTO `users` (`id`, `hotel_id`, `role`, `name`, `email`, `phone`, `password`, `provider`, `provider_id`, `photo`, `is_verified`, `is_active`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
(1, 0, 'admin', 'Mick Jagger', 'admin@admin.com', '81234567890', '$2y$10$TYZN8k0YxaB.jxCtqA4sl.JnllEeN3/UF9oGYK5.LTvbGlCe7HE82', 'local', NULL, 'uploads/profiles/profile_2_1768811928.png', 0, 'active', '2026-01-18 12:25:53', 1, '2026-01-18 12:25:53', 1, NULL, NULL),
(2, 1, 'worker', 'Muhamad Ridwan Munawar', 'ridwanmunawar2607@gmail.com', '85171040347', '$2y$10$cd46MWgwLtVEaT0q1cQgiOi0ixH5HS8rIRewd7ohU326D5N1OLK22', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:53', 1, '2026-02-21 08:16:16', 1, NULL, NULL),
(3, 1, 'worker', 'Taufik Kurnia', 'dantiratu8@gmail.com', NULL, '$2y$10$lYBxa6y7u/fsBBcis8UJVeE0/Ux/oye4cAcTb4Em.gbbX9.p0x0EC', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:53', 1, '2026-02-21 10:11:50', 1, NULL, NULL),
(4, 1, 'worker', 'Rahadian Perdana', 'rahadian.rivelino@gmail.com', '88802308136', '$2y$10$BtcSKJUO/fdWbm1Kb/Bb6.pPPjBWRLRksjHqDJW/tboXWJKjXVH4S', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:53', 1, '2026-02-22 16:53:23', 1, NULL, NULL),
(5, 1, 'worker', 'Renaldy Herlando', 'rey.herlando@gmail.com', '81255800626', '$2y$10$BtcSKJUO/fdWbm1Kb/Bb6.pPPjBWRLRksjHqDJW/tboXWJKjXVH4S', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:53', 1, '2026-02-22 16:53:23', 1, NULL, NULL),
(6, 1, 'worker', 'Tri Setiyawati', 'celineq683@gmail.com', '87880006558', '$2y$10$7piC97XEwOQId2uMb5A.UecxpVwq3hAVlrBo.gkzcp3iqFYoRFX2i', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:53', 1, '2026-02-22 23:21:54', 1, NULL, NULL),
(7, 1, 'worker', 'Raafi Teguh Septianto', 'raafiteguh73@gmail.com', '895711102828', '$2y$10$EJeLN55b5c4hPxbOZ08MvOlzqjW4P/KoDll8VSgGl4GlPp9mov/n6', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:53', 1, '2026-02-24 16:57:04', 1, NULL, NULL),
(8, 1, 'worker', 'Jan Pelupessy', 'janhawajasmine14@gmail.com', '81212790875', '$2y$10$7piC97XEwOQId2uMb5A.UecxpVwq3hAVlrBo.gkzcp3iqFYoRFX2i', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-22 23:21:00', 1, NULL, NULL),
(9, 1, 'worker', 'Adi Alfian Surahman', 'Adialfian83@gmail.com', '83811404011', '$2y$10$7piC97XEwOQId2uMb5A.UecxpVwq3hAVlrBo.gkzcp3iqFYoRFX2i', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-22 23:21:00', 1, NULL, NULL),
(10, 1, 'worker', 'Dini Wulandari', 'Dinilandari18@gmail.com', '8987795834', '$2y$10$7piC97XEwOQId2uMb5A.UecxpVwq3hAVlrBo.gkzcp3iqFYoRFX2i', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-22 23:21:00', 1, NULL, NULL),
(11, 1, 'worker', 'Didik Febriawan', 'didikj4dul@gmail.com', '81298096880', '$2y$10$Pl4rYXHK5ew1/NhfVag9H.51rS6x07me6wXifU2chgeX4.0lacX4q', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-24 00:42:06', 1, NULL, NULL),
(12, 1, 'worker', 'Muji priyanto', 'mujipriyanto445@gmail.com', '82139111259', '$2y$10$7piC97XEwOQId2uMb5A.UecxpVwq3hAVlrBo.gkzcp3iqFYoRFX2i', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-22 23:21:00', 1, NULL, NULL),
(13, 1, 'worker', 'Syahwal Ramadhan', 'syahwal.86@gmail.com', '87711210850', '$2y$10$tPizxl3IxXA4FmK9XQ6sX.Dx8g8J3KxalgZzOQLcInIrrZX9curua', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-25 01:17:14', 1, NULL, NULL),
(14, 1, 'worker', 'Ijang Sulaeman', 'ijangsulaeman3@gmail.com', '81317087778', '$2y$10$7piC97XEwOQId2uMb5A.UecxpVwq3hAVlrBo.gkzcp3iqFYoRFX2i', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-22 23:21:00', 1, NULL, NULL),
(15, 1, 'worker', 'Faisal Bahri', 'salbahri43@gmail.com', '85283872224', '$2y$10$l3UXm5Y3Nh/t04IlpsXU4OfxUh4OwsFuUouss7AVpxIo7wcfT3.wm', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-24 00:43:07', 1, NULL, NULL),
(16, 1, 'worker', 'Eka panji asmoro', 'panjiasmoro1786@gmail.com', '82130884044', '$2y$10$7piC97XEwOQId2uMb5A.UecxpVwq3hAVlrBo.gkzcp3iqFYoRFX2i', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-22 23:21:00', 1, NULL, NULL),
(17, 1, 'hotel_hr', 'Yend Hendriyana', 'yend.hendriyana@gmail.com', '81519992334', '$2y$10$YOlHspewzNL1BEGcSsUTnOOOFQNuaE93.brwNQRCxM.cM/Ege0Loi', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-24 01:20:19', 1, NULL, NULL),
(18, 1, 'worker', 'M Aji Maulana', 'muhamadajimaulana557@gmail.com', '89630707971', '$2y$10$7piC97XEwOQId2uMb5A.UecxpVwq3hAVlrBo.gkzcp3iqFYoRFX2i', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-22 23:21:00', 1, NULL, NULL),
(19, 1, 'worker', 'Syahla Rahayu Munandar', 'syahlarahayu98@gmail.com', '85811547147', '$2y$10$7piC97XEwOQId2uMb5A.UecxpVwq3hAVlrBo.gkzcp3iqFYoRFX2i', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-22 23:21:00', 1, NULL, NULL),
(20, 1, 'worker', 'Rima Lestari Sonneville', 'rima.sonneville.89@gmail.com', '88211521716', '$2y$10$ySX1Lpn2NiSeTU0hQ.KbXe..D1pjorZXAADjem7nZ5vxaJm6Rl8Sm', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-24 16:50:03', 1, NULL, NULL),
(21, 1, 'worker', 'Mohtar Bimantoro', 'sofiabimantoro1@gmail.com', '83165994287', '$2y$10$7piC97XEwOQId2uMb5A.UecxpVwq3hAVlrBo.gkzcp3iqFYoRFX2i', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-22 23:21:00', 1, NULL, NULL),
(22, 1, 'worker', 'Hani yuniarti', 'haniyuniarti1306@gmail.com', '85691659516', '$2y$10$Pz5QVATwxPKyNUfUbT4FRu/wonNfLVQRrmhnFeb0Y7FFomVhgwnNS', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-24 16:58:35', 1, NULL, NULL),
(23, 1, 'worker', 'Qhalia putri', 'halloqhalia@gmail.com', '85775264566', '$2y$10$7piC97XEwOQId2uMb5A.UecxpVwq3hAVlrBo.gkzcp3iqFYoRFX2i', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-22 23:21:00', 1, NULL, NULL),
(24, 1, 'worker', 'Faishal Tri Aditama', 'faishaltriaditama@gmail.com', '81295724744', '$2y$10$lC5t.48FjdMSqR/Q0P6LKuEkvyW0iklBc2ELXi0ncdK7VeiWEnAAu', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-23 22:47:14', 1, NULL, NULL),
(25, 1, 'worker', 'Hilwa Salsabila Ahesa', 'ahesa.hilwa@gmail.com', '87897532333', '$2y$10$rg8QNjy6OPk1XqEbdjliMOiDZd/afRZStBlQyowkvPycH9qB74jai', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-23 22:49:29', 1, NULL, NULL),
(26, 1, 'worker', 'Bambang Setiawan', 'bambangsetiawan0681@gmail.com', '8996601717', '$2y$10$rg8QNjy6OPk1XqEbdjliMOiDZd/afRZStBlQyowkvPycH9qB74jai', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-23 22:49:29', 1, NULL, NULL),
(27, 1, 'worker', 'Firmansyah', 'firmansyahfirmansyah934@gmail.com', '85777166572', '$2y$10$rg8QNjy6OPk1XqEbdjliMOiDZd/afRZStBlQyowkvPycH9qB74jai', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-23 22:49:29', 1, NULL, NULL),
(28, 1, 'worker', 'Jarkasih', 'jarkasihuntung4@gmail.com', '85775588443', '$2y$10$rg8QNjy6OPk1XqEbdjliMOiDZd/afRZStBlQyowkvPycH9qB74jai', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-23 22:49:29', 1, NULL, NULL),
(29, 1, 'worker', 'Cecep dikdik Kurniawan ', 'cecepdikdikkurniawan@gmail.com', '85719251910', '$2y$10$rg8QNjy6OPk1XqEbdjliMOiDZd/afRZStBlQyowkvPycH9qB74jai', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-23 22:49:29', 1, NULL, NULL),
(30, 1, 'worker', 'Dadan Mulyana', 'cipitung78@gmail.com', '85716638004', '$2y$10$rg8QNjy6OPk1XqEbdjliMOiDZd/afRZStBlQyowkvPycH9qB74jai', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-23 22:49:29', 1, NULL, NULL),
(31, 1, 'worker', 'Prabu', 'prabunad@salamdjourney.com', '812', '$2y$10$e5fGDgW5bz9oTupY.ZgsN.KPwzNC6JKcFZE2uAq5kZ7ve./OSMVYi', 'local', NULL, NULL, 0, 'active', '2026-01-21 12:25:00', 1, '2026-02-24 16:43:44', 1, NULL, NULL);

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
(12, 13, 45, '2026-02-21 08:44:00', 1, '2026-02-21 08:44:00', 1, NULL, NULL),
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
(29, 30, 32, '2026-02-21 08:44:00', 1, '2026-02-21 08:44:00', 1, NULL, NULL);

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
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `job_applications`
--
ALTER TABLE `job_applications`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- AUTO_INCREMENT for table `job_attendances`
--
ALTER TABLE `job_attendances`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=354;

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `refresh_tokens`
--
ALTER TABLE `refresh_tokens`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=21;

--
-- AUTO_INCREMENT for table `skills`
--
ALTER TABLE `skills`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=55;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

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
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT;

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
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=30;

--
-- AUTO_INCREMENT for table `worker_spouse`
--
ALTER TABLE `worker_spouse`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `worker_contracts`
--
ALTER TABLE `worker_contracts`
  ADD CONSTRAINT `fk_worker_contract_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
