-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 05, 2020 at 03:25 PM
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
INSERT INTO `vote` (`direction`, `currency_pair_id`, `user_id`) VALUES (`vote`, (SELECT id FROM currency_pair WHERE currency_pair.ticker=`ticker`) , (SELECT id FROM user WHERE user.hash = `user_hash` AND user.email = `user_email`))$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `user_check` (IN `email` VARCHAR(50), IN `pass` VARCHAR(50), INOUT `hash` VARCHAR(100))  NO SQL
procdure_exit:BEGIN

DECLARE found INT DEFAULT 0;
DECLARE oldhash VARCHAR(100) DEFAULT 0;
DECLARE logged INT DEFAULT 0;
DECLARE registered INT DEFAULT 0;
DECLARE newcomer INT DEFAULT 0;
    
SELECT COUNT(*) INTO newcomer FROM user WHERE user.email=email;

-- If it is a new user make a record into users table.
IF 0 = newcomer THEN
	INSERT INTO user (user.email, user.pass, user.hash) VALUES (email, pass, hash);
	LEAVE procdure_exit;
END IF;

SELECT COUNT(*) INTO found FROM user WHERE user.email=email AND user.pass=pass AND user.hash=hash;

-- If user is found and its hash matches just return the hash.
IF 1 = found THEN
	LEAVE procdure_exit;
END IF;

SELECT COUNT(*) INTO logged FROM user WHERE user.email=email AND user.hash=hash;

-- If user is found and its hash matches just return the hash.
IF 1 = logged THEN
	LEAVE procdure_exit;
END IF;

SELECT user.hash INTO oldhash FROM user WHERE user.email=email AND user.pass=pass;

-- If the user is found but he/she has an old hash value, just take this value and return it.
IF oldhash <> hash THEN
	SET hash = oldhash;
	LEAVE procdure_exit;
END IF;

SELECT COUNT(*) INTO registered FROM user WHERE user.email=email AND user.pass<>pass AND user.hash<>hash;

-- Stop handling if there is an attacker.
IF 1 = registered THEN
	SET hash = 0;
	LEAVE procdure_exit;
END IF;

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
(7, 'USDCAD', 'USD/CAD'),
(8, 'CADCHF', 'CAD/CHF');

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
(0, 'null', 'null', ''),
(13, 'todor.balabanov@gmail.com', '1234', '9262'),
(18, 'is2020web@abv.bg', '5678', '9263');

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
(72, '2020-12-05 14:22:02', 'down', 1, 13),
(73, '2020-12-05 14:22:53', 'down', 3, 13),
(74, '2020-12-05 14:24:33', 'down', 8, 13),
(75, '2020-12-05 14:24:35', 'up', 8, 13);

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
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `vote`
--
ALTER TABLE `vote`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;

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
