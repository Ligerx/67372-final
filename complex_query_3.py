# As a Driver, I want to be able to complete multiple rides for one user
# so that the rider doesn't have to request a new uber if they want to continue a trip

import psycopg2
import sys


# Hard coded values
ride_id = 6 # the ride in progress
distance = 10
price = 12.50
rider_rating = 5
driver_rating = 5
time = 10
time_fullfilled = 'now'

rider_username = 'ethan'
pickup_location = "6075 Penn Street Lynn, MA 01902"
destination_location = "1502 Lake Blvd Lynn, MA 01902"
time_requested = 'now'
surge_multiplier = 1
request_fullfilled = True
cancelled = False

driver_username = 'david'
estimated_time_of_arrival = 5
is_completed = False



def create_new_ride_for_current_trip():
    end_ride(ride_id)
    request_id = create_request()
    create_ride(request_id)

def end_ride(ride_id):
    # End Ride
    template = '''
        UPDATE Rides
        SET is_completed = true
        WHERE id = %s;
    '''

    cmd = cur.mogrify(template, (ride_id,))
    print(cmd.decode('utf-8')) # show resulting SQL statement

    cur.execute(cmd)

    print('Marked Ride id ' + str(ride_id) + ' as completed')

    # Fill out RideInformation
    template = '''
        INSERT INTO RideInformation (ride_id, distance, price, rider_rating, driver_rating, time, time_fullfilled)
        VALUES (%s, %s, %s, %s, %s, %s, %s)
        RETURNING ride_id;
    '''

    cmd = cur.mogrify(template, (ride_id, distance, price, rider_rating, driver_rating, time, time_fullfilled))
    print(cmd.decode('utf-8')) # show resulting SQL statement

    cur.execute(cmd)
    old_ride_id = cur.fetchall()[0][0]

    print('Filled out RideInformation')
    return old_ride_id

def create_request():
    template = '''
        INSERT INTO Requests (rider_username, pickup_location, destination_location, time_requested, surge_multiplier, request_fullfilled, cancelled)
        VALUES (%s, %s, %s, %s, %s, %s, %s)
        RETURNING id;
    '''

    cmd = cur.mogrify(template, (rider_username, pickup_location, destination_location, time_requested, surge_multiplier, request_fullfilled, cancelled))
    print(cmd.decode('utf-8')) # show resulting SQL statement

    cur.execute(cmd)
    new_request_id = cur.fetchall()[0][0]

    print('Newly inserted Request id = ' + str(new_request_id))
    return new_request_id

def create_ride(request_id):
    template = '''
        INSERT INTO Rides (request_id, driver_username, estimated_time_of_arrival, is_completed)
        VALUES (%s, %s, %s, %s)
        RETURNING id; -- get id to use for child tables
    '''

    cmd = cur.mogrify(template, (request_id, driver_username, estimated_time_of_arrival, is_completed))
    print(cmd.decode('utf-8')) # show resulting SQL statement

    cur.execute(cmd)
    new_ride_id = cur.fetchall()[0][0]

    print('Newly inserted Ride id = ' + str(new_ride_id))
    return new_ride_id




def create_payment_type():
    template = '''
        INSERT INTO PaymentTypes (username, payment_type, is_primary_payment_method)
        VALUES (%s, %s, %s)
        RETURNING id; -- get id to use for child tables
    '''

    cmd = cur.mogrify(template, (username, payment_type, is_primary_payment_method))
    print(cmd.decode('utf-8')) # show resulting SQL statement

    cur.execute(cmd)
    new_payment_type_id = cur.fetchall()[0][0]

    print('Newly inserted PaymentType id = ' + str(new_payment_type_id))
    return new_payment_type_id

def create_credit_card(payment_type_id):
    template = '''
        INSERT INTO CreditCards (payment_type_id, credit_card_num, credit_card_type)
        VALUES (%s, %s, %s);
    '''

    cmd = cur.mogrify(template, (payment_type_id, credit_card_num, credit_card_type))
    print(cmd.decode('utf-8')) # show resulting SQL statement

    cur.execute(cmd)

def create_paypal(payment_type_id):
    # mock function
    return


if __name__ == '__main__':
    try:
        # default database and user
        db, user = 'db_project', 'postgres'

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
        create_new_ride_for_current_trip()

        # Finally close the db connection
        cur.close()
        conn.close()

    except psycopg2.Error as e:
        print("Unable to open connection: %s" % (e,))
