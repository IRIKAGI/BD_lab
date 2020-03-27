--drop table employee;
create table employee
(
	[node] hierarchyid primary key clustered,
	level as node.GetLevel() persisted,
	member_id int unique identity(1,1),
	member_name nvarchar(50) unique
);
go

--drop procedure add_descendant;
create procedure add_descendant @parent_name nvarchar(50), @descendant_name nvarchar(50)
as
begin
declare @parentHid hierarchyid = (select [node] from employee where member_name=@parent_name);
-- child.GetAncestor(n): n An int, representing the number of levels to go up in the hierarchy.
declare @maxChildHid hierarchyid = (select max([node]) from employee where [node].GetAncestor(1) = @parentHid)
insert into employee ([node], member_name) values (@parentHid.GetDescendant(@maxChildHid, NULL), @descendant_name);
return @@IDENTITY; 
end;
go

--drop procedure get_descendants;
create procedure get_descendants @parent_name nvarchar(50)
as
begin
declare @parent hierarchyid = (select node from employee where member_name=@parent_name);
select [node].ToString() as NodeAsString,
	   [node] as NodeAsBinary,
	   [node].GetLevel() as Level,
	   member_id,
	   member_name
from employee
where [node].IsDescendantOf(@parent)=1;
end;
go

--drop procedure change_parent;
create procedure change_parent @node nvarchar(50), @new_parent nvarchar(50)
as
begin
declare @old hierarchyid = (select [node] from employee where member_name=@node);
declare @new hierarchyid = (select [node] from employee where member_name=@new_parent);
declare @max_child hierarchyid = (select max([node]) from employee where [node].GetAncestor(1)=@new);
declare @new_child hierarchyid = @new.GetDescendant(@max_child, null);
update employee set [node]=[node].GetReparentedValue(@old, @new_child)
where [node].IsDescendantOf(@old)=1;
end;
go


insert into employee ([node], member_name) values (hierarchyid::GetRoot(), 'Big Boss');
exec add_descendant 'Big Boss','Medium Boss 1';
exec add_descendant 'Big Boss', 'Medium Boss 2';
exec add_descendant 'Medium Boss 1','Small Boss 1';
exec add_descendant 'Medium Boss 1','Small Boss 2';
exec add_descendant 'Medium Boss 2','Small Boss 3';

exec get_descendants 'Big Boss';
exec get_descendants 'Medium Boss 2';

exec change_parent 'Medium Boss 2', 'Medium Boss 1';
go
