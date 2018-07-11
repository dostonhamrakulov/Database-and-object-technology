CREATE OR REPLACE directory XMLFILES AS 'C:\Database_course\XML_files\Practical work_3' ;

create or replace directory XMLDIR as 'E:/RTU lessons/Databases and object technology/Practical work_3/XMLSchema';



----============================= Uploading xml file through BFILE=============

begin
DBMS_XMLSCHEMA.REGISTERSCHEMA(
SCHEMAURL => 'http://localhost:8080/public/Customer.xsd',
SCHEMADOC => bfilename('XMLFILES', 'Customer.xsd'),
LOCAL => TRUE,
CSID => nls_charset_id('AL32UTF8') ) ;
end;


begin
DBMS_XMLSCHEMA.REGISTERSCHEMA(
SCHEMAURL => 'http://localhost:8080/public/Hotel.xsd',
SCHEMADOC => bfilename('XMLFILES', 'Hotel.xsd'),
LOCAL => TRUE,
CSID => nls_charset_id('AL32UTF8') ) ;
end;


---==========================3.0 Unstructured type (CLOB type)=================

create table Customer_table of XMLType
XMLTYPE store as CLOB;
/


create table Hotel_table of XMLType
XMLTYPE store as CLOB;
/


---- data input
drop table Hotel_table;
insert into Customer_table values (xmltype( 
     bfilename('XMLFILES',  'customer.xml'),
     nls_charset_id('AL32UTF8') ) );
/

insert into Hotel_table values (xmltype( 
     bfilename('XMLFILES',  'hotel.xml'),
     nls_charset_id('AL32UTF8') ) );
/

--- data output===========

select EXTRACT(OBJECT_VALUE, '/Customers/Customer[10001]') as Cutomer
from Customer_table;
/
select * from Customer_table;

select EXTRACT(OBJECT_VALUE, '/Customers/Customer[1]/Fullname') "Fullname"
from Customer_table;
/

SELECT OBJECT_VALUE
  FROM Customer_table
  WHERE existsNode(OBJECT_VALUE, '/Customers/Customer[id="101"]') 
        = 1;
        
select EXTRACT(OBJECT_VALUE, '/Hotels/Hotel[1]/*') "First_hotel"
from HOTEL_TABLE;
/

select EXTRACT(OBJECT_VALUE, '/Customers/Customer[2]/Fullname') "Fullname",
      EXTRACT(OBJECT_VALUE, '/Customers/Customer[2]/Address/Phone') "Phone",
      EXTRACT(OBJECT_VALUE, '/Customers/Customer[2]/Address/Email') "Email"
from Customer_table;
/


select EXTRACT(OBJECT_VALUE, '/Customers/Customer/Fullname') "Fullnames"
from Customer_table;


----========================== GLOBAL() =================================

select X.OBJECT_VALUE.GETCLOBVAL()
FROM Hotel_table X;



------========================EXTRACTVALUE()===================

SELECT EXTRACTVALUE(OBJECT_VALUE, '/Hotels/Hotel[1]/Address/Country') as Country
FROM Hotel_table;

SELECT EXTRACTVALUE(OBJECT_VALUE, '/Hotels/Hotel[1]/Name') as Name,
        EXTRACTVALUE(OBJECT_VALUE, '/Hotels/Hotel[1]/Address/City') as City,
        EXTRACTVALUE(OBJECT_VALUE, '/Hotels/Hotel[1]/Address/Country') as Country,
        EXTRACTVALUE(OBJECT_VALUE, '/Hotels/Hotel[1]/Contact/Email') as Email
FROM Hotel_table;


SELECT EXTRACTVALUE(OBJECT_VALUE, '/Customers/Customer[2]/Fullname') as Name,
      EXTRACTVALUE(OBJECT_VALUE, '/Customers/Customer[2]/Booking/Check-in') as Coming_date,
      EXTRACTVALUE(OBJECT_VALUE, '/Customers/Customer[2]/Booking/Check-out') as Leaving_date,
      EXTRACTVALUE(OBJECT_VALUE, '/Customers/Customer[2]/Address/Email') as Email
FROM Customer_table;




----------------------------================4.0 ====================================
CREATE TABLE Employees(
    em_id NUMBER,
    em_name VARCHAR2(20),
    em_surname VARCHAR2(20),
    em_position VARCHAR2(20),
    working_year VARCHAR2(20),
    dep_name VARCHAR2(20),
    dep_address_str VARCHAR2(20),
    dep_address_city VARCHAR2(20)
);


CREATE TABLE Cars_from_xml(
  name varchar2(20),
  hourse_power number,
  year number,
  condition varchar2(20),
  price varchar2(20),
  type varchar(20)
);

insert into Cars_from_xml (name, hourse_power, year, condition, price, type )
select x.Name, x.Hourse_power, x.Year, x.Condition, x.Price, x.Type
from xmltable(
'/Cars/Car'
passing xmltype(
bfilename('MY_DIR', 'Cars.xml'),
nls_charset_id('AL32UTF8')
)
columns id      integer  path  '@cid',
name    varchar2(20) path 'Name',
hourse_power number path 'Horse_power',
year number path 'Year',
condition varchar2(30) path 'Condition',
price varchar2(20) path 'Price',
type varchar2(20) path 'Type'
) x
;

create or replace directory MY_DIR as 'C:\Database_course\XML_files\Practical work_3\xml files';


insert into Employees (em_id, em_name, em_surname, em_position, working_year, dep_name, dep_address_str, dep_address_city)
select x.Id, x.Name, x.Surname, x.Position, x.Working_year, x.Department.Department_name, 
x.Department.Department_address.Street, x.Department.Department_address.City
from xmltable(
'/Employees/Employee'
passing xmltype(
bfilename('MY_DIR', 'Employees.xml'),
nls_charset_id('AL32UTF8')
)
columns 
em_id      number      path 'em_id',
em_name    varchar2(20) path 'em_name',
em_surname varchar2(20) path 'em_surname',
em_position varchar2(20) path 'em_position',
working_year varchar2(30) path 'working_year',
dep_name varchar2(20) path 'dep_name',
dep_address_str varchar2(20) path 'dep_address_str',
dep_address_city varchar2(20) path 'dep_address_city'
) x
;



--================== 5.0  ============================================

CREATE TABLE Product(
  id NUMBER,
  name VARCHAR2(20),
  price VARCHAR2(20),
  made_year NUMBER,
  valid_year NUMBER,
  made_country VARCHAR2(20)
);


INSERT INTO Product values(1, 'T-shirt', '23 EURO', 2015, 2020, 'LATVIA');
INSERT INTO Product values(2, 'Shampoo', '2 EURO', 2015, 2018, 'Turkey');
INSERT INTO Product values(3, 'Milk', '4 EURO', 2016, 2018, 'LATVIA');
INSERT INTO Product values(4, 'Chocolate', '4 EURO', 2017, 2020, 'Gemany');
INSERT INTO Product values(5, 'Cheese', '3 EURO', 2016, 2019, 'LATVIA');


SELECT XMLElement("Product", XMLAttributes(P.id as "iD"), 
  XMLForest(P.name as "name", P.price as "price",  
  P.made_year as "made_year", P.valid_year as "P.valid_year", 
  P.made_country as "made_country")).EXTRACT('/*') AS XML 
FROM Product P; 
