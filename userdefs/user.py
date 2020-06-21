##################################################################
#  User class : Functionalities like book and cancel a ticket 
#               are implemented in this class 
#
##################################################################

import mysql.connector
from mysql.connector import Error
from tabulate import tabulate

class user_object:
    def __init__(self,database_cursor,connection):
        self.main_function(database_cursor,connection)    
    
    # register an user , insert the details onto passenger tables 
    def register_user(self,email_id):
        passenger_name       = input(" Please enter your name : ");
        passenger_secret_key = input(" Please enter the secret key for identification : ");
        sql_command_insert_passenger_details = " INSERT INTO passenger(name,email_id,secret_key) VALUES ('"+passenger_name+"','"+email_id+"','"+passenger_secret_key+"')";
        self.database_cursor.execute(sql_command_insert_passenger_details)
        self.connection.commit()        
    
    # Displays all user services provided for passenger
    def user_services(self,email_id):    
        secret_key_input = input(" Please enter the secret key ! : ")
        sql_command_check_secret_key = " SELECT 1 FROM passenger WHERE email_id = '" + email_id + "' and secret_key = '" + secret_key_input + "'";
        self.database_cursor.execute(sql_command_check_secret_key)
        check_secret_key = self.database_cursor.fetchone()
        if check_secret_key:
            print(" Welcome ! , Please find the functions that user can perform ")
            typeof_function = input(" 1 . Book a seat \n 2 . Display Tickets \n 3 . Cancel Ticket \n Input : ")        
            if typeof_function == '1':
                self.book_seat(email_id)
            elif typeof_function == '2':
                self.display_tickets(email_id)
            elif typeof_function == '3':
                self.cancel_tickets(email_id)
            else:
            # go back to main function and try the process again for incorrect input entered
                print(" Incorrect Code Entered ! ")
        else:
            print(" Invalid Secret Key Entered , please try once more ")
            self.user_services(email_id)        


    # Main function to login or register and invoke the user services
    # Diplay user services or prompt options for a new user to register 
    def main_function(self,database_cursor,connection):                
        email_id_input   = input(" Please enter the email id : ")
        self.database_cursor = database_cursor
        self.connection = connection
        sql_command_check_email_id = " SELECT 1 FROM passenger  WHERE email_id = '" + email_id_input + "'"
        self.database_cursor.execute(sql_command_check_email_id)
        check_email_id = self.database_cursor.fetchone()
        if check_email_id:
            print(" Found your records ! ")
            self.user_services(email_id_input)
        else:
            print(" No Match For Email-Id Provided , please follow registration process below ( your entered email-id would be used as is , in registering ) ! ")
            self.register_user(email_id_input)
            
        admin_continuation = input(" Do you want to continue with any other service of passenger ? - Yes or No : ")
        if admin_continuation == "Yes":
            self.main_function(database_cursor,connection)
        else:
            print(" Thanks for using the services!")
                
    # Book a ticket for an user            
    # Generate available stations from the table
    # Request for boarding and arrival station , sanitise them
    # Display whether trains are available or not 
    # Book a ticket based on user response
    def book_seat(self,email_id):
        sql_command_get_station_names = " SELECT station_name FROM stations "
        self.database_cursor.execute(sql_command_get_station_names)
        result_cursor = self.database_cursor.fetchall()
        print(" Please find available stations : " )
        print(tabulate(result_cursor,headers=['Station Name']))
        boarding_station = input(" Please enter boarding station : ")
        
        sql_command_get_boarding_station_id = " SELECT station_id FROM stations  WHERE station_name = '" + boarding_station + "'"
        self.database_cursor.execute(sql_command_get_boarding_station_id)
        
        boarding_station_id_tuple = self.database_cursor.fetchone()
        
        if boarding_station_id_tuple:
            boarding_station_id = boarding_station_id_tuple[0]
        
            arrival_station = input(" Please enter arrival station : ")
            sql_command_get_arrival_station_id = " SELECT station_id FROM stations  WHERE station_name = '" + arrival_station + "'"
    
            self.database_cursor.execute(sql_command_get_arrival_station_id)
            arrival_station_id_tuple = self.database_cursor.fetchone()
        
            if arrival_station_id_tuple:
                arrival_station_id = arrival_station_id_tuple[0]
                station_details_args = [boarding_station_id,arrival_station_id]
                result = self.database_cursor.callproc("display_trains",station_details_args)
                results_data = [result.fetchall() for result in self.database_cursor.stored_results()]
                if(len(results_data[0]) > 0):
                    print(" Weekly Train Time Table is below for trains between those stations , it also has number of seats for each day ")
                    print(tabulate(results_data[0], headers=['Train Id','Train_Name','Boarding_Time','Arrival_Time','Mon','Tue','Wed','Thu','Fri','Sat','Sun'], tablefmt='psql'))
                    train_id_local_db   = input(" Please enter the train id : " )
                    train_name_local_db = input(" Please enter the train name : " )
                    day_week_local_db   = input(" Please enter the day in that week : " )
                    num_seats_local_db  = input(" Please enter the number of seats : " )
                    sql_command_update_week_sched = "UPDATE weekly_availability_seats SET "+str(day_week_local_db)+"="+ str(day_week_local_db)+"-"+ str(num_seats_local_db)+" WHERE train_id="+str(train_id_local_db)+";"      
                    if self.sanity_check(results_data[0],train_id_local_db,day_week_local_db,num_seats_local_db) > 0:
                        self.database_cursor.execute(sql_command_update_week_sched)
                        insert_records_args = [train_id_local_db,boarding_station_id,arrival_station_id,num_seats_local_db,day_week_local_db,email_id]
                        self.database_cursor.callproc("insert_records",insert_records_args)
                        print(str(num_seats_local_db) + " Tickets Booked on " + str(train_name_local_db) + " for " + str(day_week_local_db))                    
                        self.connection.commit()
                    else:
                        self.book_seat(email_id)                    
                else:
                    print(" No trains available for those stations yet ! ")
            else:
                print(" Incorrect Arrival Station Name ! " );
                self.book_seat(email_id)                            
        else:
            print(" Incorrect Boarding Station Name ! " );
            self.book_seat(email_id)        

    # Display Tickets in tabular format using tabulate module 
    def display_tickets(self,email_id):
        display_tickets_args = [email_id]
        result = self.database_cursor.callproc("display_tickets",display_tickets_args)
        results_data = [result.fetchall() for result in self.database_cursor.stored_results()]
        if(len(results_data[0]) > 0):
            print(" Please find all tickets details and booking history ")
            print(tabulate(results_data[0], headers=['Ticket Id','Boarding Station Name','Destination Station Name','Train_Name','Number of seats','Day'], tablefmt='psql'))
                        
        else:
            print( " No ticket details or booking history found ! ")
        return results_data                

    # Cancel Tickets as provided by user
    # update weekly_availability_seats table and remove the entry from tickets table . 
    def cancel_tickets(self,email_id):       
        results_data = self.display_tickets(email_id)
        ticket_id_local = input(" Please enter the ticket id : ")
        if len(results_data[0]) > 0:
            if self.sanitise_ticket_id(results_data[0],ticket_id_local) == 1:
                sql_command_get_ticket_details = " SELECT train_id,num_seats,Day FROM passenger_train  WHERE passenger_train_id = " + str(ticket_id_local)
                self.database_cursor.execute(sql_command_get_ticket_details)
                ticket_details_tuple = self.database_cursor.fetchone()
                train_id_local  =  ticket_details_tuple[0] 
                num_seats_local =  ticket_details_tuple[1]
                day_week        =  ticket_details_tuple[2]
                sql_command_update_week_schedule  = " UPDATE weekly_availability_seats SET " + str(day_week) + " = " + str(day_week) + " + " + str(num_seats_local) + " WHERE train_id = " + str(train_id_local)
                self.database_cursor.execute(sql_command_update_week_schedule)
                sql_command_delete_week_schedule  = " DELETE FROM passenger_train WHERE passenger_train_id = " + str(ticket_id_local)
                self.database_cursor.execute(sql_command_delete_week_schedule)
                self.connection.commit()
                print( " Ticket has been successfully cancelled ! " )
                
                
    # Perform a sanity on input ticket id to see if it is present in data.    
    def sanitise_ticket_id(self,results,ticket_id):
        for result_row in results:
            if int(result_row[0]) == int(ticket_id):
                return 1
        print("Invalid ticket_id please refer table above for ticket_id column details")        
        return 0        
            
        
    # Performs a sanity check on user provided input and returns an error or non-error code as below
    def sanity_check(self,results_data,train_id,day_week,num_seats):
        for result_row in results_data:
            if int(result_row[0]) == int(train_id):
                final_num_seats = 0
                if day_week == "Mon":
                    final_num_seats = int(result_row[4]) - int(num_seats) 
                elif day_week == "Tue":  
                    final_num_seats = int(result_row[5]) - int(num_seats)                
                elif day_week == "Wed":  
                    final_num_seats = int(result_row[6]) - int(num_seats)                    
                elif day_week == "Thu":  
                    final_num_seats = int(result_row[7]) - int(num_seats)                    
                elif day_week == "Fri":  
                    final_num_seats = int(result_row[8]) - int(num_seats)                    
                elif day_week == "Sat":  
                    final_num_seats = int(result_row[9]) - int(num_seats)
                elif day_week == "Sun":  
                    final_num_seats = int(result_row[10]) - int(num_seats)
                else:
                    print(" Invalid day of week entered !")
                    return 0
                    
                if final_num_seats < 0:
                    print(" Invalid number of seats requested , Overflow !")
                    return 0
                else:
                    return 1
        print(" Invalid Train Id entered " )
        return 0        