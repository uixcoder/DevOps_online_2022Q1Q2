-- MySQL dump 10.13  Distrib 8.0.29, for Linux (x86_64)
--
-- Host: database-1.cszga80cboxg.eu-north-1.rds.amazonaws.com    Database: business
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
SET @MYSQLDUMP_TEMP_LOG_BIN = @@SESSION.SQL_LOG_BIN;
SET @@SESSION.SQL_LOG_BIN= 0;

--
-- GTID state at the beginning of the backup 
--

SET @@GLOBAL.GTID_PURGED=/*!80000 '+'*/ '';

--
-- Table structure for table `acc_transaction`
--

DROP TABLE IF EXISTS `acc_transaction`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `acc_transaction` (
  `txn_id` bigint NOT NULL AUTO_INCREMENT,
  `amount` float NOT NULL,
  `funds_avail_date` datetime NOT NULL,
  `txn_date` datetime NOT NULL,
  `txn_type_cd` varchar(10) DEFAULT NULL,
  `account_id` int DEFAULT NULL,
  `execution_branch_id` int DEFAULT NULL,
  `teller_emp_id` int DEFAULT NULL,
  PRIMARY KEY (`txn_id`),
  KEY `acc_transaction_account_fk` (`account_id`),
  KEY `acc_transaction_branch_fk` (`execution_branch_id`),
  KEY `acc_transaction_employee_fk` (`teller_emp_id`),
  CONSTRAINT `acc_transaction_account_fk` FOREIGN KEY (`account_id`) REFERENCES `account` (`account_id`),
  CONSTRAINT `acc_transaction_branch_fk` FOREIGN KEY (`execution_branch_id`) REFERENCES `branch` (`branch_id`),
  CONSTRAINT `acc_transaction_employee_fk` FOREIGN KEY (`teller_emp_id`) REFERENCES `employee` (`emp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `acc_transaction`
--

LOCK TABLES `acc_transaction` WRITE;
/*!40000 ALTER TABLE `acc_transaction` DISABLE KEYS */;
INSERT INTO `acc_transaction` VALUES (1,100,'2000-01-15 00:00:00','2000-01-15 00:00:00','CDT',1,NULL,NULL),(2,100,'2000-01-15 00:00:00','2000-01-15 00:00:00','CDT',2,NULL,NULL),(3,100,'2004-06-30 00:00:00','2004-06-30 00:00:00','CDT',3,NULL,NULL),(4,100,'2001-03-12 00:00:00','2001-03-12 00:00:00','CDT',4,NULL,NULL),(5,100,'2001-03-12 00:00:00','2001-03-12 00:00:00','CDT',5,NULL,NULL),(6,100,'2002-11-23 00:00:00','2002-11-23 00:00:00','CDT',7,NULL,NULL),(7,100,'2002-12-15 00:00:00','2002-12-15 00:00:00','CDT',8,NULL,NULL),(8,100,'2003-09-12 00:00:00','2003-09-12 00:00:00','CDT',10,NULL,NULL),(9,100,'2000-01-15 00:00:00','2000-01-15 00:00:00','CDT',11,NULL,NULL),(10,100,'2004-09-30 00:00:00','2004-09-30 00:00:00','CDT',12,NULL,NULL),(11,100,'2004-01-27 00:00:00','2004-01-27 00:00:00','CDT',13,NULL,NULL),(12,100,'2002-08-24 00:00:00','2002-08-24 00:00:00','CDT',14,NULL,NULL),(13,100,'2004-12-28 00:00:00','2004-12-28 00:00:00','CDT',15,NULL,NULL),(14,100,'2004-01-12 00:00:00','2004-01-12 00:00:00','CDT',17,NULL,NULL),(15,100,'2001-05-23 00:00:00','2001-05-23 00:00:00','CDT',18,NULL,NULL),(16,100,'2001-05-23 00:00:00','2001-05-23 00:00:00','CDT',19,NULL,NULL),(17,100,'2003-07-30 00:00:00','2003-07-30 00:00:00','CDT',21,NULL,NULL),(18,100,'2004-10-28 00:00:00','2004-10-28 00:00:00','CDT',22,NULL,NULL),(19,100,'2004-06-30 00:00:00','2004-06-30 00:00:00','CDT',23,NULL,NULL),(20,100,'2002-09-30 00:00:00','2002-09-30 00:00:00','CDT',24,NULL,NULL),(21,100,'2003-07-30 00:00:00','2003-07-30 00:00:00','CDT',28,NULL,NULL);
/*!40000 ALTER TABLE `acc_transaction` ENABLE KEYS */;
UNLOCK TABLES;
SET @@SESSION.SQL_LOG_BIN = @MYSQLDUMP_TEMP_LOG_BIN;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-06-15 23:31:43
