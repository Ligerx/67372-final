\c postgres
DROP DATABASE IF EXISTS db_project;

CREATE database db_project;
\c db_project

CREATE TABLE Users (
   username text PRIMARY KEY, -- no id to prevent anomalies
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
   -- subclass uses superclass primary key
   payment_type_id integer PRIMARY KEY REFERENCES PaymentTypes(id),
   paypal_num text
);

CREATE TABLE CreditCards (
   -- subclass uses superclass primary key
   payment_type_id integer PRIMARY KEY REFERENCES PaymentTypes(id),
   credit_card_num text,
   credit_card_type text
);

CREATE TABLE CustomerServiceSpecialists (
   -- subclass uses superclass primary key
   username text PRIMARY KEY REFERENCES Users(username),
   first_name text,
   last_name text
);


CREATE TABLE Riders (
   -- subclass uses superclass primary key
   username text PRIMARY KEY REFERENCES Users(username),
   first_name text,
   last_name text,
   phone_number text,
   rating integer,
   is_in_ride boolean -- if the user is currently on an Uber ride
);


CREATE TABLE Requests (
   id serial PRIMARY KEY,
   rider_username text REFERENCES Riders(username),
   pickup_location text,
   destination_location text,
   time_requested TIMESTAMP DEFAULT LOCALTIMESTAMP(0),
   surge_multiplier integer DEFAULT 1, -- surge normally at 1x multiplier
   request_fullfilled boolean,
   cancelled boolean
);


CREATE TABLE Drivers (
   -- subclass uses superclass primary key
   username text PRIMARY KEY REFERENCES Users(username),
   first_name text,
   last_name text,
   phone_number text,
   rating text,
   is_turned_on boolean -- driver logged in and awaiting ride requests
);


CREATE TABLE Rides (
   id serial PRIMARY KEY,
   request_id integer REFERENCES Requests(id),
   driver_username text REFERENCES Drivers(username),
   estimated_time_of_arrival text,
   distance text, -- total distance of trip
   price integer,
   driver_rating text,
   rider_rating text,
   is_completed boolean,
   time TIMESTAMP DEFAULT LOCALTIMESTAMP(0), -- total time of trip
   time_fullfilled TIMESTAMP DEFAULT LOCALTIMESTAMP(0) -- time trip finished
);
