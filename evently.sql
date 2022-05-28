-- MySQL dump 10.13  Distrib 8.0.29, for Linux (x86_64)
--
-- Host: 127.0.0.1    Database: evently
-- ------------------------------------------------------
-- Server version	8.0.29-0ubuntu0.20.04.3

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `evently`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `evently` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `evently`;

--
-- Table structure for table `Attending`
--

DROP TABLE IF EXISTS `Attending`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Attending` (
  `user_ID` varchar(36) NOT NULL,
  `event_ID` varchar(36) NOT NULL,
  `attendance_type` varchar(63) DEFAULT NULL,
  KEY `user_ID` (`user_ID`),
  KEY `event_ID` (`event_ID`),
  CONSTRAINT `Attending_ibfk_1` FOREIGN KEY (`user_ID`) REFERENCES `User` (`user_ID`) ON DELETE CASCADE,
  CONSTRAINT `Attending_ibfk_2` FOREIGN KEY (`event_ID`) REFERENCES `Events` (`event_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Attending`
--

LOCK TABLES `Attending` WRITE;
/*!40000 ALTER TABLE `Attending` DISABLE KEYS */;
INSERT INTO `Attending` VALUES ('1','1','Author'),('2','1','Attending');
/*!40000 ALTER TABLE `Attending` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Calendar_Events`
--

DROP TABLE IF EXISTS `Calendar_Events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Calendar_Events` (
  `calendar_ID` varchar(36) NOT NULL,
  `event_ID` varchar(36) NOT NULL,
  KEY `calendar_ID` (`calendar_ID`),
  KEY `event_ID` (`event_ID`),
  CONSTRAINT `Calendar_Events_ibfk_1` FOREIGN KEY (`calendar_ID`) REFERENCES `Google_Calendar` (`calendar_ID`) ON DELETE CASCADE,
  CONSTRAINT `Calendar_Events_ibfk_2` FOREIGN KEY (`event_ID`) REFERENCES `Events` (`event_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Calendar_Events`
--

LOCK TABLES `Calendar_Events` WRITE;
/*!40000 ALTER TABLE `Calendar_Events` DISABLE KEYS */;
/*!40000 ALTER TABLE `Calendar_Events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Date_Time`
--

DROP TABLE IF EXISTS `Date_Time`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Date_Time` (
  `date_time_ID` varchar(36) NOT NULL,
  `start_date_time` datetime DEFAULT NULL,
  `end_date_time` datetime DEFAULT NULL,
  `event_duration` varchar(127) DEFAULT NULL,
  PRIMARY KEY (`date_time_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Date_Time`
--

LOCK TABLES `Date_Time` WRITE;
/*!40000 ALTER TABLE `Date_Time` DISABLE KEYS */;
INSERT INTO `Date_Time` VALUES ('1','2022-08-18 10:00:00','2022-08-19 11:00:00',NULL),('2','2022-08-20 11:00:00','2022-08-20 12:00:00',NULL);
/*!40000 ALTER TABLE `Date_Time` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Event_Address`
--

DROP TABLE IF EXISTS `Event_Address`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Event_Address` (
  `address_ID` varchar(36) NOT NULL,
  `street_number` int DEFAULT NULL,
  `street_name` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `postcode` int DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`address_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Event_Address`
--

LOCK TABLES `Event_Address` WRITE;
/*!40000 ALTER TABLE `Event_Address` DISABLE KEYS */;
INSERT INTO `Event_Address` VALUES ('1',4,'Test st','Adelaide',5000,'AU');
/*!40000 ALTER TABLE `Event_Address` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Event_Location`
--

DROP TABLE IF EXISTS `Event_Location`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Event_Location` (
  `location_ID` varchar(36) NOT NULL,
  `address_ID` varchar(36) NOT NULL,
  `event_venue` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`location_ID`),
  KEY `address_ID` (`address_ID`),
  CONSTRAINT `Event_Location_ibfk_1` FOREIGN KEY (`address_ID`) REFERENCES `Event_Address` (`address_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Event_Location`
--

LOCK TABLES `Event_Location` WRITE;
/*!40000 ALTER TABLE `Event_Location` DISABLE KEYS */;
INSERT INTO `Event_Location` VALUES ('1','1','Town Hall');
/*!40000 ALTER TABLE `Event_Location` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Events`
--

DROP TABLE IF EXISTS `Events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Events` (
  `event_ID` varchar(36) NOT NULL,
  `date_time_ID` varchar(36) NOT NULL,
  `location_ID` varchar(36) NOT NULL,
  `event_name` varchar(255) DEFAULT NULL,
  `event_description` text,
  `event_image_url` varchar(255) DEFAULT NULL,
  `event_author` varchar(255) DEFAULT NULL,
  `num_attending` int DEFAULT NULL,
  PRIMARY KEY (`event_ID`),
  KEY `date_time_ID` (`date_time_ID`),
  KEY `location_ID` (`location_ID`),
  CONSTRAINT `Events_ibfk_1` FOREIGN KEY (`date_time_ID`) REFERENCES `Date_Time` (`date_time_ID`) ON DELETE CASCADE,
  CONSTRAINT `Events_ibfk_2` FOREIGN KEY (`location_ID`) REFERENCES `Event_Location` (`location_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Events`
--

LOCK TABLES `Events` WRITE;
/*!40000 ALTER TABLE `Events` DISABLE KEYS */;
INSERT INTO `Events` VALUES ('1','1','1','Event 1','This is an event...',NULL,'Bob1',100);
/*!40000 ALTER TABLE `Events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Google_Calendar`
--

DROP TABLE IF EXISTS `Google_Calendar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Google_Calendar` (
  `calendar_ID` varchar(36) NOT NULL,
  `user_ID` varchar(36) NOT NULL,
  `calendar_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`calendar_ID`),
  KEY `user_ID` (`user_ID`),
  CONSTRAINT `Google_Calendar_ibfk_1` FOREIGN KEY (`user_ID`) REFERENCES `User` (`user_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Google_Calendar`
--

LOCK TABLES `Google_Calendar` WRITE;
/*!40000 ALTER TABLE `Google_Calendar` DISABLE KEYS */;
/*!40000 ALTER TABLE `Google_Calendar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Permission`
--

DROP TABLE IF EXISTS `Permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Permission` (
  `permission_ID` int NOT NULL AUTO_INCREMENT,
  `permission_name` varchar(255) DEFAULT NULL,
  `active` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`permission_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Permission`
--

LOCK TABLES `Permission` WRITE;
/*!40000 ALTER TABLE `Permission` DISABLE KEYS */;
INSERT INTO `Permission` VALUES (1,'manage_user_info',1),(2,'manage_users',1),(3,'manage_events',1),(4,'signup_admin',1);
/*!40000 ALTER TABLE `Permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Role`
--

DROP TABLE IF EXISTS `Role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Role` (
  `role_ID` int NOT NULL AUTO_INCREMENT,
  `role_name` varchar(63) DEFAULT NULL,
  PRIMARY KEY (`role_ID`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Role`
--

LOCK TABLES `Role` WRITE;
/*!40000 ALTER TABLE `Role` DISABLE KEYS */;
INSERT INTO `Role` VALUES (1,'admin'),(2,'user');
/*!40000 ALTER TABLE `Role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Role_Permissions`
--

DROP TABLE IF EXISTS `Role_Permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `Role_Permissions` (
  `role_ID` int DEFAULT NULL,
  `permission_ID` int DEFAULT NULL,
  KEY `role_ID` (`role_ID`),
  KEY `permission_ID` (`permission_ID`),
  CONSTRAINT `Role_Permissions_ibfk_1` FOREIGN KEY (`role_ID`) REFERENCES `Role` (`role_ID`) ON DELETE CASCADE,
  CONSTRAINT `Role_Permissions_ibfk_2` FOREIGN KEY (`permission_ID`) REFERENCES `Permission` (`permission_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Role_Permissions`
--

LOCK TABLES `Role_Permissions` WRITE;
/*!40000 ALTER TABLE `Role_Permissions` DISABLE KEYS */;
INSERT INTO `Role_Permissions` VALUES (1,1),(1,2),(1,3),(1,4),(2,1);
/*!40000 ALTER TABLE `Role_Permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `User` (
  `user_ID` varchar(36) NOT NULL,
  `username` varchar(63) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `google_ID` varchar(36) DEFAULT NULL,
  PRIMARY KEY (`user_ID`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES ('07304438-de60-11ec-b8ef-0022485ac961','exampleuser','password',NULL),('1','bob1','password',NULL),('2','Alice2','12345',NULL);
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User_Preferences`
--

DROP TABLE IF EXISTS `User_Preferences`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `User_Preferences` (
  `user_preference_ID` int NOT NULL AUTO_INCREMENT,
  `profile_ID` varchar(36) NOT NULL,
  `dark_mode` tinyint(1) DEFAULT '0',
  `email_notifications` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`user_preference_ID`),
  KEY `profile_ID` (`profile_ID`),
  CONSTRAINT `User_Preferences_ibfk_2` FOREIGN KEY (`profile_ID`) REFERENCES `User_Profile` (`profile_ID`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User_Preferences`
--

LOCK TABLES `User_Preferences` WRITE;
/*!40000 ALTER TABLE `User_Preferences` DISABLE KEYS */;
INSERT INTO `User_Preferences` VALUES (1,'1',1,1),(2,'2',0,1),(4,'0cde7c1a-de60-11ec-b8ef-0022485ac961',0,1);
/*!40000 ALTER TABLE `User_Preferences` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User_Profile`
--

DROP TABLE IF EXISTS `User_Profile`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `User_Profile` (
  `profile_ID` varchar(36) NOT NULL,
  `user_ID` varchar(36) NOT NULL,
  `first_name` varchar(63) DEFAULT NULL,
  `last_name` varchar(63) DEFAULT NULL,
  `email` varchar(127) DEFAULT NULL,
  `image_url` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`profile_ID`),
  KEY `user_ID` (`user_ID`),
  CONSTRAINT `User_Profile_ibfk_1` FOREIGN KEY (`user_ID`) REFERENCES `User` (`user_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User_Profile`
--

LOCK TABLES `User_Profile` WRITE;
/*!40000 ALTER TABLE `User_Profile` DISABLE KEYS */;
INSERT INTO `User_Profile` VALUES ('0cde7c1a-de60-11ec-b8ef-0022485ac961','07304438-de60-11ec-b8ef-0022485ac961','firstname','lastname','example@email.com','/null.png'),('1','1','Bob','Smith','bob@gmail.com','/puppy.jpg'),('2','2','Alice','Dawson','alice@gmail.com','/kitty.jpg');
/*!40000 ALTER TABLE `User_Profile` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User_Role`
--

DROP TABLE IF EXISTS `User_Role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `User_Role` (
  `role_ID` int DEFAULT NULL,
  `profile_ID` varchar(36) NOT NULL,
  KEY `role_ID` (`role_ID`),
  KEY `profile_ID` (`profile_ID`),
  CONSTRAINT `User_Role_ibfk_1` FOREIGN KEY (`role_ID`) REFERENCES `Role` (`role_ID`) ON DELETE CASCADE,
  CONSTRAINT `User_Role_ibfk_2` FOREIGN KEY (`profile_ID`) REFERENCES `User_Profile` (`profile_ID`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User_Role`
--

LOCK TABLES `User_Role` WRITE;
/*!40000 ALTER TABLE `User_Role` DISABLE KEYS */;
INSERT INTO `User_Role` VALUES (1,'1'),(2,'2'),(2,'0cde7c1a-de60-11ec-b8ef-0022485ac961');
/*!40000 ALTER TABLE `User_Role` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-05-28  8:31:20
