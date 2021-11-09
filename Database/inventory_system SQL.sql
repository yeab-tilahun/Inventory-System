-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Sep 09, 2021 at 07:27 PM
-- Server version: 5.7.31
-- PHP Version: 7.3.21

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `inventory_system`
--

DELIMITER $$
--
-- Procedures
--
DROP PROCEDURE IF EXISTS `addBuy`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `addBuy` (IN `staffIn` INT, IN `productIn` INT, IN `supplierIn` INT, IN `quantityIn` INT, IN `priceIn` DOUBLE)  INSERT buy (`staffID`, `productID`, `supplierID`, `quantity`, `price`, `date`)
VALUES
(staffIn,productIn,supplierIn,quantityIn,priceIn, NOW())$$

DROP PROCEDURE IF EXISTS `addSell`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `addSell` (IN `staffIn` INT(11), IN `productIn` INT(11), IN `customerIn` INT(11), IN `quantityIn` INT(11), IN `priceIn` DOUBLE)  INSERT sell (`staffID`, `productID`, `customerID`, `quantity`, `price`, `date`)
VALUES
(staffIn,productIn,customerIn,quantityIn,priceIn, NOW())$$

DROP PROCEDURE IF EXISTS `getBuyNumber`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getBuyNumber` ()  SELECT COUNT(*)
FROM buy$$

DROP PROCEDURE IF EXISTS `getCategoryNumber`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getCategoryNumber` ()  SELECT COUNT(*)
FROM category$$

DROP PROCEDURE IF EXISTS `getCustomerNumber`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getCustomerNumber` ()  SELECT COUNT(*)
FROM customer$$

DROP PROCEDURE IF EXISTS `getPrice`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getPrice` (IN `pID` INT)  NO SQL
SELECT productPrice
From product
where pID = productID$$

DROP PROCEDURE IF EXISTS `getProductNumber`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getProductNumber` ()  READS SQL DATA
SELECT COUNT(*)
FROM product$$

DROP PROCEDURE IF EXISTS `getQuantity`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getQuantity` (IN `pID` INT)  SELECT productQuantity as PQ
FROM product
WHERE pID = productID$$

DROP PROCEDURE IF EXISTS `getSellNumber`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getSellNumber` ()  READS SQL DATA
SELECT COUNT(*)
FROM sell$$

DROP PROCEDURE IF EXISTS `getStaffNumber`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getStaffNumber` ()  READS SQL DATA
SELECT COUNT(*)
FROM staff$$

DROP PROCEDURE IF EXISTS `getStorageNumber`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getStorageNumber` ()  READS SQL DATA
SELECT COUNT(*)
FROM storage$$

DROP PROCEDURE IF EXISTS `getSupplierNumber`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `getSupplierNumber` ()  SELECT COUNT(*)
FROM supplier$$

DROP PROCEDURE IF EXISTS `updateBuy`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateBuy` (IN `productIn` INT(11), IN `quantityIn` INT)  UPDATE product
SET productQuantity = (productQuantity + quantityIn)
WHERE productID = productIn$$

DROP PROCEDURE IF EXISTS `updateSell`$$
CREATE DEFINER=`root`@`localhost` PROCEDURE `updateSell` (IN `productIn` INT(11), IN `quantityIn` INT(11))  MODIFIES SQL DATA
UPDATE product
SET productQuantity = (productQuantity - quantityIn)
WHERE productIn = productID$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `buy`
--

DROP TABLE IF EXISTS `buy`;
CREATE TABLE IF NOT EXISTS `buy` (
  `BuyID` int(11) NOT NULL AUTO_INCREMENT,
  `staffID` int(11) NOT NULL,
  `supplierID` int(11) NOT NULL,
  `productID` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` double NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`BuyID`),
  KEY `staffID` (`staffID`),
  KEY `supplierID` (`supplierID`),
  KEY `productID` (`productID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `category`
--

DROP TABLE IF EXISTS `category`;
CREATE TABLE IF NOT EXISTS `category` (
  `categoryName` varchar(15) NOT NULL,
  `categoryID` int(11) NOT NULL AUTO_INCREMENT,
  `Description` varchar(30) NOT NULL,
  PRIMARY KEY (`categoryID`)
) ENGINE=InnoDB AUTO_INCREMENT=406 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `category`
--

INSERT INTO `category` (`categoryName`, `categoryID`, `Description`) VALUES
('Electronics', 401, 'Phones,Laptops,Desktops...'),
('Cosmetics', 402, 'Makeups,brushes,perfume...'),
('Food', 403, 'Biscuits,tuna,oil...'),
('clothes', 404, 't-shirts,shirts,dresses..'),
('furniture', 405, 'chair,table,sofa..');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

DROP TABLE IF EXISTS `customer`;
CREATE TABLE IF NOT EXISTS `customer` (
  `Fname` varchar(15) NOT NULL,
  `Lname` varchar(15) NOT NULL,
  `customerID` int(11) NOT NULL AUTO_INCREMENT,
  `customerPhone` char(13) NOT NULL,
  `customerAddress` varchar(40) NOT NULL,
  `customerEmail` varchar(40) NOT NULL,
  PRIMARY KEY (`customerID`)
) ENGINE=InnoDB AUTO_INCREMENT=215 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`Fname`, `Lname`, `customerID`, `customerPhone`, `customerAddress`, `customerEmail`) VALUES
('Bereket', 'Endale', 201, '0951075991', 'Semit', 'beki21@gmail'),
('Beza', 'Teferi', 202, '0911451213', 'Six kilo', 'be2@gmail'),
('Bisrat', 'Kebede', 203, '0912115678', 'Lideta', 'Bib6@gmail'),
('Neda', 'Hashim', 204, '0956784352', 'Bisrate Gebrial', 'ned@gmail'),
('Edini', 'Tilahun', 205, '0987654322', 'Lebu', 'edi@gmail'),
('Retina', 'Scanner', 212, '11223511', 'Eye Clinic', 'Retina@biometrics.co'),
('', '', 214, '', '', '');

-- --------------------------------------------------------

--
-- Table structure for table `product`
--

DROP TABLE IF EXISTS `product`;
CREATE TABLE IF NOT EXISTS `product` (
  `productName` varchar(30) NOT NULL,
  `productID` int(11) NOT NULL AUTO_INCREMENT,
  `productPrice` double NOT NULL,
  `importDate` date NOT NULL,
  `productDescription` varchar(50) NOT NULL,
  `productQuantity` int(11) NOT NULL,
  `categoryID` int(11) NOT NULL,
  `storageID` int(11) NOT NULL,
  PRIMARY KEY (`productID`),
  KEY `catalogID` (`categoryID`),
  KEY `storageID` (`storageID`)
) ENGINE=InnoDB AUTO_INCREMENT=606 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `product`
--

INSERT INTO `product` (`productName`, `productID`, `productPrice`, `importDate`, `productDescription`, `productQuantity`, `categoryID`, `storageID`) VALUES
('HP spectre X360', 601, 40000, '2021-09-01', 'hp laptop', 8, 401, 501),
('MAC makeup', 602, 750, '2021-08-30', 'makeup brand', 22, 402, 502),
('Nana biscuit', 603, 5.5, '2021-09-06', 'creamy biscuit', 50, 403, 503),
('denim jeans', 604, 899.99, '2021-09-08', 'black, made in china', 100, 404, 504),
('Ballina Sofa', 605, 70000, '2021-07-01', 'greyish,made in turkey', 3, 405, 505);

-- --------------------------------------------------------

--
-- Table structure for table `sell`
--

DROP TABLE IF EXISTS `sell`;
CREATE TABLE IF NOT EXISTS `sell` (
  `Sell_ID` int(11) NOT NULL AUTO_INCREMENT,
  `staffID` int(11) NOT NULL,
  `productID` int(11) NOT NULL,
  `customerID` int(11) NOT NULL,
  `quantity` int(11) NOT NULL,
  `price` double NOT NULL,
  `date` date NOT NULL,
  PRIMARY KEY (`Sell_ID`),
  KEY `staffID` (`staffID`),
  KEY `productID` (`productID`),
  KEY `catalogID` (`customerID`)
) ENGINE=InnoDB AUTO_INCREMENT=528 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sell`
--

INSERT INTO `sell` (`Sell_ID`, `staffID`, `productID`, `customerID`, `quantity`, `price`, `date`) VALUES
(526, 111, 601, 201, 2, 4325, '2021-09-09'),
(527, 111, 602, 201, 3, 5654, '2021-09-09');

-- --------------------------------------------------------

--
-- Table structure for table `staff`
--

DROP TABLE IF EXISTS `staff`;
CREATE TABLE IF NOT EXISTS `staff` (
  `Fname` varchar(15) NOT NULL,
  `Lname` varchar(15) NOT NULL,
  `staffID` int(11) NOT NULL AUTO_INCREMENT,
  `staffAddress` varchar(40) NOT NULL,
  `staffPhone` char(13) NOT NULL,
  `staffEmail` varchar(40) NOT NULL,
  PRIMARY KEY (`staffID`)
) ENGINE=InnoDB AUTO_INCREMENT=118 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `staff`
--

INSERT INTO `staff` (`Fname`, `Lname`, `staffID`, `staffAddress`, `staffPhone`, `staffEmail`) VALUES
('Solomon', 'Wassie', 111, 'Bole', '0971234590', 'solomo123@gmail.com'),
('Daniel ', 'Abebe', 112, 'Gerji', '0934658972', 'danielab23@gmail.com'),
('Mohammed', 'Adul', 113, 'Mexico', '0911453200', 'mohamab11@gmail.com'),
('Hiwot', 'Negusse', 114, 'Megenagna', '0967113582', 'hiwin222@gmail.com'),
('Ruth', 'Tesfaye', 115, 'Semit', '0944635211', 'rutht76@gmail.com'),
('Kolon', 'Oscopy', 117, 'Uperander', '123244211', 'kolon@hospital.com');

-- --------------------------------------------------------

--
-- Table structure for table `storage`
--

DROP TABLE IF EXISTS `storage`;
CREATE TABLE IF NOT EXISTS `storage` (
  `storageArea` varchar(20) NOT NULL,
  `storageID` int(11) NOT NULL AUTO_INCREMENT,
  `description` varchar(255) NOT NULL,
  PRIMARY KEY (`storageID`)
) ENGINE=InnoDB AUTO_INCREMENT=508 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `storage`
--

INSERT INTO `storage` (`storageArea`, `storageID`, `description`) VALUES
('northern part', 501, 'In front of the front Door next to the reception Desk'),
('southern part', 502, 'In front of the back Door next to the back window'),
('Eastern part', 503, 'Behind 501 next to the window in the right.'),
('Western part', 504, 'Behind 501 next to the window in the left. '),
('Centeral part', 505, 'In front of 502 and between 503 and 504.');

-- --------------------------------------------------------

--
-- Table structure for table `supplier`
--

DROP TABLE IF EXISTS `supplier`;
CREATE TABLE IF NOT EXISTS `supplier` (
  `supplierID` int(11) NOT NULL AUTO_INCREMENT,
  `supplierName` varchar(30) NOT NULL,
  `supplierAddress` varchar(40) NOT NULL,
  `supplierPhone` varchar(13) NOT NULL,
  `supplierEmail` varchar(40) NOT NULL,
  `POBOX` int(11) NOT NULL,
  `supplierDescription` varchar(50) NOT NULL,
  PRIMARY KEY (`supplierID`)
) ENGINE=InnoDB AUTO_INCREMENT=307 DEFAULT CHARSET=latin1;

--
-- Dumping data for table `supplier`
--

INSERT INTO `supplier` (`supplierID`, `supplierName`, `supplierAddress`, `supplierPhone`, `supplierEmail`, `POBOX`, `supplierDescription`) VALUES
(301, 'gage plc', 'Jacros', '0119876523', 'gageplc@gmail', 4567, 'electronic supplier'),
(302, 'Victoria', 'Merkato', '0115527890', 'vicosmo@gmail', 7890, 'Cosmotics supplier'),
(303, 'Alsam plc', 'Bole', '0115570707', 'alsam@gmail', 4792, 'cloth supplier'),
(304, 'moya plc', 'Gerji', '011454545', 'moya@gmail', 1234, 'food supplier'),
(305, '3F furnitures', 'CMC', '0115123232', '3furni@gmail', 6060, 'Furniture supplier'),
(306, 'United Steel', 'kornis', '112992222', 'unsteel@gmail.com', 2323, 'Steel and other small materials');

--
-- Constraints for dumped tables
--

--
-- Constraints for table `buy`
--
ALTER TABLE `buy`
  ADD CONSTRAINT `buy_ibfk_1` FOREIGN KEY (`staffID`) REFERENCES `staff` (`staffID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `buy_ibfk_2` FOREIGN KEY (`supplierID`) REFERENCES `supplier` (`supplierID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `buy_ibfk_3` FOREIGN KEY (`productID`) REFERENCES `product` (`productID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`categoryID`) REFERENCES `category` (`categoryID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `product_ibfk_2` FOREIGN KEY (`storageID`) REFERENCES `storage` (`storageID`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sell`
--
ALTER TABLE `sell`
  ADD CONSTRAINT `sell_ibfk_2` FOREIGN KEY (`staffID`) REFERENCES `staff` (`staffID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `sell_ibfk_3` FOREIGN KEY (`productID`) REFERENCES `product` (`productID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `sell_ibfk_4` FOREIGN KEY (`customerID`) REFERENCES `customer` (`customerID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
