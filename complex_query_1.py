import psycopg2
import sys


# Hard coded values
username = 'alex'
payment_type = 'CreditCard'
is_primary_payment_method = False
credit_card_num = '6011096166450496'
credit_card_type = 'Discover'


def add_new_payment_method():
    payment_type_id = create_payment_type()

    if 'CreditCard' == payment_type:
        create_credit_card(payment_type_id)
    elif 'Paypal' == payment_type:
        create_paypal(payment_type_id)

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
        add_new_payment_method()

        # Finally close the db connection
        cur.close()
        conn.close()

    except psycopg2.Error as e:
        print("Unable to open connection: %s" % (e,))
