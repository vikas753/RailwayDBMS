CREATE DATABASE  IF NOT EXISTS `railway dbms` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `railway dbms`;
-- MySQL dump 10.13  Distrib 8.0.20, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: railway dbms
-- ------------------------------------------------------
-- Server version	8.0.20

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
-- Table structure for table `daily_station_train_schedule`
--

DROP TABLE IF EXISTS `daily_station_train_schedule`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `daily_station_train_schedule` (
  `schedule_id` int NOT NULL AUTO_INCREMENT,
  `station_id` int NOT NULL,
  `train_id` int NOT NULL,
  `time_of_arrival` varchar(20) NOT NULL,
  `time_of_departure` varchar(20) NOT NULL,
  `sequence_number` int NOT NULL,
  PRIMARY KEY (`schedule_id`),
  KEY `station_id` (`station_id`),
  KEY `train_id` (`train_id`),
  CONSTRAINT `daily_station_train_schedule_ibfk_1` FOREIGN KEY (`station_id`) REFERENCES `stations` (`station_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `daily_station_train_schedule_ibfk_2` FOREIGN KEY (`train_id`) REFERENCES `trains` (`train_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `daily_station_train_schedule`
--

LOCK TABLES `daily_station_train_schedule` WRITE;
/*!40000 ALTER TABLE `daily_station_train_schedule` DISABLE KEYS */;
INSERT INTO `daily_station_train_schedule` VALUES (1,1,1,'13:00','13:10',1),(2,8,1,'14:00','14:10',2),(3,9,1,'18:00','18:20',3),(4,2,1,'20:00','20:30',4),(5,1,2,'13:00','13:10',1),(6,4,2,'14:00','14:10',2),(7,5,2,'18:00','18:20',3),(8,1,3,'13:00','13:10',1),(9,8,3,'15:00','15:10',2),(10,1,4,'13:00','13:10',1),(11,10,4,'14:30','15:10',2),(12,1,5,'13:00','13:10',1),(13,4,5,'14:30','15:10',2),(14,3,5,'20:30','21:10',3),(15,1,6,'13:00','13:10',1),(16,4,6,'14:30','15:10',2),(17,5,6,'18:30','19:10',3),(18,1,7,'13:00','13:10',1),(19,4,7,'14:30','15:10',2),(20,5,7,'18:30','19:10',3),(21,14,7,'21:30','21:40',4),(22,15,7,'23:30','23:40',5),(26,1,9,'13:00','13:10',1),(27,1,10,'13:00','13:10',1),(28,3,10,'18:30','19:10',2),(29,13,10,'21:30','21:40',3),(30,1,11,'13:00','13:10',1),(31,2,11,'18:30','19:10',2),(32,12,11,'21:30','21:40',3),(33,1,12,'13:00','13:10',1),(34,3,12,'18:30','19:10',2),(35,7,12,'21:30','21:40',3),(36,1,13,'13:00','13:10',1),(37,4,13,'18:30','19:10',2),(38,6,13,'21:30','21:40',3);
/*!40000 ALTER TABLE `daily_station_train_schedule` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `passenger`
--

DROP TABLE IF EXISTS `passenger`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `passenger` (
  `passenger_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `email_id` varchar(100) NOT NULL,
  `secret_key` varchar(45) NOT NULL,
  PRIMARY KEY (`passenger_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `passenger`
--

LOCK TABLES `passenger` WRITE;
/*!40000 ALTER TABLE `passenger` DISABLE KEYS */;
INSERT INTO `passenger` VALUES (1,'Vikas V','vvikas1996@gmail.com','12345678'),(2,'Vykuntham V','vaiku213@gmail.com','12345678'),(3,'vikas2','abcd@gmail.com','12345678');
/*!40000 ALTER TABLE `passenger` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `passenger_train`
--

DROP TABLE IF EXISTS `passenger_train`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `passenger_train` (
  `passenger_train_id` int NOT NULL AUTO_INCREMENT,
  `passenger_id` int NOT NULL,
  `boarding_station_id` int NOT NULL,
  `train_id` int NOT NULL,
  `destination_station_id` int NOT NULL,
  `num_seats` int NOT NULL,
  `Day` varchar(45) NOT NULL,
  PRIMARY KEY (`passenger_train_id`),
  KEY `passenger_id` (`passenger_id`),
  KEY `boarding_station_id` (`boarding_station_id`),
  KEY `destination_station_id` (`destination_station_id`),
  KEY `train_id` (`train_id`),
  CONSTRAINT `passenger_train_ibfk_1` FOREIGN KEY (`passenger_id`) REFERENCES `passenger` (`passenger_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `passenger_train_ibfk_2` FOREIGN KEY (`boarding_station_id`) REFERENCES `stations` (`station_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `passenger_train_ibfk_3` FOREIGN KEY (`destination_station_id`) REFERENCES `stations` (`station_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `passenger_train_ibfk_4` FOREIGN KEY (`train_id`) REFERENCES `trains` (`train_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `passenger_train`
--

LOCK TABLES `passenger_train` WRITE;
/*!40000 ALTER TABLE `passenger_train` DISABLE KEYS */;
INSERT INTO `passenger_train` VALUES (4,1,1,6,5,5,'Mon'),(6,1,1,3,8,23,'Sun'),(7,2,1,5,3,30,'Tue'),(9,3,1,7,14,45,'Wed'),(10,3,1,13,6,30,'Thu'),(11,3,4,2,5,13,'Fri');
/*!40000 ALTER TABLE `passenger_train` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `stations`
--

DROP TABLE IF EXISTS `stations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `stations` (
  `station_id` int NOT NULL AUTO_INCREMENT,
  `station_name` varchar(100) NOT NULL,
  PRIMARY KEY (`station_id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `stations`
--

LOCK TABLES `stations` WRITE;
/*!40000 ALTER TABLE `stations` DISABLE KEYS */;
INSERT INTO `stations` VALUES (1,'Mumbai'),(2,'Delhi'),(3,'Bengaluru'),(4,'Pune'),(5,'Hyderabad'),(6,'Kolkata'),(7,'Chennai'),(8,'Ahmedabad'),(9,'Jaipur'),(10,'Surat'),(11,'Warangal'),(12,'Benaras'),(13,'Kochi'),(14,'Vijaywada'),(15,'Bhubaneshwar');
/*!40000 ALTER TABLE `stations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `trains`
--

DROP TABLE IF EXISTS `trains`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `trains` (
  `train_id` int NOT NULL AUTO_INCREMENT,
  `train_name` varchar(100) NOT NULL,
  PRIMARY KEY (`train_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `trains`
--

LOCK TABLES `trains` WRITE;
/*!40000 ALTER TABLE `trains` DISABLE KEYS */;
INSERT INTO `trains` VALUES (1,'Rajasthan Express'),(2,'LTT Duronto Express'),(3,'Karnavati Express'),(4,'Flying Rani Express'),(5,'Udyan Express'),(6,'Hussain Sagar Express'),(7,'Konark Express'),(8,'Coromandel Express'),(9,'Matsyagandha Express'),(10,'Konkankanya Express'),(11,'Kashi Express'),(12,'Chennai Express'),(13,'Geetanjali Express');
/*!40000 ALTER TABLE `trains` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `weekly_availability_seats`
--

DROP TABLE IF EXISTS `weekly_availability_seats`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `weekly_availability_seats` (
  `train_id` int NOT NULL,
  `Mon` int NOT NULL,
  `Tue` int NOT NULL,
  `Wed` int NOT NULL,
  `Thu` int NOT NULL,
  `Fri` int NOT NULL,
  `Sat` int NOT NULL,
  `Sun` int NOT NULL,
  KEY `train_id` (`train_id`),
  CONSTRAINT `weekly_availability_seats_ibfk_1` FOREIGN KEY (`train_id`) REFERENCES `trains` (`train_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `weekly_availability_seats`
--

LOCK TABLES `weekly_availability_seats` WRITE;
/*!40000 ALTER TABLE `weekly_availability_seats` DISABLE KEYS */;
INSERT INTO `weekly_availability_seats` VALUES (1,30,31,40,0,0,50,50),(2,0,0,0,0,85,0,100),(3,96,100,100,100,100,100,77),(4,100,100,100,100,100,100,100),(5,100,70,100,1001,100,100,100),(6,95,100,100,100,100,100,100),(7,100,100,55,100,100,100,100),(8,100,100,100,100,100,100,100),(9,100,100,100,100,100,100,100),(10,100,100,100,100,100,100,100),(11,100,100,100,100,100,100,100),(12,100,100,100,100,100,100,100),(13,100,1001,100,70,100,100,100);
/*!40000 ALTER TABLE `weekly_availability_seats` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'railway dbms'
--

--
-- Dumping routines for database 'railway dbms'
--
/*!50003 DROP PROCEDURE IF EXISTS `display_tickets` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `display_tickets`(
  email_id_arg   VARCHAR(100)
)
BEGIN
  DECLARE passenger_id_local INT;
  SELECT passenger_id INTO passenger_id_local FROM passenger WHERE email_id = email_id_arg;
  SELECT passenger_train_id,boarding_station_table.boarding_station_name,destination_station_table.destination_station_name,
  train_table.train_name,num_seats,`Day` FROM passenger_train INNER JOIN 
  (SELECT train_id,train_name FROM trains) as train_table ON passenger_train.train_id = train_table.train_id INNER JOIN 
  (SELECT station_id,station_name as boarding_station_name FROM stations) as boarding_station_table ON passenger_train.boarding_station_id = boarding_station_table.station_id INNER JOIN 
  (SELECT station_id,station_name as destination_station_name FROM stations) as destination_station_table ON passenger_train.destination_station_id = destination_station_table.station_id 
    WHERE passenger_id = passenger_id_local;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `display_trains` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `display_trains`(
  boarding_station_id INT,
  arrival_station_id INT
)
BEGIN
  SELECT week_availability.train_id,train_name,boarding_time,arrival_time,Mon,Tue,Wed,Thu,Fri,Sat,Sun FROM
  (SELECT train_time_table.train_id,train_name,boarding_time,arrival_time FROM 
  (SELECT board_train_id as train_id,boarding_station_table.time_of_arrival as boarding_time,arrival_station_table.time_of_arrival as arrival_time FROM
  (SELECT train_id as board_train_id,time_of_arrival,time_of_departure,sequence_number as board_seq_num FROM daily_station_train_schedule
  WHERE station_id = boarding_station_id) as boarding_station_table 
  INNER JOIN
  (SELECT train_id as arrival_train_id,time_of_arrival,time_of_departure,sequence_number as arr_seq_num FROM daily_station_train_schedule
  WHERE station_id = arrival_station_id) as arrival_station_table 
  ON (board_seq_num < arr_seq_num) and (board_train_id = arrival_train_id)) as train_time_table
  INNER JOIN
  (SELECT train_id,train_name FROM trains) as train_name ON train_time_table.train_id = train_name.train_id) as named_train_table
  INNER JOIN
  (SELECT train_id,Mon,Tue,Wed,Thu,Fri,Sat,Sun FROM weekly_availability_seats) as week_availability
  ON week_availability.train_id = named_train_table.train_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_records` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_records`(
  train_id INT,
  boarding_station_id INT,
  arrival_station_id INT,
  num_seats         INT,
  day_week       VARCHAR(45),
  email_id_arg   VARCHAR(100)
)
BEGIN
  DECLARE passenger_id_local INT;
  SELECT passenger_id INTO passenger_id_local FROM passenger WHERE email_id = email_id_arg;
  INSERT INTO passenger_train 
  (passenger_id,boarding_station_id,train_id,destination_station_id,num_seats,`Day`)
  VALUES (passenger_id_local,boarding_station_id,train_id,arrival_station_id,num_seats,day_week);
END ;;
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

-- Dump completed on 2020-06-21 12:49:27
