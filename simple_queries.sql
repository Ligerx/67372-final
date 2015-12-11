\echo -----------------------------------------------------------------
\echo * 1.As driver "Ryan Sickles", I am able to turn on uber
\echo -----------------------------------------------------------------
\echo

UPDATE Drivers
SET is_turned_on=true
WHERE username='ryan';

\echo -----------------------------------------------------------------
\echo * 2. As driver "Ryan Sickles", I am able to change my password
\echo -----------------------------------------------------------------

UPDATE Users
SET password = 'newPassword'
WHERE username = 'ryan';

\echo -----------------------------------------------------------------
\echo * 3. driver end trip
\echo -----------------------------------------------------------------
\echo

UPDATE Riders
SET is_in_ride=false
WHERE username='alex';

UPDATE Rides
SET is_completed = true
WHERE driver_username='ryan';

\echo -----------------------------------------------------------------
\echo * 4. As rider "Lois Yang", I am able to request a ride
\echo -----------------------------------------------------------------
\echo


INSERT INTO Requests (id, rider_username, pickup_location, destination_location, surge_multiplier, request_fullfilled, cancelled)
VALUES (7,'lois','5000 Forbes Avenue','1000 Morewood Avenue',1, false, false);

\echo -----------------------------------------------------------------
\echo  * 5. Cancel ride request
\echo -----------------------------------------------------------------
\echo

UPDATE Requests
SET cancelled=true
WHERE rider_username='alex';

\echo -----------------------------------------------------------------
\echo  * 6. Get Lowest Rated Rider
\echo -----------------------------------------------------------------
\echo

SELECT *
FROM Drivers
ORDER BY rating DESC
LIMIT 1;

\echo -----------------------------------------------------------------
\echo  * 7. View Riders Ride History
\echo -----------------------------------------------------------------
\echo

SELECT req.rider_username, req.pickup_location, ride.driver_username, ride.is_completed
FROM Requests as req
INNER JOIN Rides as ride
ON ride.request_id = req.id
INNER Join Riders as rider
ON rider.username = req.rider_username
INNER Join RideInformation as Rideinfo
ON Rideinfo.ride_id = ride.id
WHERE req.request_fullfilled = true AND ride.is_completed = true AND req.rider_username = 'ethan'
ORDER BY Rideinfo.time_fullfilled DESC;
