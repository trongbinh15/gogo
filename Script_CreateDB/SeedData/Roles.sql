use GoGo

insert into Roles values ('Administrator', GETDATE(), GETDATE(), 0)
insert into Roles values ('Agent', GETDATE(), GETDATE(), 0)
insert into Roles values  ('Customer', GETDATE(), GETDATE(), 0)

select *
from Roles