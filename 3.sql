use Arenda;
exec sp_configure 'clr_enabled', 1
exec sp_configure 'clr_strict_security', 0
reconfigure



create assembly GetCount
	from 'C:\University\3lab.dll';

go
drop procedure GetCount (@dateStart datetime, @dateEnd datetime)
	as external name GetCount.StoredProcedures.GetCount

go
create procedure GetCount (@dateStart datetime, @dateEnd datetime)
	as external name GetCount.StoredProcedures.GetCount

declare @ref int
exec @ref = GetCount '01-01-2018', '01-02-2019'
print @ref

select * from Contracts
pivot (
  sum(Cost_arenda) for Year_arenda_start in ([2018], [2019])
) as pvt

DECLARE @cols  AS NVARCHAR(MAX)='';
DECLARE @query AS NVARCHAR(MAX)='';

SELECT @cols = @cols + QUOTENAME(Year_arenda_start) + ',' FROM (select distinct Year_arenda_start from Contracts ) as tmp
select @cols = substring(@cols, 0, len(@cols)) --trim "," at end
print @cols

set @query = 
'select * from Contracts
            pivot (
                sum(Cost_arenda) for Year_arenda_start in (' + @cols + ')
) piv'
	
execute(@query)