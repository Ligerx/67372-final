\c postgres
DROP DATABASE IF EXISTS db_project;

CREATE database db_project;
\c db_project

CREATE TABLE Users (
   username text PRIMARY KEY,
   type text,
   password text
);

CREATE TABLE PaymentTypes (
   id serial PRIMARY KEY,
   username text REFERENCES Users(username),
   payment_type text,
   is_primary_payment_method boolean,
   time_added TIMESTAMP DEFAULT LOCALTIMESTAMP(0),
   time_last_used TIMESTAMP DEFAULT LOCALTIMESTAMP(0)
);

CREATE TABLE Paypals (
   id serial PRIMARY KEY,
   paypal_num text
);

CREATE TABLE CreditCards (
   id serial PRIMARY KEY,
   credit_card_num text,
   credit_card_type text
);

CREATE TABLE CustomerServiceSpecialists (
   id serial PRIMARY KEY,
   first_name text,
   last_name text
);


CREATE TABLE Riders (
   id serial PRIMARY KEY,
   first_name text,
   last_name text,
   phone_number text,
   rating integer,
   is_in_ride boolean
);


CREATE TABLE Requests (
   id serial PRIMARY KEY,
   rider_id integer REFERENCES Riders(id),
   pickup_location text,
   destination_location text,
   time_requested TIMESTAMP DEFAULT LOCALTIMESTAMP(0),
   surge_multiplier integer,
   request_fullfilled boolean,
   cancelled boolean
);


CREATE TABLE Drivers (
   id serial PRIMARY KEY,
   first_name text,
   last_name text,
   phone_number text,
   rating text,
   is_turned_on boolean
);


CREATE TABLE Rides (
   id serial PRIMARY KEY,
   request_id integer REFERENCES Requests(id),
   driver_id integer REFERENCES Drivers(id),
   estimated_time_of_arrival text,
   distance text,
   price integer,
   driver_rating text,
   rider_rating text,
   is_completed boolean,
   time TIMESTAMP DEFAULT LOCALTIMESTAMP(0),
   time_fullfilled TIMESTAMP DEFAULT LOCALTIMESTAMP(0)
);


