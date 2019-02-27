create resource pool PoolAdmin
create resource pool PoolMarketing


create workload group GroupAdmins
using PoolAdmin
go

create workload group GroupMarketing
using PoolMarketing
go

create function classifier()
returns sysname with schemabinding
begin
	declare @val varchar(30)
	if 'Hans' = Suser_sname()
		set @val='GroupAdmins'
	else if 'Susi' = suser_sname()
		set @val='GroupMarketing'
	return @val
end

alter resource governor
	with (Classifier_function=dbo.classifier)
	
alter resource governor reconfigure