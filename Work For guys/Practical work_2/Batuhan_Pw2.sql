CREATE OR REPLACE FUNCTION Book RETURN VARCHAR2 AS   
LANGUAGE JAVA NAME 'Bookstore.Book() return java.lang.String'; 
/

VARIABLE myString VARCHAR2(100); 
CALL Book() INTO :myString; 
 
PRINT myString; 


select  OBJECT_NAME, OBJECT_TYPE, STATUS, CREATED,  
GENERATED from  USER_OBJECTS  where CREATED >= TO_DATE('08-02-2018', 'DD-MM-YYYY');


CREATE OR REPLACE TYPE BALANCE AS OBJECT (
  ID NUMBER,
  CURRENT_BLANCE NUMBER,
  EXPENSES NUMBER, 
  SALARY NUMBER,
  MEMBER FUNCTION CALCULATOR RETURN NUMBER);
/
  
CREATE OR REPLACE TYPE BODY BALANCE AS 
  MEMBER FUNCTION CALCULATOR RETURN NUMBER IS
  BEGIN
    RETURN (CAL_FUNCTION(SELF.CURRENT_BLANCE, SELF.EXPENSES, SELF.SALARY));
  END CALCULATOR;
END;




  CREATE OR REPLACE FUNCTION CAL_FUNCTION(CURRENT_BALANCE IN NUMBER, EXPENSES IN NUMBER,
    SALARY IN NUMBER) RETURN NUMBER 
    AS LANGUAGE JAVA NAME 'Calculator.Calculate(java.lang.Integer, java.lang.Integer, java.lang.Integer)
    return java.lang.int';
  
  
CREATE TABLE BALANCE_TAB OF BALANCE;
/

INSERT INTO BALANCE_TAB VALUES(1, 1000, 200, 540);
INSERT INTO BALANCE_TAB VALUES(2, 800, 200, 250);
INSERT INTO BALANCE_TAB VALUES(3, 700, 180, 800);
INSERT INTO BALANCE_TAB VALUES(4, 900, 150, 600);

SELECT Value(a).CALCULATOR()
FROM BALANCE_TAB a;


select * from BALANCE_TAB;



--- ===============Stored Procedure============================================


CREATE TABLE COUNTRIES(
  COUNTRY_ID NUMBER,
  COUNTRY_NAME VARCHAR2(30),
  REGION_ID NUMBER
);

INSERT INTO COUNTRIES VALUES(101, 'GERMANY', 44);
INSERT INTO COUNTRIES VALUES(102, 'LATVIA', 371);
INSERT INTO COUNTRIES VALUES(103, 'TURKEY', 999);
INSERT INTO COUNTRIES VALUES(104, 'RUSSIA', 78);
INSERT INTO COUNTRIES VALUES(105, 'GERMANY', 45);
INSERT INTO COUNTRIES VALUES(106, 'LATVIA', 372);
INSERT INTO COUNTRIES VALUES(106, 'TURKEY', 998);
INSERT INTO COUNTRIES VALUES(107, 'RUSSIA', 77);
INSERT INTO COUNTRIES VALUES(108, 'GERMANY', 43);
INSERT INTO COUNTRIES VALUES(109, 'LATVIA', 373);
INSERT INTO COUNTRIES VALUES(110, 'TURKEY', 997);
INSERT INTO COUNTRIES VALUES(111, 'RUSSIA', 77);

--SELECT COUNTRY_ID,COUNTRY_NAME,REGION_ID INTO COUNTRY_ID_OUT,COUNTRY_NAME_OUT,REGION_ID_OUT
--  FROM COUNTRIES WHERE REGION_ID=REGION_ID_IN;
select * from COUNTRIES;

create or replace PROCEDURE GET_ALL_COUNTRIES
(
  COUNTRY_CURSOR OUT SYS_REFCURSOR
) AS 
BEGIN
  OPEN COUNTRY_CURSOR FOR 
  SELECT * FROM COUNTRIES;
END GET_ALL_COUNTRIES;

---
create or replace PROCEDURE GET_COUNTRIES
(
  COUNTRY_CURSOR OUT SYS_REFCURSOR,
  REGION_ID_IN IN NUMBER,
  COUNTRY_ID_OUT OUT VARCHAR2, 
  COUNTRY_NAME_OUT OUT VARCHAR2,
  REGION_ID_OUT OUT VARCHAR2  
) AS 
BEGIN
  OPEN COUNTRY_CURSOR FOR 
  SELECT COUNTRY_ID,COUNTRY_NAME,REGION_ID INTO COUNTRY_ID_OUT,COUNTRY_NAME_OUT,REGION_ID_OUT
  FROM COUNTRIES WHERE REGION_ID=REGION_ID_IN;
END GET_COUNTRIES;




------==============================



create or replace PROCEDURE GET_COUNTRIES
(
  COUNTRY_CURSOR OUT SYS_REFCURSOR,
  REGION_ID_IN IN NUMBER,
  COUNTRY_ID_OUT OUT VARCHAR2, 
  COUNTRY_NAME_OUT OUT VARCHAR2,
  REGION_ID_OUT OUT VARCHAR2  
) AS 
BEGIN
  OPEN COUNTRY_CURSOR FOR 
  SELECT COUNTRY_ID,COUNTRY_NAME,REGION_ID INTO COUNTRY_ID_OUT,COUNTRY_NAME_OUT,REGION_ID_OUT
  FROM COUNTRIES WHERE REGION_ID=REGION_ID_IN;
END GET_COUNTRIES;
--


--==========================4.2=========================

CREATE OR REPLACE PROCEDURE GET_COUNTRY_NAME 
(
  COUNTRY_ID_INPUT IN VARCHAR2 
, COUNTRY_NAME_OUTPUT OUT VARCHAR2 
) AS 
BEGIN
  SELECT COUNTRY_NAME INTO COUNTRY_NAME_OUTPUT FROM COUNTRIES WHERE COUNTRY_ID=COUNTRY_ID_INPUT;
END GET_COUNTRY_NAME;




----==========================4.3 =========================================

create or replace 
PROCEDURE GET_ALL_COUNTRIES 
(
   country_cursor OUT SYS_REFCURSOR
) AS 
BEGIN
  OPEN country_cursor FOR 
   SELECT * FROM COUNTRIES ;
END GET_ALL_COUNTRIES;
/



--=============================== 5.0 ======================

CREATE TABLE STUDENTS(
  ID NUMBER,
  NAME VARCHAR2(20),
  COUNTRY VARCHAR(20),
  MARK NUMBER,
  DEGREE VARCHAR2(20)
);

SELECT * FROM STUDENTS;
--create table faculty(
--f_num number primary key,
--f_name varchar2(20));
--
--drop table students;
--create table students(
--id number primary key,
--name varchar2(20),
--surname varchar2(20),
--gen varchar2(20),
--gr_id number,
--num_f number,
--FOREIGN KEY (num_f) REFERENCES faculty(f_num));
--
--select students.id, faculty.f_name 
--from students, faculty
--join students on students.num_f = faculty.f_num;
--
--select faculty.f_name
--from students, faculty
--where (select MAX(
--
--select students.id, students.name, students.surname from students, faculty
--where students.num_f = faculty.f_num and faculty.f_num='II RDB';
--
--
--select faculty.f_name 
--from students, faculty
--where faculty.f_num = (select students.f_num from students 
--
--select faculty.f_name, count(student.f_num)
--from students, faculty
--right join students(students.num_f = faculty.f_num
