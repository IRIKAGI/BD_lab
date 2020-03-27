drop database Arenda;
create database Arenda;

use Arenda;
drop table Clients;
drop table Cars;
drop table Contracts;
drop table DTP

create table Clients(
Id_client int IDENTITY(1,1) primary key,
Name_client nvarchar(50),
Passport_client nvarchar(50),
Experience_year_client int,
Telephone_client nvarchar(10),
Address_client nvarchar(50)
)

create table Cars(
Id_car int IDENTITY(1,1) primary key,
Marka_car nvarchar(50),
Color_car nvarchar(50),
Status_car nvarchar(50)
)

create table Contracts(
Id_contract int IDENTITY(1,1) primary key,
Date_arenda_start date,
Date_arenda_end date,
Client int,
Car int,
Cost_arenda int,
Year_arenda_start as year(Date_arenda_start),
FOREIGN KEY (Client) REFERENCES Clients(Id_client) ON DELETE CASCADE,
FOREIGN KEY (Car) REFERENCES Cars(Id_car) ON DELETE CASCADE
)

alter table Contracts add  Year_arenda_start as year(Date_arenda_start)

create table DTP(
Id_dtp int IDENTITY(1,1) primary key,
Date_dtp date,
Id_contract int,
Procent_broken int,
About_dtp varchar(50),
CHECK (Procent_broken between 1 and 100),
FOREIGN KEY (Id_contract) REFERENCES Contracts(Id_contract) ON DELETE CASCADE
)


insert into Clients values('Petya','RR12345678',3,'147-12-92','Ymanskaya 19');
insert into Clients values('Alla','RR12345687',1 ,'159-29-49','Katachatova 12');
insert into Clients values('Anastasya','RR1234567',2,'147-87-74','Azbekova 8');
insert into Clients values('Nikolay','RR1475236',5 ,'156-23-34','Armena 121');
insert into Clients values('Vasiliy','RR87654321',6 ,'785-63-98','Aleva 23');

select * from Clients;

Insert into Cars values('Toyota RAV4','Blue','New');
Insert into Cars values('Toyota Camry','White','Old');
Insert into Cars values('Fiat Punto','Black','Old, crashed');
Insert into Cars values('Honda Civic','Orange','old');
Insert into Cars values('Kia Rio','Black','New');

select * from Cars;

Insert into Contracts values('17-01-2019','25-01-2019', 5,5 ,300);
Insert into Contracts values('17-04-2018','25-04-2018', 5,4 ,120);
Insert into Contracts values('11-03-2019','21-04-2019', 3,2 ,145);
Insert into Contracts values('01-04-2019','07-05-2019', 2,1 ,230);
Insert into Contracts values('03-04-2019','13-05-2019', 2,5 ,500);
Insert into Contracts values('18-04-2019','20-04-2019', 3,3 ,300);
Insert into Contracts values('21-04-2019','24-04-2019', 2,3 ,250);
Insert into Contracts values('25-03-2019','28-04-2019', 3,3 ,100);
Insert into Contracts values('16-04-2019','17-05-2019', 2,2 ,200);

select * from Contracts;

Insert into DTP values('20-02-2019',6,10,'Pozarapal krylo');
Insert into DTP values('24-02-2019',7,20,'Pozarapal vtoroe krylo');
Insert into DTP values('28-02-2019',8,95,'Razbila');
Insert into DTP values('17-02-2019',9,10,'Pozarapala krylo');

select * from DTP;
--------------------------------------------------------------------------------------------------------------------------

GO
CREATE INDEX date_begin_end_index
ON Contracts(Date_arenda_start, Date_arenda_end)

GO
CREATE INDEX name__index
ON Clients(name_client)

--------------------------

CREATE VIEW Contract_view AS SELECT Contracts.Date_arenda_start, Contracts.Date_arenda_end, Clients.Name_client,
Cars.Marka_car, Contracts.Cost_arenda FROM ((Contracts
INNER JOIN  Clients ON Contracts.Client = Clients.Id_client)
INNER JOIN  Cars ON Contracts.Car = Cars.Id_car);

select * from Contract_view;

--------------------------

GO  
CREATE FUNCTION countContractsOfClient(@datastarta date,@dataend date)  
RETURNS int   
AS   
BEGIN  
    DECLARE @ret int;  
    SELECT @ret =count(*)   
    FROM Contracts co 
    WHERE Date_arenda_start between @datastarta and @dataend;  
     IF (@ret IS NULL)   
        SET @ret = 0;  
    RETURN @ret;  
END;  
GO  

  drop function dbo.countContractsOfClient;
  select dbo.countContractsOfClient('01-02-2019','10-02-2019');

-----------------------
GO  
CREATE PROCEDURE ContractsOfClient(@datastarta date,@dataend date)    
AS   
BEGIN  
    SELECT *   
    FROM Contracts co 
    WHERE Date_arenda_start between @datastarta and @dataend;  
END;  
GO  

drop function dbo.ContractsOfClient;
  exec ContractsOfClient '01-02-2019','10-02-2019';
  
-----------------------
CREATE TABLE History 
(
    Id INT IDENTITY PRIMARY KEY,
    Operation NVARCHAR(200) NOT NULL,
    CreateAt DATETIME NOT NULL DEFAULT GETDATE(),
);

drop table History;
drop trigger Car_INSERT;

GO
CREATE TRIGGER Car_INSERT
on Cars
AFTER INSERT
AS
INSERT INTO History(Operation)
SELECT  'Добавлена машина' + Marka_car + '   цвета ' + Color_car + ' Статуса ' + Status_car FROM inserted

Insert into Cars values('Lada Vesta','Green','New');
select * from History;


------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------
drop procedure add_client

CREATE PROCEDURE add_client
    @fio nvarchar(50),
	@passport nvarchar (max),
	@experience nvarchar(15),
	@tel nvarchar(50),
	@adr nvarchar(50)
AS
	BEGIN
		INSERT INTO Clients(Name_client,Passport_client,Experience_year_client,Telephone_client,Address_client)
		values(	@fio,@passport,@experience,@tel,@adr)
		DECLARE @userId int;
		SELECT 0;
	END
GO
----
CREATE PROCEDURE drop_client
	@passport nvarchar (max)
AS
	BEGIN
	DELETE FROM Clients where Passport_client = @passport;
		SELECT 0;
	END
GO
----
CREATE PROCEDURE change_client
    @fio nvarchar(50),
	@passport nvarchar (max),
	@experience nvarchar(15),
	@tel nvarchar(50),
	@adr nvarchar(50)
AS
	BEGIN
	update Clients set Name_client=@fio, Experience_year_client=@experience,Telephone_client=@tel,Address_client=@adr 
	where Passport_client=@passport;
		SELECT 0;
	END
GO
----
create procedure  getAllClients
AS
select * from Clients

-------------------------------------------------------------------------------------


CREATE PROCEDURE add_car
    @marka nvarchar(50),
	@color nvarchar (max),
	@status nvarchar(15)
AS
	BEGIN
		INSERT INTO Cars(Marka_car,Color_car,Status_car)
		values(	@marka,@color,@status)
		SELECT 0;
	END
GO
----
CREATE PROCEDURE drop_car
	@marka nvarchar (max)
AS
	BEGIN
	DELETE FROM Cars where Marka_car = @marka;
		SELECT 0;
	END
GO
----
CREATE PROCEDURE change_car
     @marka nvarchar(50),
	@color nvarchar (max),
	@status nvarchar(15)
AS
	BEGIN
	update Cars set Color_car=@color,Status_car=@status 
	where Marka_car=@marka;
		SELECT 0;
	END
GO
----
create procedure  getAllCars
AS
select * from Cars
-------------------------------------------------------------------------------
CREATE PROCEDURE add_contract
    @datestart date,
	@dateend date,
	@client int,
	@car int,
	@cost int
AS
	BEGIN
		INSERT INTO Contracts(Date_arenda_start,Date_arenda_end,Client,Car,Cost_arenda)
		values(	@datestart,@dateend,@client,@car,@cost)
		SELECT 0;
	END
GO
----
CREATE PROCEDURE drop_contract
	 @datestart date,
	@dateend date
AS
	BEGIN
	DELETE FROM Contracts where Date_arenda_start between @datestart and @dateend;
		SELECT 0;
	END
GO
----
CREATE PROCEDURE change_contract
      @datestart date,
	@dateend date,
	@client int,
	@car int,
	@cost int
AS
	BEGIN
	update Contracts set Date_arenda_start=@datestart,Date_arenda_end=@dateend,Car=@car,Cost_arenda=@cost 
	where Client=@client and Car = @car
		SELECT 0;
	END
GO
---
create procedure  getallContracts
AS
SELECT Contracts.Date_arenda_start, Contracts.Date_arenda_end, Clients.Name_client,
Cars.Marka_car, Contracts.Cost_arenda FROM ((Contracts
INNER JOIN  Clients ON Contracts.Client = Clients.Id_client)
INNER JOIN  Cars ON Contracts.Car = Cars.Id_car);

-----------------------------------------------------------------------------------------------------------------------

CREATE PROCEDURE add_dtp
    @datedtp date,
	@contract int,
	@procent int,
	@about varchar(50)
AS
	BEGIN
		INSERT INTO DTP(Date_dtp,Id_contract,Procent_broken,About_dtp)
		values(	@datedtp,@contract,@procent,@about)
		SELECT 0;
	END
GO
----
CREATE PROCEDURE drop_dtp
	@contract int
AS
	BEGIN
		DELETE FROM DTP where Id_contract = @contract
		SELECT 0;
	END
GO
----
CREATE PROCEDURE change_dtp
    @datedtp date,
	@contract int,
	@procent int,
	@about varchar(50)
AS
	BEGIN
	update DTP set Date_dtp=@datedtp,Procent_broken=@procent,About_dtp=@about 
	where Id_contract=@contract;
		SELECT 0;
	END
GO
----
create procedure  getAllDtp
AS
select * from DTP
-----------------------

CREATE PROCEDURE spisok_arend
    @datestart date,
	@dateend date
AS
	BEGIN
SELECT Contracts.Date_arenda_start, Contracts.Date_arenda_end, Clients.Name_client,
Cars.Marka_car, Contracts.Cost_arenda FROM ((Contracts
	INNER JOIN  Clients ON Contracts.Client = Clients.Id_client)
	INNER JOIN  Cars ON Contracts.Car = Cars.Id_car) 
	where Contracts.Date_arenda_start between @datestart and @dateend
ORDER BY Contracts.Cost_arenda asc;
	END
GO
drop procedure spisok_arend