/*******************************************************************************
   Drop database if it exists
********************************************************************************/
DROP DATABASE IF EXISTS `Railway DBMS`;

/*******************************************************************************
   Create database for Railway Database Project
********************************************************************************/
CREATE DATABASE `Railway DBMS`;

USE `Railway DBMS`;

CREATE TABLE IF NOT EXISTS stations(
  `station_id` INT NOT NULL auto_increment,
  `station_name` VARCHAR(100) NOT NULL ,
   PRIMARY KEY(station_id)
   );

CREATE TABLE IF NOT EXISTS trains(
  `train_id` INT NOT NULL auto_increment,
  `train_name` VARCHAR(100) NOT NULL ,
   PRIMARY KEY(train_id)
   );

CREATE TABLE IF NOT EXISTS weekly_availability_seats(
  `train_id` INT NOT NULL,
  `Mon` INT NOT NULL ,
  `Tue` INT NOT NULL ,
  `Wed` INT NOT NULL ,
  `Thu` INT NOT NULL ,
  `Fri` INT NOT NULL ,
  `Sat` INT NOT NULL ,
  `Sun` INT NOT NULL ,
   FOREIGN KEY(`train_id`) REFERENCES trains(`train_id`)
   ON UPDATE RESTRICT ON DELETE RESTRICT
);
 
 CREATE TABLE IF NOT EXISTS passenger(
  `passenger_id` INT NOT NULL auto_increment,
  `passenger_name` VARCHAR(100) NOT NULL ,
  `passenger_email_id` VARCHAR(100) NOT NULL ,
   PRIMARY KEY(`passenger_id`)
   );

CREATE TABLE IF NOT EXISTS daily_station_train_schedule(
  `schedule_id` INT NOT NULL auto_increment,
  `station_id` INT NOT NULL,
  `train_id` INT NOT NULL,
  `time_of_arrival` VARCHAR(20) NOT NULL ,
  `time_of_departure` VARCHAR(20) NOT NULL ,
  `sequence_number` INT NOT NULL,
   PRIMARY KEY(schedule_id),
   FOREIGN KEY(`station_id`) REFERENCES stations(`station_id`)
   ON UPDATE RESTRICT ON DELETE RESTRICT,
   FOREIGN KEY(`train_id`) REFERENCES trains(`train_id`)
   ON UPDATE RESTRICT ON DELETE RESTRICT
   );
   
 CREATE TABLE IF NOT EXISTS passenger_train(
  `passenger_train_id` INT NOT NULL auto_increment, 
  `passenger_id` INT NOT NULL,
  `boarding_station_id` INT NOT NULL,
  `train_id` INT NOT NULL,
  `destination_station_id` INT NOT NULL,
   PRIMARY KEY(`passenger_train_id`),
   FOREIGN KEY(`passenger_id`) REFERENCES passenger(`passenger_id`)
   ON UPDATE RESTRICT ON DELETE RESTRICT,
   FOREIGN KEY(`boarding_station_id`) REFERENCES stations(`station_id`)
   ON UPDATE RESTRICT ON DELETE RESTRICT,
   FOREIGN KEY(`destination_station_id`) REFERENCES stations(`station_id`)
   ON UPDATE RESTRICT ON DELETE RESTRICT,
   FOREIGN KEY(`train_id`) REFERENCES trains(`train_id`)
   ON UPDATE RESTRICT ON DELETE RESTRICT
   );
   
 
 
   
      
   