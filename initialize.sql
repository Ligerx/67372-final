\copy Users(username, type, password) FROM './data/Users.txt' DELIMITER ',' CSV

-- no primary key field, automatic
\copy PaymentTypes(username, payment_type, is_primary_payment_method, time_added, time_last_used) FROM './data/PaymentTypes.txt' DELIMITER ',' CSV

\copy Paypals(payment_type_id, paypal_num) FROM './data/Paypals.txt' DELIMITER ',' CSV

\copy CreditCards(payment_type_id, credit_card_num, credit_card_type) FROM './data/CreditCards.txt' DELIMITER ',' CSV

\copy CustomerServiceSpecialists(username, first_name, last_name) FROM './data/CustomerServiceSpecialists.txt' DELIMITER ',' CSV

\copy Riders(username, first_name, last_name, phone_number, rating, is_in_ride) FROM './data/Riders.txt' DELIMITER ',' CSV

-- no primary key field, automatic
\copy Requests(rider_username, pickup_location, destination_location, time_requested, surge_multiplier, request_fullfilled, cancelled) FROM './data/Requests.txt' DELIMITER ',' CSV

\copy Drivers(username, first_name, last_name, phone_number, rating, is_turned_on) FROM './data/Drivers.txt' DELIMITER ',' CSV

-- no primary key field, automatic
\copy Rides(request_id, driver_username, estimated_time_of_arrival, is_completed) FROM './data/Rides.txt' DELIMITER ',' CSV

\copy RideInformation(ride_id, distance, price, rider_rating, driver_rating, time, time_fullfilled) FROM './data/RideInformation.txt' DELIMITER ',' CSV
