-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Generation Time: Apr 09, 2020 at 02:36 AM
-- Server version: 10.4.11-MariaDB
-- PHP Version: 7.4.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `E-exam`
--

-- --------------------------------------------------------

--
-- Table structure for table `Admin`
--

CREATE TABLE `Admin` (
  `ID` int(11) NOT NULL,
  `Nationalid` int(11) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `Password` varchar(15) DEFAULT NULL,
  `realName` varchar(15) DEFAULT NULL,
  `graduted` varchar(15) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `request` varchar(10) DEFAULT 'null'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Admin`
--

INSERT INTO `Admin` (`ID`, `Nationalid`, `Email`, `Password`, `realName`, `graduted`, `age`, `request`) VALUES
(1, 111111, 'moataz@gmail.com', 'moataz', 'moataz', 'm', 40, 'null'),
(2, 222222, 'saad@gmail.com', 'saad11', 'saad', 's', 30, 'null'),
(7, 3333, '3ali33@gmail.com', ':d', ':e', ':f', 40, 'null');

-- --------------------------------------------------------

--
-- Table structure for table `Chapter`
--

CREATE TABLE `Chapter` (
  `ID` int(11) NOT NULL,
  `subjectname` text DEFAULT NULL,
  `chaptername` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Chapter`
--

INSERT INTO `Chapter` (`ID`, `subjectname`, `chaptername`) VALUES
(14, 'OOP', 'g'),
(15, 'OOP', 'g'),
(18, 'data structure', 'k'),
(20, 'OOP', 'z'),
(21, 'OOP', 'hh');

-- --------------------------------------------------------

--
-- Table structure for table `Department`
--

CREATE TABLE `Department` (
  `ID` int(11) NOT NULL,
  `Name` text DEFAULT NULL,
  `whenstart` text DEFAULT NULL,
  `leader` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Department`
--

INSERT INTO `Department` (`ID`, `Name`, `whenstart`, `leader`) VALUES
(1, 'SE', 'level 1', 'عمر ابو هانى'),
(3, 'bio', 'level 1', 'kk'),
(4, 'IS', 'level 3', '10100');

-- --------------------------------------------------------

--
-- Table structure for table `examchapter`
--

CREATE TABLE `examchapter` (
  `ID` int(11) NOT NULL,
  `examid` int(11) DEFAULT NULL,
  `chapter` int(11) DEFAULT NULL,
  `type` text DEFAULT NULL,
  `level` text DEFAULT NULL,
  `count` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `examchapter`
--

INSERT INTO `examchapter` (`ID`, `examid`, `chapter`, `type`, `level`, `count`) VALUES
(108, 45, 1, 'trueandfalse', 'null', '5'),
(109, 46, 1, 'mcq', 'A', '7'),
(110, 46, 1, 'mcq', 'B', '10'),
(111, 46, 1, 'mcq', 'C', '8'),
(112, 46, 1, 'trueandfalse', 'null', '5'),
(113, 47, 1, 'mcq', 'C', '10'),
(114, 47, 1, 'trueandfalse', 'null', '6'),
(115, 47, 1, 'mcq', 'A', '8'),
(116, 47, 1, 'mcq', 'B', '4');

-- --------------------------------------------------------

--
-- Table structure for table `examdetails`
--

CREATE TABLE `examdetails` (
  `ID` int(11) NOT NULL,
  `subject` text DEFAULT NULL,
  `whenstart` text DEFAULT NULL,
  `time` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `examdetails`
--

INSERT INTO `examdetails` (`ID`, `subject`, `whenstart`, `time`) VALUES
(45, 'OOP', '2020-04-08 09:55', '1 Hours'),
(46, 'OOP', '2020-04-08 09:55', '1 Hours'),
(47, 'data structure', '2020-04-08 10:11', '2 Hours'),
(48, 'subject', 'when', 'time'),
(49, 'subject', 'when', 'time');

-- --------------------------------------------------------

--
-- Table structure for table `Professor`
--

CREATE TABLE `Professor` (
  `ID` int(11) NOT NULL,
  `Nationalid` int(11) DEFAULT NULL,
  `Email` text DEFAULT NULL,
  `Password` text DEFAULT NULL,
  `realName` text DEFAULT NULL,
  `graduted` text DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `request` varchar(10) DEFAULT 'null'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Professor`
--

INSERT INTO `Professor` (`ID`, `Nationalid`, `Email`, `Password`, `realName`, `graduted`, `age`, `request`) VALUES
(6, 111111, 'amr@gmail.com', 'amr111', 'عمرو ابو هانى', 'm', 48, 'null'),
(7, 555555, 'islam@gmail.com', 'islam111', 'اسلام حسن', 'h', 30, 'null');

-- --------------------------------------------------------

--
-- Table structure for table `queastion_mcq`
--

CREATE TABLE `queastion_mcq` (
  `ID` int(11) NOT NULL,
  `Question` text DEFAULT NULL,
  `subject` text DEFAULT NULL,
  `numberofchapter` text DEFAULT NULL,
  `level` text DEFAULT NULL,
  `answer1` text DEFAULT NULL,
  `answer2` text DEFAULT NULL,
  `answer3` text DEFAULT NULL,
  `answer4` text DEFAULT NULL,
  `correctanswer` text DEFAULT NULL,
  `bank` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `queastion_mcq`
--

INSERT INTO `queastion_mcq` (`ID`, `Question`, `subject`, `numberofchapter`, `level`, `answer1`, `answer2`, `answer3`, `answer4`, `correctanswer`, `bank`) VALUES
(2, 'fd', 'OOP', '3', 'C', 'd', 'j', 'f', 'k', 'f', 'false'),
(3, 'u', 'OOP', '2', 'B', 'p', 'k', 'g', 'u', 'k', 'true'),
(4, 'd', 'data structure', '1', 'B', 'f', 'j', 'b', 'p', 'j', 'true');

-- --------------------------------------------------------

--
-- Table structure for table `queastion_true_and_false`
--

CREATE TABLE `queastion_true_and_false` (
  `ID` int(11) NOT NULL,
  `Question` text DEFAULT NULL,
  `subject` text DEFAULT NULL,
  `numberofchapter` text DEFAULT NULL,
  `correctanswer` text DEFAULT NULL,
  `bank` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `queastion_true_and_false`
--

INSERT INTO `queastion_true_and_false` (`ID`, `Question`, `subject`, `numberofchapter`, `correctanswer`, `bank`) VALUES
(1, 'yy', 'OOP', '2', 'False', 'true'),
(3, 'x', 'data structure', '1', 'True', 'true');

-- --------------------------------------------------------

--
-- Table structure for table `request`
--

CREATE TABLE `request` (
  `ID` int(11) NOT NULL,
  `type` varchar(11) DEFAULT NULL,
  `Nationalid` int(11) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `Password` varchar(20) DEFAULT NULL,
  `realName` varchar(20) DEFAULT NULL,
  `graduted` varchar(100) DEFAULT NULL,
  `age` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `request`
--

INSERT INTO `request` (`ID`, `type`, `Nationalid`, `Email`, `Password`, `realName`, `graduted`, `age`) VALUES
(25, 'Professor', 33, 'mohamed@gmail.com', 'q33', '33', '33', 33),
(29, 'Admin', 5665655, 'dggdggg@gmail.com', '', 'dghtydghfg', 'fhgf', 566),
(31, 'Professor', 2222222, 'fhhg@fh.cib', 'fughugg', 'tkgytjgyufre', 'dhhh', 25),
(34, 'Professor', 111111, 'amr@gmail.com', 'aaaaaa', 'aagghhgg', 'aa', 40),
(35, 'Professor', 5555559, 'ipislam@gmail.com', 'islam111', 'vwjkwes', 'anakk', 40);

-- --------------------------------------------------------

--
-- Table structure for table `Student`
--

CREATE TABLE `Student` (
  `ID` int(11) NOT NULL,
  `Nationalid` int(11) DEFAULT NULL,
  `Collageid` int(11) DEFAULT NULL,
  `name` text DEFAULT NULL,
  `password` text DEFAULT NULL,
  `level` text DEFAULT NULL,
  `department` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Student`
--

INSERT INTO `Student` (`ID`, `Nationalid`, `Collageid`, `name`, `password`, `level`, `department`) VALUES
(1, 222222, 222222, 'asdasd', '222222', 'level 2', 'SE');

-- --------------------------------------------------------

--
-- Table structure for table `Subject`
--

CREATE TABLE `Subject` (
  `ID` int(11) NOT NULL,
  `Name` varchar(15) DEFAULT NULL,
  `department` varchar(65) DEFAULT NULL,
  `professor` varchar(65) DEFAULT NULL,
  `level` varchar(65) DEFAULT NULL,
  `semester` varchar(15) DEFAULT NULL,
  `counter` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `Subject`
--

INSERT INTO `Subject` (`ID`, `Name`, `department`, `professor`, `level`, `semester`, `counter`) VALUES
(1, 'OOP', 'general', 'عمرو ابو هانى', 'level 2', 'semester 1', '4'),
(4, 'data structure', 'general', 'عمرو ابو هانى', 'level 2', 'semester 2', '1'),
(6, 'kk', 'bio', 'اسلام حسن', 'level 3', 'semester 2', '0');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Admin`
--
ALTER TABLE `Admin`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Nationalid` (`Nationalid`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- Indexes for table `Chapter`
--
ALTER TABLE `Chapter`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `Department`
--
ALTER TABLE `Department`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Name` (`Name`) USING HASH;

--
-- Indexes for table `examchapter`
--
ALTER TABLE `examchapter`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `examdetails`
--
ALTER TABLE `examdetails`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `Professor`
--
ALTER TABLE `Professor`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Nationalid` (`Nationalid`),
  ADD UNIQUE KEY `Email` (`Email`) USING HASH;

--
-- Indexes for table `queastion_mcq`
--
ALTER TABLE `queastion_mcq`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Question` (`Question`) USING HASH;

--
-- Indexes for table `queastion_true_and_false`
--
ALTER TABLE `queastion_true_and_false`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Question` (`Question`) USING HASH;

--
-- Indexes for table `request`
--
ALTER TABLE `request`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Nationalid` (`Nationalid`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- Indexes for table `Student`
--
ALTER TABLE `Student`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Nationalid` (`Nationalid`),
  ADD UNIQUE KEY `Collageid` (`Collageid`);

--
-- Indexes for table `Subject`
--
ALTER TABLE `Subject`
  ADD PRIMARY KEY (`ID`),
  ADD UNIQUE KEY `Name` (`Name`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Admin`
--
ALTER TABLE `Admin`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `Chapter`
--
ALTER TABLE `Chapter`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- AUTO_INCREMENT for table `Department`
--
ALTER TABLE `Department`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `examchapter`
--
ALTER TABLE `examchapter`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=117;

--
-- AUTO_INCREMENT for table `examdetails`
--
ALTER TABLE `examdetails`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `Professor`
--
ALTER TABLE `Professor`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `queastion_mcq`
--
ALTER TABLE `queastion_mcq`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `queastion_true_and_false`
--
ALTER TABLE `queastion_true_and_false`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `request`
--
ALTER TABLE `request`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=36;

--
-- AUTO_INCREMENT for table `Student`
--
ALTER TABLE `Student`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `Subject`
--
ALTER TABLE `Subject`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
