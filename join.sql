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


