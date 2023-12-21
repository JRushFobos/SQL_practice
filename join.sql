select 
	api_user.api_user_id as api_user_id,
	api_user.api_user_name as api_user_name,
	manager.api_user_id as api_user_id
from api_user 
join manager on manager.api_user_id = api_user.api_user_id

--where id = 'apikey'
--where api_user_id = 'apikey'

-----------------------------------------------------

select f.field_id, f.crop_id, f."name" from field f where 
f.crop_id = (select id from crop where name = 'Test' and enabled is true)
and 
f.api_user_id = (select api_user_id from api_user where api_user_name = 'Test');

-----------------------------------------------------

SELECT UserId, RoleId, r.Name 
FROM [stg.test.com].sec.AspNetUserRoles as ur
inner join [stg.test.com].sec.AspNetroles as r on ur.RoleId = r.id
where UserId = 'apikey'

-----------------------------------------------------

select f."name", f.service, d."date" from tiles.date d
join tiles.field f on f.uid = d.uid and f."name" in ('test')

-----------------------------------------------------

SELECT UserId, RoleId, r.Name 
FROM [stg.test.com].sec.AspNetUserRoles as ur
inner join [stg.test.com].sec.AspNetroles as r on ur.RoleId = r.id
where UserId = 'apikey'

-----------------------------------------------------

select 	fields.Name as name,	
		fields.id as id,
		fields.cropid as cropid,
		Users.CompanyId as CompanyId
from fields
inner join users on fields.UserId = users.Id 
inner join companies on users.CompanyId = companies.id
where users.CompanyId = 32 and fields.IsArchived = 0

-----------------------------------------------------
select 	fields.Name as name,	
		fields.id as id,
		fields.cropid as cropid,
		YieldHistoryItems.PlantingDate as PlantingDate,
		Users.CompanyId as CompanyId
from Fields as fields
inner join Users as users on fields.UserId = users.Id 
inner join Companies as companies on users.CompanyId = companies.id
left join YieldHistoryItems as YieldHistoryItems on fields.Id = YieldHistoryItems.FieldId 
where users.CompanyId = 32 and fields.IsArchived = 0  and PlantingDate is NULL  
order by name ASC 

-----------------------------------------------------

SELECT DISTINCT crop_id 
FROM field 
WHERE api_user_id = 'apiKey'
UNION
SELECT DISTINCT yh.crop_id 
FROM field f 
LEFT JOIN yield_history yh on f.field_id = yh.field_id WHERE f.api_user_id = 'apiKey'

-----------------------------------------------------

UPDATE notification_field SET is_approved = null
