import psycopg2
import sys

# Hard coded values
username = 'alex'
payment_type = 'CreditCard'
credit_card_num = '6011096166450496'
credit_card_type = 'Discover'
is_primary_payment_method = False



# REMOVE THIS
def new_user(first_name, last_name, email):
    tmpl = '''
        INSERT INTO Users (first_name, last_name, email)
        VALUES(%s, %s, %s)
        RETURNING uid; -- for convenience
    '''
    cmd = cur.mogrify(tmpl, (first_name, last_name, email))
    print_cmd(cmd)
    cur.execute(cmd)
    result = cur.fetchall()[0][0] # just get the id of the new user

    print(first_name + ' ' + last_name + 'has been added (id: ' + str(result) + ')')
# REMOVE THIS



def add_payment_method():
    template = '''
        INSERT INTO PaymentTypes (username, payment_type, credit_card_num, credit_card_type, is_primary_payment_method)
        VALUES (%s, %s, %s, %s, %s)
        RETURNING id; -- get id to use for child tables
    '''

    cmd = cur.mogrify(template, (username, payment_type, credit_card_num, credit_card_type, is_primary_payment_method))
    print(cmd.decode('utf-8')) # show resulting SQL statement

    cur.execute(cmd)
    result = cur.fetchall()[0]

    print(str(result))




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

        # CALL METHOD
        add_payment_method()

        # Finally close the db connection
        cur.close()
        conn.close()

    except psycopg2.Error as e:
        print("Unable to open connection: %s" % (e,))
