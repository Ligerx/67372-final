\echo -----------------------------------------------------------------
\echo  * 1. Cancel ride request
\echo -----------------------------------------------------------------
\echo

UPDATE Requests
SET cancelled=true
WHERE rider_username='alex';

\echo -----------------------------------------------------------------
\echo  * 2. Get Lowest Rated Rider
\echo -----------------------------------------------------------------
\echo

SELECT *
FROM Drivers
ORDER BY rating DESC
LIMIT 1;

\echo -----------------------------------------------------------------
\echo  * 3. View Riders Ride History
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