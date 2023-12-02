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
INSERT INTO `answer_collection_wordlist_international` VALUES (1,1,'SzÃ¡m'),(1,2,'Number'),(2,1,'Kutya Ã©s Macska'),(2,2,'Dog and Cat');
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
INSERT INTO `country_name` VALUES (1,1,'MagyarorszÃ¡g'),(1,2,'Hungary'),(2,1,'Anglia'),(2,2,'England'),(3,1,'SzÃ¡jc'),(3,2,'Switzerland'),(3,3,'SvÃ¡jc'),(3,4,'Suisse'),(3,5,'Svizzera');
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
INSERT INTO `gender_name` VALUES (1,1,'FÃ©rfi'),(1,2,'Male'),(2,1,'NÅ‘'),(2,2,'Female'),(3,1,'Macska'),(3,2,'Cat');
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
INSERT INTO `language_name` VALUES (1,1,'magyar'),(1,2,'hungarian'),(2,1,'angol'),(2,2,'english'),(3,1,'nÃ©met'),(4,1,'francia'),(5,1,'olasz');
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
INSERT INTO `picture_bin_data` VALUES (16,'‰PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0\0\0\0¯\0\0\0£gs\0\04IDATx^íÒ[Ü8ÑÚÿ¦Ûl£Ûa©J’™LÆôã™.‘Wñú’¼øÒ†§†§†§†§†§†§†§†§†§†§†§†§†§†§†§†§†§†wÒëõzüèÛ²k0ŠÑÏê–[€D?«Zææüà™-qk~è»Ïü­½g%ånËùî‰Âsd8Óh¥nÊxôdÁse:[oenÊ¸÷dÄ3f=gk%nÉ·÷dÆ³f?oÓŞŠÏlxşïpÅ”·ãªğ±xÙïóÉt7ã‡©ô‘xŸ\nw:2ÕÍøQ*~ ª÷¢)nÆQù£ğeïÉÈ†¡òÇøk…»¦¾?@åñï[ñÎioÄá«~€#¼wµ»§¼\r¯8ü•ïŸî6»âègqƒJ;¤º	G®6öU·Hs\\mè»ªî‘â&·ÚÈOp“*»„ß‚£V\Z·•ŠÛ„Ş‚ƒV\Z¶%îSa£°pÈ*ƒöRm§pÄ*cöÄ­fßkøé9^…Gà^³o6üôoöGân3o7üäU†‹Re¿á\'¯2\\”*û…œ¼ÂpQO!O!O!O!O!O!O!O!O!O!O!OÃ1:ÃÓU¢ÛÌ}ú…0:ÃÓ•¢ÛÌƒE†ct†§î\\…è65nQXÅè6unR”á)„á)„ái8Fgx\Z¢jt›Z·)„Ñ†¨İ¦Ş\n`t†§!ªG·©y«‰1:ÃÓ+D·©{³	1:ÃÓ«D·©}»‰0:ÃSw®zt›ú7LÁ†`p+D·Yã–‰­İf›&ÄèOC¬\Zİf­Û&ÂèOİ18ÃSwŒmÅè6ëİ8ƒ[1ºÍš·ÂàVn³îÍcp†§îÛêÑmÖ¾ı\0ŒÍè~s›Á}s‰NœáıË%:`l†÷?—hŒ¡Û>WiˆÁŞ1Wi„±İ{.Ó\0c3¼Ï\\æ!†fpç¸ĞŒÍèÎs¥››Ñ]ãR706£»Îµ.blFw‹]ÄàŒîW»€Áİ}.wƒ3¼g\\îÆfpÏ¹àÎğÚpÁ7›ÑµãŠ›Ñµå’œÑµåš;œÑµç¢ÀàŒ®WıÁ]?.ûƒ3¼¾\\öËè\",¿.c3¸1–^™ÁŞ8Ë®ÌØn¬%×fp†7Şrk36£‹±ÔâŒÍàâ,³<ƒ3¼XK,ÏØ~F·÷oê¯üÒë(8>ê«ìÂéÎ£~J®Ë€î>ê§ÜºŒçìsô·ê£Ü²çÓCŸş»Ú(µ,£y÷9ûÿé™2Ë2˜½çşÍÙ¿Ó5%Ve(|®âßßù\r½7ı¢„Ï]­~Gû¦_”´Š…¿õô÷ô¯i×d=âào·şı•M¹$cè¿Ç;V5İ’¡w#ŞÑKæsç;Ñ¡÷°£ŞÓ\ZÏíì¹Nó‡1&ß7ê½Oğ¬Ï›ïD8äÈAùÎQï½ƒçÌzÖœ§1(ß=úıŸğlYÏùWÎSıÀ#Çä¢ÎA<S¶óíÉ{²¯ãA#e>ŸÌÒ#f“ç‰:Ï}«R’Cf\Z•ç}.¾—Ï,R”cf•ç\Zu>¾oï™EÚ“f“¼×Yùû{ÏŒæ<u eüÍ£gVó<	†ğ$şÆÑSA[c=Ÿ*êÜ$iıTSïFK‹§ªº7Äx®>+Xã–JÇğÂğÂğÂğÂğÂğÂğÂğÂğÂğÂğÂğÂğÂğÂğâq†İİ¼Ó.½\0\0\0\0IEND®B`‚'),(15,'‰PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0y\0\0\0{\0\0\0P2/B\0\0üIDATx^í‘Ënã@ıÿ?E°‡ÅÒ’­ÇPœé®x	bM“õúò¼ôP$7\0É\r@rÜ\0$7\0É\r@rÜ\0$7\0É\r@rÜ\0$7\0É\r@rÜ\0$7À\"ùõz\nx¾°\n¼\ZÇĞ5UÔèÀ5†/§bRØ×82¾ş#±·¿:¶ş.•±_?r,ıÖŠI`5QRßœ)	ì¯ÎPò½#•öWg(yíp\'	ì¯ÎP²;öÕ‘œÇ¾:’óØWGrûêHÎc_Éyì«#9}u$ç±¯ä<öÕ‘œÇ¾:’óØWGrûêHÎc_Éyì«#9}u$ç±¯ä<öÕ‘œÇ¾:’óØWGrûêHÎc_Éyì«#9}u$ç±¯ä<öÕ‘œÇ¾:’óØWGrûêHÎc_Éyì«#9}u$ç±¯ä<öÕ‘œÇ¾:’óXWWÁHÎ`]Ás`]És`[^#9‡my|5pÛŠ*ënà:¶õT’#pëR*ÅØgúuTæ·À;K¬¢\"¿şgÙETìVà/%–P¹[éL™ö*u+])×\\Åj:R¶µÊÕt¢|[•«é@‹–*VSú\rÜAtív;¨àê¢ë6û‚\n®,ºf«ƒ¨`$É\'Xu,½{¥Û2¤‘´Ú`zó*weHH³+Ş|”amt¤­ÌŒŞ:û½g°4Ñ±¶2#+Üxkm/³ wÍtÛi¡Ãíef¼é.µĞñ>%ÉL·Œ\"ÖBÇÜËÓ¤ßw0Ev+O‘z×É4-tÜ½¸yú½\'˜®…¬qóô{O0}İ-à‰7f‰:¼f$Îo§X¦…¯…ë»I–k¡Fq|3Í²-T†æ*£¾3K·P![9ËİßÏH‰*Fs†;¿•\Z-~Şå|Ê\'Îüï*Ôh!¨¨;©@;¨°+©@_PqgR\Z-N ·Rzà\r$7\0É\r@rÜ\0$7\0É\r@rÜ\0$7\0É\r@rÜ€?/*ê°U*œ\0\0\0\0IEND®B`‚'),(18,'‰PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0¤\0\0\0²\0\0\0Ì:dÇ\0\09IDATx^íÒÙrÛJEQıÿO\'®ï‰,ì\ZÃ^Uy‰m‰<Ø¯@\"/ıà$‚D*‰T©$R!H¤BH… ‘\nA\"‚D*‰T©$R!H¤BH… ‘\nA\"‚D*‰Trƒ×ëõ÷Ö°à¢¯1ä:\\ 1ä:\\ 1ä:\\ 1ä:|HC$È=Xğ!\r‘ ÷`Á4Bı‡çXÏHã{÷Ï±†÷\'¾wÿ‡gXÏ@Ã#ÈıXï&îkxßı?ìXï\rN£ÓŸéÏqË]ĞĞŞÅ¦?÷;¸‡å>ĞÈ>…v÷÷ğË} ‘}\níîïá3–û†v™åwñ=–{Cãº™şîÕïã=V\Z•%®\'ƒÿc5¡QYÂzúwø«‰•¨Vş¿°Ú\Z”5ª•¿Å/¬ö›Æô$¨Õ¿Aşµ#¦Ÿ1«ıø7¤§1íøŒéÆ¯¦­„´ës&½š´\ZÑÎÏšjôj»Úıy]MãÙ~ŞÏœfìb\ZÎ®x<>s’‘‹i4;ÃñúÜ)Æ-¦ÁìÆó³\'µ˜ÆâŒ÷çw7j±ˆXô;¼¾§«1ki$¡D}OGcÖÒH<C‰úF¬¥xG¢ßåı}´_JÃˆŠãÄwvĞz)\"2ŒSß[]ë¥NFqò»+k»”ÅÉï®¬íR\ZDt\'¿»²–Ki\'‚8ııUµ[JC8ƒ>Ã©ç¨¦ÕJ\ZÀé2=K­VÒ\0NGéYªhµR¶\0²=O-VÒÃg	 ÛóTP~%=z¦ãg|¦ìJ¯¤Ïvø¬Ï•Yé•ôàÙùÙ²*»’;ãÁ³?_F%WÒCg=v…gÌ¦ÜJzäÌÇ®ğŒÙ”[IœùĞU3“R+é³¹Ò³fQj%=pö#WzÖ,Ê¬¤Ç­pàjÏ›A‰•ô°U[ñ™O+±RÕÃV}î“Ò¯¤G­tØªÏ}Rê•ô ÕZùÙOI»’³âA«?ÿ	)WÒCV=f‡wˆ–n%=båCvyH©VÒV?d—÷ˆ”j%=`õ#vz—(iVÒãu8`·÷‰b%=\\—v{ŸÇWÒ£u:`·÷‰p|%=Z§ãu|\'oÇWê|´ÎïæåèJz°nGëün^­¤Çêx´ÎïæåØJz¬ëş~¬¤‡êz¬	ï¸[øJz¤ÎÇšğ»…®¤ê~¨)ï¹SèJz îGšô®»„®4í@ÓŞw‡°•ô84í}wYI3å8ßy•ûJz”IÇ™øÎ«ÜWÒ£L:ÌÔ÷^á¾Òä£L~÷§BVšz‚´c%GiÇJÒ•¤+9\"H;VrDv¬äˆ íXÉAÚ±’#‚´c%GiÇJÒ•¤+9\"H;VrDv¬äˆ íXÉAÚ±’#‚´c%GiÇJÒ•¤+9\"H;VrDv¬äˆ íXÉAÚ±’#‚´c%GiÇJÒ•¤+9\"H;VrDv¬äˆ íXÉAÚ±’#‚´c%GiÇJÒ•¤+9\"H;VrDv¬äˆ íXÉAÚ±’#‚´c%GiÇJÒ•¤+9Ò ‰ò\Z9#HrF6,äŒ mXÈAÚ°3\r’(?c\0yë ÈûX\'\0AŞÇ:ò>Ö	 Aå÷X&AŞÃ2A4H¢|U‚hŒù«\"Èk¬ˆ ¯±J ‚¼Æ*ò\Z«\"Èk¬ˆ ¯±J ‚¼Æ*Áò3VA*‰T©$R!H¤BH… ‘ÊO8¡µâÅè\0\0\0\0IEND®B`‚'),(19,'‰PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0Ç\0\0\0·\0\0\0¦\'J\0\0ãIDATx^íÓËn$G@ıÿOÛÃ—„¸Ëîék*¨‹¤ÑdæÏ?À¯~òÀ”\nÊå€‚r@A9  PP((”\nÊå€‚r@A9  PP((”\nÊå€‚r@A9  PP((Ç~~~.yÜË†”á¾êq›}HúÇµlôâ»×°Édx¯pş¿||Îo–¡½:¸ù¿óqíİ(ƒzg`ó;îş¾ØÜM2 O5¿ë©ïıV¶v“ç“Íï}úû¿…İ CùF0óûßœeU6uƒã[ÌŞœeE6uƒIaÌY&Ì´\n[ºX†pBs	3­À–.65„9×´ù&²eğ¦…/g›8ã$6s‘ÜÔĞåŒSçœÀf.a›¸•f}“Í\\ Ã6=p9ëôyßb+X-h9ï\n3¿ÁV.°bĞræUæ~’|(¶JÈræUæ~’|hå€­<ûlä®Õ¶òìO°‘“2X«låÙïf#\'e)„ëû¸è	Y\nÅøN®zBC9¾“« {pÙƒ²Êñ½\\ö ,†r|/—= K¡ßÍuÈb(Çwsİc/.|€rìÅ…›²Êñı\\¸)‹¡ßÏ…›c?®Ü¤ûqå&åØ+7)Ç~\\¹I9öãÊMÊ±WnRı¸r“rìÇ•›”c?®Ü¤ûqå&åØ+7)Ç~\\¹I9öãÊMÊ±WnÈb(Ç\\¹!‹¡{påÅØ“K7(Ç\\ºA9öäÒ\rÊ±\'—nP=¹tƒrìÉ¥”cO.İ {réåØ“K7(Ç\\ºA9öäÒ\rÊ±\'—nP=¹tƒrìÉ¥”cO.İ {réåØ“K7(Ç\\ºA9öäÒ\rÊ±\'—nP=¹tƒrìÉ¥”cO.İpG9òvÏ²ñ†+BšÿãªÇ}l·á“@ægï|\\ËFÎ†0?÷Ôã\Z6Ùp&|ù™êuåç:ÏØ`C†îoÁË¿í~î¨üßzgk\r´?…-ÿîo•ü¾êÑg[M²ß‚–¿¯şîNùİùè³­¦Y-WıİSr†7gY•mP-¿ÓÄ™Va[dĞş[şlR§ÎµÛ: ƒV½I&Ï6m”aûíM2y¶élë [¾i¦Ï7™m›¾éóMf[\'dà&o…§²­V\nÜJ³Nc[\'¬¸•fÆ¶NÈÀMİ*sNd[\'dà&‡n•9\'²­“V	İ*sNd[\'­ºUæœÈ¶NÊĞM\rŞ\n3Ne[\'eè¦†oú|“ÙÖ2xÃ7}¾ÉlëC¾iœ<Ût¶õ¡ß´\0Nm:Ûº@pR§ÎµÛº@pR\'Î´\nÛºH†ğ0æwÿöè³­eïd~OçÑg[Ë0^ÊüŸGÇØØ\r2”gÃ™ŸÿôqŒİ$ƒùäã\Z6y£í]{ØìÍ2ÈŸ>cÛÈ€y¼Çö¡ PP((”\nÊå€‚r@A9  PP((”\nÊå€‚r@A9  PP((”\nÊå€‚r@A9  PP((”\nÊå€‚r@A9  PP((”\nÊå€‚r@A9  PP((”\nÊ…ÅóiÌb\0\0\0\0IEND®B`‚'),(17,'‰PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0“\0\0\0§\0\0\0n®\0\0óIDATx^í’ÛnäXóÿ?½û00S°“¶[–H5ĞK.>dI_ÿ…PÄÂ]rL¡ŒS(#ÇÊÈ1…2rL¡ŒS(#ÇÊÈ1…2rL¡ŒS(#ÇÊÈ1…2rL¡ŒS(#ÇÊÈ1…2rL¡ŒS(#ÇÊÈ1…2rL¡ŒS(#ÇÊÈ1…2rL¡ŒS(Ãê˜¾¾¾Şğvy•söF¸´5.xjÂkÈšâB&üŒœ!.ó.üŞ;şEÊ—Åy¾qgÂdLpAËâ{wçÓ‘0À¥L.ˆïß™OE¢9—¡´æº2ŸÆhcÊW^3^™Oa¬)…;ˆgÖ+ó	Œ´¤h\'éÌ{u63Ò‚%3?»ğgG³‘F›¤²ûğwG³…ö&¹Aæ+}ø7œ\r´¶ À-_…İ9î´6 ¼\rïB|´¦ß$®\n:qvÓ–š²\\…=½¸úiKLQ²„nµ¥u–Ô	=9¹jKê*hºrñÕ–ÒQÎtåâ«-¥£œIèËÁY[B71\nĞ™º·¶tNRT 3uomé(E]Œ\nNÎZÓ9‰QÁÉYk:\'1*89kMG1êrpòÕrÔMBOê®FÒ9	š„Ô]¤s4‰›§‘„n’& #O#	)ÉAT7ôãàh,!E9Èê‚^\\ÜŒ¦¤0iOC\'.^ÆSRš‹¸\'qõ!‘ÔUŞĞ…“‰¤®ò€.œ|H$¥<\'•Ğ›™´”è&ò]Øİ±¿TbÊtzvví-—zƒÔ«°³ko¹Ô”ê*öØÓ½¯drÊu|ûmè)™‚7ˆş†8ÎÈ¦§ä²úlèõt\nwÏÜg³ù&ï\"Ÿ™fÜ–À¼G³‹V\\„ê2˜ñl¶bÓŒQ[\n³©æ|«¦\\Òä¢˜ãl>	«¶\\T÷²øöOó‰ØµæÒºÇ7šOÅ²9—÷ÔùÆoóéX\Zà«—ÉïMø[#\\lÅ‚ù­³	ÇX›á’ßY6¿q6áœvî,œÿs6áuVØâüvüÛ£	×YcÇptüıÙ„{¬2Ç£øû0øó£	ï±Î ä·	u¬´Éƒ9›PËJ£<šPëìòx&<Ã*³<šŸ&Ô³Æ*…GÃŸç êYa”Grv,üıÑß„ûØÛäqüv$ü»Ÿş6\\ÃŞ$ã•ãàß¿úág¬\rò®ÿïÎ7Â¿ØšãÜ9şïİï„?ØZãòï\0¿Á	¯ci‹¯Z:¿YùíOÀÎ]½l~û‰7¶be‰~jÑüşSïlÃÆûô‚ùÎÓïmÀÆ—Ú±X¾×õ®+f¸Ìî…òíî÷]°°¢°Hf˜Ì¢Š¼\r.orÌ1G\ry\\Üôò˜E%—Ò¸,•…1“Z¾)¤Û«/ŠùTsv!ÛœR]3ªç}ÙÆN‹aV—ÜÕÈ¶u\\\n3»åÙ–®Ë`nÎfdÛ¹/ù9‘mµA>;Í&dÛPº³xöàlA¶	…oÎ>[z}#İd­ô¥%İb£ğoØmCGéôí.›°›{Gùäí,ûvsî)Ÿ˜‚%ÿûq\\°Hê*÷*ìéÖ×\")å:	¾\n{r”ÑN÷”ê ÷ØÓ¡³n2@¡êb+`WõŞš©N Pe±•°¯jw­4/B¡jRŸ€}9\nh¤¸E*	}\ZvVê?Ÿà&©\"´vVé?ûz”9-´öî?÷r!”9)´öì>÷r1:-¶vêŞÿâCPä¤Ô	Øy¢{ïkC‘B\'aïîş}/5B™b§`ßÎÎ}/5C¡r§`ß®Î=¯A¡œ­°gW×W†¡ØnÉLôìyE\0Ê=šMLtëyEJ>w&úô¼\"Eÿ4®LôèyE\n¿:Š0cgÖWLà®Î$ÌÂé ç3¸ˆ»ó4|ïlºè{É.Åuºè{i!\\šÒL0óêR¸Ğ‰™döõåpÑO\n:I‚=9¦PF)”‘c\neä˜B9¦PF)”‘c\neä˜B9¦PF)”‘c\neüjH5CÂ±n\0\0\0\0IEND®B`‚'),(20,'‰PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0Æ\0\0\0İ\0\0\0àŠ\r\0\0*IDATx^íÓKrãXDQïÓÕƒ®\nÓé¤DRü\0‰{\"ŞÄ–e |ığË—ş\0\0‡X`p€Áa\0‡`p€Áa\0‡`p€Áa\0‡`p€Áa\0‡`p€Áa\0‡`p€Áa\0‡†øúúÚõ‰É.èÒïyÈÂDÿÒEÿô¡7&øçü£ø÷Ğ×øéé2ï]hı[}èiôät‰.²~‡{èeôÄtyÏZ`ıN}¨oì”tYÏ^Xın÷P×Èéè‚^µ¨úıkõŒ›Š.å]Ë©ÿÏ=Ô1n\ZºŒO,¤şÿ\'k7n•Qk©R8ıõí´JµM6*}]¼*Ë§5U«o¢1ÉëÂU\\<­­jŒI\\­ê²iÕëM5&ínK¦õv©;Åˆ¤u¹º,˜ÖÜ­şÎF$Üy©´ö®}t3\"İ„…Ò:÷ÒA|²ºHİ—I{éŞOUñ©&.‘ö”ÒW%Ñ‰êò$-ö•Ô[Ñi¦/ö—ØãS¢“œ°4Úcr¯wŠNpÊ²hŸéıŞ!:½I‹¢½NèùJÑÉM[íwJßWˆNmê‚hß“z?Ktb“—C{ŸÖÿ§bÓÒ¥˜¸ÚÿÄŠLJ—aòBh“³Ø#2%á\'ÍƒLŞ‹Lˆ%øM3!—×âÒÑá³\0ß4²Y—Œáÿ¤Ù—\nCŒŞ‹K…¡¿§‘Õoqi0ìm4\'òú)*	2ƒ~M³\"³oQ)0àc47²ã0ğ—f7=¿˜îu¨Ó{ù}‹é¡~N3œœcLçôšãÔ,cºf˜çÑ,÷äyäo*ê]ıÂÑAÂÓ<·dº÷ó•õ®~!i(Uh¦ïrİóÙêzW¿4”J4×WÙnı\\½«_H\ZJ%šë«|·|¦‹ŞÕ/$\r¥\ZÍÖe¬¿ÓßwÓ»ú…¤¡Tõ*cış¾›ŞÕ/$\r¥*Íx™µş¬ûzW¿4”Ê4çW¯³ŞÕ/$\r¥:ÍzíuÖ»ú…¤¡t y»×Yïê’†Ò…f®¯³ŞÕ/$\r¥Í=e½«_H\ZJš¹¾ÎzW¿4”4o÷:ë]ıBÒP:Ğ¼İë¬wõIC©Ls^æí~ÖUïê’†R•f¬Y¯ı¼£ŞÕ/$\r¥\ZÍv-çW¿ë¦wõIC©B3Õ§Şı¾“ŞÕ/$\råiš¥{Î–ÏtÑ»ú…¤¡<Aó{õÖlı\\½«_Ğ¡tÌÕ4«-ï½Ÿ¯¬wõ\"i0k´Ç«ßŸüm5½«:˜ŠÃÑúª¾#Îø*zW/t0O\rHÿ—÷©³¿ïI½«7t8WI¿»ë;ÛÕß§ŞÕ¯Ğ}2$ı\n¯ª.unÑ»útH[¥sÅK•ÔgïêßĞA½–~ö“7QR½«CuöÃOIùô®~Ö‘‡m’rë]ı:´wû%eØ»útxúp\\R–½«G)`p€Áa\0‡`p€Áa\0‡`p€Áa\0‡`p€Áa\0‡`p€Áa\0‡`p€Áa\0‡`p€Áa\0‡`p€Áa\0‡`p€Áa\0B‚Ã\0şü>Œîúw€8Àà0\0ƒÃ\008Àà0\0ƒÃ\008Àà0\0ƒÃ\008Àà0\0ƒÃ\0zğç÷a$ÈèbEÒ *ã0\ZÑa¥¬¢Äœ3º:¨¤U”˜sF†+ihÕ$fœÑÅ\nXÒà*IÌ7£‹thIÃ«\"1ÛŒ.ŞĞÁ¥¯ŠÄl3ºØ@‡—2À\nsÍèb^Ê\0+HÌ5£‹XAb®]l”8À\nsÍèb#`Ò Ÿ”˜gF;èSù¤Ä<3ºØI™2Ì§$f™ÑÅN:È”a>AsLÉ2£‹t˜)½[j†9ì¤M\ZêR3Ìéä€Ô¡ŞEóKÊ0§“t¨Iƒ½CrvYİì¤ƒMòU’3Ëêæ\0nâ¯’œYV7é€S‡}¶ä¬²ºù€yíá[r6Yİ|HıêM§y¤e’ÕÍItàko*Í!1‹¼N¢ƒwo*Í!1‹¼.”¾[MÈ!³«‹èB¤/‡£}§öÙÕEt!ôM0¥çÜÎ.¢‹1aIşÑ~“{Îíìº$ÉË¢=¦öùOvw7ĞeI\\í+­?\'»»›èÂ$-ö“Ò×;ùŞDG_WÚGç^ö˜ÑåÍt‘º.”Öß±‡£ætz3]¨nË¥5w©û,³º½™.V—%ÓZ;Ô|¶Yİ>@—«ú¢i•k½Ò¼¢‹¦¯­©Rmw›Ùõƒtéô=Akxº\nævş ]¾µw5ıú&›İıƒt	«½éH \0]Ê\'şGÅè¢Şùğ4ŠÒ¥½êÁ#Àà0\0ƒÃ\008Àà0\0ƒÃ\008Àà0\0ƒÃ\008Àà0\0ƒÃ\0Œÿ\0,œƒ1vŠ\0\0\0\0IEND®B`‚'),(21,'‰PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0Ç\0\0\0·\0\0\0¦\'J\0\0\0IDATx^íÓYR$IPîiÆ°f\ZÚIÕBmÒ{fşÃG‘’ÂßŞCoùàå€‚r@A9  PP((”\nÊå€‚r@A9  PP((”\nÊå€‚r@A9  PP((”\nÊå€‚r@A9  PP((”\nÊåhâííí.á‹m,,î3ƒrÜ,U·L6{úB>é™jîäïıJpù›÷üíİŒœ:¿r^!¿áUßñjm§Îã>2åŒ]ç<¥İÄyĞß†Ÿ»œ¦ÕÄyÌKB-w5m_-¦Í^.“{›´»­\'Í£e¸©{İrÒ<ÖQ¸Ÿ©»İnÒ<T†û›ºãm&Íexœ©»^~Ò<L†Ç›ºó¥\'Í£dx©{_vÒ<ÈÄã¬bêş—œ41í(«™z‡¥&Í#L;Æª¦Şc™Ió\0Ó±²©7YbÒ\\ş´#¬nê]–™têv0õ6s&å×”\nÊ²Êï³‹ñaÖ´\\,K1­æMÌYYŠ‰Åø0sjJY\nå€wÅHs\'ç¯,ƒbü1{z~”A1¾ØÀ`YÅø—-•ePŠŸlc,‚Rœf+d2³™æ²Gá˜Í4–%Èpš\r5“Èp9Ûj$‹á:6ÖDA)ngs›Ë\"…ß±¹\råã?\n·³ÅÍd	Â}ØäòñWá¾ltQùğO…Ç°Ù+åÃ|Ux<[¾B>ĞW…ç°éå}vx>[¿B>ØG‡×r_Ê‡|öæ‚7È2œ\nûqµ;È\"œ\nûp­;Ê\"Ta.õ@YŠks¡\'Éb…µ¸Èeª°—x,C^Ë^(Ëp.<—/\"‹p.<-/&Kp.<í.(p.<†Ín$K‘á¾ltCYŠ*ÜÆ7–e¨ÂïØ\\Y†*\\ÇÆšÈ\"œçÙRSY†KÂ¿l¤¹,À¹ğÅ6†ÈœÊ1V–áT¦š;9eÎeŠ9“rV–à\\ºë?!WËœKW}\'ãn²§ÒI¯ix¸,C•zLÁSeNeg{=KÈBdvµï—³¤,ÆÎÙó«Y^–cÇ‚ì÷ÅlC9  PP((”\nÊå€Yå€O»ãÃ_ÍÒ²ÊŸ:ãÃ¾_Î²”d1”Ş{ãÃŞ__èrœd):ì~ÿ	B·í¢ãŞ{LñMÇ#­.wŞeï=¦ø&ÔåP«Ê]wÚwŸI>å¡ºl%¹ãn»î3É7y¬‡{µÜkÇıöšæS,ÃmrŸ]÷Úo¢Oy¸ÎG|¶Üg×öœ*ä!;ô‘rİ÷Øw²ÍpZîkÂŞzOò°å¦ì¬÷tò¸~ÊMÙÓŒ)yğÌt¹i{™3é	yüÌD¹ƒ‰û˜3éù\02“äìc÷˜,BfŠœ{Úüÿ›7ñ…òad:Ê;Ïz‰¹“_(JÇG“se¦š;ùò±dv–³d&›=ı•òáìşˆr†Ìt6ğùˆ²¢üÆ£ğÅ6në(«Èï:\nÿ²‘å;Ê+å·…c6sùØNåòÇlæòñ­.cS’r•p9Ûz‚| Ï¿csO–÷Qáv¶å€‚r@A9  PP((”\nÊå€‚r@A9  PP((”\nÊå€‚r@A9  PP((”\nÊå€‚r@á?ç:ÃEyÛ è\0\0\0\0IEND®B`‚');
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
INSERT INTO `type_wordlist_international` VALUES (2,1,'Ãllat'),(2,2,'Animal'),(1,2,'Number'),(1,1,'SzÃ¡m');
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
