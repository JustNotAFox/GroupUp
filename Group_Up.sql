-- MySQL dump 10.13  Distrib 5.7.20, for Linux (x86_64)
--
-- Host: localhost    Database: Group_Up
-- ------------------------------------------------------
-- Server version	5.7.20-0ubuntu0.16.04.1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `Channel_users`
--

DROP TABLE IF EXISTS `Channel_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Channel_users` (
  `channel_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `role` int(2) DEFAULT '2',
  PRIMARY KEY (`channel_id`,`user_id`),
  KEY `user_id` (`user_id`),
  CONSTRAINT `Channel_users_ibfk_1` FOREIGN KEY (`channel_id`) REFERENCES `Groupchannel` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `Channel_users_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `User` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Channel_users`
--

LOCK TABLES `Channel_users` WRITE;
/*!40000 ALTER TABLE `Channel_users` DISABLE KEYS */;
INSERT INTO `Channel_users` VALUES (1,4,2),(1,5,2),(1,6,2),(1,9,2),(1,16,2),(1,17,2),(1,18,2),(1,19,2),(1,20,2),(1,24,2),(1,25,2),(1,26,2),(1,27,2),(1,28,2),(1,29,2),(1,30,2),(1,31,2),(1,32,2),(1,33,2),(1,34,2),(1,35,2),(1,36,2),(1,37,2),(1,38,2),(1,39,2),(1,40,2),(1,41,2),(1,42,2),(1,43,2),(1,44,2),(1,45,2),(1,46,2),(1,47,2),(1,48,2),(1,49,2),(1,50,2),(2,20,2),(2,37,2),(2,41,2),(2,42,2),(2,44,2),(2,45,2),(2,47,2),(3,5,1),(3,9,1),(3,17,1),(3,20,3),(3,34,1),(3,37,1),(3,41,1),(3,42,2),(3,44,2),(3,46,2),(4,20,3),(4,42,2),(4,43,2),(4,44,2),(5,20,3),(5,43,0),(5,47,2),(6,47,3),(7,47,3),(8,47,3),(9,42,3),(10,43,3),(11,42,3),(12,42,3),(13,42,3),(14,42,3),(15,42,3),(16,44,3),(17,20,3),(17,42,0),(17,43,1),(17,44,1),(17,45,0),(17,46,0),(17,48,1);
/*!40000 ALTER TABLE `Channel_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `Groupchannel`
--

DROP TABLE IF EXISTS `Groupchannel`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `Groupchannel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `private` int(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `Groupchannel`
--

LOCK TABLES `Groupchannel` WRITE;
/*!40000 ALTER TABLE `Groupchannel` DISABLE KEYS */;
INSERT INTO `Groupchannel` VALUES (1,'default',0),(2,'test',0),(3,'testingitout',0),(4,'testing the create button',0),(5,'does it still work',0),(6,'testitagain',0),(7,'testitagain',0),(8,'testitagain',0),(9,'demo user 1 channel',0),(10,'channel name',0),(11,'channel name again',0),(12,'channel name again again',0),(13,'is it working now',0),(14,'does private work',0),(15,'does private work',0),(16,'private again',1),(17,'testing invites',1);
/*!40000 ALTER TABLE `Groupchannel` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `MsgLog`
--

DROP TABLE IF EXISTS `MsgLog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `MsgLog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `channel_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `msg` text,
  `time_stamp` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `channel_id` (`channel_id`,`user_id`),
  CONSTRAINT `MsgLog_ibfk_1` FOREIGN KEY (`channel_id`, `user_id`) REFERENCES `Channel_users` (`channel_id`, `user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=174 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `MsgLog`
--

LOCK TABLES `MsgLog` WRITE;
/*!40000 ALTER TABLE `MsgLog` DISABLE KEYS */;
INSERT INTO `MsgLog` VALUES (1,1,4,'test','2017-11-01 19:53:43'),(2,1,4,'test','2017-11-01 19:55:48'),(3,1,4,'this was a triumph','2017-11-01 19:56:01'),(4,1,24,'test','2017-11-22 01:14:35'),(5,1,24,'test','2017-11-22 01:25:37'),(6,1,26,'test','2017-11-22 17:08:33'),(7,1,26,'test','2017-11-22 17:10:26'),(8,1,26,'test','2017-11-22 17:14:20'),(9,1,26,'test','2017-11-22 17:18:43'),(10,1,26,'test2','2017-11-22 17:27:02'),(11,1,26,'test','2017-11-22 18:04:51'),(12,1,27,'test','2017-11-22 18:05:17'),(13,1,28,'test','2017-11-22 18:16:21'),(14,1,26,'test','2017-11-22 18:27:03'),(15,1,26,'test','2017-11-22 18:27:06'),(16,1,26,'test','2017-11-22 18:27:11'),(17,1,29,'taur test','2017-11-23 01:03:04'),(18,1,20,'rawr','2017-11-23 01:03:07'),(19,1,20,'kk','2017-11-23 01:03:10'),(20,1,20,'I need to fix the chat box clearing itself again','2017-11-23 01:03:21'),(21,1,20,'test','2017-11-23 02:14:40'),(22,1,33,'test','2017-11-25 00:00:29'),(23,1,33,'test23','2017-11-25 00:01:34'),(24,1,20,'test','2017-11-25 00:39:04'),(25,1,20,'test','2017-11-25 00:39:06'),(26,1,20,'test','2017-11-25 00:39:06'),(27,1,20,'test','2017-11-25 00:39:06'),(28,1,20,'test','2017-11-25 00:39:06'),(29,2,20,'test','2017-11-25 00:46:08'),(30,1,35,'s','2017-11-25 01:08:58'),(31,1,37,'da potato moo','2017-11-29 23:35:10'),(32,1,37,'MOO OF THE MAJESTIC POOOTAAAAA TOOOO','2017-11-29 23:35:30'),(33,1,20,'o-o','2017-11-29 23:35:55'),(34,1,38,'test','2017-11-29 23:36:54'),(35,1,37,'TESTEH','2017-11-29 23:37:08'),(36,1,20,'test','2017-11-29 23:40:06'),(37,1,20,'hmmmm','2017-11-29 23:40:10'),(38,1,20,'test','2017-11-29 23:41:32'),(39,1,20,'','2017-11-29 23:41:33'),(40,3,20,'words','2017-11-29 23:44:09'),(41,1,20,'test','2017-12-02 18:32:53'),(42,1,39,'1234','2017-12-02 18:35:29'),(43,1,41,'sah dude','2017-12-02 18:38:49'),(44,1,20,'fg','2017-12-02 18:42:07'),(45,1,20,'','2017-12-02 18:42:07'),(46,1,20,'','2017-12-02 18:42:07'),(47,1,20,'','2017-12-02 18:42:07'),(48,1,20,'','2017-12-02 18:42:08'),(49,1,20,'','2017-12-02 18:42:08'),(50,1,20,'','2017-12-02 18:42:08'),(51,1,20,'','2017-12-02 18:42:08'),(52,1,20,'','2017-12-02 18:42:08'),(53,1,20,'','2017-12-02 18:42:08'),(54,1,41,'t','2017-12-02 19:23:03'),(55,1,41,'t','2017-12-02 19:23:05'),(56,1,41,'t','2017-12-02 19:23:05'),(57,1,41,'t','2017-12-02 19:23:05'),(58,1,41,'t','2017-12-02 19:23:06'),(59,1,41,'t','2017-12-02 19:23:06'),(60,1,41,'t','2017-12-02 19:23:07'),(61,1,41,'t','2017-12-02 19:23:08'),(62,1,41,'t','2017-12-02 19:23:10'),(63,1,41,'t','2017-12-02 19:23:11'),(64,1,41,'t','2017-12-02 19:23:15'),(65,1,41,'t','2017-12-02 19:23:44'),(66,1,41,'t','2017-12-02 19:23:45'),(67,1,41,'t','2017-12-02 19:23:47'),(68,1,41,'t','2017-12-02 19:23:52'),(69,1,41,'t','2017-12-02 19:24:03'),(70,1,41,'t','2017-12-02 19:24:04'),(71,1,41,'t','2017-12-02 19:24:06'),(72,1,41,'t','2017-12-02 19:24:07'),(73,1,41,'t','2017-12-02 19:24:08'),(74,1,41,'t','2017-12-02 19:24:10'),(75,1,41,'t','2017-12-02 19:24:17'),(76,1,41,'y','2017-12-02 19:37:38'),(77,1,41,'y','2017-12-02 19:37:40'),(78,1,41,'y','2017-12-02 19:37:40'),(79,1,41,'y','2017-12-02 19:37:41'),(80,1,41,'y','2017-12-02 19:37:41'),(81,1,41,'y','2017-12-02 19:37:42'),(82,1,41,'y','2017-12-02 19:37:42'),(83,1,41,'y','2017-12-02 19:37:43'),(84,1,41,'y','2017-12-02 19:37:43'),(85,1,41,'y','2017-12-02 19:37:43'),(86,1,41,'y','2017-12-02 19:37:43'),(87,1,41,'y','2017-12-02 19:37:44'),(88,1,41,'y','2017-12-02 19:37:44'),(89,1,41,'y','2017-12-02 19:37:44'),(90,1,41,'y','2017-12-02 19:37:44'),(91,1,41,'y','2017-12-02 19:37:44'),(92,1,41,'y','2017-12-02 19:37:45'),(93,1,20,'test','2017-12-02 19:55:12'),(94,1,20,'','2017-12-02 19:55:13'),(95,1,20,'','2017-12-02 19:55:13'),(96,1,20,'','2017-12-02 19:55:13'),(97,1,20,'test','2017-12-02 19:55:16'),(98,1,20,'test','2017-12-02 19:55:16'),(99,1,20,'ets','2017-12-02 19:55:17'),(100,1,20,'t','2017-12-02 19:57:19'),(101,1,20,'t','2017-12-02 19:57:19'),(102,1,20,'t','2017-12-02 19:57:20'),(103,1,20,'t','2017-12-02 19:57:20'),(104,1,20,'t','2017-12-02 19:57:20'),(105,1,20,'t','2017-12-02 19:57:20'),(106,1,20,'t','2017-12-02 20:00:01'),(107,1,20,'','2017-12-02 20:00:01'),(108,1,20,'','2017-12-02 20:00:01'),(109,1,20,'t','2017-12-02 20:01:28'),(110,1,20,'','2017-12-02 20:01:29'),(111,1,20,'','2017-12-02 20:01:29'),(112,1,20,'','2017-12-02 20:01:29'),(113,1,20,'','2017-12-02 20:01:29'),(114,1,20,'','2017-12-02 20:01:30'),(115,1,20,'','2017-12-02 20:01:30'),(116,1,20,'','2017-12-02 20:01:30'),(117,1,20,'','2017-12-02 20:01:30'),(118,1,20,'','2017-12-02 20:01:30'),(119,1,20,'','2017-12-02 20:01:30'),(120,1,20,'','2017-12-02 20:01:30'),(121,1,20,'','2017-12-02 20:01:30'),(122,1,20,'','2017-12-02 20:01:30'),(123,1,20,'','2017-12-02 20:01:30'),(124,1,20,'','2017-12-02 20:01:30'),(125,1,20,'','2017-12-02 20:01:30'),(126,1,20,'','2017-12-02 20:01:30'),(127,1,20,'','2017-12-02 20:01:31'),(128,1,20,'','2017-12-02 20:01:31'),(129,1,20,'','2017-12-02 20:01:31'),(130,1,20,'','2017-12-02 20:01:31'),(131,1,20,'','2017-12-02 20:01:31'),(132,1,20,'','2017-12-02 20:01:31'),(133,1,20,'','2017-12-02 20:01:31'),(134,1,20,'','2017-12-02 20:01:31'),(135,1,20,'','2017-12-02 20:01:31'),(136,1,20,'','2017-12-02 20:01:31'),(137,1,20,'','2017-12-02 20:01:31'),(138,1,20,'','2017-12-02 20:01:31'),(139,1,20,'','2017-12-02 20:01:31'),(140,1,20,'','2017-12-02 20:01:31'),(141,1,20,'','2017-12-02 20:01:31'),(142,1,20,'','2017-12-02 20:01:31'),(143,1,20,'','2017-12-02 20:01:31'),(144,1,20,'','2017-12-02 20:01:31'),(145,1,20,'','2017-12-02 20:01:31'),(146,1,20,'','2017-12-02 20:01:31'),(147,1,20,'','2017-12-02 20:01:31'),(148,1,20,'','2017-12-02 20:01:31'),(149,1,20,'t','2017-12-02 20:02:06'),(150,1,20,'','2017-12-02 20:02:08'),(151,1,20,'','2017-12-02 20:02:08'),(152,1,20,'','2017-12-02 20:02:08'),(153,1,20,'','2017-12-02 20:02:08'),(154,1,20,'','2017-12-02 20:02:08'),(155,1,20,'','2017-12-02 20:02:08'),(156,1,41,'hello','2017-12-02 20:02:17'),(157,1,41,'420 blaze it','2017-12-02 20:13:42'),(158,1,41,'420','2017-12-02 20:13:46'),(159,1,41,'lit','2017-12-02 20:13:48'),(160,1,41,'buttered','2017-12-02 20:13:51'),(161,1,41,'asdffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffeeeeeeeeeeeeeeeeeeeeeeee','2017-12-02 20:45:49'),(162,1,20,'test','2017-12-04 05:38:20'),(163,3,20,'test','2017-12-04 13:18:22'),(164,3,20,'test','2017-12-04 13:24:33'),(165,4,44,'test','2017-12-04 15:24:00'),(166,1,45,'test','2017-12-04 15:45:30'),(167,17,20,'test','2017-12-04 16:02:28'),(168,1,49,'test','2017-12-04 16:02:43'),(169,17,20,'test','2017-12-04 16:09:18'),(170,2,45,'test','2017-12-04 16:09:24'),(171,5,20,'test','2017-12-04 16:18:21'),(172,1,42,'test','2017-12-04 16:21:32'),(173,4,43,'test','2017-12-04 16:21:40');
/*!40000 ALTER TABLE `MsgLog` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `User`
--

DROP TABLE IF EXISTS `User`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `User` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(30) NOT NULL,
  `password` varchar(256) NOT NULL,
  `dispname` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `User`
--

LOCK TABLES `User` WRITE;
/*!40000 ALTER TABLE `User` DISABLE KEYS */;
INSERT INTO `User` VALUES (4,'name','€1þÛ†_@Þ÷	Ø8*³žV9:3!jØ’|›žõ\\','name'),(5,'test','€*aJ¸›tÂ‘¨O;g¦sæ_áæ“','test'),(6,'test2','€*aJ¸›tÂ‘¨O;g¦sæ_áæ“','test2'),(9,'test4','€*aJ¸›tÂ‘¨O;g¦sæ_áæ“','test4'),(16,'awkward','€1þÛ†_@Þ÷	Ø8*³žV9:3!jØ’|›žõ\\','awkward'),(17,'yolo','€ê6è‚¬\n%ób¿´<I°É¤ÊSœðe ›Õ’­]^','yolo'),(18,'username','€1þÛ†_@Þ÷	Ø8*³žV9:3!jØ’|›žõ\\','username'),(19,'SERVER','€pÅáÜòeê‰‚\'§ÒYA64b\'`+˜):º@«¸b=N˜›{ì','SERVER'),(20,'NotAFox','€ £A€Í´çÁËI_õŒ[','NotAFox'),(21,'NotAFox2','€ £A€Í´çÁËI_õŒ[',NULL),(22,'NotAFox3','€ £A€Í´çÁËI_õŒ[',NULL),(23,'NotAFox4','€ £A€Í´çÁËI_õŒ[','NotAFox4'),(24,'testtest','€E#V†ï‘\n_›ØÂä','testtest'),(25,'testtesttest','€£uÌ›ÔN|','testtesttest'),(26,'sexy','€âÒº!»ˆnG','sexy'),(27,'lolwat','€œæº“–Î\Zk','lolwat'),(28,'rawr','€iÞ¨ljòšˆ','rawr'),(29,'doubletrouble','€LGbaãzåÅ0®\nÊÊ','doubletrouble'),(30,'testestestest','€£uÌ›ÔN|','testestestest'),(31,'sadfasdf','€O|§ò1ÊuÝ¿äAë¿','sadfasdf'),(32,'sadfawefarewf','€fÍr¥É«@*ºt­0öR','sadfawefarewf'),(33,'asdfasdf','€í‘nõÝkÎ¯FEÿ‹<Êí','asdfasdf'),(34,'asdfasdfasdfasdf','€\'\ri(–†Û—)®©â5ê','asdfasdfasdfasdf'),(35,'sdsd','€0+¾}Â),=','sdsd'),(36,'asdfasdfasdfadfawf','€˜V¹0ä=¨¥_iª(Ÿ-','asdfasdfasdfadfawf'),(37,'potato','€kà7›Ü‚W','potato'),(38,'whoopsIforgottologout','€K$›ÿ½ÆP','whoopsIforgottologout'),(39,'1234','€õCQ·Éü/','1234'),(40,'awkwardwat','€ôÊYèÇ','awkwardwat'),(41,'mcgoggles02','€óÈv8¥çÒúX®Luê*ƒ','mcgoggles02'),(42,'Demouser1','€ê–&M\Zí‘sy]ç½?_G','Demouser1'),(43,'Demouser2','€ê–&M\Zí‘sy]ç½?_G','Demouser2'),(44,'Demouser3','€ê–&M\Zí‘sy]ç½?_G','Demouser3'),(45,'Demouser4','€ê–&M\Zí‘sy]ç½?_G','Demouser4'),(46,'Demouser5','€ê–&M\Zí‘sy]ç½?_G','Demouser5'),(47,'thisisauser','€mÏÉÚCŒÓ¸ùÿ>¥“','thisisauser'),(48,'demouser6','€ê–&M\Zí‘sy]ç½?_G','demouser6'),(49,'demouser7','€ê–&M\Zí‘sy]ç½?_G','demouser7'),(50,'wtf','€ê–&M\Zí‘sy]ç½?_G','wtf');
/*!40000 ALTER TABLE `User` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger User_insert_encrypt before Insert on User for each row set new.password = des_encrypt(new.password) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger User_update_encrypt before update on User for each row set new.password = des_encrypt(new.password) */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2017-12-04 11:28:49
