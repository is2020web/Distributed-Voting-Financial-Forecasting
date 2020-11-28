-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 28, 2020 at 03:40 PM
-- Server version: 10.4.14-MariaDB
-- PHP Version: 7.4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `dist_vot_fin_for`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `load_currencies` ()  NO SQL
SELECT ticker, name AS pair FROM currency_pair ORDER BY ticker$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `store_vote` (IN `user_email` VARCHAR(50), IN `user_hash` VARCHAR(100), IN `ticker` VARCHAR(10), IN `vote` VARCHAR(10))  NO SQL
INSERT INTO `vote` (`direction`, `currency_pair_id`, `user_id`) VALUES (`vote`, (SELECT id FROM currency_pair WHERE currency_pair.ticker=`ticker`) , '1')$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `user_check` (IN `email` VARCHAR(50), IN `pass` VARCHAR(50), INOUT `hash` VARCHAR(100))  NO SQL
BEGIN

DECLARE registered INT DEFAULT 0;

SELECT COUNT(*) INTO @found FROM user WHERE user.email=email AND user.pass=pass AND user.hash=hash;

SELECT user.hash INTO @oldhash FROM user WHERE user.email=email AND user.pass=pass;

SELECT COUNT(*) INTO @logged FROM user WHERE user.email=email AND user.hash=hash;

SELECT COUNT(*) INTO registered FROM user WHERE user.email=email AND user.pass<>pass AND user.hash<>hash;

-- TODO Stop handling if there is an attacker.
-- IF 1 = registered THEN
-- 	RETURN;
-- END IF;
    
SELECT COUNT(*) INTO @newcomer FROM user WHERE user.email=email;

END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `currency_pair`
--

CREATE TABLE `currency_pair` (
  `id` int(11) NOT NULL,
  `ticker` varchar(10) NOT NULL,
  `name` varchar(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `currency_pair`
--

INSERT INTO `currency_pair` (`id`, `ticker`, `name`) VALUES
(1, 'EURUSD', 'EUR/USD'),
(3, 'GBPUSD', 'GBP/USD'),
(4, 'USDJPY', 'USD/JPY'),
(5, 'CHFUSD', 'CHF/USD'),
(6, 'NZDUSD', 'NZD/USD'),
(7, 'USDCND', 'USD/CND');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `email` varchar(50) NOT NULL,
  `pass` varchar(50) NOT NULL,
  `hash` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `email`, `pass`, `hash`) VALUES
(1, 'todor.balabanov@gmail.com', 'asdf', 'asdf');

-- --------------------------------------------------------

--
-- Table structure for table `vote`
--

CREATE TABLE `vote` (
  `id` int(11) NOT NULL,
  `time` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `direction` set('up','down') NOT NULL,
  `currency_pair_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `vote`
--

INSERT INTO `vote` (`id`, `time`, `direction`, `currency_pair_id`, `user_id`) VALUES
(41, '2020-11-28 11:18:49', 'up', 1, 1),
(42, '2020-11-28 11:19:14', 'down', 1, 1),
(43, '2020-11-28 11:19:30', 'down', 3, 1),
(44, '2020-11-28 11:20:21', 'up', 3, 1),
(45, '2020-11-28 11:20:38', 'down', 4, 1),
(46, '2020-11-28 12:13:42', 'down', 6, 1),
(47, '2020-11-28 12:25:38', 'down', 5, 1),
(48, '2020-11-28 12:27:12', 'down', 1, 1),
(49, '2020-11-28 12:27:45', 'down', 5, 1),
(50, '2020-11-28 12:30:35', 'up', 5, 1),
(51, '2020-11-28 12:30:39', 'down', 3, 1);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `currency_pair`
--
ALTER TABLE `currency_pair`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ticker` (`ticker`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vote`
--
ALTER TABLE `vote`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `currency_pair_id` (`currency_pair_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `currency_pair`
--
ALTER TABLE `currency_pair`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `vote`
--
ALTER TABLE `vote`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `vote`
--
ALTER TABLE `vote`
  ADD CONSTRAINT `vote_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON UPDATE CASCADE,
  ADD CONSTRAINT `vote_ibfk_2` FOREIGN KEY (`currency_pair_id`) REFERENCES `currency_pair` (`id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
