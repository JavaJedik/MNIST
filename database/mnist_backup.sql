-- MariaDB dump 10.19  Distrib 10.11.4-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: mnist
-- ------------------------------------------------------
-- Server version	10.11.4-MariaDB-1~deb12u1

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
INSERT INTO `answer_collection` VALUES
(1,1),
(2,2);
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
INSERT INTO `answer_collection_answers` VALUES
(1,1,1),
(1,2,2),
(1,3,3),
(1,4,4),
(1,5,5),
(1,6,6),
(1,7,7),
(1,8,8),
(1,9,9),
(1,10,10),
(2,11,1),
(2,12,2);
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
INSERT INTO `answer_collection_wordlist` VALUES
(1),
(2);
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
INSERT INTO `answer_collection_wordlist_international` VALUES
(1,1,'Szám'),
(1,2,'Number'),
(2,1,'Kutya és Macska'),
(2,2,'Dog and Cat');
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
INSERT INTO `answer_option` VALUES
(1,1,1),
(2,1,2),
(3,1,3),
(4,1,4),
(5,1,5),
(6,1,6),
(7,1,7),
(8,1,8),
(9,1,9),
(10,1,10),
(11,2,11),
(12,2,12);
/*!40000 ALTER TABLE `answer_option` ENABLE KEYS */;
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
INSERT INTO `answer_wordlist` VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10),
(11),
(12);
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
INSERT INTO `answer_wordlist_international` VALUES
(10,1,'0'),
(10,2,'0'),
(1,1,'1'),
(1,2,'1'),
(2,1,'2'),
(2,2,'2'),
(3,1,'3'),
(3,2,'3'),
(4,1,'4'),
(4,2,'4'),
(5,1,'5'),
(5,2,'5'),
(6,1,'6'),
(6,2,'6'),
(7,1,'7'),
(7,2,'7'),
(8,1,'8'),
(8,2,'8'),
(9,1,'9'),
(9,2,'9'),
(12,2,'Cat'),
(11,2,'Dog'),
(11,1,'Kutya'),
(12,1,'Macska');
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
INSERT INTO `country` VALUES
(1),
(2),
(3);
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
INSERT INTO `country_calling_code` VALUES
(1,1,36),
(2,2,44);
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
INSERT INTO `country_language` VALUES
(1,1),
(2,2),
(3,3),
(3,4),
(3,5);
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
INSERT INTO `country_name` VALUES
(1,1,'Magyarország'),
(1,2,'Hungary'),
(2,1,'Anglia'),
(2,2,'England'),
(3,1,'Szájc'),
(3,2,'Switzerland'),
(3,3,'Svájc'),
(3,4,'Suisse'),
(3,5,'Svizzera');
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
INSERT INTO `email_tld` VALUES
(2,'com'),
(1,'hu');
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
INSERT INTO `email_type` VALUES
(1,'gmail',2),
(2,'mailbox.unideb',1);
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
  `language_id` int(11) DEFAULT NULL,
  `name` varchar(15) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_language_id` (`language_id`),
  CONSTRAINT `fk_language_id` FOREIGN KEY (`language_id`) REFERENCES `language` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gender`
--

LOCK TABLES `gender` WRITE;
/*!40000 ALTER TABLE `gender` DISABLE KEYS */;
INSERT INTO `gender` VALUES
(1,NULL,'férfi'),
(2,NULL,'nő'),
(3,NULL,'macska');
/*!40000 ALTER TABLE `gender` ENABLE KEYS */;
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
INSERT INTO `guest_player` VALUES
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10),
(11),
(12),
(13),
(14),
(15),
(16),
(17),
(18),
(19),
(20),
(21),
(22),
(23),
(24),
(25),
(26);
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
INSERT INTO `language` VALUES
(1),
(2),
(3),
(4),
(5);
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
INSERT INTO `language_name` VALUES
(1,1,'magyar'),
(1,2,'hungarian'),
(2,1,'angol'),
(2,2,'english'),
(3,1,'német'),
(4,1,'francia'),
(5,1,'olasz');
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
INSERT INTO `login_info` VALUES
(1,1,1,'2023-10-13 09:45:37');
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
INSERT INTO `phone_network` VALUES
(2,30),
(1,70);
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
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `picture`
--

LOCK TABLES `picture` WRITE;
/*!40000 ALTER TABLE `picture` DISABLE KEYS */;
INSERT INTO `picture` VALUES
(1),
(2),
(3),
(4),
(5),
(6),
(7),
(8),
(9),
(10),
(11),
(12);
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
INSERT INTO `picture_answer_answer` VALUES
(1,1),
(2,2),
(3,3),
(4,4),
(5,5),
(6,6),
(7,7),
(8,8),
(9,9),
(10,10),
(11,11),
(12,12);
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
INSERT INTO `picture_answer_type` VALUES
(1,1),
(2,2);
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
INSERT INTO `picture_bin_data` VALUES
(2,'�PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0\0\0\0\0\0\0r\rߔ\0\0\0�IDATx^�K\n� Ds�K�X�4��$��~�1�yn��f��X�ǅ\"��V�4����ْ��KE[�b5�,0XG��`ԣ��@�_\",x}�-z�(^_������x�K����B����2�%daF�CM��d�3q&[��k:r�	�_��%EV����\0\0\0\0IEND�B`�'),
(3,'�PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0\0\0\0\0\0\0r\rߔ\0\0\0�IDATx^��A\n�0DQ������b��$C?��.#{��w�����]	�P{�~Uk����/��s��b,:�@�,Ʋ;+]J���ӽ.��@w_&&���@�_3|��Xm혠U[;&h�֎��U�?p+��cXeM\0\0\0\0IEND�B`�'),
(4,'�PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0\0\0\0\0\0\0r\rߔ\0\0\0�IDATx^�A\n� ��O�,4 �h6�=��݌*�ǈ���C	E�=Q���bo>�M�$-��2LFE\n���0�.ɔ{�xҁ�.m`_�tCF��CFR�����W*��H	m����U��tS+�\'K��#��a9��>9���t\0\0\0\0IEND�B`�'),
(5,'�PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0\0\0\0\0\0\0r\rߔ\0\0\0xIDATx^��Q\n�0������B1�����~�la:;���x۷�l;\"�4;����T�09�\'�r\0R���\0�|5��P)[�	|,���R S��;@�XO�.l�����\\�����������rSX��tu&��\0\0\0\0IEND�B`�'),
(6,'�PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0\0\0\0\0\0\0�x��\0\0\ruIDATx^��˲�H@��O{�g�����\"YEdF��W��\"��7\0P�W�\0�|\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0�~��5�cyU�0Y�O=�;^L&��}~�{^\n���<�^|!�7��{}s�\0?��2�5��OZI?�K��]�w���\'O\'��{La�u�-�#O%�Tˏ�O����w��i��\n�1u�/�OV&�<Z~���%s��`E��c�G��Aʌ�:X����A>z�Nf擃YI\'��ݽ�Q2[�f#�,/?�[gȜ�;��D������-3��`��r�c���ln�E�XJ~<�`6�ѭ�;HK�����2�yp5�cz����de��<���1��8�H��i��j������ɓd��+I\ZS�a�A�\\湂t15C\Zd������|i�Y�{�&YL͇�F�{����|\0i���� QL��V�}�g4�bj>�4��$QL��f�o��������*��;`$I�X���(�09�3H��\0� I\0�3\08�$L�\0��09�3H��\0� I\0�3\08�$L�\0��09�3H��\0� I\0��7\0E�\0&��o\00�$L*�_�3�4LJ�s&��P���h0�,~���\n`\"Y�ʟ�H�$��\r\0�$Y\0��W��M�\0n��������(K_�s)�I����J�p�,~�+I\Z�\r��?W�8��e�\0�A�\0.�e�W�:��e�+~f }\0\'��σ�H�	���$�\0e���,�`�,�<��D|)�~�`6R	�CY�y03	�P�����,���H*��,�W��Z�\rY�{��^���_��RT�bw��T�b�;x*��d��<�����~䠅�����ꠑ����~䠕���R?z��\0��e��?y��ԏ���\0�����c�`*Y�p��&��~�.�E~�q�(�tY�0���*�����Ҁ��̏p=/\"K����\n��d�r�<�H�,�O��W	��e~䀹y����?9`\r^+�,�W��+�(�W<�������,^5��b�;�ټr(�%�w��y�P\"K~�^<�ȲW����Y����@�,C\0�y�P$�?���C�,����K�RY�[<����x/��,�<�Y�j�oY�y�sx���\0�\0<��������/e����8,K�5x��G��_0//��,����u_���;`^$0T������Sd�:�z^p�,�w\\ǋ.�e�w�5�6�rY�[��+n�ſu�x^p�,����id�:�;^0�,��~����e���x5�Բ��p��,)�?x�+����u�6�X^�����U\0����w�\0<P��A;�\0x�,���F�<^��A�jd��A��d��<�������J��jY�{O#�\0��\rx�ؐ�o�4��#���I���,�<X���ş��Z�����`%�,����I)�e�o�J:����u0#��R���l�`�,C�I#�	���\0f#�\0\'��7���,��`�p�,�<���\\$K?�$q\0��σ�H�M���\0�$i\07��7����,���\n�0�,~#��I�$��\r\0�$Y\0�1\0��dL&�!�$\n`BY��\0�I�����\0F�\"��e�\0�\"E\00\0M�\0���[���,~�oI�\"��\r\0�!=\01\0Ez\0b\00��\0,�\0`�X��(���Q�`!\0�H�B\0F���\0�\"=\01\0Ez\0b\00��\0,�\0`�X��(���,�oH���\r\0�%=\0��7\0���\0L.K_�3�L,��\0`)�T���HR0�,}��H�0�,}��h0�,~�3H�$��?g�*�	d�+�&Y\07��W�\\A�\0n�e������ _�s5I�@����U�\r�dY�[W�:�e���]��Y�{w�>�����`��,����H$���؏�F*�Rw03	x#����\n$`C�����H-��d���N�~/~��SH2P%�����H��|`�\Z�֎<���(?6>80V���\r$�F���;�|3?=h\"�7�Б�f�~r�0��8}r�t����_^�d�5�`��+��uL.?fw|#�t���j���^��+������0�v�������J����w�0������O��W���w]����VY$�8��\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B�ʜ2�*�\0\0\0\0IEND�B`�'),
(7,'�PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0\0\0\0\0\0\0�x��\0\0\rVIDATx^��K�7EQ��6��l�S}�2�$�9@L4SW2���\0��+�\0؟\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0��ׯoÜ�2\0�-���aN~\0��c��aN~\0�����aN~�2y����W�\\磆��6�G��a?~U��>z؟_`ry���\0L\"�����\0 ����\0(�����(��#���jydg����C;z`&�H`yp�\ZX�/8T��v�k��#��@#_>�ȣ�:���Jy�>��k�Ns�\0��R���ʼ>�^�j��ak��Tr�v6�\0��棒\0\0��|T\0@;��J\0hg�QI\0\0�l>*	\0���G%\0����$\0�v6�\0��棒\0\0��|T\0@;��:y�\0���J~\0��������Z�~Tq��؀T\0\0_l@�\0�/6 U\0��\Zy�\0���B~\0��������قTp���	� \0\0��	� \0\0��	� \0\0��	�^\0 \0�\\~���m����lD�&\0\0n�ٚ\0\0��Fdk\0�6�m��\0\0���R~\0�Ȗ��;�\0�يl��x�fdK\0�1��-	\0��lF���_\0\0��fd;�?�s�#�\0\0�َl%��\0\0��vdy���lH����Ζd\0�u�$[��/\0\0�%Y^~��9���9�\0�-Y�\0\0x�m��\0��lK�\'\0\0�g[��<�\0�5�%���/\0\0^g[��<��?��lL������ɲ\0��ٚ,)��\0\0x���r��;�\0�9Y���9ۓ�\0��ٞ,%��\0\0�ۓe��w�~�e�?�qlQ�!\0\0�c��\0p[�%��\0\0��E�^~\0�9[����w��a�2�<��?�1lS�����Fej\0�6*S\0\0�Q��\0\08��ʴ��\0��بL)��p,[�)9�\0�Y�N\0p<�����\0\0�Y�J~���+������ǆe\ny�\0��lX�����8�-���lZ� \0\0Ʋi��\0\0˦�ry�\0��lZ.��_\0\0�a�r�<��?��-�r��a�r�<�\0`�K��\0\0cٸ\\\"��0���%�kټ\\B\0\0\\��e�<�\0`<�����پ��_\0\0\\��e�<�\0�:�/���\0\0ױ}����-�0\0`�0�\0�y��#\0\0�a3�\0\0��-�0\0`�0�\0�y��#\0\0�a3�\0\0��-�0\0`�0�\0�y��� \0�c3L!\0p��a���\Z\0ưq*���1lT.�����u�&��C>�\0��vc\ZyxW�U�X,%�0;��-��y\0f`�y�G��\r$�pN����8����q�d\0~����e\0�es���ȿ2\0��1`y���[lXT�g��,.����F�\r�w�>^>l,��zx�<����C�<���//����7�~�l(����\0{�?�����E7���/�+�./x(�~�&�xY�`^,�<�9�\Z�V�my�\0��k>� `\r^(�<�9���N�cy�o\r0�8T~\0s�\"�S��\00/8�\0�yy��i2\0D\0��kN��_�<�D�Ty�\0��KN\'\0`>^\"p:\0����e\0�\0��W�.����y��y�\0\\��\00/F\0�<�@`\0���a\0���\00/F\0�<�@`\0���a\0���\00/F\0�<�@`�<�\0�����/\0�z^ p�<�\0���s�a>^\"p:\0���S��\00/8M~\0������w�a^#p�<��?�ŋ�G_\0���H�0y���W	\"��s�2����w�a~^(�<��?��+~$~07�xK�`\r^+�<�9�:�X�<��X�W<���ч=x���9J|���+ތ%��;���%oƢ����\0��7ca�S���\0{�7ci����\0��7cq��^|;��+ߌ%�+�;���o�\"��6�\r��kߌe�-�]�������[�7@\'�3�;�\r<\Z��\r��[������f,�.�{?��l��X��w~4\0���������xĖ�L�`��>�gl���!p֕���	�cCy ���owo\0>a�lʱXO�f��S6ɦ�y�o��\0�V�Td��<���0��C�\\/�Gp6�fcyT�q����\0�b�l΁+�ޏ�J����1���l\0�fm.����{�;\03��6���!z_��^���R�09P�ɿ�;0;��D(��K�->���ZE�`��,�����l�2y���.����\0��V+������n���5@#ۏ�a�q\0�b#�<��\0���\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B��9�KK*\0\0\0\0IEND�B`�'),
(8,'�PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0\0\0\0\0\0\0�x��\0\0\ruIDATx^��˲�H@��O{�g�����\"YEdF��W��\"��7\0P�W�\0�|\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0�~��5�cyU�0Y�O=�;^L&��}~�{^\n���<�^|!�7��{}s�\0?��2�5��OZI?�K��]�w���\'O\'��{La�u�-�#O%�Tˏ�O����w��i��\n�1u�/�OV&�<Z~���%s��`E��c�G��Aʌ�:X����A>z�Nf擃YI\'��ݽ�Q2[�f#�,/?�[gȜ�;��D������-3��`��r�c���ln�E�XJ~<�`6�ѭ�;HK�����2�yp5�cz����de��<���1��8�H��i��j������ɓd��+I\ZS�a�A�\\湂t15C\Zd������|i�Y�{�&YL͇�F�{����|\0i���� QL��V�}�g4�bj>�4��$QL��f�o��������*��;`$I�X���(�09�3H��\0� I\0�3\08�$L�\0��09�3H��\0� I\0�3\08�$L�\0��09�3H��\0� I\0��7\0E�\0&��o\00�$L*�_�3�4LJ�s&��P���h0�,~���\n`\"Y�ʟ�H�$��\r\0�$Y\0��W��M�\0n��������(K_�s)�I����J�p�,~�+I\Z�\r��?W�8��e�\0�A�\0.�e�W�:��e�+~f }\0\'��σ�H�	���$�\0e���,�`�,�<��D|)�~�`6R	�CY�y03	�P�����,���H*��,�W��Z�\rY�{��^���_��RT�bw��T�b�;x*��d��<�����~䠅�����ꠑ����~䠕���R?z��\0��e��?y��ԏ���\0�����c�`*Y�p��&��~�.�E~�q�(�tY�0���*�����Ҁ��̏p=/\"K����\n��d�r�<�H�,�O��W	��e~䀹y����?9`\r^+�,�W��+�(�W<�������,^5��b�;�ټr(�%�w��y�P\"K~�^<�ȲW����Y����@�,C\0�y�P$�?���C�,����K�RY�[<����x/��,�<�Y�j�oY�y�sx���\0�\0<��������/e����8,K�5x��G��_0//��,����u_���;`^$0T������Sd�:�z^p�,�w\\ǋ.�e�w�5�6�rY�[��+n�ſu�x^p�,����id�:�;^0�,��~����e���x5�Բ��p��,)�?x�+����u�6�X^�����U\0����w�\0<P��A;�\0x�,���F�<^��A�jd��A��d��<�������J��jY�{O#�\0��\rx�ؐ�o�4��#���I���,�<X���ş��Z�����`%�,����I)�e�o�J:����u0#��R���l�`�,C�I#�	���\0f#�\0\'��7���,��`�p�,�<���\\$K?�$q\0��σ�H�M���\0�$i\07��7����,���\n�0�,~#��I�$��\r\0�$Y\0�1\0��dL&�!�$\n`BY��\0�I�����\0F�\"��e�\0�\"E\00\0M�\0���[���,~�oI�\"��\r\0�!=\01\0Ez\0b\00��\0,�\0`�X��(���Q�`!\0�H�B\0F���\0�\"=\01\0Ez\0b\00��\0,�\0`�X��(���,�oH���\r\0�%=\0��7\0���\0L.K_�3�L,��\0`)�T���HR0�,}��H�0�,}��h0�,~�3H�$��?g�*�	d�+�&Y\07��W�\\A�\0n�e������ _�s5I�@����U�\r�dY�[W�:�e���]��Y�{w�>�����`��,����H$���؏�F*�Rw03	x#����\n$`C�����H-��d���N�~/~��SH2P%�����H��|`�\Z�֎<���(?6>80V���\r$�F���;�|3?=h\"�7�Б�f�~r�0��8}r�t����_^�d�5�`��+��uL.?fw|#�t���j���^��+������0�v�������J����w�0������O��W���w]����VY$�8��\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B�ʜ2�*�\0\0\0\0IEND�B`�'),
(9,'�PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0\0\0\0\0\0\0�x��\0\0}IDATx^��ۮ��P��O;0� Rix��}!k-`�$�-\r����?\0@�_�?\0\0��\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH�����%�	���n������P6=`,[��C�=~�wll\"�+�j����gs`�<f?�;ʿ�xΦ�\"y��^��\rF>he�a�<@G������6�&�c���=��}����������8G���>hc�a�<0�k�43�0@�G`%)\'�#�`	N��>�n$|!���#��C�`gR\n>��>��$�)���\\�Ԃ��w��+�\\�D�|\0W$��y��\\��y��\\����;���H4y����\Z�s|�\0த\Z���;�@	G�<��?�B�Q-�����t�ʣ��M$���+\0@�G�<��?�J�Q#��4�|Tȃ�����;�@;	����w�\0n.�\0�_���ʣ����4���;�\0���N}��oR�������M2r+y��Ǥ#���_\08&��<��?��$$��G��xNJryy���$%����OZriy�\0��HK.+���:��%��w��#5��<�\n\0�{�&�����x���R��;�\0���\\F~��s��p��#E�\0�<R�K��\0\0|G���<�\n\0���([ˣ���C���<��?�9�)[s�Ɛ�lM\0C���<�\n\0�y$*[�ï\0\0�K���<��?���*[r�ƒ�lI\0K���<�\n\0��$+���\0\0�O���<��?�ҕm��w�Ƒ�l!�\00��ey����,[p�撴lA\0�KҲ\0`.I�\0��$-���W\0\0Ɠ�,�����Cڲ�����e)\0`\r��R\n\0�\Z�e��+\0\0�H\\������%uY��XK�\0���e	\0`-��\n\0�Z��%\0��$/���W\0\0擼L���\'}�N\0XO�2�\0���e�<��\n@�7��\0F�2L�nơ���]��$���\Zu����\0�L3�0�����N*0��)�}����?�����L������� �Ο>���g�O�M�s�>>����i~:4��}��[�F�<��l9S�q�߁�������7}���������;=�>l4����1^��p�������C~�G�6[�0y0~z�)�ӣ\\��e�<?=������bk9]�|\\W~�G����� ������gS\"��p?�]=`_6�����o�{��l\'�9�;��7��p�A��޾=��F2�#�\'�������\0t��n`/6�����f�`N�3����1���_9fֲy\'��]΃ـ5l�	yR΄���l�	xɹ0#0�Mc8��Or>�	�a�N��LΈ9��l�	v^�sbV`,�pB�W䜘�v1�@�U9+�ƱU\'�yG΋��1l�	rޕ3cn�|���9�ȹ1?p.��p�O�ܘ8�mb8Χrv���61�\0�9?��a�Np�s�E\'��VΐY��� �ڜ!��<�wl�	lΒ�d��s���6g�y2S���p��)���a8a��r�����0���l9Sf�gcNH3BΕق���Ҍb��s6��4��-���a8!�(9[f^gSN83JΖ����Ό��e��56��3�匙5xΆ0�Pf��1�����̐sf��g6��2��5x�\ra8��,9k�\r����̔�f��1��p��<g3N3����l�	cf˙3w�7[�p���r����F0�f��;��\'�Y���1�pB�U��\'�Y���1�pB�U��\'�Y���1�pB�U��\'�Y���1�pB�U��\'�Y���1�pB�U��\'�Y���1�pB�U��\'�Y���1�pB�U��\'�Y���1�pB�U��\'�Y���1�pB�U��\'�Y���1�pB�U��\'�Y���1�pB�U��\'�Y���1�pB�U��\'�Y���1�pB�U��\'�Y���1�pB�U��\'�Y���1�p�Y��L�A,�����1���r����F0�0f��53�L#��%gͼ��l�df1k��`�e��(���L��,����s6��3#�|�1x�f0�pf��-3�l�	gF��2_p�v0]���9S�\n~fCXBPs��\'s���Ԝ)��\\�s6�%5g2O�>���3�\'x�Ma�l��7��Ϧ�L����9C�^cSXJp�s��),%��TΎ�����|\"�����lK	pޕ3c~�36��8��Y���ְT��0瑜�߳=,�a.�I9������@��.g#����:��\\�\r8�mb򂞜s�Ml#�^�w����6�a�-��Y�ql[������e��J�����<p>��V2����o������!p�+��o��2��t���{�<6�-�Ap�%��o��8�����������yl[s �!���e�ؚ#qm��=`\r����X8ב�-��-dky4���z��l\"�����+�Q>`6�K�C��\'��o{��\\�����.��=�N.#��V~�|��l)��ơY#�G؟M�R��86s�o������qx��������r9yx���w�\\����9F�������sYy��s����̥�qr����e>�>l4��Gʡz_�~�p/����C�h�.�|�}�pn!�#�\\�N��{���F0��O��������N���������zn\'[�����}l>���������:�~n+ݝ�^��~z\0���Z�|w����;����!|�v��O��5� ��v��W�3��:y,��\0�!5�����]���N\08�D��Gw�p&�\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0��=$�|�\0\0\0\0IEND�B`�'),
(10,'�PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0\0\0\0\0\0\0�x��\0\0}IDATx^��ۮ��P��O;0� Rix��}!k-`�$�-\r����?\0@�_�?\0\0��\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH�����%�	���n������P6=`,[��C�=~�wll\"�+�j����gs`�<f?�;ʿ�xΦ�\"y��^��\rF>he�a�<@G������6�&�c���=��}����������8G���>hc�a�<0�k�43�0@�G`%)\'�#�`	N��>�n$|!���#��C�`gR\n>��>��$�)���\\�Ԃ��w��+�\\�D�|\0W$��y��\\��y��\\����;���H4y����\Z�s|�\0த\Z���;�@	G�<��?�B�Q-�����t�ʣ��M$���+\0@�G�<��?�J�Q#��4�|Tȃ�����;�@;	����w�\0n.�\0�_���ʣ����4���;�\0���N}��oR�������M2r+y��Ǥ#���_\08&��<��?��$$��G��xNJryy���$%����OZriy�\0��HK.+���:��%��w��#5��<�\n\0�{�&�����x���R��;�\0���\\F~��s��p��#E�\0�<R�K��\0\0|G���<�\n\0���([ˣ���C���<��?�9�)[s�Ɛ�lM\0C���<�\n\0�y$*[�ï\0\0�K���<��?���*[r�ƒ�lI\0K���<�\n\0��$+���\0\0�O���<��?�ҕm��w�Ƒ�l!�\00��ey����,[p�撴lA\0�KҲ\0`.I�\0��$-���W\0\0Ɠ�,�����Cڲ�����e)\0`\r��R\n\0�\Z�e��+\0\0�H\\������%uY��XK�\0���e	\0`-��\n\0�Z��%\0��$/���W\0\0擼L���\'}�N\0XO�2�\0���e�<��\n@�7��\0F�2L�nơ���]��$���\Zu����\0�L3�0�����N*0��)�}����?�����L������� �Ο>���g�O�M�s�>>����i~:4��}��[�F�<��l9S�q�߁�������7}���������;=�>l4����1^��p�������C~�G�6[�0y0~z�)�ӣ\\��e�<?=������bk9]�|\\W~�G����� ������gS\"��p?�]=`_6�����o�{��l\'�9�;��7��p�A��޾=��F2�#�\'�������\0t��n`/6�����f�`N�3����1���_9fֲy\'��]΃ـ5l�	yR΄���l�	xɹ0#0�Mc8��Or>�	�a�N��LΈ9��l�	v^�sbV`,�pB�W䜘�v1�@�U9+�ƱU\'�yG΋��1l�	rޕ3cn�|���9�ȹ1?p.��p�O�ܘ8�mb8Χrv���61�\0�9?��a�Np�s�E\'��VΐY��� �ڜ!��<�wl�	lΒ�d��s���6g�y2S���p��)���a8a��r�����0���l9Sf�gcNH3BΕق���Ҍb��s6��4��-���a8!�(9[f^gSN83JΖ����Ό��e��56��3�匙5xΆ0�Pf��1�����̐sf��g6��2��5x�\ra8��,9k�\r����̔�f��1��p��<g3N3����l�	cf˙3w�7[�p���r����F0�f��;��\'�Y���1�pB�U��\'�Y���1�pB�U��\'�Y���1�pB�U��\'�Y���1�pB�U��\'�Y���1�pB�U��\'�Y���1�pB�U��\'�Y���1�pB�U��\'�Y���1�pB�U��\'�Y���1�pB�U��\'�Y���1�pB�U��\'�Y���1�pB�U��\'�Y���1�pB�U��\'�Y���1�pB�U��\'�Y���1�pB�U��\'�Y���1�p�Y��L�A,�����1���r����F0�0f��53�L#��%gͼ��l�df1k��`�e��(���L��,����s6��3#�|�1x�f0�pf��-3�l�	gF��2_p�v0]���9S�\n~fCXBPs��\'s���Ԝ)��\\�s6�%5g2O�>���3�\'x�Ma�l��7��Ϧ�L����9C�^cSXJp�s��),%��TΎ�����|\"�����lK	pޕ3c~�36��8��Y���ְT��0瑜�߳=,�a.�I9������@��.g#����:��\\�\r8�mb򂞜s�Ml#�^�w����6�a�-��Y�ql[������e��J�����<p>��V2����o������!p�+��o��2��t���{�<6�-�Ap�%��o��8�����������yl[s �!���e�ؚ#qm��=`\r����X8ב�-��-dky4���z��l\"�����+�Q>`6�K�C��\'��o{��\\�����.��=�N.#��V~�|��l)��ơY#�G؟M�R��86s�o������qx��������r9yx���w�\\����9F�������sYy��s����̥�qr����e>�>l4��Gʡz_�~�p/����C�h�.�|�}�pn!�#�\\�N��{���F0��O��������N���������zn\'[�����}l>���������:�~n+ݝ�^��~z\0���Z�|w����;����!|�v��O��5� ��v��W�3��:y,��\0�!5�����]���N\08�D��Gw�p&�\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0R\0\0��\0\0�\0\0(�\0\0@!\0\0\n)\0\0PH\0�B\n\0\0��=$�|�\0\0\0\0IEND�B`�'),
(12,'�PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0\0\0\0\0\0\0�x��\0\0\rVIDATx^��K�7EQ��6��l�S}�2�$�9@L4SW2���\0��+�\0؟\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0��ׯoÜ�2\0�-���aN~\0��c��aN~\0�����aN~�2y����W�\\磆��6�G��a?~U��>z؟_`ry���\0L\"�����\0 ����\0(�����(��#���jydg����C;z`&�H`yp�\ZX�/8T��v�k��#��@#_>�ȣ�:���Jy�>��k�Ns�\0��R���ʼ>�^�j��ak��Tr�v6�\0��棒\0\0��|T\0@;��J\0hg�QI\0\0�l>*	\0���G%\0����$\0�v6�\0��棒\0\0��|T\0@;��:y�\0���J~\0��������Z�~Tq��؀T\0\0_l@�\0�/6 U\0��\Zy�\0���B~\0��������قTp���	� \0\0��	� \0\0��	� \0\0��	�^\0 \0�\\~���m����lD�&\0\0n�ٚ\0\0��Fdk\0�6�m��\0\0���R~\0�Ȗ��;�\0�يl��x�fdK\0�1��-	\0��lF���_\0\0��fd;�?�s�#�\0\0�َl%��\0\0��vdy���lH����Ζd\0�u�$[��/\0\0�%Y^~��9���9�\0�-Y�\0\0x�m��\0��lK�\'\0\0�g[��<�\0�5�%���/\0\0^g[��<��?��lL������ɲ\0��ٚ,)��\0\0x���r��;�\0�9Y���9ۓ�\0��ٞ,%��\0\0�ۓe��w�~�e�?�qlQ�!\0\0�c��\0p[�%��\0\0��E�^~\0�9[����w��a�2�<��?�1lS�����Fej\0�6*S\0\0�Q��\0\08��ʴ��\0��بL)��p,[�)9�\0�Y�N\0p<�����\0\0�Y�J~���+������ǆe\ny�\0��lX�����8�-���lZ� \0\0Ʋi��\0\0˦�ry�\0��lZ.��_\0\0�a�r�<��?��-�r��a�r�<�\0`�K��\0\0cٸ\\\"��0���%�kټ\\B\0\0\\��e�<�\0`<�����پ��_\0\0\\��e�<�\0�:�/���\0\0ױ}����-�0\0`�0�\0�y��#\0\0�a3�\0\0��-�0\0`�0�\0�y��#\0\0�a3�\0\0��-�0\0`�0�\0�y��� \0�c3L!\0p��a���\Z\0ưq*���1lT.�����u�&��C>�\0��vc\ZyxW�U�X,%�0;��-��y\0f`�y�G��\r$�pN����8����q�d\0~����e\0�es���ȿ2\0��1`y���[lXT�g��,.����F�\r�w�>^>l,��zx�<����C�<���//����7�~�l(����\0{�?�����E7���/�+�./x(�~�&�xY�`^,�<�9�\Z�V�my�\0��k>� `\r^(�<�9���N�cy�o\r0�8T~\0s�\"�S��\00/8�\0�yy��i2\0D\0��kN��_�<�D�Ty�\0��KN\'\0`>^\"p:\0����e\0�\0��W�.����y��y�\0\\��\00/F\0�<�@`\0���a\0���\00/F\0�<�@`\0���a\0���\00/F\0�<�@`�<�\0�����/\0�z^ p�<�\0���s�a>^\"p:\0���S��\00/8M~\0������w�a^#p�<��?�ŋ�G_\0���H�0y���W	\"��s�2����w�a~^(�<��?��+~$~07�xK�`\r^+�<�9�:�X�<��X�W<���ч=x���9J|���+ތ%��;���%oƢ����\0��7ca�S���\0{�7ci����\0��7cq��^|;��+ߌ%�+�;���o�\"��6�\r��kߌe�-�]�������[�7@\'�3�;�\r<\Z��\r��[������f,�.�{?��l��X��w~4\0���������xĖ�L�`��>�gl���!p֕���	�cCy ���owo\0>a�lʱXO�f��S6ɦ�y�o��\0�V�Td��<���0��C�\\/�Gp6�fcyT�q����\0�b�l΁+�ޏ�J����1���l\0�fm.����{�;\03��6���!z_��^���R�09P�ɿ�;0;��D(��K�->���ZE�`��,�����l�2y���.����\0��V+������n���5@#ۏ�a�q\0�b#�<��\0���\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B\0\0\n	\0\0($\0\0��\0\0�B��9�KK*\0\0\0\0IEND�B`�'),
(11,'�PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0\0\0\0\0\0\0�x��\0\0\ruIDATx^��˲�H@��O{�g�����\"YEdF��W��\"��7\0P�W�\0�|\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0�~��5�cyU�0Y�O=�;^L&��}~�{^\n���<�^|!�7��{}s�\0?��2�5��OZI?�K��]�w���\'O\'��{La�u�-�#O%�Tˏ�O����w��i��\n�1u�/�OV&�<Z~���%s��`E��c�G��Aʌ�:X����A>z�Nf擃YI\'��ݽ�Q2[�f#�,/?�[gȜ�;��D������-3��`��r�c���ln�E�XJ~<�`6�ѭ�;HK�����2�yp5�cz����de��<���1��8�H��i��j������ɓd��+I\ZS�a�A�\\湂t15C\Zd������|i�Y�{�&YL͇�F�{����|\0i���� QL��V�}�g4�bj>�4��$QL��f�o��������*��;`$I�X���(�09�3H��\0� I\0�3\08�$L�\0��09�3H��\0� I\0�3\08�$L�\0��09�3H��\0� I\0��7\0E�\0&��o\00�$L*�_�3�4LJ�s&��P���h0�,~���\n`\"Y�ʟ�H�$��\r\0�$Y\0��W��M�\0n��������(K_�s)�I����J�p�,~�+I\Z�\r��?W�8��e�\0�A�\0.�e�W�:��e�+~f }\0\'��σ�H�	���$�\0e���,�`�,�<��D|)�~�`6R	�CY�y03	�P�����,���H*��,�W��Z�\rY�{��^���_��RT�bw��T�b�;x*��d��<�����~䠅�����ꠑ����~䠕���R?z��\0��e��?y��ԏ���\0�����c�`*Y�p��&��~�.�E~�q�(�tY�0���*�����Ҁ��̏p=/\"K����\n��d�r�<�H�,�O��W	��e~䀹y����?9`\r^+�,�W��+�(�W<�������,^5��b�;�ټr(�%�w��y�P\"K~�^<�ȲW����Y����@�,C\0�y�P$�?���C�,����K�RY�[<����x/��,�<�Y�j�oY�y�sx���\0�\0<��������/e����8,K�5x��G��_0//��,����u_���;`^$0T������Sd�:�z^p�,�w\\ǋ.�e�w�5�6�rY�[��+n�ſu�x^p�,����id�:�;^0�,��~����e���x5�Բ��p��,)�?x�+����u�6�X^�����U\0����w�\0<P��A;�\0x�,���F�<^��A�jd��A��d��<�������J��jY�{O#�\0��\rx�ؐ�o�4��#���I���,�<X���ş��Z�����`%�,����I)�e�o�J:����u0#��R���l�`�,C�I#�	���\0f#�\0\'��7���,��`�p�,�<���\\$K?�$q\0��σ�H�M���\0�$i\07��7����,���\n�0�,~#��I�$��\r\0�$Y\0�1\0��dL&�!�$\n`BY��\0�I�����\0F�\"��e�\0�\"E\00\0M�\0���[���,~�oI�\"��\r\0�!=\01\0Ez\0b\00��\0,�\0`�X��(���Q�`!\0�H�B\0F���\0�\"=\01\0Ez\0b\00��\0,�\0`�X��(���,�oH���\r\0�%=\0��7\0���\0L.K_�3�L,��\0`)�T���HR0�,}��H�0�,}��h0�,~�3H�$��?g�*�	d�+�&Y\07��W�\\A�\0n�e������ _�s5I�@����U�\r�dY�[W�:�e���]��Y�{w�>�����`��,����H$���؏�F*�Rw03	x#����\n$`C�����H-��d���N�~/~��SH2P%�����H��|`�\Z�֎<���(?6>80V���\r$�F���;�|3?=h\"�7�Б�f�~r�0��8}r�t����_^�d�5�`��+��uL.?fw|#�t���j���^��+������0�v�������J����w�0������O��W���w]����VY$�8��\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B\0\02\0\0��\0\0�\0\0(d\0\0@!\0\0\n\0\0P�\0\0�B�ʜ2�*�\0\0\0\0IEND�B`�');
/*!40000 ALTER TABLE `picture_bin_data` ENABLE KEYS */;
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
INSERT INTO `picture_ext_option` VALUES
(2,'jpeg'),
(1,'png');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `picture_real_options`
--

LOCK TABLES `picture_real_options` WRITE;
/*!40000 ALTER TABLE `picture_real_options` DISABLE KEYS */;
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
INSERT INTO `picture_upload_info` VALUES
(3,1,1,'2023-10-12 18:17:42');
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
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_game`
--

LOCK TABLES `player_game` WRITE;
/*!40000 ALTER TABLE `player_game` DISABLE KEYS */;
INSERT INTO `player_game` VALUES
(1,2,'2023-11-26 11:35:51'),
(2,6,'2023-11-26 12:13:09'),
(3,6,'2023-11-26 12:15:59'),
(4,7,'2023-11-26 12:16:55'),
(5,9,'2023-11-26 12:51:32'),
(6,9,'2023-11-26 12:55:09'),
(7,11,'2023-11-26 19:03:06'),
(8,11,'2023-11-26 19:03:12'),
(9,11,'2023-11-26 19:03:17');
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
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `player_id`
--

LOCK TABLES `player_id` WRITE;
/*!40000 ALTER TABLE `player_id` DISABLE KEYS */;
INSERT INTO `player_id` VALUES
(1,1,2),
(2,1,1),
(3,1,1),
(4,1,1),
(5,1,1),
(6,1,1),
(7,1,1),
(8,1,1),
(9,1,1),
(10,1,1),
(11,1,1),
(12,1,1),
(13,1,1),
(14,1,1),
(15,1,1),
(16,1,1),
(17,1,1),
(18,1,1),
(19,1,1),
(20,1,1),
(21,1,1),
(22,1,1),
(23,1,1),
(24,1,1),
(25,1,1),
(26,1,1);
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
INSERT INTO `player_role` VALUES
(1,'user'),
(2,'admin');
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
INSERT INTO `registered_player` VALUES
(1,'Sanyi',3,'SanyiVagyok',1,1,1,123456789);
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
INSERT INTO `type_wordlist` VALUES
(1),
(2);
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
INSERT INTO `type_wordlist_international` VALUES
(2,1,'Állat'),
(2,2,'Animal'),
(1,2,'Number'),
(1,1,'Szám');
/*!40000 ALTER TABLE `type_wordlist_international` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-11-26 22:48:30
