-- MySQL dump 10.13  Distrib 8.0.28, for Win64 (x86_64)
--
-- Host: localhost    Database: joljak
-- ------------------------------------------------------
-- Server version	8.0.28

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `userID` varchar(20) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `userPassword` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `userName` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `userBirth` date NOT NULL,
  `userPhone` varchar(11) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `userAddress` varchar(100) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `userNickname` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  PRIMARY KEY (`userID`),
  UNIQUE KEY `userNickname_UNIQUE` (`userNickname`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('kangms8084','$2a$10$sMPfT8B8JMRwO1dJO/lupOFG97RsKLWH3pT01Qaf98xtyQWcK359S','강문선','2022-05-05','01011112222','경기도 안양시 동안구 비산동','우리동네'),('kio1214','$2a$10$utGnDD1HDUJFMGuqxnszPOLyw8dp5fCflz9u1wIgX6FCr2msFjVqy','강문선','2022-05-05','01011112222','경기도 안양시 동안구 비산동','네동리우'),('moonsun','$2a$10$I4p/nR3wZO0uan2HgMwJcuIZT/NKYglxYjlepZHCPPjZlZMlwpLmi','강문선','2022-04-01','01034534543','경기도 안양시 동안구 비산동','무운서언'),('woori','$2a$10$mUPfjWe9muJkq12sXqfMTOaA9g/Jy2dngmtYo1hNvoVB.DKKNz5CS','1234','2022-04-06','1234','1234','1234');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-05-10 16:33:56
