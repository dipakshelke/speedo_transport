-- phpMyAdmin SQL Dump
-- version 4.7.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 29, 2018 at 06:25 PM
-- Server version: 10.1.25-MariaDB
-- PHP Version: 7.1.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `tecvehicle`
--

-- --------------------------------------------------------

--
-- Table structure for table `cost`
--

CREATE TABLE `cost` (
  `v_id` int(11) NOT NULL,
  `v_type` varchar(20) NOT NULL,
  `cost_per_km` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `cost`
--

INSERT INTO `cost` (`v_id`, `v_type`, `cost_per_km`) VALUES
(1, 'Container', 500),
(2, 'JCB', 1000),
(3, 'Crane', 1000),
(4, 'Pickup', 500),
(5, 'Tractor', 500);

-- --------------------------------------------------------

--
-- Table structure for table `driver`
--

CREATE TABLE `driver` (
  `d_id` int(11) NOT NULL,
  `d_name` varchar(50) NOT NULL,
  `d_mob` varchar(11) NOT NULL,
  `d_email` varchar(50) NOT NULL,
  `d_password` varchar(20) NOT NULL,
  `d_area` varchar(50) NOT NULL,
  `vehicle_id` varchar(10) NOT NULL,
  `v_type` varchar(30) NOT NULL,
  `d_licence` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `driver`
--

INSERT INTO `driver` (`d_id`, `d_name`, `d_mob`, `d_email`, `d_password`, `d_area`, `vehicle_id`, `v_type`, `d_licence`) VALUES
(11, 'dipak', '8975212080', 'dipak@gmail.com', 'dipak123', 'katraj', 'MH145060', 'Container', 'mh1234567'),
(12, 'sachin', '9604991011', 'sachin@gmail.com', 'sachin123', 'swargate', 'MH204050', 'JCB', 'LKGHTI12345'),
(13, 'suaraj', '9545321280', 'suraj@gmail.com', 'suraj123', 'shivajinagar', 'MH202025', 'Crane', 'MK123HUPL'),
(14, 'payal', '7709928447', 'payal@gmail.com', 'payal123', 'vadgaon', 'MH207023', 'Tractor', 'LKSWTY1234'),
(15, 'raj', '8975073743', 'raj@gmail.com', 'raj123', 'kothrud', 'MH175169', 'Pickup', 'HJIOP90890'),
(16, 'manish', '8975212020', 'manish@gmail.com', 'manish123', 'kothrud', 'MH14 5150', 'Pickup', 'QW1234567891234');

-- --------------------------------------------------------

--
-- Table structure for table `history`
--

CREATE TABLE `history` (
  `h_id` int(11) NOT NULL,
  `req_id` int(11) NOT NULL,
  `d_id` int(11) NOT NULL,
  `u_id` int(11) NOT NULL,
  `source` varchar(50) NOT NULL,
  `destination` varchar(50) NOT NULL,
  `est_cost` int(11) NOT NULL,
  `date_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `history`
--

INSERT INTO `history` (`h_id`, `req_id`, `d_id`, `u_id`, `source`, `destination`, `est_cost`, `date_time`) VALUES
(16, 1, 12, 11, 'swargate', 'swargate', 3000, '2017-10-09 18:30:00'),
(17, 3, 12, 11, 'swargate', 'shivajinagar', 4000, '2016-10-09 18:30:00'),
(18, 8, 12, 2, 'swargate', 'shivajinagar', 2000, '2017-10-09 18:30:00'),
(19, 9, 13, 11, 'shivajinagar', 'kothrud', 5000, '2017-10-12 14:44:14'),
(20, 7, 13, 11, 'shivajinagar', 'swargate', 4000, '2017-10-12 14:44:29'),
(21, 10, 15, 11, 'kothrud', 'shivajinagar', 3000, '2017-10-12 14:56:09'),
(22, 3, 11, 11, 'katraj', 'swargate', 1000, '2017-11-08 07:44:26'),
(23, 4, 12, 11, 'swargate', 'swargate', 2000, '2017-11-08 07:57:07'),
(24, 2, 11, 11, 'katraj', 'swargate', 2500, '2017-11-11 10:47:01');

-- --------------------------------------------------------

--
-- Table structure for table `requests`
--

CREATE TABLE `requests` (
  `req_id` int(11) NOT NULL,
  `u_id` int(11) NOT NULL,
  `d_id` int(11) NOT NULL,
  `source` varchar(50) NOT NULL,
  `destination` varchar(50) NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'pending',
  `r_date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `v_type` varchar(20) NOT NULL,
  `hours` int(11) NOT NULL,
  `est_cost` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `requests`
--
DELIMITER $$
CREATE TRIGGER `estcost` BEFORE INSERT ON `requests` FOR EACH ROW set NEW.est_cost=NEW.hours * (SELECT cost_per_km from cost where v_type=new.v_type)
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `rides`
--

CREATE TABLE `rides` (
  `ride_id` int(11) NOT NULL,
  `req_id` int(11) NOT NULL,
  `u_id` int(11) NOT NULL,
  `d_id` int(11) NOT NULL,
  `source` varchar(50) NOT NULL,
  `destination` varchar(50) NOT NULL,
  `est_cost` int(11) NOT NULL,
  `status` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `u_id` int(11) NOT NULL,
  `u_name` varchar(30) NOT NULL,
  `u_mob` varchar(11) NOT NULL,
  `u_email` varchar(100) NOT NULL,
  `u_password` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`u_id`, `u_name`, `u_mob`, `u_email`, `u_password`) VALUES
(2, 'sunil', '9545321281', 'sunil@gmail.com', 'sunil123'),
(11, 'dipak', '8975212080', 'dipak@gmail.com', 'dipak123'),
(12, 'sarang', '9545321280', 'sarang@gmail.com', 'sarang123');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `cost`
--
ALTER TABLE `cost`
  ADD PRIMARY KEY (`v_id`);

--
-- Indexes for table `driver`
--
ALTER TABLE `driver`
  ADD PRIMARY KEY (`d_id`);

--
-- Indexes for table `history`
--
ALTER TABLE `history`
  ADD PRIMARY KEY (`h_id`),
  ADD KEY `d_id` (`d_id`);

--
-- Indexes for table `requests`
--
ALTER TABLE `requests`
  ADD PRIMARY KEY (`req_id`),
  ADD KEY `u_id` (`u_id`),
  ADD KEY `d_id` (`d_id`);

--
-- Indexes for table `rides`
--
ALTER TABLE `rides`
  ADD PRIMARY KEY (`ride_id`),
  ADD KEY `u_id` (`u_id`),
  ADD KEY `d_id` (`d_id`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`u_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `cost`
--
ALTER TABLE `cost`
  MODIFY `v_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;
--
-- AUTO_INCREMENT for table `driver`
--
ALTER TABLE `driver`
  MODIFY `d_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;
--
-- AUTO_INCREMENT for table `history`
--
ALTER TABLE `history`
  MODIFY `h_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;
--
-- AUTO_INCREMENT for table `requests`
--
ALTER TABLE `requests`
  MODIFY `req_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `rides`
--
ALTER TABLE `rides`
  MODIFY `ride_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `u_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `history`
--
ALTER TABLE `history`
  ADD CONSTRAINT `history_ibfk_1` FOREIGN KEY (`d_id`) REFERENCES `driver` (`d_id`);

--
-- Constraints for table `requests`
--
ALTER TABLE `requests`
  ADD CONSTRAINT `requests_ibfk_1` FOREIGN KEY (`u_id`) REFERENCES `user` (`u_id`),
  ADD CONSTRAINT `requests_ibfk_2` FOREIGN KEY (`d_id`) REFERENCES `driver` (`d_id`);

--
-- Constraints for table `rides`
--
ALTER TABLE `rides`
  ADD CONSTRAINT `rides_ibfk_1` FOREIGN KEY (`u_id`) REFERENCES `user` (`u_id`),
  ADD CONSTRAINT `rides_ibfk_2` FOREIGN KEY (`d_id`) REFERENCES `driver` (`d_id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
