--Task №11**
SELECT name
FROM passenger
WHERE LENGTH(name) = (
		SELECT MAX(LENGTH(name)) as maxlenname
		FROM passenger
	)
------------------------------------------------------
--Task №12*
SELECT trip,
	COUNT(passenger) as count
FROM Pass_in_trip
GROUP BY trip
------------------------------------------------------
--Task №13**
SELECT DISTINCT(p1.name)
FROM passenger as p1
WHERE EXISTS (
		SELECT 1
		FROM passenger as p2
		WHERE p2.name = p1.name
			and p2.id <> p1.id
	)
------------------------------------------------------
--Task №14*
SELECT town_to
FROM Trip
	JOIN Pass_in_trip on Trip.id = Pass_in_trip.trip
	JOIN Passenger on Passenger.id = Pass_in_trip.passenger
WHERE Passenger.name = 'Bruce Willis'
------------------------------------------------------
--Task №15*
SELECT Trip.time_in
from Trip
	join Pass_in_trip on Trip.id = Pass_in_trip.trip
	JOIN Passenger on Pass_in_trip.passenger = Passenger.id
WHERE Passenger.name = 'Steve Martin'
	AND Trip.town_to = 'London'
