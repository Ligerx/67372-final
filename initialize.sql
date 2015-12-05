\copy Users(username, type, password)
FROM 'data/Users.txt' DELIMITER ',' CSV

\copy Users(username, type, password)
FROM 'data/PaymentTypes.txt' DELIMITER ',' CSV

\copy Users(username, type, password)
FROM 'data/Paypals.txt' DELIMITER ',' CSV

\copy Users(username, type, password)
FROM 'data/CreditCards.txt' DELIMITER ',' CSV

\copy Users(username, type, password)
FROM 'data/CustomerServiceSpecialists.txt' DELIMITER ',' CSV

\copy Users(username, type, password)
FROM 'data/Riders.txt' DELIMITER ',' CSV

\copy Users(username, type, password)
FROM 'data/Requests.txt' DELIMITER ',' CSV

\copy Users(username, type, password)
FROM 'data/Drivers.txt' DELIMITER ',' CSV

\copy Users(username, type, password)
FROM 'data/Rides.txt' DELIMITER ',' CSV
