-- phpMyAdmin SQL Dump
-- version 4.4.14
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Dec 03, 2015 at 10:31 PM
-- Server version: 5.6.26
-- PHP Version: 5.6.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `eventmanagementsystem`
--

-- --------------------------------------------------------

--
-- Table structure for table `booking`
--

CREATE TABLE IF NOT EXISTS `booking` (
  `booking_id` int(11) NOT NULL,
  `id` int(11) NOT NULL,
  `customer_id` int(11) NOT NULL,
  `number_of_tickets` int(11) NOT NULL,
  `price` float NOT NULL,
  `booking_flag` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Triggers `booking`
--
DELIMITER $$
CREATE TRIGGER `tkt_trigger` AFTER INSERT ON `booking`
 FOR EACH ROW Begin
Update event_venue set event_venue.total_seats = event_venue.total_seats - NEW.number_of_tickets where event_venue.id = new.id;
end
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `tkt_trigger_cancellation` BEFORE DELETE ON `booking`
 FOR EACH ROW Begin
Update event_venue set event_venue.total_seats = event_venue.total_seats + old.number_of_tickets where id = old.id;
end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

CREATE TABLE IF NOT EXISTS `category` (
  `event_id` int(11) NOT NULL,
  `category` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`event_id`, `category`) VALUES
(1, 'Action'),
(1, 'Science Fiction'),
(2, 'Thriller');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE IF NOT EXISTS `customer` (
  `customer_id` int(11) NOT NULL,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `email` varchar(30) NOT NULL,
  `password` varchar(20) NOT NULL,
  `cc_number` int(16) NOT NULL,
  `cc_cvv` int(3) NOT NULL,
  `cc_exp` date NOT NULL,
  `cc_name` varchar(25) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customer_id`, `first_name`, `last_name`, `email`, `password`, `cc_number`, `cc_cvv`, `cc_exp`, `cc_name`) VALUES
(1, 'Anil', 'Zack', 'az@uncc.edu', 'az', 2345, 123, '2015-11-30', 'azz'),
(2, 'zoey', 'xavier', 'zx@uncc.edu', 'zx', 5678, 678, '2015-11-26', 'cgscxs');

-- --------------------------------------------------------

--
-- Table structure for table `event`
--

CREATE TABLE IF NOT EXISTS `event` (
  `event_id` int(11) NOT NULL,
  `event_name` varchar(30) NOT NULL,
  `type` varchar(20) NOT NULL,
  `description` varchar(70) NOT NULL,
  `duration` float NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `event`
--

INSERT INTO `event` (`event_id`, `event_name`, `type`, `description`, `duration`) VALUES
(1, 'Star wars', 'Movie', 'abc', 1.5),
(2, 'Star Trek', 'Movie', 'nmko', 1.2);

-- --------------------------------------------------------

--
-- Table structure for table `event_venue`
--

CREATE TABLE IF NOT EXISTS `event_venue` (
  `id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `venue_id` int(11) NOT NULL,
  `play_date` date NOT NULL,
  `play_time` time NOT NULL,
  `total_seats` int(11) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `event_venue`
--

INSERT INTO `event_venue` (`id`, `event_id`, `venue_id`, `play_date`, `play_time`, `total_seats`) VALUES
(1, 1, 1, '2015-11-11', '01:10:00', 100),
(2, 1, 1, '2015-11-11', '08:00:00', 100);

-- --------------------------------------------------------

--
-- Table structure for table `featuring`
--

CREATE TABLE IF NOT EXISTS `featuring` (
  `event_id` int(11) NOT NULL,
  `feat_name` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `featuring`
--

INSERT INTO `featuring` (`event_id`, `feat_name`) VALUES
(2, 'AVBC'),
(2, 'Zack');

-- --------------------------------------------------------

--
-- Table structure for table `feedback`
--

CREATE TABLE IF NOT EXISTS `feedback` (
  `customer_id` int(11) NOT NULL,
  `event_id` int(11) NOT NULL,
  `review` varchar(1000) DEFAULT NULL,
  `rating` enum('1','2','3','4','5') NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `ticket`
--

CREATE TABLE IF NOT EXISTS `ticket` (
  `event_id` int(11) NOT NULL,
  `venue_id` int(11) NOT NULL,
  `price` decimal(10,0) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `ticket`
--

INSERT INTO `ticket` (`event_id`, `venue_id`, `price`) VALUES
(1, 1, '120'),
(2, 1, '100');

-- --------------------------------------------------------

--
-- Table structure for table `venue`
--

CREATE TABLE IF NOT EXISTS `venue` (
  `venue_id` int(11) NOT NULL,
  `venue_name` varchar(20) NOT NULL,
  `Capacity` int(3) NOT NULL
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `venue`
--

INSERT INTO `venue` (`venue_id`, `venue_name`, `Capacity`) VALUES
(1, 'Gopalan', 0),
(2, 'Mantri', 0);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `booking`
--
ALTER TABLE `booking`
  ADD PRIMARY KEY (`booking_id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `id` (`id`);

--
-- Indexes for table `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`event_id`,`category`);

--
-- Indexes for table `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`customer_id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Indexes for table `event`
--
ALTER TABLE `event`
  ADD PRIMARY KEY (`event_id`);

--
-- Indexes for table `event_venue`
--
ALTER TABLE `event_venue`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `uniq_const` (`event_id`,`play_date`,`play_time`,`venue_id`),
  ADD KEY `event_id` (`event_id`),
  ADD KEY `venue_id` (`venue_id`);

--
-- Indexes for table `featuring`
--
ALTER TABLE `featuring`
  ADD PRIMARY KEY (`event_id`,`feat_name`);

--
-- Indexes for table `feedback`
--
ALTER TABLE `feedback`
  ADD PRIMARY KEY (`customer_id`,`event_id`),
  ADD KEY `event_id` (`event_id`);

--
-- Indexes for table `ticket`
--
ALTER TABLE `ticket`
  ADD PRIMARY KEY (`event_id`,`venue_id`),
  ADD KEY `venue_id` (`venue_id`);

--
-- Indexes for table `venue`
--
ALTER TABLE `venue`
  ADD PRIMARY KEY (`venue_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `booking`
--
ALTER TABLE `booking`
  MODIFY `booking_id` int(11) NOT NULL AUTO_INCREMENT;
--
-- AUTO_INCREMENT for table `customer`
--
ALTER TABLE `customer`
  MODIFY `customer_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `event`
--
ALTER TABLE `event`
  MODIFY `event_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `event_venue`
--
ALTER TABLE `event_venue`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- AUTO_INCREMENT for table `venue`
--
ALTER TABLE `venue`
  MODIFY `venue_id` int(11) NOT NULL AUTO_INCREMENT,AUTO_INCREMENT=3;
--
-- Constraints for dumped tables
--

--
-- Constraints for table `booking`
--
ALTER TABLE `booking`
  ADD CONSTRAINT `booking_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  ADD CONSTRAINT `booking_ibfk_2` FOREIGN KEY (`id`) REFERENCES `event_venue` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `category`
--
ALTER TABLE `category`
  ADD CONSTRAINT `category_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`),
  ADD CONSTRAINT `category_ibfk_2` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`) ON DELETE CASCADE;

--
-- Constraints for table `event_venue`
--
ALTER TABLE `event_venue`
  ADD CONSTRAINT `event_venue_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `event_venue_ibfk_2` FOREIGN KEY (`venue_id`) REFERENCES `venue` (`venue_id`) ON DELETE CASCADE;

--
-- Constraints for table `featuring`
--
ALTER TABLE `featuring`
  ADD CONSTRAINT `featuring_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`) ON DELETE CASCADE;

--
-- Constraints for table `feedback`
--
ALTER TABLE `feedback`
  ADD CONSTRAINT `feedback_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  ADD CONSTRAINT `feedback_ibfk_2` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`) ON DELETE CASCADE;

--
-- Constraints for table `ticket`
--
ALTER TABLE `ticket`
  ADD CONSTRAINT `ticket_ibfk_1` FOREIGN KEY (`event_id`) REFERENCES `event` (`event_id`) ON DELETE CASCADE,
  ADD CONSTRAINT `ticket_ibfk_2` FOREIGN KEY (`venue_id`) REFERENCES `venue` (`venue_id`) ON DELETE CASCADE;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
