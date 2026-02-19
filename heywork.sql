-- phpMyAdmin SQL Dump
-- version 5.2.3
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Feb 20, 2026 at 12:13 AM
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
(4, 1, 'credit', 740000.00, 33.78, 'NOT OPTIMAL MAN POWER', 'revenue', 'Daily Revenue H-1', '', '', '2026-02-17', '2026-02-18 01:20:12', 3, NULL, NULL, NULL, NULL),
(5, 1, 'debit', 260000.00, NULL, NULL, 'payroll', 'Auto Payroll Deduction H-1', '', '', '2026-02-18', '2026-02-19 13:19:52', 3, NULL, NULL, NULL, NULL),
(6, 1, 'credit', 450000.00, 57.78, 'NOT OPTIMAL MAN POWER', 'revenue', 'Daily Revenue H-1', '', '', '2026-02-18', '2026-02-19 13:19:52', 3, NULL, NULL, NULL, NULL);

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
  `category` enum('daily_worker','casual','coorporate') DEFAULT 'daily_worker',
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
(1, 1, 'Room Attendant', '2026-02-17', '2026-02-18', '07:30:00', '20:30:00', 'daily_worker', 110000, 'Bogor West Java', '', NULL, 'open', NULL, NULL, '2026-02-18 12:58:25', 3, NULL, NULL),
(2, 1, 'Public Area', '2026-02-18', '2026-02-19', '07:30:00', '18:20:00', 'daily_worker', 150000, 'Bogor West Java', NULL, NULL, 'open', NULL, NULL, NULL, NULL, NULL, NULL),
(3, 1, 'Front Office', '2026-02-19', '2026-02-20', '07:30:00', '19:30:00', 'daily_worker', 200000, 'Bogor West Java', '', '', 'open', '2026-01-26 01:35:59', NULL, NULL, NULL, NULL, NULL),
(4, 1, 'FnB Service', '2026-02-20', '2026-02-21', '07:30:00', '21:30:00', 'daily_worker', 250000, 'Bogor West Java', '', '', 'open', '2026-01-26 01:36:37', NULL, NULL, NULL, NULL, NULL),
(5, 1, 'FnB Product', '2026-02-21', '2026-02-22', '07:30:00', '17:30:00', 'daily_worker', 300000, 'Bogor West Java', '', '', 'open', '2026-01-26 01:36:47', NULL, NULL, NULL, NULL, NULL),
(6, 1, 'Security', '2026-02-22', '2026-02-23', '07:30:00', '17:30:00', 'daily_worker', 350000, 'Bogor West Java', '', '', 'open', '2026-01-26 02:07:23', NULL, NULL, NULL, NULL, NULL),
(7, 1, 'Marketing', '2026-02-23', '2026-02-24', '07:30:00', '17:30:00', 'daily_worker', 400000, 'Bogor West Java', '', '', 'open', '2026-01-26 02:07:55', NULL, NULL, NULL, NULL, NULL),
(8, 1, 'Bellboy', '2026-02-24', '2026-02-25', '07:30:00', '20:30:00', 'daily_worker', 400000, 'Bogor West Java', '', '', 'open', '2026-01-26 02:07:55', NULL, NULL, NULL, NULL, NULL),
(9, 1, 'Barista', '2026-02-25', '2026-02-26', '07:30:00', '17:30:00', 'daily_worker', 120000, 'Bogor, Jawa Barat', 'Melayani dan memasak untuk tamu hotel', '', 'open', '2026-02-05 20:21:58', 3, NULL, NULL, NULL, NULL),
(10, 1, 'Bartender', '2026-02-26', '2026-02-27', '07:30:00', '17:30:00', 'daily_worker', 120000, 'Bogor, Jawa Barat', 'Melayani dan memasak untuk tamu hotel', '', 'open', '2026-02-05 20:21:58', 3, NULL, NULL, NULL, NULL),
(11, 1, 'Cook', '2026-02-27', '2026-02-28', '07:30:00', '17:30:00', 'daily_worker', 120000, 'Bogor, Jawa Barat', 'Melayani dan memasak untuk tamu hotel', '', 'open', '2026-02-05 20:21:58', 3, NULL, NULL, NULL, NULL),
(14, 1, 'Food & Beverage Manager', '2026-02-01', '2026-04-30', '07:00:00', '17:00:00', 'coorporate', 120000, NULL, 'Mengontrol urusan F&B Hotel', NULL, 'open', '2026-02-19 21:55:46', 3, NULL, NULL, NULL, NULL);

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
(2, 2, 1, 'accepted', '2026-02-17 16:44:02', '2026-02-18 15:26:48', 3, NULL),
(4, 12, 1, 'accepted', '2026-02-18 19:19:54', '2026-02-18 19:20:16', 3, NULL),
(11, 14, 11, 'accepted', '2026-02-19 21:57:36', '2026-02-19 21:57:36', 3, NULL),
(12, 7, 11, 'accepted', '2026-02-19 21:58:31', '2026-02-19 21:58:46', 3, NULL);

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
(1, 2, 2, 1, 0, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_2_1_1771409398.jpg', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', '2026-02-18 07:09:58', 1, NULL, NULL, NULL, NULL),
(2, 2, 2, 1, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-18 18:21:20', NULL, NULL, NULL, NULL, NULL),
(3, 12, 4, 1, NULL, 'checkin', -6.6011188, 106.7941239, 'uploads/attendance/checkin_12_1_1771422651.jpg', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36 Edg/145.0.0.0', '2026-02-18 08:50:51', 1, NULL, NULL, NULL, NULL),
(4, 12, 4, 1, NULL, 'checkout', 0.0000000, 0.0000000, 'system-auto-checkout', 'AUTO SYSTEM', '2026-02-18 18:57:47', NULL, NULL, NULL, NULL, NULL);

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
(10, 1, 'd86fcd19bd505ba442c8f5310a35db35b65d7ecfb4d288148823a75481e3ea3a3eb7664a044946dbd7375ac829177c70f9b1058fac40477fdeabec915d77dcb9', '2026-03-21 18:20:38', '2026-02-19 18:20:38'),
(11, 1, '4e79f4a134b39f71c49f087e6039af56c9f3695d638ec24ec3716ccd52657ffa093ddc23ea662493248e26c45d03bcaea35c25bf74771cc259efc965f753d3a2', '2026-03-22 13:20:48', '2026-02-20 13:20:48'),
(12, 1, '84640708db0887a55590d624a1889dea12fcfde7119c78c81848f5d6d6d62c861a4bf93934ba4a0edae09015718ff0027ba14ee016c85d133c3f58677622b5f4', '2026-03-22 13:21:12', '2026-02-20 13:21:12'),
(13, 1, 'ac241bec8bc5baf71fd6f0382e5aed4b386862135afd02baf11bee9967f04c804fb806ebe158c8be7146d64db2a5bff55e7ed9674d603bc954a42c2cb8a98d62', '2026-03-22 13:21:43', '2026-02-20 13:21:43'),
(14, 1, 'f056c80b12b7385f4b8ddce04cd439ba8942b37da7f230958349f3e1492f4f451cfdecb69c8c563ecbc55d002272b9ef81d26a624e24157c67a70c0d80ab4e69', '2026-03-20 14:05:55', '2026-02-18 14:05:55'),
(15, 1, '03aa5c4d225d8b976efcba87f65601f45309d58d1c5eff8db22aca3e685eb0991c0526f9bcef37e5bf1c5ffdb408344a381dbf113456207b7aa4f101c3b444a3', '2026-03-20 14:31:52', '2026-02-18 14:31:52'),
(16, 1, 'a7e225198efcc74b0024b5c1aba5d389ed8ff372112a7b8844bde6da19d9fec50672447a5ecddc2bbfd9c4aa55bb87487cc485f57eb943d9753c6b00f90585a2', '2026-03-20 14:51:04', '2026-02-18 14:51:04'),
(17, 1, '1281ebb589b892027903bcc2f71ff9d6f799ddad0846938e3fc98a5253b4f8a5453c0443e4043c94f3a8c5364141c99417ce80cf337581808eb5b2a4e4aa23db', '2026-03-20 14:51:25', '2026-02-18 14:51:25'),
(18, 1, '23bf6d131bd8bee24b8eb95ec4f4d307588c0390c0dccc95e10c2812566706473dd3b296b77cf126bd21e947bc9e3f73b848f117bb396e273c3c381866776446', '2026-03-20 14:52:38', '2026-02-18 14:52:38'),
(19, 1, '5abc327c91bd78534268b896cfbdfc7652bc73260cb0456c10b57cba8ab82c0bd6cc3d10b9f0590009f51cf423bfb861964a4683f505957788a954849e743d23', '2026-03-20 15:09:55', '2026-02-18 15:09:55'),
(20, 1, 'b8d00e7bacc5bd048d40cf8036e189b4270fab6f82b559f322520a8a5094a9f744516a092a674348b61b558b7893a34f513bc034b3359a5feb4b0cf120b1eef6', '2026-03-20 15:10:10', '2026-02-18 15:10:10'),
(21, 1, 'fa7acc16ceb8ee6c1efb55de8e2505e6c9522954619268fcb148cf91c1800dfd7dd2fa46b1239205d6ca04c40fa3c786da478798b7224ed4895a49b6be080c9f', '2026-03-20 15:15:11', '2026-02-18 15:15:11'),
(22, 1, '0c94843fbfac4353a210c9875b21d2ccdc11a8706956f1fed37f335c026decf9f3434f40f4c86f6f462dbf04b59fccbf5fa19e4f21aa0f0622357bdf55d75908', '2026-03-20 15:17:37', '2026-02-18 15:17:37'),
(23, 1, '859c4a265dcd1ea36440b05f0a3bc2cff500567a7c810bdcfd98fabe72bc06fef158ba8230a488a2357c5cc68db40e5e0c89e3a231daa41b640d2810985d0c87', '2026-03-20 16:51:06', '2026-02-18 16:51:06'),
(24, 1, '6b967314fa85d6408eb318ebb208e8a5cef7c9e5ca7a360285909fe8d840e19eae4cb512fc07de9815da38d4730eade92bf1da0e02066882afa35253380e67f9', '2026-03-20 17:09:44', '2026-02-18 17:09:44'),
(25, 1, 'a23889f567cedd39e14ac58cecfe82bf6b641c6a1c97ab2c8ebf34bf547911767820328aefda421cd79d982b584b37588df6368483ce7a975e13501845f9239d', '2026-03-20 19:19:17', '2026-02-18 19:19:17'),
(26, 1, 'cc7de48d0b90b036e33851cd53a9928e254b4aa5788c4b6e3594447bc718da591bac91d684ab9fb0ffd32d1443788368788cc60b7ee81505e3feebbbdd7da3b2', '2026-03-20 19:35:41', '2026-02-18 19:35:41'),
(27, 1, 'c5e589231ff400b2e61f048039f4ce17b8a4b03ebb58ebb56c8bc9f1c116c0177d32d35b67e3149277bffe40158ebb716e7a96f75db22e4d79175db39b8dacb2', '2026-03-20 20:44:50', '2026-02-18 20:44:50'),
(28, 1, 'c0c51c31392c87bc1f59c3db80e9ab9513629700217bd6486407a196ef818d3e83c7bb5cb34aae4e78f7a13977268222b30c8e2f581061d9046f67006e9511a5', '2026-03-20 20:49:08', '2026-02-18 20:49:08'),
(29, 1, 'c0d548ac28c100505c135c94af000e2f151d6a2b01bc477bddc88c828836a394962204cd534102a08f6f2d52f568b1da290ef3beca64bac26797abfc582e210f', '2026-03-20 20:49:40', '2026-02-18 20:49:40'),
(30, 1, '25fca5221f5cbb491a89fab3a58d0e71d127aeacd2273b20771a3623164aa04751868c18b95048795d312bdb30df732785d3b50680490b65ff5c1e53b5a39d55', '2026-03-20 20:50:02', '2026-02-18 20:50:02'),
(31, 1, 'faaa841acc7940dae712cdec1f6cc46f2dd69eddf2e3f7dd40ef0996bb3c458f7b09b6c4c7634e69b0e86dbda469011a5352dbb88ca75ec2d582eb58d1335518', '2026-03-20 20:50:32', '2026-02-18 20:50:32'),
(32, 6, '2afc963b5127aecdfd7c157656ca05c0a7d266aa0293d8c1be7fa5ea74c1988b2550a24aecf0508df9d232eb0293f8783a5f7bdca6187d97efaea35a4f381a10', '2026-03-21 19:29:46', '2026-02-19 19:29:46'),
(33, 6, '375ff62a7be0f9b61653006720c1bfbf02b891b7ba24cb5ed0c9724d13cd38991de6778eee25788cecd2042845161339ac8482ab32f28f15fead32b6c2f4d192', '2026-03-21 19:30:26', '2026-02-19 19:30:26'),
(34, 6, '31520709b46ec53acfd2dd2b561e03e3516cae953a53558776555d9a88301e71935ccf45403447388e529b5df6261cd748b7aae8c5e76f05e38bf288a7ba7475', '2026-03-21 19:35:29', '2026-02-19 19:35:29'),
(35, 6, 'db46f8197f826b7bd08d7aba6df88dee6a07e1dcf4714508526ae68c844b223386421d7b329524b998d52ef8e8d043e12132ad2a74e3779d7e6170b1fe0e9e2d', '2026-03-21 19:36:19', '2026-02-19 19:36:19'),
(36, 6, '97c5a8df86ce35b009a98d259387fe4146a429673292600642f6b024ec7cf4e8b7190cfcd4d98bb663c55b6f7ea840dc5b5707145850057ebbee74ae43d6e01f', '2026-03-21 19:37:34', '2026-02-19 19:37:34'),
(37, 6, '1111c9fec6cb9711f619436f592384be95c227ecb4c3f5c7743add13eaedcf5e5113c69270b6d4eaf0fa21c01671738117ebd144548d0701e64d6398c035f1e7', '2026-03-21 19:38:18', '2026-02-19 19:38:18'),
(38, 6, '495c2309fbc74b0f230c0aa9a6584262dfb54e1a3c12dcffcbdc1623a28a83bb403ac739fb808bec6565dffca03cba4ff4b469b895fae3d3899a8f5b90607200', '2026-03-21 19:39:01', '2026-02-19 19:39:01'),
(39, 6, 'c6e5422667f407f005aebbe2fe6d7b79c972f11a9562252d0892f9bfe680958a9308aac8219f36862a8f57a115e726b4296b27f3b93579b0e8de9df89a8b3f82', '2026-03-21 19:39:41', '2026-02-19 19:39:41'),
(40, 10, '25cdbb7b36b2bce2fca386871c33892966b8542e9b18c75294d80ea3a87208d89d5f2e2a12ba04138043f788588126316a0bdc6a14bdedbb45655791c1fa5eae', '2026-03-21 19:53:34', '2026-02-19 19:53:34'),
(41, 11, '932b4f8126532879db7afa8d62fec3ab92bd78d955b2250c46723acc6f0e744cb4fcdaccb7299a02a0f3f1209d53ab73ff2ff464e15f25007017e11f0aa4118a', '2026-03-21 21:58:17', '2026-02-19 21:58:17'),
(42, 11, 'b9ffde83786554890f68a0e3d9a878df059ae147b87426cf6d53d895ac3a29261753e8b90ab6d0b5323f0d62ee79a47bc59013a6f15a5d2bd15814ff0e8a8733', '2026-03-21 21:59:02', '2026-02-19 21:59:02');

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
(1, 0, 'worker', 'Mick Jagger', 'admin@admin.com', '0812', '$2y$10$TYZN8k0YxaB.jxCtqA4sl.JnllEeN3/UF9oGYK5.LTvbGlCe7HE82', 'local', NULL, 'uploads/profiles/profile_2_1768811928.png', 0, 'active', '2026-01-18 12:25:53', 1, NULL, NULL, NULL, NULL),
(2, 1, 'hotel_hr', 'Arya Seftian', 'yerblues6@gmail.com', '895330907220', '$2y$10$ziaDpWwWk3gBjVGu6XqmoebCqmePQwtuwaRGY5ggXBpOI/.Wubhq.', 'local', NULL, 'uploads/profiles/profile_2_1768811928.png', 0, 'active', '2026-01-18 18:59:55', NULL, '2026-01-19 08:38:48', NULL, NULL, NULL),
(3, 1, 'admin', 'Muhammad', 'muhammad@gmail.com', '99988776', '$2y$10$relLlluCofLYvJKJDW65zuxFadTF4X4A.mCur9V2uEbiZVW8vGhaa', 'local', NULL, 'uploads/profiles/profile_3_1768820480.png', 0, 'active', '2026-01-19 10:53:08', NULL, '2026-02-03 10:39:03', NULL, NULL, NULL),
(4, 1, 'hotel_fnb_service', 'Muhammad', 'worker@gmail.com', '99988776', '$2y$10$relLlluCofLYvJKJDW65zuxFadTF4X4A.mCur9V2uEbiZVW8vGhaa', 'local', NULL, 'uploads/profiles/profile_3_1768820480.png', 0, 'active', '2026-01-19 10:53:08', NULL, '2026-02-03 10:39:03', NULL, NULL, NULL),
(11, 1, 'worker', 'ARYA', 'aryaseftzzz@gmail.com', '12345678', '$2y$10$IjZCDqrLF0sRno3N/9nhAervuBHYN8Nd/4Zomo0.Zo/V4447Wz3Ai', 'local', NULL, 'uploads/profiles/1771513056_81b7408381a221dd0232.png', 0, 'active', '2026-02-19 21:57:36', 3, '2026-02-19 21:57:36', 3, NULL, NULL);

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
(3, 11, 'corporate', NULL, '2026-02-01', '2026-04-30', 1, 'monthly', 6000000.00, 0.00, NULL, NULL, '2026-02-19 21:57:36', 3, '2026-02-19 22:10:13', NULL, NULL, NULL);

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
(34, 1, 10, '2026-02-18 19:19:41', 1, '2026-02-18 19:19:41', NULL, NULL, NULL),
(35, 1, 9, '2026-02-18 19:19:41', 1, '2026-02-18 19:19:41', NULL, NULL, NULL),
(36, 1, 36, '2026-02-18 19:19:41', 1, '2026-02-18 19:19:41', NULL, NULL, NULL);

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
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `job_applications`
--
ALTER TABLE `job_applications`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `job_attendances`
--
ALTER TABLE `job_attendances`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

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
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `skills`
--
ALTER TABLE `skills`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `worker_contracts`
--
ALTER TABLE `worker_contracts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

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
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

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
