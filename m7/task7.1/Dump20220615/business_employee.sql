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
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `emp_id` int NOT NULL AUTO_INCREMENT,
  `end_date` date DEFAULT NULL,
  `first_name` varchar(20) NOT NULL,
  `last_name` varchar(20) NOT NULL,
  `start_date` date NOT NULL,
  `title` varchar(20) DEFAULT NULL,
  `assigned_branch_id` int DEFAULT NULL,
  `dept_id` int DEFAULT NULL,
  `superior_emp_id` int DEFAULT NULL,
  PRIMARY KEY (`emp_id`),
  KEY `employee_branch_fk` (`assigned_branch_id`),
  KEY `employee_department_fk` (`dept_id`),
  KEY `employee_employee_fk` (`superior_emp_id`),
  CONSTRAINT `employee_branch_fk` FOREIGN KEY (`assigned_branch_id`) REFERENCES `branch` (`branch_id`),
  CONSTRAINT `employee_department_fk` FOREIGN KEY (`dept_id`) REFERENCES `department` (`dept_id`),
  CONSTRAINT `employee_employee_fk` FOREIGN KEY (`superior_emp_id`) REFERENCES `employee` (`emp_id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (1,NULL,'Michael','Smith','2001-06-22','President',1,3,NULL),(2,NULL,'Susan','Barker','2002-09-12','Vice President',1,3,1),(3,NULL,'Robert','Tyler','2000-02-09','Treasurer',1,3,1),(4,NULL,'Susan','Hawthorne','2002-04-24','Operations Manager',1,1,3),(5,NULL,'John','Gooding','2003-11-14','Loan Manager',1,2,4),(6,NULL,'Helen','Fleming','2004-03-17','Head Teller',1,1,4),(7,NULL,'Chris','Tucker','2004-09-15','Teller',1,1,6),(8,NULL,'Sarah','Parker','2002-12-02','Teller',1,1,6),(9,NULL,'Jane','Grossman','2002-05-03','Teller',1,1,6),(10,NULL,'Paula','Roberts','2002-07-27','Head Teller',2,1,4),(11,NULL,'Thomas','Ziegler','2000-10-23','Teller',2,1,10),(12,NULL,'Samantha','Jameson','2003-01-08','Teller',2,1,10),(13,NULL,'John','Blake','2000-05-11','Head Teller',3,1,4),(14,NULL,'Cindy','Mason','2002-08-09','Teller',3,1,13),(15,NULL,'Frank','Portman','2003-04-01','Teller',3,1,13),(16,NULL,'Theresa','Markham','2001-03-15','Head Teller',4,1,4),(17,NULL,'Beth','Fowler','2002-06-29','Teller',4,1,16),(18,NULL,'Rick','Tulman','2002-12-12','Teller',4,1,16);
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
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

-- Dump completed on 2022-06-15 23:31:44
