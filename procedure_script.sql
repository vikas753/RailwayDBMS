USE `railway dbms`;

DELIMITER $$

CREATE PROCEDURE display_trains
(
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
END $$

DELIMITER ;

CALL display_trains(1,8);

DELIMITER $$

CREATE PROCEDURE insert_records
(
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
END $$

DELIMITER ;

DELIMITER $$

CREATE PROCEDURE display_tickets
(
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
END $$

DELIMITER ;

CALL display_tickets("vvikas1996@gmail.com");

