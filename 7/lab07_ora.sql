drop table report;
create table report 
(
  id number(5) GENERATED BY DEFAULT AS IDENTITY(START WITH 1 INCREMENT BY 1), 
  xml_data xmltype
);

set serveroutput on;

create or replace procedure GenerateXML(xml_data out report.xml_data%type)
is
begin
  select xmlelement(orders, 
                    xmlagg(
                      xmlelement(
                        "ORDER",
                        xmlattributes(ord.Id as Id),
                        xmlforest (
                          ord.Price as Price,
                          xmlforest (
                            typo.Name as Name,
                            typo.Address as Address,
                            typo.PhoneNumber as Phone) as Typography,
                          xmlforest (
                            cust.Name as Name,
                            cust.Address as Address,
                            cust.PhoneNumber as Phone) as Customer))))   
        into xml_data
			  from "Order" ord 
			  inner join Customer cust on ord.CustomerId = cust.Id 
			  inner join Typography typo on ord.TypographyId = typo.Id;
end;

create or replace procedure InsertXML(xml_data report.xml_data%type)
is
begin
  insert into report(xml_data) values(xml_data);
end;

create or replace procedure ExtractXmlElement(elem varchar2, node varchar2, res out varchar2)
is
begin
  select extractvalue(xml_data, elem) 
  into res
  from report r
  where r.xml_data.existsnode(node) = 1;
end;

declare
  res report.xml_data%type;
  elem nvarchar2(100);
begin
  GenerateXML(res);
  InsertXML(res);
  ExtractXmlElement('ORDERS/ORDER[@ID="22"]/CUSTOMER/NAME', '//ORDER[@ID="22"]', elem);
  dbms_output.put_line(res.GetStringVal());
  dbms_output.put_line(elem);
end;


select r.xml_data.GetStringVal() from report r;
select * from report;












select extractvalue(xml_data, 'ORDERS/ORDER[@ID="22"]/CUSTOMER/NAME') 
  from report r
  where r.xml_data.existsnode('//ORDER[@ID="22"]') = 1;
  
