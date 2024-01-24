--Task №16**
SELECT Passenger.name,
       COUNT(Pass_in_trip.trip) as count
FROM Pass_in_trip
    JOIN Passenger ON Pass_in_trip.passenger = Passenger.id
GROUP BY Passenger.name
ORDER BY
    count DESC, Passenger.name ASC
------------------------------------------------------
--Task №17*

------------------------------------------------------
--Task №18*

------------------------------------------------------
--Task №19*
SELECT DISTINCT status
FROM FamilyMembers
JOIN Payments on FamilyMembers.member_id = Payments.family_member
where Payments.good = 9
------------------------------------------------------
--Task №20*

------------------------------------------------------
