#As a driver I want to be able to pick a ride I want to accept in order to make the most money
import psycopg2
import sys


# Hard coded values
driver_username = 'olivia'

def get_all_riders_requesting_rides():
    template = '''
        SELECT *
        FROM Requests as reqs
        WHERE reqs.request_fullfilled = false
    '''

    cur.execute(template)
    all_riders = cur.fetchall()

    print('ALl Riders Found = ' + str(all_riders))
    return all_riders

def select_rider_from_list_and_create_ride():
		all_riders_availible = get_all_riders_requesting_rides()
		template = '''
		    UPDATE Requests
				SET request_fullfilled=true
				WHERE rider_username=%s;
		'''
		rider_username = all_riders_availible[0][1]
		cmd = cur.mogrify(template, (rider_username,))
		print(cmd.decode('utf-8')) # show resulting SQL statement
		cur.execute(cmd)

		#now create a ride
		template = '''
		  INSERT INTO Rides (request_id, driver_username,estimated_time_of_arrival,is_completed)
		  VALUES (%s, %s, %s,%s)
		'''
		print(all_riders_availible[0][0])
		cmd = cur.mogrify(template, (all_riders_availible[0][0], driver_username,5, False))
		print(cmd.decode('utf-8')) # show resulting SQL statement

		cur.execute(cmd)
		new_ride = cur.fetchall()
		print('Newly inserted Ride = ' + str(new_ride))
		return new_ride



if __name__ == '__main__':
    try:
        # default database and user
        db, user = 'db_project', 'Hova'

        # if command line argument is used, use it as the user name
        # e.g. python complex_query_1.p postgres
        if len(sys.argv) >= 2:
            user = sys.argv[1]

        # by assigning to conn and cur here they become
        # global variables.  Hence they are not passed
        # into the various SQL interface functions
        conn = psycopg2.connect(database=db, user=user)
        conn.autocommit = True
        cur = conn.cursor()

        #### CALL METHOD HERE
        select_rider_from_list_and_create_ride()

        # Finally close the db connection
        cur.close()
        conn.close()

    except psycopg2.Error as e:
        print("Unable to open connection: %s" % (e,))
