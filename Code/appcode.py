##################################################################
#  Main class : Connects to the database with credentials 
#                Displays different roles and offloads the 
#                functioning to that object 
##################################################################

import mysql.connector
from mysql.connector import Error
from userdefs.admin import admin_object
from userdefs.user  import user_object


# Connect to database with username and password in arguments
# Run the application code to take a legal name and track the 
# character using stored procedure. 
def connect_to_database_and_experiment(username_arg,password_arg):
    try:
        # Q.1 Solution 
        connection = mysql.connector.connect(host='127.0.0.1',
                                         database='railway dbms',
                                         user=username_arg,
                                         password=password_arg)
        
        if connection.is_connected():
            database_info = connection.get_server_info()
            print("Connected to MySQL Server version ", database_info)
            db_cursor = connection.cursor()
            db_cursor.execute("select database();")
            record = db_cursor.fetchone()
            print("Connected to database Successful ! : ", record)
            prompt_user(db_cursor,connection)                            
            
            connection.close()
            
    except Error as e:
        print("Error while connecting to MySQL", e)
    
# Main function of the application
def main():
    #   Q.1 , prompt user for username and password . 
    username = input(" Please enter the username for your database : ")
    password = input(" Please enter the password for your database : ")
    # Q.2 Solution is below
    lotr_db_cursor = connect_to_database_and_experiment(username,password)
 
# Prompt user for type of application usage and invoke them. 
def prompt_user(db_cursor,connection): 
    typeof_user = input(" Please enter the type of user 1 - Administrator 2 - Passenger : ")    
    if typeof_user == '1':
        admin_object(db_cursor,connection)
    elif typeof_user == '2':
        user_object(db_cursor,connection)
    else:
        prompt_user(db_cursor,connection)    

main()    