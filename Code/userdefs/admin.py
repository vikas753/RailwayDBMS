##################################################################
#  Admin class : Functionalities like adding trains , stations and 
#               their schedules are done by this class
#
##################################################################

import csv
import mysql.connector
from mysql.connector import Error

class admin_object:
    def __init__(self,database_cursor,connection):
        username   = input(" Please enter the admin credentials , username ? : ")
        secret_key = input(" Please enter the admin credentials , secret_key ? : ")
        self.database_cursor = database_cursor
        self.connection = connection
        if username == "root" and secret_key == "root":
            print(" Admin authorised successfully ")
            self.main_function()
        else:
            print(" Invalid credentials for admin , exiting the program")        
    
    def main_function(self):    
        print(" Please find the functions that admin can perform ")
        typeof_function = input(" 1 . Add a station , 2 . Add a train : ")        
        if typeof_function == '1':
            self.add_station()
        elif typeof_function == '2':
            self.add_train()
        else:
        # go back to main function and try the process again for incorrect input entered
            print(" Incorrect Code Entered ! ")
            
        admin_continuation = input(" Do you want to continue with services of admin ? - Yes or No : ")
        if admin_continuation == "Yes":
            self.main_function()
        else:
            print(" Thanks for using the services!")
   
    # Ask user for a station as an input , check it's existence in station table and add it .      
    def add_station(self):
        station_name_input = input(" Please enter the station name to be added : ")
        sql_command_check_station_name = " SELECT 1 FROM stations  WHERE station_name = '" + station_name_input + "'"
        self.database_cursor.execute(sql_command_check_station_name)
        check_station_name = self.database_cursor.fetchone() 
        if check_station_name:
            print(" Station Name : " , station_name_input , "already exists")
        else:
            sql_command_insert_station_name = " INSERT INTO stations(station_name) VALUES ('"+station_name_input+"')"
            self.database_cursor.execute(sql_command_insert_station_name)
            self.connection.commit()            
            print("Station Name :" , station_name_input,"added successfully")         
    
    # Add a train based on it's check in the db 
    # Train name is checked for duplication and added 
    def add_train(self):
        train_name_input = input(" Please enter the train name to be added : ")
        sql_command_check_train_name = " SELECT 1 FROM trains  WHERE train_name = '" + train_name_input + "'"
        self.database_cursor.execute(sql_command_check_train_name)
        check_train_name = self.database_cursor.fetchone()        
        if check_train_name:
            print("Train name already exists!")
        else:
            sql_command_insert_train_name = " INSERT INTO trains(train_name) VALUES ('"+train_name_input+"')" 
            self.database_cursor.execute(sql_command_insert_train_name)
            self.connection.commit()
            print("Train Name :" , train_name_input,"added successfully")
            self.prompt_schedule_csv_parse_and_add(train_name_input)    
       
    # Add weekly availability for trains here  
    # It requests a CSV in a specified format , which is parsed and update into schedule table    
    def prompt_schedule_csv_parse_and_add(self,train_name_input):
        sql_command_get_train_id = " SELECT train_id FROM trains  WHERE train_name = '" + train_name_input + "'"
        self.database_cursor.execute(sql_command_get_train_id)
        train_id = self.database_cursor.fetchone()
        num_seats_monday = input(" Weekly Availability - Please enter the number of seats available for train on Monday : ")
        num_seats_tuesday = input(" Weekly Availability - Please enter the number of seats available for train on Tuesday : ")        
        num_seats_wednesday = input(" Weekly Availability - Please enter the number of seats available for train on Wednesday : ")
        num_seats_thursday = input(" Weekly Availability - Please enter the number of seats available for train on Thursday : ")
        num_seats_friday = input(" Weekly Availability - Please enter the number of seats available for train on Friday : ")
        num_seats_saturday = input(" Weekly Availability - Please enter the number of seats available for train on saturday : ")
        num_seats_sunday = input(" Weekly Availability - Please enter the number of seats available for train on sunday : ")
        sql_command_insert_week_availability = "INSERT INTO weekly_availability_seats(train_id,Mon,Tue,Wed,Thu,Fri,Sat,Sun) VALUES ('"+str(train_id[0])+"','"+num_seats_monday+"','"+num_seats_tuesday+"','"+num_seats_wednesday+"','"+num_seats_thursday+"','"+num_seats_friday+"','"+num_seats_saturday+"','"+num_seats_sunday+"')";
        self.database_cursor.execute(sql_command_insert_week_availability)
        self.connection.commit()
        
        daily_schedule_csvfile = input(" Please provide csv file that contains schedule for this train :")
        with open(daily_schedule_csvfile, 'r') as csvfile: 
            csvreader = csv.reader(csvfile)
            commit = 1
            for row in csvreader:
                station_name = row[0]
                time_of_arrival = row[1]
                time_of_departure = row[2]
                sequence_number   = row[3]
                sql_command_get_station_id = " SELECT station_id FROM stations  WHERE station_name = '" + station_name + "'"
                self.database_cursor.execute(sql_command_get_station_id)
                station_id_tuple = self.database_cursor.fetchone()
                if station_id_tuple:
                    station_id = station_id_tuple[0]
                    sql_command_insert_day_sched = "INSERT INTO daily_station_train_schedule(station_id,train_id,time_of_arrival,time_of_departure,sequence_number) VALUES ('"+str(station_id)+"','"+str(train_id[0])+"','"+time_of_arrival+"','"+time_of_departure+"','"+str(sequence_number)+"')";
                    self.database_cursor.execute(sql_command_insert_day_sched)
                else:
                    print(" Incorrect station encountered in schedule : " , row[0])
                    commit = 0
                    break                
            if commit == 1:
                print(" Schedule Updated Succesfully ! " )
                self.connection.commit()
                    
                    