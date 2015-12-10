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

SELECT *
FROM Rides as ride
INNER JOIN Requests as req
ON ride.request_id = req.id;
INNER Join Riders as rider
ON rider.username = req.rider_username
WHERE req.request_fullfilled = true AND ride.is_completed = true;