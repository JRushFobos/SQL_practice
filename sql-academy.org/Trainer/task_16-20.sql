--Task №16**
SELECT Passenger.name,
       COUNT(Pass_in_trip.trip) as count
FROM Pass_in_trip
    JOIN Passenger ON Pass_in_trip.passenger = Passenger.id
GROUP BY Passenger.name
ORDER BY
    count DESC, Passenger.name ASC
------------------------------------------------------
--Task №17**
SELECT  FamilyMembers.member_name as member_name,
        FamilyMembers.status as status,
        SUM(Payments.unit_price * Payments.amount) as costs
FROM FamilyMembers
JOIN Payments on FamilyMembers.member_id = Payments.family_member
WHERE YEAR(Payments.date) = 2005
GROUP BY FamilyMembers.member_name, FamilyMembers.status
------------------------------------------------------
--Task №18**
SELECT member_name
FROM FamilyMembers
ORDER BY birthday
LIMIT 1
------------------------------------------------------
--Task №19*
SELECT DISTINCT status
FROM FamilyMembers
JOIN Payments on FamilyMembers.member_id = Payments.family_member
where Payments.good = 9
------------------------------------------------------
--Task №20**
SELECT FamilyMembers.status as status,
       FamilyMembers.member_name as member_name,
       SUM(Payments.amount*Payments.unit_price) as costs
FROM FamilyMembers
JOIN Payments on FamilyMembers.member_id = Payments.family_member
JOIN Goods on Payments.good = Goods.good_id
WHERE Goods.type = 4
GROUP by FamilyMembers.status, FamilyMembers.member_name
------------------------------------------------------
