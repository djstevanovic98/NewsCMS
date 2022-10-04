-- MySQL dump 10.13  Distrib 8.0.25, for Win64 (x86_64)
--
-- Host: localhost    Database: posts_schema
-- ------------------------------------------------------
-- Server version	8.0.25

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
-- Table structure for table `posts`
--

DROP TABLE IF EXISTS `posts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `posts` (
  `id` int NOT NULL AUTO_INCREMENT,
  `author` text NOT NULL,
  `title` text NOT NULL,
  `quote` text NOT NULL,
  `date` text NOT NULL,
  `brojposeta` int NOT NULL,
  `like` int NOT NULL,
  `dislike` int NOT NULL,
  `tag` text NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `posts_id_uindex` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `posts`
--

LOCK TABLES `posts` WRITE;
/*!40000 ALTER TABLE `posts` DISABLE KEYS */;
INSERT INTO `posts` VALUES (4,'sdada','dsdad','Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.','Sat May 22 19:05:51 CEST 2021',6,2,1,'lorem,tekst'),(8,'Ja sam','NoviPost','Probajedan','Tue Aug 31 12:33:43 CEST 2021',0,0,0,'sport,gluma'),(9,'Nikola','dodajemdo10','Puno pricam','Sun Sep 05 23:46:07 CEST 2021',3,0,0,'lorem,tekst'),(10,'sdasd','ovo je post','dasdadada','Sun Sep 05 23:46:15 CEST 2021',4,0,0,'lorem,tekst'),(11,'lose','najbolje','dobro','Sun Sep 05 23:46:23 CEST 2021',0,0,0,'tag,faks'),(12,'gore','gore','gore','Sun Sep 05 23:46:29 CEST 2021',5,5,0,'tag,faks'),(13,'hohoho','ohoho','hehehe\n','Sun Sep 05 23:46:45 CEST 2021',0,3,0,'sport,faks'),(15,'adad','ovo je post','ovo je quote','Mon Sep 06 12:26:31 CEST 2021',24,2,2,'tag,sport'),(16,'Ja sam','Najnoviji','ti si','Wed Sep 08 15:31:01 CEST 2021',12,10,0,'faks,lorem'),(17,'Novak Djokovic','Nole','Novak Djokovic is a Serbian professional tennis player. He is currently ranked as world No. 1 by the Association of Tennis Professionals. Djokovic has been No. 1 for a record total of 337 weeks, and has finished as ATP year-end No. 1 on a joint-record six occasions.','Wed Sep 08 15:31:51 CEST 2021',10,6,2,'sport,nole'),(18,'Djordje','Novak Najbolji','Djokovic had another career year in 2015, reaching fifteen consecutive finals, including all four major finals and eight Masters finals, winning three majors and a season-record of six Masters events as well as the ATP Finals. The following year, he won the 2016 French Open to complete the non-calendar year Grand Slam and the career Grand Slam.','Wed Sep 08 15:33:17 CEST 2021',0,2,0,'nole,sport'),(19,'sdasd','Donald Trump','Donald John Trump (born June 14, 1946) is an American politician, businessman and media personality who served as the 45th president of the United States from 2017 to 2021.','Wed Sep 08 15:34:59 CEST 2021',11,3,0,'politika,trump'),(20,'biden','Joe Biden','At age 29, President Biden became one of the youngest people ever elected to the United States Senate. Just weeks after his Senate election, tragedy struck the Biden family when his wife Neilia and daughter Naomi were killed, and sons Hunter and Beau were critically injured, in an auto accident.','Wed Sep 08 15:36:13 CEST 2021',0,1,0,'politika,trump'),(21,'Obema nama','Obama','During Obama\'s terms as president, the United States\' reputation abroad, as well as the American economy, significantly improved.[4] Obama\'s presidency has generally been regarded favorably, and evaluations of his presidency among historians, political scientists, and the general public frequently place him among the upper tier of American presidents.','Wed Sep 08 15:37:44 CEST 2021',0,1,2,'politika,trump'),(22,'Andjela','Glumica','Angelina Jolie DCMG is an American actress, filmmaker, and humanitarian. The recipient of numerous accolades, including an Academy Award and three Golden','Wed Sep 08 15:41:09 CEST 2021',0,2,4,'gluma,moda'),(23,'andjela','Andjelina dzoli','Angelina Jolie DCMG is an American actress, filmmaker, and humanitarian. The recipient of numerous accolades, including an Academy Award and three Golden','Wed Sep 08 15:41:36 CEST 2021',0,0,0,'moda,gluma'),(24,'bred','Bred pit','Bred pit DCMG is an American actress, filmmaker, and humanitarian. The recipient of numerous accolades, including an Academy Award and three Golden','Wed Sep 08 15:42:10 CEST 2021',0,1,0,'gluma,moda'),(25,'milan','Milan lane','Milan Jolie DCMG is an American actress, filmmaker, and humanitarian. The recipient of numerous accolades, including an Academy Award and three Golden','Wed Sep 08 15:42:42 CEST 2021',0,0,0,'gluma, moda'),(26,'Carl','Car racing','Auto racing has existed since the invention of the automobile. Races of various sorts were organised, with the first recorded as early as 1867. Many of the earliest events were effectively reliability trials, aimed at proving these new machines','Wed Sep 08 15:43:46 CEST 2021',0,3,2,'trke,brzina'),(27,'kola','kola','Auto racing has existed since the invention of the automobile. Races of various sorts were organised, with the first recorded as early as 1867. Many of the earliest events were effectively reliability trials, aimed at proving these new machines','Wed Sep 08 15:44:04 CEST 2021',0,0,0,'brzina,trke'),(28,'sda','sda trkanje moda','Auto racing has existed since the invention of the automobile. Races of various sorts were organised, with the first recorded as early as 1867. Many of the earliest events were effectively reliability trials, aimed at proving these new machines','Wed Sep 08 15:44:32 CEST 2021',0,0,0,'trka,moda'),(29,'igor','trkanje faks','Auto racing has existed since the invention of the automobile. Races of various sorts were organised, with the first recorded as early as 1867. Many of the earliest events were effectively reliability trials, aimed at proving these new machines','Wed Sep 08 15:44:56 CEST 2021',0,0,0,'trka,faks');
/*!40000 ALTER TABLE `posts` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-09-08 15:47:40
