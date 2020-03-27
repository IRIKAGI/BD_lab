use publishing_house;
go

create view PUBLICATIONS_VIEW 
as select [Name] from Publication;
go

create table test (id int);
go

CREATE TRIGGER TEST_TRIGGER  
ON dbo.Publication  
AFTER INSERT  
AS INSERT INTO dbo.test VALUES(1);
GO 