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
(1,1,'SzÃ¡m'),
(1,2,'Number'),
(2,1,'Kutya Ã©s Macska'),
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
(1,1,'MagyarorszÃ¡g'),
(1,2,'Hungary'),
(2,1,'Anglia'),
(2,2,'England'),
(3,1,'SzÃ¡jc'),
(3,2,'Switzerland'),
(3,3,'SvÃ¡jc'),
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
(1,NULL,'fÃ©rfi'),
(2,NULL,'nÅ‘'),
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
(3,1,'nÃ©met'),
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
(2,'‰PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0\0\0\0\0\0\0r\rß”\0\0\0“IDATx^í“K\nÀ DsÿK·X¨4šÌ$¢…~¸1“yn”íf¤½XÍÇ…\"ÏæV¤4’±èÒÙ’¬¸KE[¢b5,0XG°`Ô£„³@_\",x}Ç-zÑ(^_ÎÆëü…ÃxK„¨ïùBöÅê…2°%daF¤CMÏ¶dİ3q&[€©k:ré	¼_¸¾%EVı‡«\0\0\0\0IEND®B`‚'),
(3,'‰PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0\0\0\0\0\0\0r\rß”\0\0\0€IDATx^íÑA\nÀ0DQïé‚ˆš‘bÁİ$C?¥´.#{ĞíwˆöƒÂ—‰]	êP{Ğ~UkĞÆä…/—“s¼Œb,:÷@Ë,Æ²;+]JèôÂÓ½.‘@w_&&¨áË@å_3|¨ÄXmí˜ U[;&hÕÖ÷ƒUï?p+°êcXeM\0\0\0\0IEND®B`‚'),
(4,'‰PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0\0\0\0\0\0\0r\rß”\0\0\0ŒIDATx^íA\nÀ óÿO·,4 Ñh6¦=¼„İŒ*×Çˆ¼Í–C	EÄ=Q–ÉÈbo>ÂM®$-‘Œ2LFE\n•í¤0ù.É”{ÁxÒ‘.m`_¸tCFøÆCFR­¬ĞÍìW*áæ®H	m¨’éUÉÀtS+´\'Kª¹#çÒa9ÿŞ>9™ˆ®t\0\0\0\0IEND®B`‚'),
(5,'‰PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0\0\0\0\0\0\0r\rß”\0\0\0xIDATx^íÒQ\n€0ĞŞÿÒÊşB1­µˆôÁ~¶la:;š™ŸxÛ·Íl;\"¤4;œ­íĞTä09ç\'r\0Rò÷‰\0å–|5¨µP)[¶	|,‘¡ĞR S‚â;@¦XOÿ.lû¤™ÿ·\\Òş²‘‘ÛõÀ–›ÂrSXî°tu&Èã\0\0\0\0IEND®B`‚'),
(6,'‰PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0\0\0\0\0\0\0ôxÔú\0\0\ruIDATx^íÖË²ÛH@ÿÿO{¢gÑ˜”¨«\"YEdFœW¶…\"ğë7\0PçWş\0ğ|\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0»~ıú5ÍcyUğ0YœO=à;^L&‹Î}~À{^\näæ<à^|!æ‰7‹ü{}s€\0?–¥2Ó5ÈóOZI?üK–Ã]Çwòÿó\'O\'åğ{LaüuÌ-¯#O%İTËıOµäïwôài¤š\nù1u¬/ÓOV&Á<Z~°ü%sñê`E’ËcåGúİAÊŒ¼:XÔòùA>zğNfæ“ƒYI\'İ½ƒQ2[ïf#•,/?´[gÈœ½;˜‰D²¬ü¸îœ-3÷î`’Èròcš³ÈlnÜEúXJ~<ó`6™Ñ­ƒ;HKÈæÖÁÌ2¯yp5©czù¡ôÑde™á<¸Š´1µü8úHò™iùæj’ÆÔòÃèÉ“d®å›+I\ZSóa¤Aæ\\æ¹‚t15C\ZdÎóà’ÅÔ|i‘Y—{Î&YLÍ‡F™{ùçÅÔ|\0i”¹—Î QLÍV™}ùg4‰bj>€4“Î$QLÍf™o€‘¤‰éùøÑ*Ëß;`$I˜X–¿À(’09€3HÀä\0Î I\0“3\08ƒ$LÎ\0à’09€3HÀä\0Î I\0“3\08ƒ$LÎ\0à’09€3HÀä\0Î I\0Ëò7\0E’\0&•Åo\00’$L*‹_ù3’4LJùs&‰˜P–¿Àh0™,~åÏ¤\n`\"YüÊŸ³HÀ$²ø\r\0Î$Y\0ÈÒWşœMº\0n–¥¯ü¹‚„Ü(K_ùs)¸I–¾òçJ’p“,~€+I\ZÀ\r²ô?W“8€‹eñ\0ÜAâ\0.eŸW“:€“eÙ+~f }\0\'ÊÂÏƒ»HÀ	²è·î$\0eÉçÁ,¤`,û<˜‰D|)‹~ë`6R	ğCYòy03	øPıÖÁì¤à ,ù½ƒH*À,öW«‘Z€\rYğ{«’^€ßÇ_ñóRTËbwğÒTÊbß;x*éêdÉï<™„•…~ä …´”Åşê ‘ä‘Å~ä •ôËËR?zĞÌ\0–”eşê€?yÀ²Ô°Íë\0¦–…şî€c¼`*YèŸpœÜ&üÓ~Î.—E~ô€q¼(àtYäŸ0—œ*ËüÈçóÒ€¡²Ìp=/\"Kıİ÷ò\nd‘rÀ<¼Hà°,ôO˜‹W	¼•e~ä€¹y¥À²Ì?9`\r^+ğ·,óW¬Í+ş(÷W<ƒ×¥²Øßğ,^5”Ébß;àÙ¼r(’%¿wÀóyéP\"K~ë€^<”È²WúĞÍë‡YüÊºù@‰,C\0ºyùP$‹?èáÅC™,ı­ÏK‡RYú[<—å²ô·x/ø¿,ı<àY¼jàoYúyÀsxÑÀ®\0†\0<‡—ìÊâÏÖå/eéï°¯8,Kë€5x­ÀG²ğ_0//ø‘,û½æäu_ËÒß;`^$0T–şÖ÷óSdé¿:àz^pš,úw\\Ç‹.‘e¿wÀ5¼6àrYú[œË+n•Å¿uÀx^p»,ü­Æòª€idé¿:à;^0¥,ü½~Æë¦•eÿê€Ïx5ÀÔ²èßpŒ×,)‹?xÍ+–•¥¿uÀ6¯X^–şÖÿåU\0‘¥¿w€\0<PşÖA;¯\0x¬,ı½ƒF’<^şÖA©jdéçA‰ªdéï<”µ²ô·JºjYø{O#Õ\0¿\rx‰Øåoğ4’°#‹ßàI¤à…,ş<X•ôÅŸ«‘Z€ƒ²ôó`%ğ¡,ş­ƒÙI)ÀeéoÌJ:¾…¿u0#ÉøRşÖÁl¤`°,C€I#À	²ø\0f#‰\0\'Éâ7˜‰œ,Ëß`Òp,ş<¸šÔ\\$K?®$q\0ÊÒÏƒ«HÀM²ü\0®$i\07Êò7¸Š”Ü,Ëßà\nÒ0,~#€³IÀ$²ø\r\0Î$Y\0“1\0¸‚dL&€!À$\n`BYş†\0£IÀ¤²ø\0F’\"€‰eñ\0Œ\"E\00\0MŠ\0Àà[Ò°€,~€oIÀ\"²ü\r\0¾!=\01\0Ez\0b\00Šô\0,Ä\0`éXˆÀ(Ò°€Q¤`!\0£HÀB\0F‘€…\0Œ\"=\01\0Ez\0b\00Šô\0,Ä\0`éXˆÀ(Ò°ˆ,€oHÀ²ø\r\0¾%=\0Èâ7\0ø–ô\0L.K_ñ3‚L,‹ß\0`)˜T–¾ÀHR0©,}åÏH’0¡,}ÅÏh0™,~€3HÀ$²ğ•?g’*€	dá+Î&Y\07ËÂWş\\Aº\0n’e¯ø¹’”Ü _ùs5I¸@–üŞÁU¤\ràdYò[W“:€eÑçÁ]¤àYô{w‘>€²àó`Òğ¥,ù½ƒ™H$À‡²ØÌF*ÊRw03	x#‹ıİÁ\n$`C–ú»ƒÕH-À¿d±ï¬NŠ~/~åÏSH2P%ËüèÁÓHõ|`à\ZùÖ<™„ß(?6>80V¾¯£\r$ıFùÑÙ;àµ|3?=h\"ñ7ËĞ‘ƒfù~r€0…ü8}rğt™ùŸğ_^Ådò£5ê`™Ë+ØæuL.?fw|#ótÆŸñj”¾^™…+ø—´¸ü0®vìËÿ«öÆòªJäÇÔİwí¿0¯‘·òîÜO˜‹WÉù±w]¬ÇËåVY$îŸ8“¯\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€BÿÊœ2Æ*ğ£\0\0\0\0IEND®B`‚'),
(7,'‰PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0\0\0\0\0\0\0ôxÔú\0\0\rVIDATx^íÖK7EQíÓ6Œ†l÷S}»2™$ß9@L4SW2âşú\0¨ó+ÿ\0ØŸ\0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0õë×¯oÃœü2\0¼-ü£aN~\0îÊcş“aN~\0ş•ÇûˆaN~€2y ÏæçWØ\\ç£†µù6’Gú¨a?~U€å>zØŸ_`ryœğ\0L\"ôÑÿç‹\0 ñ™¯ğ¥\0(ñ™Ÿğ¼(ğè#ù¢€jydgÁ—ÔÈC;z`&¾H`yp¯\ZX/8TÃİvákÊ#¸Û@#_>”È£×:À¯JyÌ>¼Æk¡Nsü\0óóR©’‡Ê¼>À^¼jêäak€ØTrv6•\0ĞÎæ£’\0\0ÚÙ|T\0@;›J\0hgóQI\0\0íl>*	\0 ÍG%\0´³ù¨$\0€v6•\0ĞÎæ£’\0\0ÚÙ|T\0@;›:yü\0ĞÈæ£J~\0´²ù¨’‡ßñZÙ~Tqü¾Ø€T\0\0_l@ª\0€/6 U\0À\Zyü\0ĞÌ¤B~\0´³©‡ßñÚÙ‚Tpü¾³	© \0\0¾³	© \0\0¾³	© \0\0¾³	Ù^\0 \0Ø\\~Çà‹mÈÖ€ÛlD¶&\0\0n³Ùš\0\0¸ÍFdk\0à6‘måñ\0\0ÿ±ÙR~\0ğÈ–òğ;ş\0ßÙŠlÉñxÌfdK\0à1›‘-	\0€ÇlF¶“Ç_\0\0üÉfd;?Às¶#Û\0\0ÏÙl%¿\0\0¸Ívdyø€ûlH¶áø¼Î–d\0àu¶$[Èã/\0\0³%Y^~Çà9›’å9ş\0ï³-Y\0\0xŸmÉò\0ÀûlK–\'\0\0Şg[²´<ş\0à5¶%ËÊÃ/\0\0^g[²¬<ü?ÀëlL–åøüœ­É²\0ÀÏÙš,)¿\0\0x­Éròğ;ş\0ï³9Yãğ9Û“å\0€ÏÙ,%¿\0\0øÛ“eäáwü~Îe?ÀqlQ–!\0\0c‹²\0p[”%äñ\0\0Ÿ±E™^~\0ğ9[”©åÑwüa“2µ<ü?À1lS¦æøœÃFej\0à6*S\0\0ç°Q™š\0\08‡Ê´òø\0€ãØ¨L)¿ãp,[•)9ş\0ç²Y™N\0p<›•©äá\0\0ç°Y™J~Çà¶+ÓÈÃïøœÇ†e\nyø\0À¹lX¦‡ßñ8—-Ë€±lZ¦ \0\0Æ²i™‚\0\0Ë¦åryü\0ÀùlZ.•‡_\0\0ŒaÓr©<ü?À¶-—rü®aãr™<ş\0`—Käá\0\0cÙ¸\\\"¿ã0–­Ë%€kÙ¼\\B\0\0\\Ëæe¸<ş\0`<›—á€ëÙ¾•Ç_\0\0\\Ãöe˜<ü\0à:¶/Ãäá\0\0×±}Æá˜‡-Ì0\0`¶0Ã\0€yØÂ#\0\0æa3Œ\0\0˜‡-Ì0\0`¶0Ã\0€yØÂ#\0\0æa3Œ\0\0˜‡-Ì0\0`¶0Ã\0€yØÂ“ \0®c3L!\0p›—aòèß\Z\0Æ°q*ş»À1lT.“ÇıÓàu¶&—ËC>Û\0ìÈvc\ZyxW€UØX,%î¬0;›Š-äy\0f`Áy¼GÀ¶\r$ùpN‡üÓ8šÍƒåqÿd\0~ÊÉä‘e\0ŞesÀ¤òÈ¿2\0¯²1`yèß€[lXTúgğ¶,.ı£øÍF€\rä¡w€>^>l,ı³zxñ°¹<òèáÅC‰<ö¯°//ŠåÁ¿7À~¼l(—ÇşŞ\0{ñª?ı½öáE7åñ°/¸+°./x(~°&¯xYÿ`^,ğ–<ú9À\Z¼Vàmyô\0¬Çk>’ `\r^(ğ‘<ú9Àœ¼Nàcyôo\r0¯8T~\0sò\"Säñ\00/8\0€yy‘Ài2\0D\0ÌÃkN“Ç_À<¼DàTyü\0ÌÁKN\'\0`>^\"p:\0óñÓe\0ˆ\0¸Wœ.¿€ëyÀyü\0\\Ë†\00/F\0À<¼@`\0óğa\0ÌÃ†\00/F\0À<¼@`\0óğa\0ÌÃ†\00/F\0À<¼@`ˆ<ş\0®å§ËÃ/\0àz^ pº<ü\0®ç§søa>^\"p:\0óñSåñ\00/8M~\0óğÓäáwüa^#pŠ<ü?ÌÅ‹•G_\0Àœ¼Hà0yğ˜—W	\"¾ãsó2åÁwøa~^(ğ‘<ú?¬Á+~$~07¯xKú`\r^+ğ²<ö9À:¼Xà©<ô·X‹W<”‡ŞÑ‡=xÁ² 9J|ßìÃ+ŞŒ%Íò;ÊÖç%oÆ¢æùıä\0ûğ¢7caóSùíä\0{ñª7cióùİä\0ûñ²7cqóü^|;ĞÃ+ßŒ%Î+ò;Éöç¥oÆ\"çü6î\rĞÁkßŒeÎ-ù]Ü ‡¿ßò[¸7@\'¯3–;ù\r<\Z —\r°¾[şş·à¶Áf,û.ù{?€ßl„ÍXøòw~4\0·Ø›±ü÷–¿ï£xÄ–ØL‡`ù›>€glŠÍä!pÖ•¿á½ø	ÛcCy ‰µäowo\0>a‹lÊ±XOşfàS6É¦Œyåoóê\0ÉVÙTdù›<€³Ø0›ÊCâ \\/‹Gp6›fcyT–qòïşê\0ŒbãlÎ+ÿŞàJ¶Ğæ1òïül\0®fm.ãó¹ü{¾;\03°6—ÇÇ!z_şİ^€™ÙRò09P¯É¿×;0;›ªD(ÇêKş->€•ØZEò`åì,ÿ¯ŸÀêl²2yÈîÍ.òÿõÉ\0ìÄV+•ÇÍÜ€ÙnåòØ5@#ÛåaÜq\0øb#ò‡<š«\0² \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B†é9öKK*\0\0\0\0IEND®B`‚'),
(8,'‰PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0\0\0\0\0\0\0ôxÔú\0\0\ruIDATx^íÖË²ÛH@ÿÿO{¢gÑ˜”¨«\"YEdFœW¶…\"ğë7\0PçWş\0ğ|\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0»~ıú5ÍcyUğ0YœO=à;^L&‹Î}~À{^\näæ<à^|!æ‰7‹ü{}s€\0?–¥2Ó5ÈóOZI?üK–Ã]Çwòÿó\'O\'åğ{LaüuÌ-¯#O%İTËıOµäïwôài¤š\nù1u¬/ÓOV&Á<Z~°ü%sñê`E’ËcåGúİAÊŒ¼:XÔòùA>zğNfæ“ƒYI\'İ½ƒQ2[ïf#•,/?´[gÈœ½;˜‰D²¬ü¸îœ-3÷î`’Èròcš³ÈlnÜEúXJ~<ó`6™Ñ­ƒ;HKÈæÖÁÌ2¯yp5©czù¡ôÑde™á<¸Š´1µü8úHò™iùæj’ÆÔòÃèÉ“d®å›+I\ZSóa¤Aæ\\æ¹‚t15C\ZdÎóà’ÅÔ|i‘Y—{Î&YLÍ‡F™{ùçÅÔ|\0i”¹—Î QLÍV™}ùg4‰bj>€4“Î$QLÍf™o€‘¤‰éùøÑ*Ëß;`$I˜X–¿À(’09€3HÀä\0Î I\0“3\08ƒ$LÎ\0à’09€3HÀä\0Î I\0“3\08ƒ$LÎ\0à’09€3HÀä\0Î I\0Ëò7\0E’\0&•Åo\00’$L*‹_ù3’4LJùs&‰˜P–¿Àh0™,~åÏ¤\n`\"YüÊŸ³HÀ$²ø\r\0Î$Y\0ÈÒWşœMº\0n–¥¯ü¹‚„Ü(K_ùs)¸I–¾òçJ’p“,~€+I\ZÀ\r²ô?W“8€‹eñ\0ÜAâ\0.eŸW“:€“eÙ+~f }\0\'ÊÂÏƒ»HÀ	²è·î$\0eÉçÁ,¤`,û<˜‰D|)‹~ë`6R	ğCYòy03	øPıÖÁì¤à ,ù½ƒH*À,öW«‘Z€\rYğ{«’^€ßÇ_ñóRTËbwğÒTÊbß;x*éêdÉï<™„•…~ä …´”Åşê ‘ä‘Å~ä •ôËËR?zĞÌ\0–”eşê€?yÀ²Ô°Íë\0¦–…şî€c¼`*YèŸpœÜ&üÓ~Î.—E~ô€q¼(àtYäŸ0—œ*ËüÈçóÒ€¡²Ìp=/\"Kıİ÷ò\nd‘rÀ<¼Hà°,ôO˜‹W	¼•e~ä€¹y¥À²Ì?9`\r^+ğ·,óW¬Í+ş(÷W<ƒ×¥²Øßğ,^5”Ébß;àÙ¼r(’%¿wÀóyéP\"K~ë€^<”È²WúĞÍë‡YüÊºù@‰,C\0ºyùP$‹?èáÅC™,ı­ÏK‡RYú[<—å²ô·x/ø¿,ı<àY¼jàoYúyÀsxÑÀ®\0†\0<‡—ìÊâÏÖå/eéï°¯8,Kë€5x­ÀG²ğ_0//ø‘,û½æäu_ËÒß;`^$0T–şÖ÷óSdé¿:àz^pš,úw\\Ç‹.‘e¿wÀ5¼6àrYú[œË+n•Å¿uÀx^p»,ü­Æòª€idé¿:à;^0¥,ü½~Æë¦•eÿê€Ïx5ÀÔ²èßpŒ×,)‹?xÍ+–•¥¿uÀ6¯X^–şÖÿåU\0‘¥¿w€\0<PşÖA;¯\0x¬,ı½ƒF’<^şÖA©jdéçA‰ªdéï<”µ²ô·JºjYø{O#Õ\0¿\rx‰Øåoğ4’°#‹ßàI¤à…,ş<X•ôÅŸ«‘Z€ƒ²ôó`%ğ¡,ş­ƒÙI)ÀeéoÌJ:¾…¿u0#ÉøRşÖÁl¤`°,C€I#À	²ø\0f#‰\0\'Éâ7˜‰œ,Ëß`Òp,ş<¸šÔ\\$K?®$q\0ÊÒÏƒ«HÀM²ü\0®$i\07Êò7¸Š”Ü,Ëßà\nÒ0,~#€³IÀ$²ø\r\0Î$Y\0“1\0¸‚dL&€!À$\n`BYş†\0£IÀ¤²ø\0F’\"€‰eñ\0Œ\"E\00\0MŠ\0Àà[Ò°€,~€oIÀ\"²ü\r\0¾!=\01\0Ez\0b\00Šô\0,Ä\0`éXˆÀ(Ò°€Q¤`!\0£HÀB\0F‘€…\0Œ\"=\01\0Ez\0b\00Šô\0,Ä\0`éXˆÀ(Ò°ˆ,€oHÀ²ø\r\0¾%=\0Èâ7\0ø–ô\0L.K_ñ3‚L,‹ß\0`)˜T–¾ÀHR0©,}åÏH’0¡,}ÅÏh0™,~€3HÀ$²ğ•?g’*€	dá+Î&Y\07ËÂWş\\Aº\0n’e¯ø¹’”Ü _ùs5I¸@–üŞÁU¤\ràdYò[W“:€eÑçÁ]¤àYô{w‘>€²àó`Òğ¥,ù½ƒ™H$À‡²ØÌF*ÊRw03	x#‹ıİÁ\n$`C–ú»ƒÕH-À¿d±ï¬NŠ~/~åÏSH2P%ËüèÁÓHõ|`à\ZùÖ<™„ß(?6>80V¾¯£\r$ıFùÑÙ;àµ|3?=h\"ñ7ËĞ‘ƒfù~r€0…ü8}rğt™ùŸğ_^Ådò£5ê`™Ë+ØæuL.?fw|#ótÆŸñj”¾^™…+ø—´¸ü0®vìËÿ«öÆòªJäÇÔİwí¿0¯‘·òîÜO˜‹WÉù±w]¬ÇËåVY$îŸ8“¯\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€BÿÊœ2Æ*ğ£\0\0\0\0IEND®B`‚'),
(9,'‰PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0\0\0\0\0\0\0ôxÔú\0\0}IDATx^íÖÛ®ÜÖPıÿO;0‚ RixæÆ}!k-`¿$°-\r»«ë×?\0@_ù?\0\0÷§\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH€úõë×%°	‡ôn˜ÏæÁÆòP6=`,[›ÉCè=~Àwll\"Ü+ïjòÏÖŞgs`±<f?½;Ê¿ãxÎ¦À\"y´^£ü\rF>heúa²<@GŸåïõíƒ6¦&ÈcóÓã=ùû}ú ©‡òÈüô8Gş®¯>hcêa<0kù43õ0@úG`%)\'Ê#Ÿ`	N‡>Àn$|!ı£°#éÊCŸ`gR\n>Ç>Àî$¼)½£\\‘Ô‚åÁwü+“\\ğDû|\0W$½àyìó\\•ƒyìó\\™ƒòØ;úÀİH4yôà¤\Züs|ô\0à®¤\ZõòĞ;ú@	Gµ<ø?ĞBÊQ-¾ã´tÔÊ£ïğM$•òğ+\0@‰G•<ø?ĞJêQ#¾ã4“|TÈƒïøí¤òè;ş@;	ÈíåÑwø\0n.¿\0ğ_’ÛÊ£ïøüŸ4ä–òè;ş\0’ˆÜN}ÇàoR‘ÛÉÃïøüM2r+yø€Ç¤#·‘‡_\08&¹…<ú?ÀÏ$$——GßñxNJryyø€ç$%—çø¼OZriyü\0€×HK.+¿ãğ:‰É%åáwüŞ#5¹¤<ş\n\0À{¤&—“‡ßñxŸääRòğ;ş\0Ÿ‘\\F~Çàs”ËpüÎ#E¹\0à<R”KÈã¯\0\0|GŠ²½<ü\n\0À÷¤([Ë£ïøœC’²µ<ü?À9¤)[süÆ¨lM\0C¢²­<ş\n\0Ày$*[ÊÃ¯\0\0œK¢²¥<ü?À¹¤*[rüÆ’¬lI\0K²²<ş\n\0Àù$+ÛÉã¯\0\0œO²²•<ü?ÀÒ•mäáwüÆ‘°l!¿\00–„eyø€±¤,[püæ’´lA\0˜KÒ²\0`.IË\0€¹$-ËåñW\0\0Æ“´,•‡ßñ˜CÚ²”ã°†Äe)\0`\r‰ËR\n\0À\Z—eòø+\0\0óH\\–ÈÃïøÌ%uYÂñXKò²„\0°–äe	\0`-ÉË\n\0ÀZ’—%\0€µ$/ÓåñW\0\0æ“¼Lçø¬\'}™N\0XOú2\0°ôeª<ş³\n@ş7¯ğ\0F’2L“nÆ¡ËÿÖ]À»$ÓäÑ\Zu¸ò¿Ñş\0‘L3ú0å¿ßûóüN*0ÍÙ)ÿ}¯¼«È?÷èô±ùLóÍÑÉö× ÿÎŸ> ‡gšOMşs¯>>ûí€¶i~:4ùÿ}óø[şF¯<àŞl9SäqùßÉÿíİÇ÷ò7}ô€û±Ù—Çä›Çù;=à>l4Ãåùô1^şæp¶™áò€üôØC~—G¸6[Ì0y0~zì)¿Ó£\\“íeˆ<?=ö–ßëè×bk9]†|\\W~ËG¸ÛÊéò äãúò›æögS\"‚ãp?ù]=`_6”á…ûËoì{Ãşl\'Ã9ò;ûæ°7›ÉpA—üŞ¾=ìÉF2œ#Ğ\'¿¹ïû±ç\0tÊïn`/6‘á„·üşfö`Nè“3˜Ïæ1œ°ç_9fÖ²y\'ìù]ÎƒÙ€5lÃ	yRÎ„ù€ùlÃ	xÉ¹0#0—Mc8áÎOr>Ì	ÌaËN°óLÎˆ9ñlÃ	v^‘sbV`,ÆpBWäœ˜Ëv1œ@çU9+æÆ±U\'ÈyGÎ‹¹1lÃ	rŞ•3cnà|¶Šá9ŸÈ¹1?p.ÛÄpœOäÜ˜8—mb8Î§rvÌœÇ61œ\0ç9?æÎa‹Npóœsç°E\'¸ùVÎY‚ïÙ †Úœ!çÈ<ÁwlÃ	lÎ’³dàs¶‡á6gÊy2Sğ›ÃpÂš³™)øÍa8aÍÙr¦Ì¼ÏÖ0œ æl9SfŞgcNH3BÎ•Ù‚÷Ø†ÒŒb¶às6†á„4£˜-øœa8!Í(9[f^gSN83JÎ–ƒ×Ù†ÎŒ”óeÆà56…á„3£åŒ™5xÎ†0œPf´œ1³ÏÙ†ÊÌsfÖàg6„á„2³˜5x\ra8¡Ì,9kæ\rÙ†ÈÌ”ófæà1›ÁpÂ˜ÙÌ<g3N3›™ƒçlÃ	cfË™3wğ7[Áp‚˜ÙræÌüÍF0œf…œ;³²\'„YÅìÁ1ÁpB˜UÌ³\'„YÅìÁ1ÁpB˜UÌ³\'„YÅìÁ1ÁpB˜UÌ³\'„YÅìÁ1ÁpB˜UÌ³\'„YÅìÁ1ÁpB˜UÌ³\'„YÅìÁ1ÁpB˜UÌ³\'„YÅìÁ1ÁpB˜UÌ³\'„YÅìÁ1ÁpB˜UÌ³\'„YÅìÁ1ÁpB˜UÌ³\'„YÅìÁ1ÁpB˜UÌ³\'„YÅìÁ1ÁpB˜UÌ³\'„YÅìÁ1ÁpB˜UÌ³\'„YÅìÁ1ÁpB˜UÌ³\'„YÅìÁ1ÁpB˜UÌ³\'„YÅìÁ1ÁpÂ‚˜YÌ³L‘A,Œ™ÁÌÁ1ÁÄÂ˜ÑrŞÌüÉF00f–œ53³L#Œ™%gÍ¼ÁßlÓdf1kğœÍ`šeÁÌ(æ³L•Á,œÁŒÁs6ƒé„3#å|™1xÌf0pf”œ-3ÇlÓ	gFÉÙ2_pÌv0]´æ9Sæ\n~fCXBPs¦œ\'sÏÙ–Ôœ)çÉ\\Ás6„%5g2Oğ>›Â›3™\'xŸMa‰l¡Í7Ì¼Ï¦°L†¶àæ9Cæ^cSXJpóœs¯³),%¸ùTÎ‚÷Ø–Ş|\"çÆüÀûlK	pŞ•3c~à36†¥8¯ÊYÉ¼ÇÖ°T†¸0ç‘œ³ß³=,•a.ÔI9ù€ÏØ–Ë@êü.g#ğÛÃ„:ä\\˜\r8mbò‚œsç²Ml#ƒ^ØwÊÈœÃ6±aß-¿¿Y€ql[ú½òÛçÎe«ØJ†¾àïß<p>›ÅV2ø€ûËoí›Ã¶Œíä!pî+¿³oóØ2¶ätÈïì{Ã<6-åApî%¿­oóÙ8¶•ÇÁ¸¾üù€yl[s î!¿ã£ÌeëØš#qmùı=`\rÛÇÖòX8×‘ß-°–-dky4ıå·zô€õl\"ÛËãáˆì+¿Q>`6’KÈCâ˜ì\'¿o{³™\\†£²§ü.ù€=ÙN.#‹ã²V~‹|ÀŞl)—‘Æ¡Y#ÿGØŸMåRòĞ86såoŸ¸ËåäÑqxÆËßûÑ®ÅÖr9yx ±òwÎ\\“íå’ò9FçÊßõÑ®ÍsYy¦säï™¸ÛÌ¥åqr ¾“¿e>à>l4——GÊ¡z_ş~p/¶šËËCåh½.¯|À}Ùpn!—#ö\\şNù€{³åÜF0‡ìOù»üô€û³éÜN³öƒ–¿ÅÑºØzn\'[óËßàè}l>·”®éĞåßùÙ:Ù~n+İ^şı~z\0ÿ’ÜZ¿|w§£ğ;©Àíå!|ôv—ŞOÀï¤5ò şôv’¶WÀ3’‚:y,ïò\0Ş!5¨•ôÊà]’ş¹N\08‹DGw—p&©\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0ú§=$â–|®\0\0\0\0IEND®B`‚'),
(10,'‰PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0\0\0\0\0\0\0ôxÔú\0\0}IDATx^íÖÛ®ÜÖPıÿO;0‚ RixæÆ}!k-`¿$°-\r»«ë×?\0@_ù?\0\0÷§\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH€úõë×%°	‡ôn˜ÏæÁÆòP6=`,[›ÉCè=~Àwll\"Ü+ïjòÏÖŞgs`±<f?½;Ê¿ãxÎ¦À\"y´^£ü\rF>heúa²<@GŸåïõíƒ6¦&ÈcóÓã=ùû}ú ©‡òÈüô8Gş®¯>hcêa<0kù43õ0@úG`%)\'Ê#Ÿ`	N‡>Àn$|!ı£°#éÊCŸ`gR\n>Ç>Àî$¼)½£\\‘Ô‚åÁwü+“\\ğDû|\0W$½àyìó\\•ƒyìó\\™ƒòØ;úÀİH4yôà¤\Züs|ô\0à®¤\ZõòĞ;ú@	Gµ<ø?ĞBÊQ-¾ã´tÔÊ£ïğM$•òğ+\0@‰G•<ø?ĞJêQ#¾ã4“|TÈƒïøí¤òè;ş@;	ÈíåÑwø\0n.¿\0ğ_’ÛÊ£ïøüŸ4ä–òè;ş\0’ˆÜN}ÇàoR‘ÛÉÃïøüM2r+yø€Ç¤#·‘‡_\08&¹…<ú?ÀÏ$$——GßñxNJryyø€ç$%—çø¼OZriyü\0€×HK.+¿ãğ:‰É%åáwüŞ#5¹¤<ş\n\0À{¤&—“‡ßñxŸääRòğ;ş\0Ÿ‘\\F~Çàs”ËpüÎ#E¹\0à<R”KÈã¯\0\0|GŠ²½<ü\n\0À÷¤([Ë£ïøœC’²µ<ü?À9¤)[süÆ¨lM\0C¢²­<ş\n\0Ày$*[ÊÃ¯\0\0œK¢²¥<ü?À¹¤*[rüÆ’¬lI\0K²²<ş\n\0Àù$+ÛÉã¯\0\0œO²²•<ü?ÀÒ•mäáwüÆ‘°l!¿\00–„eyø€±¤,[püæ’´lA\0˜KÒ²\0`.IË\0€¹$-ËåñW\0\0Æ“´,•‡ßñ˜CÚ²”ã°†Äe)\0`\r‰ËR\n\0À\Z—eòø+\0\0óH\\–ÈÃïøÌ%uYÂñXKò²„\0°–äe	\0`-ÉË\n\0ÀZ’—%\0€µ$/ÓåñW\0\0æ“¼Lçø¬\'}™N\0XOú2\0°ôeª<ş³\n@ş7¯ğ\0F’2L“nÆ¡ËÿÖ]À»$ÓäÑ\Zu¸ò¿Ñş\0‘L3ú0å¿ßûóüN*0ÍÙ)ÿ}¯¼«È?÷èô±ùLóÍÑÉö× ÿÎŸ> ‡gšOMşs¯>>ûí€¶i~:4ùÿ}óø[şF¯<àŞl9SäqùßÉÿíİÇ÷ò7}ô€û±Ù—Çä›Çù;=à>l4Ãåùô1^şæp¶™áò€üôØC~—G¸6[Ì0y0~zì)¿Ó£\\“íeˆ<?=ö–ßëè×bk9]†|\\W~ËG¸ÛÊéò äãúò›æögS\"‚ãp?ù]=`_6”á…ûËoì{Ãşl\'Ã9ò;ûæ°7›ÉpA—üŞ¾=ìÉF2œ#Ğ\'¿¹ïû±ç\0tÊïn`/6‘á„·üşfö`Nè“3˜Ïæ1œ°ç_9fÖ²y\'ìù]ÎƒÙ€5lÃ	yRÎ„ù€ùlÃ	xÉ¹0#0—Mc8áÎOr>Ì	ÌaËN°óLÎˆ9ñlÃ	v^‘sbV`,ÆpBWäœ˜Ëv1œ@çU9+æÆ±U\'ÈyGÎ‹¹1lÃ	rŞ•3cnà|¶Šá9ŸÈ¹1?p.ÛÄpœOäÜ˜8—mb8Î§rvÌœÇ61œ\0ç9?æÎa‹Npóœsç°E\'¸ùVÎY‚ïÙ †Úœ!çÈ<ÁwlÃ	lÎ’³dàs¶‡á6gÊy2Sğ›ÃpÂš³™)øÍa8aÍÙr¦Ì¼ÏÖ0œ æl9SfŞgcNH3BÎ•Ù‚÷Ø†ÒŒb¶às6†á„4£˜-øœa8!Í(9[f^gSN83JÎ–ƒ×Ù†ÎŒ”óeÆà56…á„3£åŒ™5xÎ†0œPf´œ1³ÏÙ†ÊÌsfÖàg6„á„2³˜5x\ra8¡Ì,9kæ\rÙ†ÈÌ”ófæà1›ÁpÂ˜ÙÌ<g3N3›™ƒçlÃ	cfË™3wğ7[Áp‚˜ÙræÌüÍF0œf…œ;³²\'„YÅìÁ1ÁpB˜UÌ³\'„YÅìÁ1ÁpB˜UÌ³\'„YÅìÁ1ÁpB˜UÌ³\'„YÅìÁ1ÁpB˜UÌ³\'„YÅìÁ1ÁpB˜UÌ³\'„YÅìÁ1ÁpB˜UÌ³\'„YÅìÁ1ÁpB˜UÌ³\'„YÅìÁ1ÁpB˜UÌ³\'„YÅìÁ1ÁpB˜UÌ³\'„YÅìÁ1ÁpB˜UÌ³\'„YÅìÁ1ÁpB˜UÌ³\'„YÅìÁ1ÁpB˜UÌ³\'„YÅìÁ1ÁpB˜UÌ³\'„YÅìÁ1ÁpB˜UÌ³\'„YÅìÁ1ÁpÂ‚˜YÌ³L‘A,Œ™ÁÌÁ1ÁÄÂ˜ÑrŞÌüÉF00f–œ53³L#Œ™%gÍ¼ÁßlÓdf1kğœÍ`šeÁÌ(æ³L•Á,œÁŒÁs6ƒé„3#å|™1xÌf0pf”œ-3ÇlÓ	gFÉÙ2_pÌv0]´æ9Sæ\n~fCXBPs¦œ\'sÏÙ–Ôœ)çÉ\\Ás6„%5g2Oğ>›Â›3™\'xŸMa‰l¡Í7Ì¼Ï¦°L†¶àæ9Cæ^cSXJpóœs¯³),%¸ùTÎ‚÷Ø–Ş|\"çÆüÀûlK	pŞ•3c~à36†¥8¯ÊYÉ¼ÇÖ°T†¸0ç‘œ³ß³=,•a.ÔI9ù€ÏØ–Ë@êü.g#ğÛÃ„:ä\\˜\r8mbò‚œsç²Ml#ƒ^ØwÊÈœÃ6±aß-¿¿Y€ql[ú½òÛçÎe«ØJ†¾àïß<p>›ÅV2ø€ûËoí›Ã¶Œíä!pî+¿³oóØ2¶ätÈïì{Ã<6-åApî%¿­oóÙ8¶•ÇÁ¸¾üù€yl[s î!¿ã£ÌeëØš#qmùı=`\rÛÇÖòX8×‘ß-°–-dky4ıå·zô€õl\"ÛËãáˆì+¿Q>`6’KÈCâ˜ì\'¿o{³™\\†£²§ü.ù€=ÙN.#‹ã²V~‹|ÀŞl)—‘Æ¡Y#ÿGØŸMåRòĞ86såoŸ¸ËåäÑqxÆËßûÑ®ÅÖr9yx ±òwÎ\\“íå’ò9FçÊßõÑ®ÍsYy¦säï™¸ÛÌ¥åqr ¾“¿e>à>l4——GÊ¡z_ş~p/¶šËËCåh½.¯|À}Ùpn!—#ö\\şNù€{³åÜF0‡ìOù»üô€û³éÜN³öƒ–¿ÅÑºØzn\'[óËßàè}l>·”®éĞåßùÙ:Ù~n+İ^şı~z\0ÿ’ÜZ¿|w§£ğ;©Àíå!|ôv—ŞOÀï¤5ò şôv’¶WÀ3’‚:y,ïò\0Ş!5¨•ôÊà]’ş¹N\08‹DGw—p&©\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0R\0\0 \0\0…\0\0(¤\0\0@!\0\0\n)\0\0PH\0€B\n\0\0ú§=$â–|®\0\0\0\0IEND®B`‚'),
(12,'‰PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0\0\0\0\0\0\0ôxÔú\0\0\rVIDATx^íÖK7EQíÓ6Œ†l÷S}»2™$ß9@L4SW2âşú\0¨ó+ÿ\0ØŸ\0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0õë×¯oÃœü2\0¼-ü£aN~\0îÊcş“aN~\0ş•ÇûˆaN~€2y ÏæçWØ\\ç£†µù6’Gú¨a?~U€å>zØŸ_`ryœğ\0L\"ôÑÿç‹\0 ñ™¯ğ¥\0(ñ™Ÿğ¼(ğè#ù¢€jydgÁ—ÔÈC;z`&¾H`yp¯\ZX/8TÃİvákÊ#¸Û@#_>”È£×:À¯JyÌ>¼Æk¡Nsü\0óóR©’‡Ê¼>À^¼jêäak€ØTrv6•\0ĞÎæ£’\0\0ÚÙ|T\0@;›J\0hgóQI\0\0íl>*	\0 ÍG%\0´³ù¨$\0€v6•\0ĞÎæ£’\0\0ÚÙ|T\0@;›:yü\0ĞÈæ£J~\0´²ù¨’‡ßñZÙ~Tqü¾Ø€T\0\0_l@ª\0€/6 U\0À\Zyü\0ĞÌ¤B~\0´³©‡ßñÚÙ‚Tpü¾³	© \0\0¾³	© \0\0¾³	© \0\0¾³	Ù^\0 \0Ø\\~Çà‹mÈÖ€ÛlD¶&\0\0n³Ùš\0\0¸ÍFdk\0à6‘måñ\0\0ÿ±ÙR~\0ğÈ–òğ;ş\0ßÙŠlÉñxÌfdK\0à1›‘-	\0€ÇlF¶“Ç_\0\0üÉfd;?Às¶#Û\0\0ÏÙl%¿\0\0¸Ívdyø€ûlH¶áø¼Î–d\0àu¶$[Èã/\0\0³%Y^~Çà9›’å9ş\0ï³-Y\0\0xŸmÉò\0ÀûlK–\'\0\0Şg[²´<ş\0à5¶%ËÊÃ/\0\0^g[²¬<ü?ÀëlL–åøüœ­É²\0ÀÏÙš,)¿\0\0x­Éròğ;ş\0ï³9Yãğ9Û“å\0€ÏÙ,%¿\0\0øÛ“eäáwü~Îe?ÀqlQ–!\0\0c‹²\0p[”%äñ\0\0Ÿ±E™^~\0ğ9[”©åÑwüa“2µ<ü?À1lS¦æøœÃFej\0à6*S\0\0ç°Q™š\0\08‡Ê´òø\0€ãØ¨L)¿ãp,[•)9ş\0ç²Y™N\0p<›•©äá\0\0ç°Y™J~Çà¶+ÓÈÃïøœÇ†e\nyø\0À¹lX¦‡ßñ8—-Ë€±lZ¦ \0\0Æ²i™‚\0\0Ë¦åryü\0ÀùlZ.•‡_\0\0ŒaÓr©<ü?À¶-—rü®aãr™<ş\0`—Käá\0\0cÙ¸\\\"¿ã0–­Ë%€kÙ¼\\B\0\0\\Ëæe¸<ş\0`<›—á€ëÙ¾•Ç_\0\0\\Ãöe˜<ü\0à:¶/Ãäá\0\0×±}Æá˜‡-Ì0\0`¶0Ã\0€yØÂ#\0\0æa3Œ\0\0˜‡-Ì0\0`¶0Ã\0€yØÂ#\0\0æa3Œ\0\0˜‡-Ì0\0`¶0Ã\0€yØÂ“ \0®c3L!\0p›—aòèß\Z\0Æ°q*ş»À1lT.“ÇıÓàu¶&—ËC>Û\0ìÈvc\ZyxW€UØX,%î¬0;›Š-äy\0f`Áy¼GÀ¶\r$ùpN‡üÓ8šÍƒåqÿd\0~ÊÉä‘e\0ŞesÀ¤òÈ¿2\0¯²1`yèß€[lXTúgğ¶,.ı£øÍF€\rä¡w€>^>l,ı³zxñ°¹<òèáÅC‰<ö¯°//ŠåÁ¿7À~¼l(—ÇşŞ\0{ñª?ı½öáE7åñ°/¸+°./x(~°&¯xYÿ`^,ğ–<ú9À\Z¼Vàmyô\0¬Çk>’ `\r^(ğ‘<ú9Àœ¼Nàcyôo\r0¯8T~\0sò\"Säñ\00/8\0€yy‘Ài2\0D\0ÌÃkN“Ç_À<¼DàTyü\0ÌÁKN\'\0`>^\"p:\0óñÓe\0ˆ\0¸Wœ.¿€ëyÀyü\0\\Ë†\00/F\0À<¼@`\0óğa\0ÌÃ†\00/F\0À<¼@`\0óğa\0ÌÃ†\00/F\0À<¼@`ˆ<ş\0®å§ËÃ/\0àz^ pº<ü\0®ç§søa>^\"p:\0óñSåñ\00/8M~\0óğÓäáwüa^#pŠ<ü?ÌÅ‹•G_\0Àœ¼Hà0yğ˜—W	\"¾ãsó2åÁwøa~^(ğ‘<ú?¬Á+~$~07¯xKú`\r^+ğ²<ö9À:¼Xà©<ô·X‹W<”‡ŞÑ‡=xÁ² 9J|ßìÃ+ŞŒ%Íò;ÊÖç%oÆ¢æùıä\0ûğ¢7caóSùíä\0{ñª7cióùİä\0ûñ²7cqóü^|;ĞÃ+ßŒ%Î+ò;Éöç¥oÆ\"çü6î\rĞÁkßŒeÎ-ù]Ü ‡¿ßò[¸7@\'¯3–;ù\r<\Z —\r°¾[şş·à¶Áf,û.ù{?€ßl„ÍXøòw~4\0·Ø›±ü÷–¿ï£xÄ–ØL‡`ù›>€glŠÍä!pÖ•¿á½ø	ÛcCy ‰µäowo\0>a‹lÊ±XOşfàS6É¦Œyåoóê\0ÉVÙTdù›<€³Ø0›ÊCâ \\/‹Gp6›fcyT–qòïşê\0ŒbãlÎ+ÿŞàJ¶Ğæ1òïül\0®fm.ãó¹ü{¾;\03°6—ÇÇ!z_şİ^€™ÙRò09P¯É¿×;0;›ªD(ÇêKş->€•ØZEò`åì,ÿ¯ŸÀêl²2yÈîÍ.òÿõÉ\0ìÄV+•ÇÍÜ€ÙnåòØ5@#ÛåaÜq\0øb#ò‡<š«\0² \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B\0\0\n	\0\0($\0\0 \0\0€B†é9öKK*\0\0\0\0IEND®B`‚'),
(11,'‰PNG\r\n\Z\n\0\0\0\rIHDR\0\0\0\0\0\0\0\0\0ôxÔú\0\0\ruIDATx^íÖË²ÛH@ÿÿO{¢gÑ˜”¨«\"YEdFœW¶…\"ğë7\0PçWş\0ğ|\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0»~ıú5ÍcyUğ0YœO=à;^L&‹Î}~À{^\näæ<à^|!æ‰7‹ü{}s€\0?–¥2Ó5ÈóOZI?üK–Ã]Çwòÿó\'O\'åğ{LaüuÌ-¯#O%İTËıOµäïwôài¤š\nù1u¬/ÓOV&Á<Z~°ü%sñê`E’ËcåGúİAÊŒ¼:XÔòùA>zğNfæ“ƒYI\'İ½ƒQ2[ïf#•,/?´[gÈœ½;˜‰D²¬ü¸îœ-3÷î`’Èròcš³ÈlnÜEúXJ~<ó`6™Ñ­ƒ;HKÈæÖÁÌ2¯yp5©czù¡ôÑde™á<¸Š´1µü8úHò™iùæj’ÆÔòÃèÉ“d®å›+I\ZSóa¤Aæ\\æ¹‚t15C\ZdÎóà’ÅÔ|i‘Y—{Î&YLÍ‡F™{ùçÅÔ|\0i”¹—Î QLÍV™}ùg4‰bj>€4“Î$QLÍf™o€‘¤‰éùøÑ*Ëß;`$I˜X–¿À(’09€3HÀä\0Î I\0“3\08ƒ$LÎ\0à’09€3HÀä\0Î I\0“3\08ƒ$LÎ\0à’09€3HÀä\0Î I\0Ëò7\0E’\0&•Åo\00’$L*‹_ù3’4LJùs&‰˜P–¿Àh0™,~åÏ¤\n`\"YüÊŸ³HÀ$²ø\r\0Î$Y\0ÈÒWşœMº\0n–¥¯ü¹‚„Ü(K_ùs)¸I–¾òçJ’p“,~€+I\ZÀ\r²ô?W“8€‹eñ\0ÜAâ\0.eŸW“:€“eÙ+~f }\0\'ÊÂÏƒ»HÀ	²è·î$\0eÉçÁ,¤`,û<˜‰D|)‹~ë`6R	ğCYòy03	øPıÖÁì¤à ,ù½ƒH*À,öW«‘Z€\rYğ{«’^€ßÇ_ñóRTËbwğÒTÊbß;x*éêdÉï<™„•…~ä …´”Åşê ‘ä‘Å~ä •ôËËR?zĞÌ\0–”eşê€?yÀ²Ô°Íë\0¦–…şî€c¼`*YèŸpœÜ&üÓ~Î.—E~ô€q¼(àtYäŸ0—œ*ËüÈçóÒ€¡²Ìp=/\"Kıİ÷ò\nd‘rÀ<¼Hà°,ôO˜‹W	¼•e~ä€¹y¥À²Ì?9`\r^+ğ·,óW¬Í+ş(÷W<ƒ×¥²Øßğ,^5”Ébß;àÙ¼r(’%¿wÀóyéP\"K~ë€^<”È²WúĞÍë‡YüÊºù@‰,C\0ºyùP$‹?èáÅC™,ı­ÏK‡RYú[<—å²ô·x/ø¿,ı<àY¼jàoYúyÀsxÑÀ®\0†\0<‡—ìÊâÏÖå/eéï°¯8,Kë€5x­ÀG²ğ_0//ø‘,û½æäu_ËÒß;`^$0T–şÖ÷óSdé¿:àz^pš,úw\\Ç‹.‘e¿wÀ5¼6àrYú[œË+n•Å¿uÀx^p»,ü­Æòª€idé¿:à;^0¥,ü½~Æë¦•eÿê€Ïx5ÀÔ²èßpŒ×,)‹?xÍ+–•¥¿uÀ6¯X^–şÖÿåU\0‘¥¿w€\0<PşÖA;¯\0x¬,ı½ƒF’<^şÖA©jdéçA‰ªdéï<”µ²ô·JºjYø{O#Õ\0¿\rx‰Øåoğ4’°#‹ßàI¤à…,ş<X•ôÅŸ«‘Z€ƒ²ôó`%ğ¡,ş­ƒÙI)ÀeéoÌJ:¾…¿u0#ÉøRşÖÁl¤`°,C€I#À	²ø\0f#‰\0\'Éâ7˜‰œ,Ëß`Òp,ş<¸šÔ\\$K?®$q\0ÊÒÏƒ«HÀM²ü\0®$i\07Êò7¸Š”Ü,Ëßà\nÒ0,~#€³IÀ$²ø\r\0Î$Y\0“1\0¸‚dL&€!À$\n`BYş†\0£IÀ¤²ø\0F’\"€‰eñ\0Œ\"E\00\0MŠ\0Àà[Ò°€,~€oIÀ\"²ü\r\0¾!=\01\0Ez\0b\00Šô\0,Ä\0`éXˆÀ(Ò°€Q¤`!\0£HÀB\0F‘€…\0Œ\"=\01\0Ez\0b\00Šô\0,Ä\0`éXˆÀ(Ò°ˆ,€oHÀ²ø\r\0¾%=\0Èâ7\0ø–ô\0L.K_ñ3‚L,‹ß\0`)˜T–¾ÀHR0©,}åÏH’0¡,}ÅÏh0™,~€3HÀ$²ğ•?g’*€	dá+Î&Y\07ËÂWş\\Aº\0n’e¯ø¹’”Ü _ùs5I¸@–üŞÁU¤\ràdYò[W“:€eÑçÁ]¤àYô{w‘>€²àó`Òğ¥,ù½ƒ™H$À‡²ØÌF*ÊRw03	x#‹ıİÁ\n$`C–ú»ƒÕH-À¿d±ï¬NŠ~/~åÏSH2P%ËüèÁÓHõ|`à\ZùÖ<™„ß(?6>80V¾¯£\r$ıFùÑÙ;àµ|3?=h\"ñ7ËĞ‘ƒfù~r€0…ü8}rğt™ùŸğ_^Ådò£5ê`™Ë+ØæuL.?fw|#ótÆŸñj”¾^™…+ø—´¸ü0®vìËÿ«öÆòªJäÇÔİwí¿0¯‘·òîÜO˜‹WÉù±w]¬ÇËåVY$îŸ8“¯\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€B\0\02\0\0 \0\0…\0\0(d\0\0@!\0\0\n\0\0PÈ\0\0€BÿÊœ2Æ*ğ£\0\0\0\0IEND®B`‚');
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
(2,1,'Ãllat'),
(2,2,'Animal'),
(1,2,'Number'),
(1,1,'SzÃ¡m');
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
