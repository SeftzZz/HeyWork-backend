-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 18, 2026 at 05:39 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

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
-- Table structure for table `jobs`
--

CREATE TABLE `jobs` (
  `id` int(1) NOT NULL,
  `hotel_name` varchar(150) NOT NULL,
  `position` varchar(100) NOT NULL,
  `job_date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `fee` int(1) NOT NULL,
  `location` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `status` enum('open','closed') DEFAULT 'open',
  `created_at` datetime DEFAULT NULL,
  `created_by` int(1) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `job_applications`
--

CREATE TABLE `job_applications` (
  `id` int(1) NOT NULL,
  `job_id` int(1) NOT NULL,
  `user_id` int(1) NOT NULL,
  `status` enum('pending','accepted','rejected','completed') DEFAULT 'pending',
  `applied_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

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
  `created_at` datetime DEFAULT NULL
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
(1, 1, '9d0cb9b1e472fbf4499260f3eb10aca208c260e0c0239964ab0730eb766d31c2bd678a6f872119c6814977e4ecbedf4ae035737786511af1679477d403dbd658', '2026-02-17 08:06:41', '2026-01-18 08:06:41'),
(2, 1, 'fa9523e98358ba1244822259c6cd6afa0a935e708e311b21f4d285e3b43f6f5c5df33b7b12be71663a2ca2dddf5401238509ab836d14cca49674a2c4057a79ae', '2026-02-17 08:08:35', '2026-01-18 08:08:35'),
(3, 1, '96ad5b02074ffc7e9f718ce7e26b9674c3e3c726adab30ff8e2683c46ecd2fd0c3c29511a817cb98aeebb58aad3b86accae43cc22919f6a3a1bd12e544530328', '2026-02-17 08:08:49', '2026-01-18 08:08:49'),
(4, 1, '9c25c660966db227cc7245335bf68bc86bfdbd53aa454a4bdf839d46745eee91cf87c8a82cdb9d11a57c374da71df5687b744582bbedec8e1a3d0306d2c6059a', '2026-02-17 08:34:43', '2026-01-18 08:34:43'),
(5, 1, 'c5363c19e7ad13e1c0e6c08e0ae7a487727b1af8b89f76525fdf06d0a38cd572dd47667b36fe2ee768ffbaf5f160d1aebc639555c5b280cc5c5695811de4eda5', '2026-02-17 08:59:05', '2026-01-18 08:59:05'),
(6, 1, '3a27a24b5f3b84f680133fabc852de907a85b5ed4e14dd7b5e3f448477967ca294a46968739a904a1ca5883ca86736c7c32a0e5d5808ef1ca13811a1c746457b', '2026-02-17 09:02:49', '2026-01-18 09:02:49'),
(7, 1, '4d2ebfaf3ade27d8e43663be70edc9c14752920aeb43b02c60931634d96c71a184b36a3cc050d734534c89492d7bca81862bd90508da3cf22ed502bc58aa3b6c', '2026-02-17 09:17:19', '2026-01-18 09:17:19'),
(8, 1, '6a0c8a17ffe2d69bee95401dbe55a3e3f69518f36a2903c0478234aae6ecd68c816e988381175beb3f2fa5fdaa2444dbe260a225ec4dbc62b989387eb9f558a1', '2026-02-17 09:24:12', '2026-01-18 09:24:12'),
(9, 1, '9a7479f1d84c99408a667daa701983d05615490be047d9f69ab9dda1ecf4689874fae12ccc7ee0c6932895b3131417e546de0db83df8c0980a13f99611255f45', '2026-02-17 09:24:39', '2026-01-18 09:24:39'),
(10, 1, 'f71f9f805d4f254b5834c1802ec0aa7727807e80f97dca4a8b378d0c4a4781bc1e044b7e8ec4a1d9327d10a7f3a47b8be6f1da96056fa1451f68d7ebeaa5bcb2', '2026-02-17 09:25:36', '2026-01-18 09:25:36'),
(11, 1, 'b1a1063c9a2ae3f7eaf8459d7c2eb1db5e8097c595f74c7725b3dca12e2ef90bf063d170e212cb34eb9ddf8090017b6d8fb5793155943f2bcf138bfeeda9b403', '2026-02-17 09:26:21', '2026-01-18 09:26:21'),
(12, 1, 'd21af9f937be587ba30460d310136a074df29ccbc31ab957562deac8e6966389af54e38307192f3821c63bc5aeeed7a42a8ba34608292b5589a5dcbdf53e1e89', '2026-02-17 09:26:40', '2026-01-18 09:26:40'),
(13, 1, '9e5295775397876c8183afa54c125579e029e8dcf12851f88f33ce32ef2088e43c583a721894392120793c6e3fca5208ab09e7d22f241ebc165b89b95ae5c453', '2026-02-17 09:40:56', '2026-01-18 09:40:56'),
(14, 1, 'ba67f1190910081e9e76f4af87e6ae4d7ee7f46cf0c43e8e395729dd78a826059dbde35051360578bd48ea22e7fef391c6ba56b7e9d3a6892e62cb159d206a66', '2026-02-17 09:41:20', '2026-01-18 09:41:20'),
(15, 1, 'fd2560048bb30aac6061c13675114448545ec39f33d840ff45fbc720f6a93b2b0f4a184ac01efb527617f572abb28af783bfc70cfd6b940e1926e5f2c071f011', '2026-02-17 09:43:35', '2026-01-18 09:43:35'),
(16, 1, '7edb5fb2ab52e966e98b1e09c4b70af11f0634d78214c721f811656625e9f39cbb984855bc075b56b7c8b0693c8475437b6c578b51697ac91bc6aac60018c630', '2026-02-17 09:49:45', '2026-01-18 09:49:45'),
(17, 1, '9ee28a754365f6360f69f8aca3206c960853139550b6f26aa5550f59ac9946c73a886c7f20a9f50fec89deff10db602686c5b4d2462d5b9760b65d5f62bae7be', '2026-02-17 09:50:43', '2026-01-18 09:50:43'),
(18, 1, '672c13c8f7ba788ce81cefcf738ddcdbfc1a8fcd3010db6d1dfb7752faa09838ce17d399b94c3c12e5dcea00dda82f17195ed9e679803af9b119efe0f0081a30', '2026-02-17 10:08:51', '2026-01-18 10:08:51'),
(19, 1, '36588d96e7c238d038161a6d026a79b30e26fc9f2fcc91c911f00fef7c6205d4ff82451dfd796319a3ae5f12782dc644552590a22e37f74d08dc568d8a491a4b', '2026-02-17 10:11:47', '2026-01-18 10:11:47'),
(20, 1, '7dac2e67c183f0397deb092f939191b714bb396553e407450cc5212c0b2bdd587ae13940a005f24fe29e86efff15cebd15d2b8cbe05becdd8d566e337a311e5d', '2026-02-17 10:14:23', '2026-01-18 10:14:23'),
(21, 1, 'd464b5e4ec4a4dcd0125e4ab6f9e7a3b0df6d502a0f7c9cd00bf8b51355f9ea151e8786ad43c86669bebcbdd066dcfcfc7eb16812964150272a4716e740d426c', '2026-02-17 10:16:48', '2026-01-18 10:16:48'),
(22, 1, 'db12a185fb97503e95b9b356c4ebf03041c5f3e9aa41958022b3efe9a739363035b166311b9b3aec9d0f34a932a258e75696b1296eca95cb057f26423a6ecddf', '2026-02-17 10:18:40', '2026-01-18 10:18:40'),
(23, 1, '15ed788fa7ed045e78bd9be54fb3c55678939bad0036f93b3a7b3ebc31cc7863bf95a599ca7eaa594e2c7ea3ae4e3f86b12887fb2d840155d3373fc1e0f11c4f', '2026-02-17 10:24:09', '2026-01-18 10:24:09'),
(24, 1, 'e6f003b00b0fb68597ce005d6e0d2bebbde0227ee65d7c17eec6d65a62c1259f7cfd43db85f6d7e322bb434a36a077d399c3e5833f0ef916665aa9ee951800bf', '2026-02-17 10:29:41', '2026-01-18 10:29:41'),
(25, 1, '5f3ab4fa44c2f219b8ac4adb8fbf2e77498101a8628ae1cf84808abcd8a178c0bdb232ab3ded73458e89b7d096071a38264891c9194cd29b80fa02e2cafbf967', '2026-02-17 10:31:33', '2026-01-18 10:31:33'),
(26, 1, 'dbfb4adca93a0b7ea87f00d89f230fbd699ec13d6231689cfbdd6a34cce8e6ea3404d73d1155a3714895de8ea25c25390f653e43cef55bbaed63b9d0aa24e252', '2026-02-17 10:34:32', '2026-01-18 10:34:32'),
(27, 1, 'ccd429f10691888aed08766d0b0a9cc30c5df4f803866546e364ee291e866df69306cf96ee5d8ba64ac2dea1297e9cc8a5c4097d93dbddf46019b67801f46a03', '2026-02-17 10:48:52', '2026-01-18 10:48:52'),
(28, 1, '6bdd9f095f9f089fefc89c0655eefd8cec3c850f8ccfd82590c427056fc3266122fa5587cccf7018a98f1709ae6df99721fda10b492515f1654e61e84b74ed54', '2026-02-17 10:51:36', '2026-01-18 10:51:36'),
(29, 1, 'c90c1cdf2bf20a68dd454872ba4d1ec98c1603d37bc20d736f6031b006ec1e68a84662c3204f028083ea3adfdb0a860dede50898ad6205670d0c00b648604a15', '2026-02-17 11:12:53', '2026-01-18 11:12:53'),
(30, 1, 'b38cae0efb1b369681868422f6d3bbe0d55d0dae57042897d27106bf1be2b387218d4bdfce46a1d5c6841d230fa550819b585b63324a80593a69489fd365b7a0', '2026-02-17 11:14:45', '2026-01-18 11:14:45'),
(31, 1, '8e66e5c08fc53d4bd55b0343471677c48c67a2858b634ebf85094e61bbd863a67c16cf1d16449c993f045f434a8ce9c7a1b908775fb1cd12fd6e4eb3e4849031', '2026-02-17 11:50:58', '2026-01-18 11:50:58'),
(32, 1, '7a7ca2d018f18ad963e412468449d11e62080bcb4e71760510cbd86d537ef17a53c9a2ad672ca6e153fbaeb48356b2b81045e40be8d7f39eae1348210290ada5', '2026-02-17 11:56:09', '2026-01-18 11:56:09'),
(33, 1, '3f11962e446a710cf5a199b3dee4b22e57b53fcd7d5b99229e77d41c7c260ab087058a78dee6314f94469b2d78354786ad9443a8c9ad27a71c49fd1001f91422', '2026-02-17 11:57:55', '2026-01-18 11:57:55'),
(34, 1, '58d6bdfd967a6bc88ca150307d1af7ad5caf22b82dbc602f5d0881b19d72864cb67a335d0162e9fdcdb6893ae10e17fd5c525ebc8e1e5f6d162a9809a17deebf', '2026-02-17 11:59:28', '2026-01-18 11:59:28'),
(35, 1, '5ac35ca4444c232fb52d01594284d24686de29844d1657430c55d983b3c7e75d1fed5dd2404e6361dfcd5413e90d357d498c64fdc1ba7aee645e5bfb693aaf7f', '2026-02-17 11:59:32', '2026-01-18 11:59:32');

-- --------------------------------------------------------

--
-- Table structure for table `skills`
--

CREATE TABLE `skills` (
  `id` int(1) NOT NULL,
  `name` varchar(100) NOT NULL,
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

INSERT INTO `skills` (`id`, `name`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
(1, 'Housekeeping', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(2, 'Waiter', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(3, 'Cook Helper', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(4, 'Public Area', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL),
(5, 'Front Office', '2026-01-18 00:54:00', 1, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(1) NOT NULL,
  `role` enum('worker','hotel','admin') DEFAULT 'worker',
  `name` varchar(100) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `phone` varchar(20) DEFAULT NULL,
  `password` varchar(250) DEFAULT NULL,
  `provider` enum('local','google','facebook') DEFAULT 'local',
  `provider_id` varchar(100) DEFAULT NULL,
  `photo` varchar(250) DEFAULT NULL,
  `is_verified` tinyint(4) DEFAULT 0,
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

INSERT INTO `users` (`id`, `role`, `name`, `email`, `phone`, `password`, `provider`, `provider_id`, `photo`, `is_verified`, `created_at`, `created_by`, `updated_at`, `updated_by`, `deleted_at`, `deleted_by`) VALUES
(1, 'worker', 'Administrator', 'admin@admin.com', '0812', '$2y$10$TYZN8k0YxaB.jxCtqA4sl.JnllEeN3/UF9oGYK5.LTvbGlCe7HE82', 'local', NULL, NULL, 0, '2026-01-18 12:25:53', 1, NULL, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `worker_documents`
--

CREATE TABLE `worker_documents` (
  `id` int(1) NOT NULL,
  `user_id` int(1) NOT NULL,
  `type` enum('ktp','certificate','other') DEFAULT 'other',
  `file_path` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

-- --------------------------------------------------------

--
-- Table structure for table `worker_experiences`
--

CREATE TABLE `worker_experiences` (
  `id` int(1) NOT NULL,
  `user_id` int(1) NOT NULL,
  `company_name` varchar(150) DEFAULT NULL,
  `position` varchar(100) DEFAULT NULL,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `created_by` int(1) DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `updated_by` int(1) DEFAULT NULL,
  `deleted_at` datetime DEFAULT NULL,
  `deleted_by` int(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

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
-- Indexes for dumped tables
--

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
-- Indexes for table `worker_experiences`
--
ALTER TABLE `worker_experiences`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `worker_profiles`
--
ALTER TABLE `worker_profiles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_id` (`user_id`);

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
-- AUTO_INCREMENT for table `jobs`
--
ALTER TABLE `jobs`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `job_applications`
--
ALTER TABLE `job_applications`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ratings`
--
ALTER TABLE `ratings`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `refresh_tokens`
--
ALTER TABLE `refresh_tokens`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `skills`
--
ALTER TABLE `skills`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `worker_documents`
--
ALTER TABLE `worker_documents`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `worker_experiences`
--
ALTER TABLE `worker_experiences`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `worker_profiles`
--
ALTER TABLE `worker_profiles`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `worker_skills`
--
ALTER TABLE `worker_skills`
  MODIFY `id` int(1) NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
