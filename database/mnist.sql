-- MariaDB dump 10.19  Distrib 10.6.12-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: mnist
-- ------------------------------------------------------
-- Server version	10.6.12-MariaDB-0ubuntu0.22.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `ai_game`
--

DROP TABLE IF EXISTS `ai_game`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ai_game` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ai_type_id` int(11) NOT NULL,
  `beginning` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `ai_type_id` (`ai_type_id`),
  CONSTRAINT `ai_game_ibfk_1` FOREIGN KEY (`ai_type_id`) REFERENCES `ai_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ai_game`
--

LOCK TABLES `ai_game` WRITE;
/*!40000 ALTER TABLE `ai_game` DISABLE KEYS */;
/*!40000 ALTER TABLE `ai_game` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ai_game_answers`
--

DROP TABLE IF EXISTS `ai_game_answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ai_game_answers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ai_game_id` int(11) NOT NULL,
  `picture_id` int(11) NOT NULL,
  `answer_option_id` int(11) NOT NULL,
  `probability` float(24,10) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `ai_game_answers_ibfk_1` (`ai_game_id`),
  KEY `ai_game_answers_ibfk_2` (`picture_id`),
  KEY `ai_game_answers_ibfk_3` (`answer_option_id`),
  CONSTRAINT `ai_game_answers_ibfk_1` FOREIGN KEY (`ai_game_id`) REFERENCES `ai_game` (`id`),
  CONSTRAINT `ai_game_answers_ibfk_2` FOREIGN KEY (`picture_id`) REFERENCES `picture` (`id`),
  CONSTRAINT `ai_game_answers_ibfk_3` FOREIGN KEY (`answer_option_id`) REFERENCES `answer_option` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ai_game_answers`
--

LOCK TABLES `ai_game_answers` WRITE;
/*!40000 ALTER TABLE `ai_game_answers` DISABLE KEYS */;
/*!40000 ALTER TABLE `ai_game_answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ai_type`
--

DROP TABLE IF EXISTS `ai_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `ai_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(31) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ai_type`
--

LOCK TABLES `ai_type` WRITE;
/*!40000 ALTER TABLE `ai_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `ai_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `answer_answer_international`
--

DROP TABLE IF EXISTS `answer_answer_international`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `answer_answer_international` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `picture_answer_answer_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `answer` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `answer` (`answer`),
  KEY `picture_answer_answer_id` (`picture_answer_answer_id`),
  KEY `language_id` (`language_id`),
  CONSTRAINT `answer_answer_international_ibfk_1` FOREIGN KEY (`picture_answer_answer_id`) REFERENCES `picture_answer_answer` (`id`),
  CONSTRAINT `answer_answer_international_ibfk_2` FOREIGN KEY (`language_id`) REFERENCES `language` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answer_answer_international`
--

LOCK TABLES `answer_answer_international` WRITE;
/*!40000 ALTER TABLE `answer_answer_international` DISABLE KEYS */;
/*!40000 ALTER TABLE `answer_answer_international` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `answer_collection`
--

DROP TABLE IF EXISTS `answer_collection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `answer_collection` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `answer_collection_wordlist_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `answer_collection_wordlist_id` (`answer_collection_wordlist_id`),
  CONSTRAINT `answer_collection_ibfk_1` FOREIGN KEY (`answer_collection_wordlist_id`) REFERENCES `answer_collection_wordlist` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answer_collection`
--

LOCK TABLES `answer_collection` WRITE;
/*!40000 ALTER TABLE `answer_collection` DISABLE KEYS */;
INSERT INTO `answer_collection` VALUES (1,1),(2,2);
/*!40000 ALTER TABLE `answer_collection` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `answer_collection_answers`
--

DROP TABLE IF EXISTS `answer_collection_answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `answer_collection_answers` (
  `answer_collection_id` int(11) NOT NULL,
  `answer_option_id` int(11) NOT NULL,
  `nth_answer` int(11) DEFAULT NULL,
  PRIMARY KEY (`answer_collection_id`,`answer_option_id`),
  KEY `answer_option_id` (`answer_option_id`),
  CONSTRAINT `answer_collection_answers_ibfk_1` FOREIGN KEY (`answer_collection_id`) REFERENCES `answer_collection` (`id`),
  CONSTRAINT `answer_collection_answers_ibfk_2` FOREIGN KEY (`answer_option_id`) REFERENCES `answer_option` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answer_collection_answers`
--

LOCK TABLES `answer_collection_answers` WRITE;
/*!40000 ALTER TABLE `answer_collection_answers` DISABLE KEYS */;
INSERT INTO `answer_collection_answers` VALUES (1,1,1),(1,2,2),(1,3,3),(1,4,4),(1,5,5),(1,6,6),(1,7,7),(1,8,8),(1,9,9),(1,10,10),(2,11,1),(2,12,2);
/*!40000 ALTER TABLE `answer_collection_answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `answer_collection_wordlist`
--

DROP TABLE IF EXISTS `answer_collection_wordlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `answer_collection_wordlist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answer_collection_wordlist`
--

LOCK TABLES `answer_collection_wordlist` WRITE;
/*!40000 ALTER TABLE `answer_collection_wordlist` DISABLE KEYS */;
INSERT INTO `answer_collection_wordlist` VALUES (1),(2);
/*!40000 ALTER TABLE `answer_collection_wordlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `answer_collection_wordlist_international`
--

DROP TABLE IF EXISTS `answer_collection_wordlist_international`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `answer_collection_wordlist_international` (
  `answer_collection_wordlist_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `word` varchar(255) NOT NULL,
  PRIMARY KEY (`answer_collection_wordlist_id`,`language_id`),
  CONSTRAINT `answer_collection_wordlist_international_ibfk_1` FOREIGN KEY (`answer_collection_wordlist_id`) REFERENCES `answer_collection_wordlist` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answer_collection_wordlist_international`
--

LOCK TABLES `answer_collection_wordlist_international` WRITE;
/*!40000 ALTER TABLE `answer_collection_wordlist_international` DISABLE KEYS */;
INSERT INTO `answer_collection_wordlist_international` VALUES (1,1,'Szám'),(1,2,'Number'),(2,1,'Kutya és Macska'),(2,2,'Dog and Cat');
/*!40000 ALTER TABLE `answer_collection_wordlist_international` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `answer_option`
--

DROP TABLE IF EXISTS `answer_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `answer_option` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `picture_answer_type_id` int(11) NOT NULL,
  `picture_answer_answer_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `answer_option_ibfk_1` (`picture_answer_type_id`),
  KEY `answer_option_ibfk_2` (`picture_answer_answer_id`),
  CONSTRAINT `answer_option_ibfk_1` FOREIGN KEY (`picture_answer_type_id`) REFERENCES `picture_answer_type` (`id`),
  CONSTRAINT `answer_option_ibfk_2` FOREIGN KEY (`picture_answer_answer_id`) REFERENCES `picture_answer_answer` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answer_option`
--

LOCK TABLES `answer_option` WRITE;
/*!40000 ALTER TABLE `answer_option` DISABLE KEYS */;
INSERT INTO `answer_option` VALUES (1,1,1),(2,1,2),(3,1,3),(4,1,4),(5,1,5),(6,1,6),(7,1,7),(8,1,8),(9,1,9),(10,1,10),(11,2,11),(12,2,12);
/*!40000 ALTER TABLE `answer_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `answer_type_international`
--

DROP TABLE IF EXISTS `answer_type_international`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `answer_type_international` (
  `id` int(11) NOT NULL,
  `picture_answer_type_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `answer` varchar(31) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_answer` (`answer`),
  KEY `picture_answer_type_id` (`picture_answer_type_id`),
  KEY `language_id` (`language_id`),
  CONSTRAINT `answer_type_international_ibfk_1` FOREIGN KEY (`picture_answer_type_id`) REFERENCES `picture_answer_type` (`id`),
  CONSTRAINT `answer_type_international_ibfk_2` FOREIGN KEY (`language_id`) REFERENCES `language` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answer_type_international`
--

LOCK TABLES `answer_type_international` WRITE;
/*!40000 ALTER TABLE `answer_type_international` DISABLE KEYS */;
/*!40000 ALTER TABLE `answer_type_international` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `answer_wordlist`
--

DROP TABLE IF EXISTS `answer_wordlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `answer_wordlist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answer_wordlist`
--

LOCK TABLES `answer_wordlist` WRITE;
/*!40000 ALTER TABLE `answer_wordlist` DISABLE KEYS */;
INSERT INTO `answer_wordlist` VALUES (1),(2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12);
/*!40000 ALTER TABLE `answer_wordlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `answer_wordlist_international`
--

DROP TABLE IF EXISTS `answer_wordlist_international`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `answer_wordlist_international` (
  `wordlist_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `word` varchar(255) NOT NULL,
  PRIMARY KEY (`wordlist_id`,`language_id`),
  KEY `windx_word` (`word`),
  CONSTRAINT `answer_wordlist_international_ibfk_1` FOREIGN KEY (`wordlist_id`) REFERENCES `answer_wordlist` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `answer_wordlist_international`
--

LOCK TABLES `answer_wordlist_international` WRITE;
/*!40000 ALTER TABLE `answer_wordlist_international` DISABLE KEYS */;
INSERT INTO `answer_wordlist_international` VALUES (10,1,'0'),(10,2,'0'),(1,1,'1'),(1,2,'1'),(2,1,'2'),(2,2,'2'),(3,1,'3'),(3,2,'3'),(4,1,'4'),(4,2,'4'),(5,1,'5'),(5,2,'5'),(6,1,'6'),(6,2,'6'),(7,1,'7'),(7,2,'7'),(8,1,'8'),(8,2,'8'),(9,1,'9'),(9,2,'9'),(12,2,'Cat'),(11,2,'Dog'),(11,1,'Kutya'),(12,1,'Macska');
/*!40000 ALTER TABLE `answer_wordlist_international` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country`
--

DROP TABLE IF EXISTS `country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `country` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country`
--

LOCK TABLES `country` WRITE;
/*!40000 ALTER TABLE `country` DISABLE KEYS */;
INSERT INTO `country` VALUES (1),(2),(3);
/*!40000 ALTER TABLE `country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country_calling_code`
--

DROP TABLE IF EXISTS `country_calling_code`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `country_calling_code` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `country_id` int(11) DEFAULT NULL,
  `country_number` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_country_number` (`country_number`),
  KEY `country_id` (`country_id`),
  CONSTRAINT `country_calling_code_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`),
  CONSTRAINT `check_country_number` CHECK (`country_number` regexp '^[0-9]+$'),
  CONSTRAINT `chk_country_number` CHECK (`country_number` regexp '^[0-9]+$')
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country_calling_code`
--

LOCK TABLES `country_calling_code` WRITE;
/*!40000 ALTER TABLE `country_calling_code` DISABLE KEYS */;
INSERT INTO `country_calling_code` VALUES (1,1,36),(2,2,44);
/*!40000 ALTER TABLE `country_calling_code` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country_language`
--

DROP TABLE IF EXISTS `country_language`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `country_language` (
  `country_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  PRIMARY KEY (`country_id`,`language_id`),
  KEY `language_id` (`language_id`),
  CONSTRAINT `country_language_ibfk_1` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`),
  CONSTRAINT `country_language_ibfk_2` FOREIGN KEY (`language_id`) REFERENCES `language` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country_language`
--

LOCK TABLES `country_language` WRITE;
/*!40000 ALTER TABLE `country_language` DISABLE KEYS */;
INSERT INTO `country_language` VALUES (1,1),(2,2),(3,3),(3,4),(3,5);
/*!40000 ALTER TABLE `country_language` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `country_name`
--

DROP TABLE IF EXISTS `country_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `country_name` (
  `country_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(63) NOT NULL,
  PRIMARY KEY (`country_id`,`language_id`),
  KEY `fk_language_country_name` (`language_id`),
  CONSTRAINT `fk_country_id` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`),
  CONSTRAINT `fk_language_country_name` FOREIGN KEY (`language_id`) REFERENCES `language` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `country_name`
--

LOCK TABLES `country_name` WRITE;
/*!40000 ALTER TABLE `country_name` DISABLE KEYS */;
INSERT INTO `country_name` VALUES (1,1,'Magyarország'),(1,2,'Hungary'),(2,1,'Anglia'),(2,2,'England'),(3,1,'Szájc'),(3,2,'Switzerland'),(3,3,'Svájc'),(3,4,'Suisse'),(3,5,'Svizzera');
/*!40000 ALTER TABLE `country_name` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_tld`
--

DROP TABLE IF EXISTS `email_tld`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_tld` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `tld` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `tld` (`tld`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_tld`
--

LOCK TABLES `email_tld` WRITE;
/*!40000 ALTER TABLE `email_tld` DISABLE KEYS */;
INSERT INTO `email_tld` VALUES (2,'com'),(1,'hu');
/*!40000 ALTER TABLE `email_tld` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `email_type`
--

DROP TABLE IF EXISTS `email_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `email_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `domain` varchar(31) NOT NULL,
  `tld_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `tld_id` (`tld_id`),
  KEY `domain_tld_index` (`domain`,`tld_id`),
  CONSTRAINT `email_type_ibfk_1` FOREIGN KEY (`tld_id`) REFERENCES `email_tld` (`id`),
  CONSTRAINT `email_domain_check` CHECK (`domain`  not like '%@%')
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `email_type`
--

LOCK TABLES `email_type` WRITE;
/*!40000 ALTER TABLE `email_type` DISABLE KEYS */;
INSERT INTO `email_type` VALUES (1,'gmail',2),(2,'mailbox.unideb',1);
/*!40000 ALTER TABLE `email_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gender`
--

DROP TABLE IF EXISTS `gender`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gender` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gender`
--

LOCK TABLES `gender` WRITE;
/*!40000 ALTER TABLE `gender` DISABLE KEYS */;
INSERT INTO `gender` VALUES (1),(2),(3);
/*!40000 ALTER TABLE `gender` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gender_name`
--

DROP TABLE IF EXISTS `gender_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gender_name` (
  `gender_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`gender_id`,`language_id`),
  KEY `language_id` (`language_id`),
  CONSTRAINT `gender_name_ibfk_1` FOREIGN KEY (`gender_id`) REFERENCES `gender` (`id`),
  CONSTRAINT `gender_name_ibfk_2` FOREIGN KEY (`language_id`) REFERENCES `language` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gender_name`
--

LOCK TABLES `gender_name` WRITE;
/*!40000 ALTER TABLE `gender_name` DISABLE KEYS */;
INSERT INTO `gender_name` VALUES (1,1,'Férfi'),(1,2,'Male'),(2,1,'Nő'),(2,2,'Female'),(3,1,'Macska'),(3,2,'Cat');
/*!40000 ALTER TABLE `gender_name` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `google_auth_player`
--

DROP TABLE IF EXISTS `google_auth_player`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `google_auth_player` (
  `player_id` int(11) NOT NULL COMMENT 'Unique identifier for the record; ensure unique across other tables',
  `email_prefix` varchar(31) NOT NULL,
  `email_type_id` int(11) NOT NULL,
  PRIMARY KEY (`player_id`),
  KEY `email_type_id` (`email_type_id`),
  CONSTRAINT `google_auth_player_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `player_id` (`id`),
  CONSTRAINT `google_auth_player_ibfk_2` FOREIGN KEY (`email_type_id`) REFERENCES `email_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `google_auth_player`
--

LOCK TABLES `google_auth_player` WRITE;
/*!40000 ALTER TABLE `google_auth_player` DISABLE KEYS */;
/*!40000 ALTER TABLE `google_auth_player` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guest_player`
--

DROP TABLE IF EXISTS `guest_player`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `guest_player` (
  `player_id` int(11) NOT NULL,
  PRIMARY KEY (`player_id`),
  CONSTRAINT `guest_player_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `player_id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guest_player`
--

LOCK TABLES `guest_player` WRITE;
/*!40000 ALTER TABLE `guest_player` DISABLE KEYS */;
INSERT INTO `guest_player` VALUES (2),(3),(4),(5),(6),(7),(8),(9),(10),(11),(12),(13),(14),(15),(16),(17),(18),(19),(20),(21),(22),(23),(24),(25),(26),(27),(28),(30),(31);
/*!40000 ALTER TABLE `guest_player` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `language`
--

DROP TABLE IF EXISTS `language`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `language` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `language`
--

LOCK TABLES `language` WRITE;
/*!40000 ALTER TABLE `language` DISABLE KEYS */;
INSERT INTO `language` VALUES (1),(2),(3),(4),(5);
/*!40000 ALTER TABLE `language` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `language_name`
--

DROP TABLE IF EXISTS `language_name`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `language_name` (
  `language_id` int(11) NOT NULL,
  `name_language_id` int(11) NOT NULL,
  `name` varchar(31) DEFAULT NULL,
  PRIMARY KEY (`language_id`,`name_language_id`),
  KEY `language_name_ibfk_2` (`name_language_id`),
  CONSTRAINT `language_name_ibfk_1` FOREIGN KEY (`language_id`) REFERENCES `language` (`id`),
  CONSTRAINT `language_name_ibfk_2` FOREIGN KEY (`name_language_id`) REFERENCES `language` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `language_name`
--

LOCK TABLES `language_name` WRITE;
/*!40000 ALTER TABLE `language_name` DISABLE KEYS */;
INSERT INTO `language_name` VALUES (1,1,'magyar'),(1,2,'hungarian'),(2,1,'angol'),(2,2,'english'),(3,1,'német'),(4,1,'francia'),(5,1,'olasz');
/*!40000 ALTER TABLE `language_name` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `login_info`
--

DROP TABLE IF EXISTS `login_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `login_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `player_id` int(11) DEFAULT NULL,
  `country_id` int(11) DEFAULT NULL,
  `login_time` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `player_id` (`player_id`),
  KEY `country_id` (`country_id`),
  KEY `idx_login_time` (`login_time`),
  CONSTRAINT `login_info_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `player_id` (`id`),
  CONSTRAINT `login_info_ibfk_2` FOREIGN KEY (`country_id`) REFERENCES `country` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `login_info`
--

LOCK TABLES `login_info` WRITE;
/*!40000 ALTER TABLE `login_info` DISABLE KEYS */;
INSERT INTO `login_info` VALUES (1,1,1,'2023-10-13 09:45:37');
/*!40000 ALTER TABLE `login_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `password`
--

DROP TABLE IF EXISTS `password`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `password` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `player_id` int(11) DEFAULT NULL,
  `salt` varchar(65) DEFAULT NULL,
  `password_hash` varchar(65) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `player_id` (`player_id`),
  CONSTRAINT `password_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `player_id` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `password`
--

LOCK TABLES `password` WRITE;
/*!40000 ALTER TABLE `password` DISABLE KEYS */;
/*!40000 ALTER TABLE `password` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `phone_network`
--

DROP TABLE IF EXISTS `phone_network`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `phone_network` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `network_number` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `network_number` (`network_number`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `phone_network`
--

LOCK TABLES `phone_network` WRITE;
/*!40000 ALTER TABLE `phone_network` DISABLE KEYS */;
INSERT INTO `phone_network` VALUES (2,30),(1,70);
/*!40000 ALTER TABLE `phone_network` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `picture`
--

DROP TABLE IF EXISTS `picture`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `picture` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `picture`
--

LOCK TABLES `picture` WRITE;
/*!40000 ALTER TABLE `picture` DISABLE KEYS */;
INSERT INTO `picture` VALUES (15),(16),(17),(18),(19),(20),(21);
/*!40000 ALTER TABLE `picture` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `picture_answer_answer`
--

DROP TABLE IF EXISTS `picture_answer_answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `picture_answer_answer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `answer_wordlist_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `answer_wordlist_id` (`answer_wordlist_id`),
  CONSTRAINT `picture_answer_answer_ibfk_1` FOREIGN KEY (`answer_wordlist_id`) REFERENCES `answer_wordlist` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `picture_answer_answer`
--

LOCK TABLES `picture_answer_answer` WRITE;
/*!40000 ALTER TABLE `picture_answer_answer` DISABLE KEYS */;
INSERT INTO `picture_answer_answer` VALUES (1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10),(11,11),(12,12);
/*!40000 ALTER TABLE `picture_answer_answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `picture_answer_type`
--

DROP TABLE IF EXISTS `picture_answer_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `picture_answer_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_wordlist_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `type_wordlist_id` (`type_wordlist_id`),
  CONSTRAINT `picture_answer_type_ibfk_1` FOREIGN KEY (`type_wordlist_id`) REFERENCES `type_wordlist` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `picture_answer_type`
--

LOCK TABLES `picture_answer_type` WRITE;
/*!40000 ALTER TABLE `picture_answer_type` DISABLE KEYS */;
INSERT INTO `picture_answer_type` VALUES (1,1),(2,2);
/*!40000 ALTER TABLE `picture_answer_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `picture_bin_data`
--

DROP TABLE IF EXISTS `picture_bin_data`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `picture_bin_data` (
  `picture_id` int(11) DEFAULT NULL,
  `bin_data` longblob DEFAULT NULL,
  KEY `picture_id` (`picture_id`),
  CONSTRAINT `picture_bin_data_ibfk_1` FOREIGN KEY (`picture_id`) REFERENCES `picture` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `picture_bin_data`
--

LOCK TABLES `picture_bin_data` WRITE;
/*!40000 ALTER TABLE `picture_bin_data` DISABLE KEYS */;
INSERT INTO `picture_bin_data` VALUES (16,'�PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0�\0\0\0�\0\0\0�gs\0\04IDATx^��[��8�����l��a�J��L���.�W�����������������������������������������w���z��۲k0����[�D?�Z������-qk~�����g%�nˏ���sd8�h�nʏx�d�se:[oen���d�3f=gk%n���dƳf?o�ސ��lx��pŔ����x�����t7㇩��x�\nw:2���Q*~����)nƏQ����e��Ȇ����k����?@���[��io��~�#�w����\r�8����6���gq�J;��	G�6�U�Hs\\m軪��&���Op�*��߂�V\Z���ۄނ�V\Z�%�Sa��p�*��Rm��p�*c�ĭf�k��9^�G�^�o6��o�G�n3o7��U��Re��\'�2\\�*�����pQO!O!O!O!O!O!O!O!O!O!O!O�1:��U���}��0:�������E��ct���\\��65nQX��6unR��)��)��i8Fgx\Z�jt�Z�)�����ݦލ\n`t��!�G��y��1:��+D��{�	1:���D��}��0:�Sw�zt��7L����`p+D�Y㖉��f��&��OC�\Z�f��&��O�18�Sw�m��6��8�[1�͚���V�n���cp������m־�\0���~s����}s�N����%:`l��?�h���>Wi���1Wi���{.�\0c3��\\�!�fp������s����]�R706��ε.blFw��]����W����}.w�3�g\\��fpϹ����p�7�ѵ��ѵ��ѵ�;�ѵ�����W���]?.��3��\\���\",�.c3�1�^���8ˮ��n�%�fp�7�rk36��������,�<�3�XK,��~F��o����(8>����Σ~J�ˀ�>�ܺ���s���ܲ��C����(�,�y�9���2�2�����ٿ�5%Ve(|�����\r�7����]�~G��_�����������i�d=��o����M�$c���;V5ݒ�w#��K�s�;�������\Zϝ��N��1&�7�O�ϛ�D8��A��Qｃ��z֜�1(�=����lY��W�S��#����A<S����{���A#e>��Ҟ�#f��:�}��R��Cf\Z��}.���,R��cf��\Zu>�o�Eړf���Y��{ό�<u�e�ͣgV�<	��$���SA�[c=�*��$i�TS�F�K����7�x�>+X�J�������������������������������q��ݼ�.�\0\0\0\0IEND�B`�'),(15,'�PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0y\0\0\0{\0\0\0P2/B\0\0�IDATx^��n�@��?�E���Ғ��P��x	bM������P$7\0�\r@r��\0$7\0�\r@r��\0$7\0�\r@r��\0$7\0�\r@r��\0$7�\"��z�\nx��\n�\Z��5U���5�/�bR���82���#����:��.���_?r,�֊I`5QRߜ)	��P��#��Wg(y�p\'	��P�;�Ց�Ǿ:���WGr��H�c_�y�#9�}u$籯��<�Ց�Ǿ:���WGr��H�c_�y�#9�}u$籯��<�Ց�Ǿ:���WGr��H�c_�y�#9�}u$籯��<�Ց�Ǿ:���WGr��H�c_�y�#9�}u$籯��<�Ց�Ǿ:��XWW�H�`]�s`]�s`[^#9�my|5pۊ*�n�:��T�#p�R*��g�uT��;K��\"��g�ET�V�/%�P�[�L��*u+])�\\�j:R����t�|[���@��*VS��\r�At�v;����6��\n�,�f���`$�\'Xu,�{�ۏ2�����`z�*weHH�+�|�amt��̌�:��g�4ѱ�2#+�xkm/��w�t�i���ef��.����>%�L��\"�B���Ӥ�w0Ev+O�z��4-tܽ�y��\'�����q��{O0}�-��7�f�:�f$�o�X������I�k�Fq|3Ͳ-T��*��3K�P![9����H�*Fs�;���\Z-~��|�\'���*�h!��;�@�;��+�@�_PqgR�\Z-N��R�z��\r$7\0�\r@r��\0$7\0�\r@r��\0$7\0�\r@r�܀?/*�U*�\0\0\0\0IEND�B`�'),(18,'�PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0�\0\0\0�\0\0\0�:d�\0\09IDATx^���r�JEQ��O\'��,�\Z�^Uy�m�<د@\"/��$�D*�T�$R!H�B�H� �\nA\"�D*�T�$R!H�B�H� �\nA\"�D*�Tr�����ְࢯ1�:\\�1�:\\�1�:\\�1�:|HC$�=X�!\r� �`�4B���X�H�{�ϱ����\'�w��gX�@�#��X�&��kx��?�X�\rN�ӟ��q�]���Ŧ?�;���>��>�v����}��}\n����3���v��w�=�{C�������=V\Z�%�\'��c5�QY�z�w�����V����\Z�5����/�����$�տA��#��1���7��1����Ư�����s&���\Z��Ϛj�j���y�]M���~ގϜf�b\Zήx<>s���i4;����)�-�����\'�������w7j��X�;����1ki$��D}OGc��H<C����F���xG����}��_JÈ���wv�z)�\"2�S�[]�NFq�+k����ﮬ�R\ZDt\'����Ki\'�8��U�[JC8�>é稦�J\Z��2=K�V�\0NG��Y�h�R�\0�=O-V��g	 ��TP~%=z��g|��J���v��ϕY���َ��ٲ*��;���?_F%W�Cg=v�g̦�Jz��Ǯ��ٔ[I����U�3�R+遳�ҳfQj%=p�#Wz�,ʬ�ǭp�jϛA����U�[�O+�R��V}�ү�G�tت�}R���ՎZ��OI����A�?�	)W�CV=f�w��n%=b�Cvy�H�V�V?d����j%=`�#vz�(iV��u8`����b%=\\�v{��Wңu:`���p|%=Z��u|\'o�W�|������Jz�nG��n^�����x������Jz����~�����z�	�[�Jz��ǚ�������~�)�S�Jz��G������4�@��w����84�}wYI3�8�y��Jz�IǙ�Ϋ�WңL:���^���L~��BV�z��c%Gi�J�Ҏ��+9\"H;VrD�v�� �X�Aڱ�#��c%Gi�J�Ҏ��+9\"H;VrD�v�� �X�Aڱ�#��c%Gi�J�Ҏ��+9\"H;VrD�v�� �X�Aڱ�#��c%Gi�J�Ҏ��+9\"H;VrD�v�� �X�Aڱ�#��c%Gi�J�Ҏ��+9\"H;VrD�v�� �X�Aڱ�#��c%Gi�J�Ҏ��+9� ��\Z9#HrF�6,� mX�Aڰ�3\r�(?c�\0y� ��X\'\0A��:�>�	�A��X&A��2A4H�|�U�h���\"�k�� ��J ���*��\Z�\"�k�� ��J ���*��3VA*�T�$R!H�B�H� ��O8������\0\0\0\0IEND�B`�'),(19,'�PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0�\0\0\0�\0\0\0�\'J\0\0�IDATx^���n$G@��O�×�����k*����d��?��~���\n�倂r@A9��PP((�\n�倂r@A9��PP((�\n�倂r@A9��PP((�~~~.y�ˆ���q�}H��ǵl��װ�dx�p��||�o���:����q���(�zg`�;�����M2�O5����V�v����}������ C�F0��ߜeU6u��[��ޜeE6u�Ia�Y&̴\n[�X�pBs�	3���.65�9״�&��e�/g�8�$6s�����S��f.�a���f}��\\ �6=p9��y�b+X-h9�\n3��V.�b�r�U�~��|(�J�r�U�~��|h倭<�l������O���2X�l���f#\'e)�����	Y\n��N�zBC9�����{pك���\\��,�r|/�= K���u�b(�ws�c/.|�r�Ņ�����\\�)���υ�c?�ܤ�q�&�؏+7)�~\\�I9���MʱWnR���r�r�Ǖ��c?�ܤ�q�&�؏+7)�~\\�I9���MʱWn�b(�\\�!��{p��ؓK7(Ǟ\\�A9���\rʱ\'�nP�=�t�r�ɥ�cO.ݠ{r��ؓK7(Ǟ\\�A9���\rʱ\'�nP�=�t�r�ɥ�cO.ݠ{r��ؓK7(Ǟ\\�A9���\rʱ\'�nP�=�t�r�ɥ�cO.�pG9�vϲ�+B����}l��@�g�|\\�FΆ0?���\Z6�p&|���u��:���`C��o�˿�~���zgk\r�?�-��o�����g[M�߂�����N���賭�Y-W��Sr�7gY�mP-���ęVa[d��[�lR�ε�: �V�I&�6�m�a��M2y��l�[�i��7�m�������Mf[\'d�&o����V\n�J�Nc[\'���f�ƶN��M�*sNd[\'d�&�n�9\'���V	�*sNd[\'��U�ȶN��M\r�\n3Ne[\'e覆o�|���2x�7}��l�C�i�<�t���ߴ\0N�m:ۺ@pR�εۺ@pR\'δ\nۺH���0�w��賭e�d~O��g[�0^���G���\r2�gÙ���q���$����\Z6y��]�{���2ȟ>�c�Ȁy�����PP((�\n�倂r@A9��PP((�\n�倂r@A9��PP((�\n�倂r@A9��PP((�\n�倂r@A9��PP((�\n�倂r@A9��PP((�\n����i��b\0\0\0\0IEND�B`�'),(17,'�PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0�\0\0\0�\0\0\0n�\0\0�IDATx^��n�X��?��00S���[�H5�K.>dI_��P��]rL��S(#���1�2rL��S(#���1�2rL��S(#���1�2rL��S(#���1�2rL��S(#���1�2rL��S(#���1�2rL��S(�꘾��ޞ�vy�s�F���5.xj�kȚ�B&���!.��.��;�E���y�qg�dLpA���{w�ӑ0��L.��ߙOE�9����2��hc�W^3^�Oa�)�;�g�+�	���h\'��{u63Ҏ�%3?��gG���F�����wG���&�A�+}�7�\r����-_��9�6��\r�B|���$�\n:qvӖ��\\�=���iKLQ����n��u��	=9�jK�*h�r�Ֆ�Q�t��-���I���Y[B71\nЙ���tNRT�3uom�(E]�\nN�Z�9�Q��Yk:\'1*89kMG1�rp�՞�r�MBO�F�9	����]��s4�����n�&�#O#	)�AT7���h,!E9��^\\܌��0iOC\'.^�SR���\'q�!��U�Ѕ�����.�|H$�<\'��Ё�����&�]�ݱ�Tb�tzvv�-�z�ԫ��ko�Ԕ�*��ӽ�dr�u|�m�)���7����8�Ȧ����l���t\nw��g��&�\"���f�ܖ��G��V\\��2��l�bӌQ[\n���|��\\�䢘�l>	��\\T����O�ص�Һ�7�OŲ9�����o��X\Z�����M�[#\\lł���	�X���Y6�q6�v�,��s6�uV���v�ۣ	�Yc��pt��ل{�2ǣ��0��	�� �	u��Ƀ9�P�J�<�P���x�&<�*�<��&Գ�*��Gß��Ya�Grv,���߄����q�v$����6\\��$���߿��g�\r�����7¿ؚ��9����?�Z���\0��	�ci��Z:�Y��O��]�l~��7�be�~j���S�l��������m���ڱX����+f�������]����Hf�̢��\r.or��1�G\ry\\���E%���,��1�Z�)�۫/��Tsv!ۜR]3��}��N�aV���ȶu\\\n3��ٖ��`n�fd۹/��9�m�A>;�&d�P��x��lA�	�o��>[z}#�d���%�b��o�mCG���.���{G���,�vs�)���%��q\\�H�*�*����\")�:	�\n{r��N��� ��ӡ�n2@��b+`W�ޚ�N�Pe����jw�4/B�jR��}9\nh��E*	}\ZvV�?��&�\"�vV�?�z�9-����?�r!�9)����>�r1:-�v�����CP��	�y�{�kC�B\'a���}/5B�b�`���}/5C�r�`߮�=�A����gWמW���n�L��yE\0�=�MLt�yEJ>w&���\"E�4�L��yE\n�:�0cg֞WL���$����3����4|�l��{�.�u��{i!\\��L0��R�Љ�d���p�O�\n:I�=9�PF�)��c\ne�B9�PF�)��c\ne�B9�PF�)��c\ne�jH5�C±n\0\0\0\0IEND�B`�'),(20,'�PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0�\0\0\0�\0\0\0��\r\0\0*IDATx^��Kr�XDQ��Ճ�\n��DR�\0�{\"�Ėe |��˗�\0\0�X`p��a\0�`p��a\0�`p��a\0�`p��a\0�`p��a\0�`p��a\0����������.���y��D��E���7&�����������2�]h�[}�i��t��.�~�{�e��ty�Z`�N}�o�tY�^X�n�P����^����k����.�]˩��=�1n\Z��O,���\'k�7n�Qk�R8���J�M6*}]�*˧5U�o�1���U\\<��j��I\\��i���M5&�nK��v�;ň�u��,��ܭ��F$�y����}t3\"݄��:��A|��HݗI{��OU�&.����W%щ��$-����[�i�/�����S����4�cr�w�Npʲh����!:�I���N��J��M[�wJ�W�Nm�hߓz?Ktb��C{����b�ҥ�������LJ�a�Bh���#2%�\'̓LދL�%�M3!������\0�4�Y������ِ��\nC��ދK������oqi0�m4\'��)*	2�~M�\"�oQ)0�c47��0�f7=���u��{�}�鞡~N3��cL�����,c�f���,��y�o*�]���A��<�d�����~!i(Uh��r����zW��4�J4�W�n�\\��_H\ZJ%��|�|����/$\r�\Z��e����wӻ����T�*c�������/$\r�*�x�����zW��4��4�W����/$\r�:�z�uֻ����t�y��Y����҅f�����/$\r��=e��_H\ZJ����zW��4�4o�:�]�B�P:м��w�IC�Ls^��~�U����R�f�Y������/$\r�\Z�v-�W��w�IC�B3է������/$\r�i��{Ζ�tѻ����<A�{��l�\\��_Сt��4�-���w�\"i0k�ǫ���m5��:�������#���*zW/t0O\rH�������I��7t8WI���;�����կ�}2$��\n��.unѻ�tH[�s�K��g����A��~��7QR��Cu��OI���~֑�m�r�]�:�w�%eػ�tx�p\\R���G)`p��a\0�`p��a\0�`p��a\0�`p��a\0�`p��a\0�`p��a\0�`p��a\0�`p��a\0�`p��a\0B���\0��>���w�8��0\0��\008��0\0��\008��0\0��\008��0\0��\0z���a$��bEҠ*�0\Z�a���Ĝ3�:���U��sF�+ih�$f���\nX��*I�7��thIë\"1ی.�������l3��@��2�\ns��b^�\0+H�5���XAb�]l�8�\ns��b#`� ���gF;�S���<3��I�2̧$f���N:Ȕa>AsL�2��t�)�[j�9��M\Z�R3���ԡ�E�K�0��t�I��CrvY�줃M�U�3���\0n␯��YV7�S�}�䬲���y��[r6Y�|H��M�y�e���It�ko*�!1���N��wo*�!1���.��[M�!����B�/��}�����Et!�M0����.��1aI��~�{����$�ˢ=���Ovw7�eI\\�+�?\'�����$-�����;��DG_W�G�^�����t��.��߱���tz3]�n˥5w��,����.V�%�Z;�|�Y�>@����i��k�Ҽ�������Rmw����t��=Akx��\n�v� ]��w5��&����t	���H�\0]�\'�G������4�ҥ���#��0\0��\008��0\0��\008��0\0��\008��0\0��\0��\0,���1v�\0\0\0\0IEND�B`�'),(21,'�PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0�\0\0\0�\0\0\0�\'J\0\0\0IDATx^��YR$IP�iưf\Z�I�Bm�{f��G����ށCo��倂r@A9��PP((�\n�倂r@A9��PP((�\n�倂r@A9��PP((�\n�倂r@A9��PP((�\n��h����.�m,,�3�r�,U�L6{�B>��j����Jp�����݌�:�r^!��U��jm���>2�]�<���y�߆������y�KB-w5m_-��^.�{����\'ͣe���{�r�<�Q�����n�<T�����m&�ex���^~�<L�Ǜ��\'ͣdx��{_v�<���b����4�1�(��z��&�#L;ƪ��c�I�\0����7Yb�\\��#�n�]��t�v0�6s&�ה\n���ﳋ�aִ\\,K1��M�YY����0sjJY\n�w�Hs\'�,�b�1{z~�A1���`Y���-�eP��lc�,�R�f+d2���G��4�%�p�\r5��p9�j$���:6�DA)ngs��\"�߱�\r��?\n����d	��}����W�ltQ��O�ǰ�+��|Ux<[�B>�W����}vx>[�B>�G��r�_ʇ|��7�2�\n�q�;�\"�\n�p�;�\"Ta.�@Y�ks�\'�b����e���x�,C^�^(�p.<��/\"�p.<�-/&Kp.<��.(p.<��n$K��ltCY�*��7�e����\\Y�*\\�ƚ�\"���RSY�K¿l��,����6����1V��T��;9e�e�9�rV��\\��?!W��KW}\'�n���I�ix�,C�zL�SeNeg{=K�Bdv��,����Y^�cǂ���lC9��PP((�\n��Y�O��Þ_�Ҳ��:�þ_β�d1��{���__�r��d):�~�	B����{L�M�#�.w�e�=��&���P��]w�w�I>塺l%��n��3�7y���{��k�����S,�mr�]��o�Oy��G|��gם��*�!;��r���w���pZ�k��zO��垦��t�~�M�ӌ)y��t��i{�3�	y��D�����3��\02���c���,Bf��{����7��ad:�;�z���_(J�G�se��;��dv��d&�=�������r��t6�������ƣ��6n��(���:\n����;�+��c6s��N����l���.cS�r�p9�z�|���csO��Q�v�倂r@A9��PP((�\n�倂r@A9��PP((�\n�倂r@A9��PP((�\n�倂r@�?�:�Ey۠�\0\0\0\0IEND�B`�');
/*!40000 ALTER TABLE `picture_bin_data` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `picture_bin_fragments`
--

DROP TABLE IF EXISTS `picture_bin_fragments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `picture_bin_fragments` (
  `id` bigint(20) NOT NULL,
  `picture_id` int(11) NOT NULL,
  `fragment_bin` binary(255) NOT NULL,
  `fragment_number` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `picture_id` (`picture_id`),
  CONSTRAINT `picture_bin_fragments_ibfk_1` FOREIGN KEY (`picture_id`) REFERENCES `picture` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `picture_bin_fragments`
--

LOCK TABLES `picture_bin_fragments` WRITE;
/*!40000 ALTER TABLE `picture_bin_fragments` DISABLE KEYS */;
/*!40000 ALTER TABLE `picture_bin_fragments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `picture_ext_option`
--

DROP TABLE IF EXISTS `picture_ext_option`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `picture_ext_option` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(7) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `picture_ext_option`
--

LOCK TABLES `picture_ext_option` WRITE;
/*!40000 ALTER TABLE `picture_ext_option` DISABLE KEYS */;
INSERT INTO `picture_ext_option` VALUES (2,'jpeg'),(1,'png');
/*!40000 ALTER TABLE `picture_ext_option` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `picture_extension`
--

DROP TABLE IF EXISTS `picture_extension`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `picture_extension` (
  `picture_id` int(11) NOT NULL,
  `ext_option_id` int(11) NOT NULL,
  PRIMARY KEY (`picture_id`),
  KEY `ext_option_id` (`ext_option_id`),
  CONSTRAINT `picture_extension_ibfk_1` FOREIGN KEY (`picture_id`) REFERENCES `picture` (`id`),
  CONSTRAINT `picture_extension_ibfk_2` FOREIGN KEY (`ext_option_id`) REFERENCES `picture_ext_option` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `picture_extension`
--

LOCK TABLES `picture_extension` WRITE;
/*!40000 ALTER TABLE `picture_extension` DISABLE KEYS */;
/*!40000 ALTER TABLE `picture_extension` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `picture_last_fragment`
--

DROP TABLE IF EXISTS `picture_last_fragment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `picture_last_fragment` (
  `fragment_id` bigint(20) NOT NULL,
  `valid_bits` int(11) NOT NULL,
  PRIMARY KEY (`fragment_id`),
  CONSTRAINT `picture_last_fragment_ibfk_1` FOREIGN KEY (`fragment_id`) REFERENCES `picture_bin_fragments` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `picture_last_fragment`
--

LOCK TABLES `picture_last_fragment` WRITE;
/*!40000 ALTER TABLE `picture_last_fragment` DISABLE KEYS */;
/*!40000 ALTER TABLE `picture_last_fragment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `picture_real_answers`
--

DROP TABLE IF EXISTS `picture_real_answers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `picture_real_answers` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `picture_real_options_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_picture_real_options_id` (`picture_real_options_id`),
  CONSTRAINT `fk_picture_real_options_id` FOREIGN KEY (`picture_real_options_id`) REFERENCES `picture_real_options` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `picture_real_answers`
--

LOCK TABLES `picture_real_answers` WRITE;
/*!40000 ALTER TABLE `picture_real_answers` DISABLE KEYS */;
/*!40000 ALTER TABLE `picture_real_answers` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `picture_real_options`
--

DROP TABLE IF EXISTS `picture_real_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `picture_real_options` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `picture_id` int(11) NOT NULL,
  `answer_collection_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_picture_id` (`picture_id`),
  KEY `answer_collection_id` (`answer_collection_id`),
  CONSTRAINT `fk_picture_id` FOREIGN KEY (`picture_id`) REFERENCES `picture` (`id`),
  CONSTRAINT `picture_real_options_ibfk_1` FOREIGN KEY (`answer_collection_id`) REFERENCES `answer_collection` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `picture_real_options`
--

LOCK TABLES `picture_real_options` WRITE;
/*!40000 ALTER TABLE `picture_real_options` DISABLE KEYS */;
INSERT INTO `picture_real_options` VALUES (10,15,1),(11,16,1),(12,17,1),(13,19,1),(14,18,1),(15,21,1),(16,20,1);
/*!40000 ALTER TABLE `picture_real_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `picture_upload_info`
--

DROP TABLE IF EXISTS `picture_upload_info`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `picture_upload_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `picture_id` int(11) DEFAULT NULL,
  `uploaded_player_id` int(11) DEFAULT NULL,
  `upload_time` datetime DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `picture_id` (`picture_id`),
  KEY `uploaded_player_id` (`uploaded_player_id`),
  CONSTRAINT `picture_upload_info_ibfk_1` FOREIGN KEY (`picture_id`) REFERENCES `picture` (`id`),
  CONSTRAINT `picture_upload_info_ibfk_2` FOREIGN KEY (`uploaded_player_id`) REFERENCES `player_id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `picture_upload_info`
--

LOCK TABLES `picture_upload_info` WRITE;
/*!40000 ALTER TABLE `picture_upload_info` DISABLE KEYS */;
/*!40000 ALTER TABLE `picture_upload_info` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_game`
--

DROP TABLE IF EXISTS `player_game`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_game` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `player_id` int(11) NOT NULL,
  `beginning` timestamp NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `player_id` (`player_id`),
  CONSTRAINT `player_game_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `player_id` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_game`
--

LOCK TABLES `player_game` WRITE;
/*!40000 ALTER TABLE `player_game` DISABLE KEYS */;
INSERT INTO `player_game` VALUES (1,2,'2023-11-26 11:35:51'),(2,6,'2023-11-26 12:13:09'),(3,6,'2023-11-26 12:15:59'),(4,7,'2023-11-26 12:16:55'),(5,9,'2023-11-26 12:51:32'),(6,9,'2023-11-26 12:55:09'),(7,10,'2023-11-27 10:53:53'),(8,10,'2023-11-27 10:54:41'),(9,11,'2023-11-27 10:57:56'),(10,12,'2023-11-27 11:01:52'),(11,13,'2023-11-27 11:02:53'),(12,14,'2023-11-27 11:06:59'),(13,15,'2023-11-27 11:18:36'),(14,15,'2023-11-27 11:18:43'),(15,15,'2023-11-27 11:20:35'),(16,16,'2023-11-27 15:31:42'),(17,16,'2023-11-27 15:31:50'),(18,17,'2023-11-27 15:33:09'),(19,16,'2023-11-27 15:38:59'),(20,17,'2023-11-27 15:41:52'),(21,16,'2023-11-27 15:50:39'),(22,18,'2023-11-27 16:02:52'),(23,19,'2023-11-27 16:03:05'),(24,18,'2023-11-27 16:04:09'),(25,20,'2023-11-27 16:06:16'),(26,21,'2023-11-27 16:11:46'),(27,22,'2023-11-27 16:19:13'),(28,24,'2023-11-27 16:30:51'),(29,25,'2023-11-27 16:34:22'),(30,26,'2023-11-30 15:21:58'),(31,27,'2023-11-30 17:13:03'),(32,27,'2023-11-30 17:13:32'),(33,30,'2023-12-01 14:45:18'),(34,30,'2023-12-01 14:45:57'),(35,30,'2023-12-01 14:46:26'),(36,30,'2023-12-01 14:46:47'),(37,31,'2023-12-02 16:36:41'),(38,31,'2023-12-02 16:44:10'),(39,31,'2023-12-02 16:44:14');
/*!40000 ALTER TABLE `player_game` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_game_answer`
--

DROP TABLE IF EXISTS `player_game_answer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_game_answer` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `player_game_id` int(11) NOT NULL,
  `picture_id` int(11) NOT NULL,
  `answer_option_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `player_game_answer_ibfk_1` (`player_game_id`),
  KEY `player_game_answer_ibfk_2` (`picture_id`),
  KEY `player_game_answer_ibfk_3` (`answer_option_id`),
  CONSTRAINT `player_game_answer_ibfk_1` FOREIGN KEY (`player_game_id`) REFERENCES `player_game` (`id`),
  CONSTRAINT `player_game_answer_ibfk_2` FOREIGN KEY (`picture_id`) REFERENCES `picture` (`id`),
  CONSTRAINT `player_game_answer_ibfk_3` FOREIGN KEY (`answer_option_id`) REFERENCES `answer_option` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_game_answer`
--

LOCK TABLES `player_game_answer` WRITE;
/*!40000 ALTER TABLE `player_game_answer` DISABLE KEYS */;
/*!40000 ALTER TABLE `player_game_answer` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_id`
--

DROP TABLE IF EXISTS `player_id`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_id` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'Avoid using the same player_id for both registered and guest players.',
  `main_language_id` int(11) NOT NULL DEFAULT 1,
  `player_role_id` int(11) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  KEY `main_language_id` (`main_language_id`),
  KEY `fk_player_role_id` (`player_role_id`),
  CONSTRAINT `fk_player_role_id` FOREIGN KEY (`player_role_id`) REFERENCES `player_role` (`id`),
  CONSTRAINT `player_id_ibfk_1` FOREIGN KEY (`main_language_id`) REFERENCES `language` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_id`
--

LOCK TABLES `player_id` WRITE;
/*!40000 ALTER TABLE `player_id` DISABLE KEYS */;
INSERT INTO `player_id` VALUES (1,1,2),(2,1,1),(3,1,1),(4,1,1),(5,1,1),(6,1,1),(7,1,1),(8,1,1),(9,1,1),(10,1,1),(11,1,1),(12,1,1),(13,1,1),(14,1,1),(15,1,1),(16,1,1),(17,1,1),(18,1,1),(19,1,1),(20,1,1),(21,1,1),(22,1,1),(23,1,1),(24,1,1),(25,1,1),(26,1,1),(27,1,1),(28,1,1),(29,1,1),(30,1,1),(31,1,1);
/*!40000 ALTER TABLE `player_id` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `player_role`
--

DROP TABLE IF EXISTS `player_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `player_role` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_role`
--

LOCK TABLES `player_role` WRITE;
/*!40000 ALTER TABLE `player_role` DISABLE KEYS */;
INSERT INTO `player_role` VALUES (1,'user'),(2,'admin');
/*!40000 ALTER TABLE `player_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `registered_player`
--

DROP TABLE IF EXISTS `registered_player`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `registered_player` (
  `player_id` int(11) NOT NULL,
  `name` varchar(31) NOT NULL,
  `gender_id` int(11) DEFAULT NULL,
  `email_prefix` varchar(31) DEFAULT NULL,
  `email_type_id` int(11) DEFAULT NULL,
  `country_calling_code_id` int(11) DEFAULT NULL,
  `phone_network_id` int(11) DEFAULT NULL,
  `phone` int(11) DEFAULT NULL,
  PRIMARY KEY (`player_id`),
  UNIQUE KEY `name` (`name`),
  KEY `gender_id` (`gender_id`),
  KEY `country_calling_code_id` (`country_calling_code_id`),
  KEY `email_type_id` (`email_type_id`),
  KEY `phone_network_id` (`phone_network_id`),
  CONSTRAINT `registered_player_ibfk_1` FOREIGN KEY (`player_id`) REFERENCES `player_id` (`id`),
  CONSTRAINT `registered_player_ibfk_2` FOREIGN KEY (`gender_id`) REFERENCES `gender` (`id`),
  CONSTRAINT `registered_player_ibfk_3` FOREIGN KEY (`country_calling_code_id`) REFERENCES `country_calling_code` (`id`),
  CONSTRAINT `registered_player_ibfk_4` FOREIGN KEY (`email_type_id`) REFERENCES `email_type` (`id`),
  CONSTRAINT `registered_player_ibfk_6` FOREIGN KEY (`phone_network_id`) REFERENCES `phone_network` (`id`),
  CONSTRAINT `CONSTRAINT_1` CHECK (`phone` is null and `country_calling_code_id` is null or `phone` regexp '^[0-9]+$' and `country_calling_code_id` is not null),
  CONSTRAINT `email_type_id_null_check` CHECK (`email_type_id` is not null or `email_prefix` is null and `email_type_id` is null),
  CONSTRAINT `email_prefix_format_check` CHECK (`email_prefix`  not like '%@%'),
  CONSTRAINT `phone_null_check` CHECK (`phone` is null or `phone` is not null and `phone_network_id` is not null)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `registered_player`
--

LOCK TABLES `registered_player` WRITE;
/*!40000 ALTER TABLE `registered_player` DISABLE KEYS */;
INSERT INTO `registered_player` VALUES (1,'Sanyi',3,'SanyiVagyok',1,1,1,123456789),(29,'egyiptomi',3,'egyiptomi',1,NULL,NULL,NULL);
/*!40000 ALTER TABLE `registered_player` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `type_wordlist`
--

DROP TABLE IF EXISTS `type_wordlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `type_wordlist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `type_wordlist`
--

LOCK TABLES `type_wordlist` WRITE;
/*!40000 ALTER TABLE `type_wordlist` DISABLE KEYS */;
INSERT INTO `type_wordlist` VALUES (1),(2);
/*!40000 ALTER TABLE `type_wordlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `type_wordlist_international`
--

DROP TABLE IF EXISTS `type_wordlist_international`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `type_wordlist_international` (
  `wordlist_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `word` varchar(255) NOT NULL,
  PRIMARY KEY (`wordlist_id`,`language_id`),
  KEY `idx_word` (`word`),
  CONSTRAINT `type_wordlist_international_ibfk_1` FOREIGN KEY (`wordlist_id`) REFERENCES `type_wordlist` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `type_wordlist_international`
--

LOCK TABLES `type_wordlist_international` WRITE;
/*!40000 ALTER TABLE `type_wordlist_international` DISABLE KEYS */;
INSERT INTO `type_wordlist_international` VALUES (2,1,'Állat'),(2,2,'Animal'),(1,2,'Number'),(1,1,'Szám');
/*!40000 ALTER TABLE `type_wordlist_international` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wordlist`
--

DROP TABLE IF EXISTS `wordlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wordlist` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wordlist`
--

LOCK TABLES `wordlist` WRITE;
/*!40000 ALTER TABLE `wordlist` DISABLE KEYS */;
/*!40000 ALTER TABLE `wordlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `wordlist_international`
--

DROP TABLE IF EXISTS `wordlist_international`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `wordlist_international` (
  `wordlist_id` int(11) NOT NULL,
  `language_id` int(11) NOT NULL,
  `word` varchar(255) NOT NULL,
  PRIMARY KEY (`wordlist_id`,`language_id`),
  KEY `fk1_language_id` (`language_id`),
  CONSTRAINT `fk1_language_id` FOREIGN KEY (`language_id`) REFERENCES `language` (`id`),
  CONSTRAINT `fk1_wordlist_id` FOREIGN KEY (`wordlist_id`) REFERENCES `wordlist` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `wordlist_international`
--

LOCK TABLES `wordlist_international` WRITE;
/*!40000 ALTER TABLE `wordlist_international` DISABLE KEYS */;
/*!40000 ALTER TABLE `wordlist_international` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-02 17:45:19
