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
-- Table structure for table `meeting`
--

DROP TABLE IF EXISTS `meeting`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `meeting` (
  `mtNum` int NOT NULL AUTO_INCREMENT,
  `mtID` varchar(20) COLLATE utf8_bin NOT NULL,
  `mtAddress` varchar(45) COLLATE utf8_bin DEFAULT NULL,
  `mtCategory` varchar(20) COLLATE utf8_bin NOT NULL,
  `mtLeader` varchar(20) COLLATE utf8_bin NOT NULL,
  `mtSummary` varchar(100) COLLATE utf8_bin DEFAULT NULL,
  `mtDate` date NOT NULL,
  PRIMARY KEY (`mtNum`,`mtID`),
  KEY `mtLeader_idx` (`mtLeader`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb3 COLLATE=utf8_bin;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `meeting`
--

LOCK TABLES `meeting` WRITE;
/*!40000 ALTER TABLE `meeting` DISABLE KEYS */;
INSERT INTO `meeting` VALUES (1,'ㅇ',NULL,'게임','d','ㅇ','2022-05-19'),(2,'ㅇ',NULL,'게임','d','ㅇ','2022-05-19'),(3,'ㅇ',NULL,'반려동물','d','ㅇ','2022-05-19'),(4,'ㅇ',NULL,'봉사활동','d','ㅇ','2022-05-19'),(5,'ㅇ',NULL,'음악/댄스','d','ㅇ','2022-05-19'),(6,'ㅇ',NULL,'음악/댄스','d','ㅇ','2022-05-19'),(7,'ㅁㅎㄴㅇㅎㅁ',NULL,'요리/제조','d','ㅇ','2022-05-19');
/*!40000 ALTER TABLE `meeting` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-05-19 13:41:14
