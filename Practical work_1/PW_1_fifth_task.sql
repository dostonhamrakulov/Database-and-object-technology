
--https://www.tutorialspoint.com/plsql/plsql_object_oriented.htm

CREATE TYPE address_type AS OBJECT (
    street VARCHAR2(15),
    city   VARCHAR2(15),
    zip    VARCHAR2(5),
    country VARCHAR(15)
);
/

CREATE Or Replace TYPE student_type AS OBJECT (
    id         NUMBER,
    name VARCHAR2(10),
    dob        VARCHAR2(10),
    phone      VARCHAR2(12),
    address    address_type
) NOT FINAL;
/

CREATE Or replace TYPE fulltime_student_type UNDER student_type (
    degree   VARCHAR2(20),
    study_year VARCHAR2(20)
);
/

CREATE TABLE object_fulltime_student_type OF fulltime_student_type;

INSERT INTO object_fulltime_student_type VALUES(
  fulltime_student_type(1, 'DOSTON', '25-9-1995', '28786188', 
  address_type('Kalku 1', 'Riga', 'LV148', 'Latvia'), 'Bachelor', '3rd yeard')
  );
  
SELECT * FROM object_fulltime_student_type;









--Examples from datubase.lv


CREATE OR REPLACE TYPE item AS OBJECT(
    item_id NUMBER,
    name VARCHAR2(20),
    description VARCHAR2(20)) NOT FINAL;
    
CREATE OR REPLACE TYPE computer UNDER item(
    memory VARCHAR2(20),
    valid DATE,
    price NUMBER) NOT FINAL;

CREATE OR REPLACE TYPE laptop UNDER computer(
    battery_life varchar2(20)
);
CREATE OR REPLACE TYPE phone UNDER item(
    memory VARCHAR2(20),
    valid DATE,
    price NUMBER
);
CREATE OR REPLACE TYPE tablet UNDER item(
    memory VARCHAR2(20),
    valid DATE,
    price NUMBER
);

CREATE TABLE computers OF computer;
CREATE TABLE items OF item;

insert into items values(item('101', 'ASUS', 'touch screen'));
insert into items values(item('102', 'PH', 'SSD card'));

insert into items values (computer('103', 'TOSHIBA', 'SS card', '1024 GB', '03-JUN-17', 555));
insert into items values (computer('104', 'TOSHIBA', 'touch screen', '128 GB', '03-MAY-17', 555));
insert into items values (computer('105', 'APPLE', 'touch screen', '512 GB', '03-SEP-16', 555));
insert into items values (computer('106', 'LENOVO', 'touch screen', '256 GB', '03-AUG-17', 555));

insert into items values (laptop('107', 'TOSHIBA', 'touch screen', '128 GB', '03-MAY-17', 555, '8 HOURS'));
insert into items values (laptop('108', 'APPLE', 'touch screen', '512 GB', '03-SEP-16', 555, '9 hours'));
insert into items values (laptop('109', 'LENOVO', 'touch screen', '256 GB', '03-AUG-17', 555, '10 hours'));

insert into items values (phone('110', 'iphone', '5g internet', '128 GB', '03-MAY-17', 100));
insert into items values (phone('111', 'samsung', 'edge screen', '512 GB', '03-SEP-16', 50));
insert into items values (phone('112', 'nokia', 'dual sim', '256 GB', '03-AUG-17', 5));

insert into items values (tablet('110', 'tablet 1', 'unlimited speed', '128 GB', '03-MAY-17', 145));
insert into items values (tablet('111', 'tablet 2', 'edge screen', '512 GB', '03-SEP-16', 5022));
insert into items values (tablet('112', 'tablet 3', 'unlimited memory', '256 GB', '03-AUG-17', 34));

select A.* from items A;

select VALUE(A).name, VALUE(A).description 
from items A;

select TREAT(VALUE(A)  as  item) 
from items A; 

select TREAT(VALUE(A)  as  laptop) 
from items A;

select TREAT(VALUE(A) as laptop).battery_life as BATTERY 
from items A; 

select VALUE(A) 
from items A 
where TREAT(VALUE(A) as phone).price = 100;

select VALUE(A) 
from items A 
where VALUE(A) IS OF TYPE (laptop);

select VALUE(A) 
from items A 
where VALUE(A) IS OF TYPE (computer, tablet);

select VALUE(A).name, VALUE(A).description 
from items  A 
where VALUE(A) IS OF TYPE (phone, tablet);

select A.name,  SYS_TYPEID(VALUE(A)) TYPE_ID 
from items A;



