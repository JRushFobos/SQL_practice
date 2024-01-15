--Task №1*
SELECT name
from passenger
------------------------------------------------------
--Task №2*
SELECT DISTINCT(name)
from company
------------------------------------------------------
--Task №3*
SELECT *
from trip
where town_from = 'Moscow'
------------------------------------------------------
--Task №4*
select DISTINCT(name)
from passenger
where name like '%man'
------------------------------------------------------
--Task №5*
select count(*) as count
from Trip
where plane = 'TU-154'
------------------------------------------------------
--Task №6*
select DISTINCT (company.name)
from trip
join company on company.id = trip.company
where trip.plane = 'Boeing'
------------------------------------------------------
--Task №7*
select DISTINCT plane
from trip
where town_to = 'Moscow'
------------------------------------------------------
--Task №8**
select town_to,
	TIMEDIFF(time_in, time_out) as flight_time
from Trip
where town_from = 'Paris'
------------------------------------------------------
--Task №9*
select company.name as name
from trip
	INNER JOIN Company on Trip.company = Company.id
where trip.town_from = 'Vladivostok'
------------------------------------------------------
--Task №10**
SELECT *
from Trip
WHERE time_out >= '1900-01-01T10:00:00'
	AND time_out <= '1900-01-01T14:00:00'
------------------------------------------------------
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
------------------------------------------------------
--Task №10**

------------------------------------------------------
--Task №10**

------------------------------------------------------
--Task №10**

------------------------------------------------------
--Task №10**

------------------------------------------------------
--Task №10**

------------------------------------------------------
--Task №10**

------------------------------------------------------
--Task №10**

------------------------------------------------------
