USE publishing_house;
GO

--DROP TABLE Report;
CREATE TABLE Report(
  id INT IDENTITY PRIMARY KEY,
  xml_data XML
)
GO
CREATE PRIMARY XML INDEX idx_xml_data ON Report (xml_data);
GO

--DROP PROCEDURE GenerateXML;
CREATE PROCEDURE GenerateXML
	@query VARCHAR(MAX), 
	@path VARCHAR(100),
	@root VARCHAR(100), 
	@result XML OUTPUT
AS
	DECLARE @sql NVARCHAR(650) = 'SET @result = (' 
								+ @query + ' FOR XML PATH (''' 
								+ @path + '''), ROOT(''' 
								+ @root + '''))';
	EXEC sp_executesql @sql, N'@result xml output', @result OUTPUT;
GO


CREATE PROCEDURE InsertXML
	@xml XML
AS
	INSERT INTO Report VALUES(@xml);
GO


--DROP PROCEDURE ExtractXmlElement
CREATE PROCEDURE ExtractXmlElement
	@xQuery NVARCHAR(MAX),
	@SQLType NVARCHAR(15),
	@element NVARCHAR(100) OUTPUT
AS
	DECLARE @sql NVARCHAR(650) = 'SET @element = (SELECT xml_data.value(''' 
									+ @xQuery + ''', ''' 
									+ @SQLType + ''') FROM Report WHERE xml_data IS NOT NULL)';
	EXEC sp_executesql @sql, N'@element NVARCHAR(100) output', @element OUTPUT;
GO


DECLARE @xml XML;
DECLARE @query NVARCHAR(MAX);

SET @query = 'SELECT ord.Id as ''ORDER/@ID'', 
	   ord.Price as ''ORDER/PRICE'', 
	   
	   typo.Name as ''ORDER/TYPOGRAPHY/NAME'', 
	   typo.Address as ''ORDER/TYPOGRAPHY/ADDRESS'', 
	   typo.PhoneNumber as ''ORDER/TYPOGRAPHY/PHONE'', 

	   cust.Name as ''ORDER/CUSTOMER/NAME'', 
	   cust.Address as ''ORDER/CUSTOMER/ADDRESS'', 
	   cust.PhoneNumber as ''ORDER/CUSTOMER/PHONE'' 

	   from [Order] ord 
	   inner join Customer cust on ord.CustomerId = cust.Id 
	   inner join Typography typo on ord.TypographyId = typo.Id ';

EXEC GenerateXML @query, '', 'ORDERS', @xml OUTPUT;
EXEC InsertXML @xml;
--SELECT @xml;
SELECT * FROM Report;

DECLARE @elem NVARCHAR(100);
DECLARE @attr NVARCHAR(100);
EXEC ExtractXmlElement '(ORDERS/ORDER[@ID="2"]/CUSTOMER/NAME)[1]', 'nvarchar(100)', @elem OUTPUT;
EXEC ExtractXmlElement '(ORDERS/ORDER/@ID)[1]', 'nvarchar(100)', @attr OUTPUT;
PRINT @elem;
PRINT @attr;
GO


















SELECT ord.Id as 'ORDER/@ID', 
	   ord.Price as 'ORDER/PRICE',
	   typo.Name as 'ORDER/TYPOGRAPHY/NAME', 
	   typo.Address as 'ORDER/TYPOGRAPHY/ADDRESS', 
	   typo.PhoneNumber as 'ORDER/TYPOGRAPHY/PHONE',
	   cust.Name as 'ORDER/CUSTOMER/NAME', 
	   cust.Address as 'ORDER/CUSTOMER/ADDRESS',
	   cust.PhoneNumber as 'ORDER/CUSTOMER/PHONE'
	   from [Order] ord 
	   inner join Customer cust on ord.CustomerId = cust.Id 
	   inner join Typography typo on ord.TypographyId = typo.Id FOR XML PATH (''), ROOT('ORDERS')