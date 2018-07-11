-- Drop all table in sql developer
BEGIN
   FOR cur_rec IN (SELECT object_name, object_type
                     FROM user_objects
                    WHERE object_type IN
                             ('TABLE',
                              'VIEW',
                              'PACKAGE',
                              'PROCEDURE',
                              'FUNCTION',
                              'SEQUENCE',
                              'SYNONYM',
                              'PACKAGE BODY'
                             ))
   LOOP
      BEGIN
         IF cur_rec.object_type = 'TABLE'
         THEN
            EXECUTE IMMEDIATE    'DROP '
                              || cur_rec.object_type
                              || ' "'
                              || cur_rec.object_name
                              || '" CASCADE CONSTRAINTS';
         ELSE
            EXECUTE IMMEDIATE    'DROP '
                              || cur_rec.object_type
                              || ' "'
                              || cur_rec.object_name
                              || '"';
         END IF;
      EXCEPTION
         WHEN OTHERS
         THEN
            DBMS_OUTPUT.put_line (   'FAILED: DROP '
                                  || cur_rec.object_type
                                  || ' "'
                                  || cur_rec.object_name
                                  || '"'
                                 );
      END;
   END LOOP;
END;
/

------------------------------ END of DROP ALL tables --------------------


--- First 
---MAP Member method

CREATE OR REPLACE TYPE Bank AS OBJECT(
ID NUMBER,
SALARY NUMBER,
EXPENSES NUMBER,
BALANCE NUMBER,
MEMBER function GET_SALARY return number,
MEMBER function CURRENT_BALANCE return number);
/

create or replace type body Bank  AS
MEMBER function CURRENT_BALANCE return number is
begin
     return SELF.BALANCE+SELF.SALARY-SELF.EXPENSES;
end CURRENT_BALANCE;
MEMBER function GET_SALARY return number is 
begin
  return SELF.SALARY;
end GET_SALARY;
end;
/

create table LV_learners of LV_Learner;
/

insert into LV_learners values(LV_Learner(1, 'John', 'Smith', 8, 7, 9, 6));
insert into LV_learners values(LV_Learner(2, 'Batuhan', 'Arslanoglu', 9, 5, 10, 7));
insert into LV_learners values(LV_Learner(3, 'Batuhan', 'Arslanoglu', 4, 6, 5, 3));
/

select Value(A).NAME, Value(A).SURNAME, Value(A).OVERALL()
from LV_learners A;
/
drop type LV_Learner;
drop type body LV_Learner;
drop table LV_learners;


---MEMBER method------
CREATE OR REPLACE TYPE Bank AS OBJECT(
ID NUMBER,
SALARY NUMBER,
EXPENSES NUMBER,
BALANCE NUMBER,
MEMBER function GET_SALARY return number,
MEMBER function CURRENT_BALANCE return number);
/

create or replace type body Bank  AS
MEMBER function CURRENT_BALANCE return number is
begin
     return SELF.BALANCE+SELF.SALARY-SELF.EXPENSES;
end CURRENT_BALANCE;
MEMBER function GET_SALARY return number is 
begin
  return SELF.SALARY;
end GET_SALARY;
end;
/

create table bank_account of Bank;
/

insert into bank_account values(Bank(1, 500, 250, 1500));
insert into bank_account values(Bank(2, 800, 400, 600));
insert into bank_account values(Bank(3, 500, 250, 800));
insert into bank_account values(Bank(4, 450, 150, 1000));

select Value(A).ID, Value(A).GET_SALARY(), Value(A).CURRENT_BALANCE()
from bank_account A;

drop type Bank;
drop type body Bank;
drop table bank_account;


--- PROCEDURE

create type Person_typ as object(
id number,
name varchar2(20),
surname varchar2(20),
gender varchar2(20),
MEMBER procedure FULL_NAME (SELF IN OUT NOCOPY Person_typ));

create type body Person_typ as 
MEMBER PROCEDURE FULL_NAME (SELF IN OUT NOCOPY Person_typ) IS
BEGIN
  DBMS_OUTPUT.PUT_LINE('Full Name: ' || name || ' - ' || surname);
END;
end;

create table person_tab of Person_typ;

insert into person_tab values(Person_typ(1, 'Batuhan', 'Anrsaloglu', 'male'));
insert into person_tab values(Person_typ(2, 'Jane', 'Kurser', 'female'));


select Value(A).id, Value(A).name from person_tab A;
/

drop table person_tab;
drop type Person_typ;
drop type body Person_typ;

----------------------Second task ------------------------

create type item_typ as object(
name varchar2(20),
description varchar2(20),
price number);
/

create type address_typ as object(
street VARCHAR2(15),
city   VARCHAR2(15),
state  CHAR(2)
);
/

create type person_typ as object(
name varchar2(20),
surname varchar2(20),
gender varchar2(20)
);
/

create type insurance as object(
id number,
person person_typ,
address address_typ,
item item_typ
);
/

create table insurance_tab of insurance;

insert into insurance_tab values (insurance( 1, 
          person_typ('Janis', 'Grabis', 'male'),
          address_typ('kalku 1', 'Riga', 'LV'),
          item_typ('Car', 'BWM car', 2000)));

insert into insurance_tab values (insurance( 2, 
          person_typ('Ruslan', 'Yurinkov', 'male'),
          address_typ('Elizabetes 103', 'Berlin', 'DE'),
          item_typ('Tank', 'Toyato car', 2000)));
          
insert into insurance_tab values (insurance( 3, 
          person_typ('thompson', 'Kear', 'male'),
          address_typ('Medved 15', 'Moscow', 'RU'),
          item_typ('Car', 'BWM car', 2000)));


select Value(A).person.name, Value(A).address.city, Value(A).item.name 
from insurance_tab A;

drop type person_typ;
drop type address_typ;
drop type item_typ;
drop type insurance;
drop table insurance_tab;


----- Object View-------------------------------------------------


CREATE TABLE product (
   pk_id INTEGER NOT NULL,
   name VARCHAR2(512),
   price INTEGER,
   CONSTRAINT product_pk PRIMARY KEY (pk_id));
/


CREATE TABLE test_product (
   test_id INTEGER NOT NULL,
   result_test VARCHAR2(45) NOT NULL,
   product INTEGER NOT NULL,
   CONSTRAINT test_product_pk PRIMARY KEY (test_id, result_test, product),
   CONSTRAINT product_fk FOREIGN KEY (product) REFERENCES product (pk_id));
/


CREATE TYPE test_product_typ AS TABLE OF VARCHAR2(45);

CREATE TYPE product_typ AS OBJECT (
    pt_id INTEGER,
    pt_name VARCHAR2(512),
    price INTEGER,
    test_result test_product_typ,
    MEMBER FUNCTION set_product (new_product_name IN VARCHAR2,
       new_product_type IN VARCHAR2, new_price IN INTEGER)
       RETURN product_typ,
    MEMBER FUNCTION set_testing (new_testing IN test_product_typ)
       RETURN product_typ,
    PRAGMA RESTRICT_REFERENCES (DEFAULT, RNDS, WNDS, RNPS, WNPS)
);
/

CREATE TYPE BODY product_typ
AS
   MEMBER FUNCTION set_product (new_product_name IN VARCHAR2,
       new_product_type IN VARCHAR2, new_price IN INTEGER)
       RETURN product_typ
   IS
      pt_container product_typ := SELF;
   BEGIN
      pt_container.pt_name := new_product_name;
      pt_container.price := new_price;
      RETURN pt_container;
   END;
   MEMBER FUNCTION set_testing (new_testing IN test_product_typ)
       RETURN product_typ
   IS
      test_container product_typ := SELF;
   BEGIN
      test_container.test_result := new_testing;
      RETURN test_container;
   END;
END;
/

CREATE VIEW product_v
   OF product_typ
   WITH OBJECT OID (pt_id)
AS
   SELECT p.pk_id, p.name, p.price,
      CAST (MULTISET (SELECT result_test
                        FROM test_product t
                       WHERE t.test_id = p.pk_id)
        AS test_product_typ)
     FROM product P;
/

insert into product values(1, 'headphone', 5000);
insert into product values(2, 'Cover for iphone 5s', 4100);
insert into product values(3, 'Glasses with black cover', 1000);
insert into product values(4, 'Keyboard for PC', 14000);

insert into test_product values(1, 'Successfully', 1);
insert into test_product values(2, 'Failed', 2);
insert into test_product values(3, 'Successfully', 3);
insert into test_product values(4, 'Successfully', 4);

SELECT pt_id, pt_name, price, test_result
  FROM product_v;
  
SELECT pt_id, pt_name, price, test_result
  FROM product_v
  WHERE price > 5000;

drop view product_v;

drop table product;
drop table test_product;
drop type product_typ;
drop type body  product_typ;
drop type test_product_typ;


-------------- Table with object collection ----------------------

CREATE TYPE BUDGET AS OBJECT(
MONTH VARCHAR2(20),
SALARY NUMBER,
EXPENSES NUMBER,
BALANCE NUMBER,
MEMBER function GET_SALARY return number,
MEMBER function CURRENT_BALANCE return number);
/
CREATE TYPE BODY BUDGET  AS
MEMBER function CURRENT_BALANCE return number is
BEGIN
     RETURN SELF.BALANCE+SELF.SALARY-SELF.EXPENSES;
END CURRENT_BALANCE;
MEMBER function GET_SALARY RETURN NUMBER IS 
BEGIN
  RETURN SELF.SALARY;
END GET_SALARY;
END;
/

CREATE TYPE PERSON_BUDGET AS TABLE OF BUDGET;
/


CREATE TABLE PERSON_BUDGET_T(
  IDNO NUMBER,
  BUDGET_C PERSON_BUDGET)
  NESTED TABLE BUDGET_C STORE AS BUDGET_NESTED;
  
INSERT INTO PERSON_BUDGET_T VALUES(1, PERSON_BUDGET(BUDGET('JANUARY', 250, 50, 400)));
INSERT INTO PERSON_BUDGET_T VALUES(1, PERSON_BUDGET(BUDGET('MARCH', 150, 150, 700)));
INSERT INTO PERSON_BUDGET_T VALUES(1, PERSON_BUDGET(BUDGET('MARCH', 500, 150, 800)));
INSERT INTO PERSON_BUDGET_T VALUES(1, PERSON_BUDGET(BUDGET('MAY', 400, 150, 700)));
INSERT INTO PERSON_BUDGET_T VALUES(1, PERSON_BUDGET(BUDGET('SEPTEMBER', 100, 150, 200)));
INSERT INTO PERSON_BUDGET_T VALUES(1, PERSON_BUDGET(BUDGET('DECEMBER', 50, 10, 400)));

SELECT N.MONTH, N.GET_SALARY(), N.CURRENT_BALANCE() 
FROM PERSON_BUDGET_T P,
TABLE(P.BUDGET_C) N
WHERE N.MONTH = 'MARCH';

DROP TYPE BUDGET;
DROP TYPE BODY BUDGET;
DROP TYPE PERSON_BUDGET;
DROP TABLE PERSON_BUDGET_T;


---------------- object type==============================

CREATE OR REPLACE TYPE PRODUCT_TYP AS OBJECT(
    product_id NUMBER,
    product_name VARCHAR2(20),
    description VARCHAR2(20)) NOT FINAL;
    
CREATE OR REPLACE TYPE LAMP_TYP UNDER PRODUCT_TYP(
    type VARCHAR2(20),
    made_year DATE,
    price NUMBER) NOT FINAL;

CREATE OR REPLACE TYPE CLOTHES_TYP UNDER PRODUCT_TYP(
    COLOR varchar2(20),
    TYPE varchar2(20)
);
CREATE OR REPLACE TYPE VEGETABLES_TYP UNDER PRODUCT_TYP(
    DELIVERED_DATE DATE,
    price NUMBER
);

CREATE TABLE LAMP OF LAMP_TYP;
CREATE TABLE VEGETABLE OF VEGETABLES_TYP;
CREATE TABLE CLOTHE OF CLOTHES_TYP;

INSERT INTO LAMP VALUES(LAMP_TYP(100, 'Eco lamp', 'new lamp', 'economical', '03-MAY-17', 50));
INSERT INTO LAMP VALUES(LAMP_TYP(101, 'Light lamp', 'Plastic', 'economical', '03-SEP-15', 70));

INSERT INTO CLOTHE VALUES(CLOTHES_TYP(201, 'T-SHIRT', 'Cotton t-shirt', 'red', 'x size'));
INSERT INTO CLOTHE VALUES(CLOTHES_TYP(202, 'T-SHIRT', 'Tight t-shirt', 'yellow', 'medium size'));

select VALUE(A).product_id, VALUE(A).product_name, VALUE(A).COLOR from CLOTHE A;

SELECT A.* FROM LAMP A;

select TREAT(VALUE(A)  as  PRODUCT_TYP) 
from LAMP A;

select A.* 
from CLOTHE A 
where TREAT(VALUE(A) as CLOTHES_TYP).COLOR = 'red';

select A.* 
from LAMP A 
where VALUE(A) IS OF TYPE (LAMP_TYP);


drop table CLOTHE;
DROP TABLE VEGETABLE;
DROP TABLE LAMP;
DROP TYPE VEGETABLES_TYP;
DROP TYPE CLOTHES_TYP;
DROP TYPE LAMP_TYP;
drop type PRODUCT_TYP;
