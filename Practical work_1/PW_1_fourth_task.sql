--https://www.club-oracle.com/threads/nested-tables-in-pl-sql.16275/

--http://www.orafaq.com/wiki/NESTED_TABLE
--https://docs.oracle.com/cd/B28359_01/appdev.111/b28371/adobjcol.htm#CHDJJBJI


--CREATE TYPE person_typ AS OBJECT (
--  idno           NUMBER,
--  name           VARCHAR2(30),
--  phone          VARCHAR2(20),
--  MAP MEMBER FUNCTION get_idno RETURN NUMBER, 
--  MEMBER PROCEDURE display_details ( SELF IN OUT NOCOPY person_typ ) );
--/
--
--CREATE TYPE BODY person_typ AS
--  MAP MEMBER FUNCTION get_idno RETURN NUMBER IS
--  BEGIN
--    RETURN idno;
--  END;
--  MEMBER PROCEDURE display_details ( SELF IN OUT NOCOPY person_typ ) IS
--  BEGIN
--    -- use the put_line procedure of the DBMS_OUTPUT package to display details
--    DBMS_OUTPUT.put_line(TO_CHAR(idno) || ' - '  || name || ' - '  || phone);
--  END;
--END;
--/
--
--CREATE TYPE people_typ AS TABLE OF person_typ; -- nested table type
--/
--
---- Using the Constructor Method to Insert Values into a Nested Table
--CREATE TABLE people_tab (
--    group_no NUMBER,
--    people_column people_typ )  -- an instance of nested table
--    NESTED TABLE people_column STORE AS people_column_nt; -- storage table for NT
--
--INSERT INTO people_tab VALUES (
--            100,
--            people_typ( person_typ(1, 'John Smith', '1-650-555-0135'),
--                        person_typ(2, 'Diane Smith', NULL)));
--                        
---- The following statement creates an array type email_list_arr that has no more than ten elements, each of data type VARCHAR2(80)
--
--CREATE TYPE email_list_arr AS VARRAY(10) OF VARCHAR2(80);
--/
--
---- Creating and Populating a VARRAY Data Type
--
--CREATE TYPE phone_typ AS OBJECT (
--    country_code   VARCHAR2(2), 
--    area_code      VARCHAR2(3),
--    ph_number      VARCHAR2(7));
--/
--CREATE TYPE phone_varray_typ AS VARRAY(5) OF phone_typ;
--/
--CREATE TABLE dept_phone_list (
--  dept_no NUMBER(5), 
--  phone_list phone_varray_typ);
--
--INSERT INTO dept_phone_list VALUES (
--   100,
--   phone_varray_typ( phone_typ ('01', '650', '5550123'),
--                      phone_typ ('01', '650', '5550148'),
--                      phone_typ ('01', '650', '5550192')));
--              
----  To declare nested table types
--CREATE TYPE people_typ AS TABLE OF person_typ;
--
--
--CREATE TABLE students (
--   graduation DATE, 
--   math_majors people_typ, -- nested tables (empty)
--   chem_majors people_typ, 
--   physics_majors people_typ)
--  NESTED TABLE math_majors STORE AS math_majors_nt  -- storage tables
--  NESTED TABLE chem_majors STORE AS chem_majors_nt
--  NESTED TABLE physics_majors STORE AS physics_majors_nt;
--
--CREATE INDEX math_idno_idx ON math_majors_nt(idno);
--CREATE INDEX chem_idno_idx ON chem_majors_nt(idno);
--CREATE INDEX physics_idno_idx ON physics_majors_nt(idno);
--
--INSERT INTO students (graduation) VALUES ('01-JUN-03');
--UPDATE students
--  SET math_majors = 
--        people_typ (person_typ(12, 'Bob Jones', '650-555-0130'), 
--                    person_typ(31, 'Sarah Chen', '415-555-0120'),
--                    person_typ(45, 'Chris Woods', '415-555-0124')),
--      chem_majors = 
--        people_typ (person_typ(51, 'Joe Lane', '650-555-0140'), 
--                    person_typ(31, 'Sarah Chen', '415-555-0120'),
--                    person_typ(52, 'Kim Patel', '650-555-0135')),
--   physics_majors = 
--        people_typ (person_typ(12, 'Bob Jones', '650-555-0130'), 
--                    person_typ(45, 'Chris Woods', '415-555-0124'))
--WHERE graduation = '01-JUN-03';
--
--SELECT m.idno math_id, c.idno chem_id, p.idno physics_id  FROM students s,
-- TABLE(s.math_majors) m, TABLE(s.chem_majors) c, TABLE(s.physics_majors) p;
-- 



--CREATE TYPE person_typ AS OBJECT (
--  idno           NUMBER,
--  name           VARCHAR2(30),
--  phone          VARCHAR2(20),
--  MAP MEMBER FUNCTION get_idno RETURN NUMBER, 
--  MEMBER PROCEDURE display_details ( SELF IN OUT NOCOPY person_typ ) );
--/
--
--CREATE TYPE BODY person_typ AS
--  MAP MEMBER FUNCTION get_idno RETURN NUMBER IS
--  BEGIN
--    RETURN idno;
--  END;
--  MEMBER PROCEDURE display_details ( SELF IN OUT NOCOPY person_typ ) IS
--  BEGIN
--    -- use the put_line procedure of the DBMS_OUTPUT package to display details
--    DBMS_OUTPUT.put_line(TO_CHAR(idno) || ' - '  || name || ' - '  || phone);
--  END;
--END;
--/
--
--CREATE TYPE people_typ AS TABLE OF person_typ; -- nested table type
--/
CREATE TYPE item_typ AS OBJECT (
  idno           NUMBER,
  name           VARCHAR2(30),
  description          VARCHAR2(20),
  MAP MEMBER FUNCTION get_idno RETURN NUMBER, 
  MEMBER PROCEDURE display_details ( SELF IN OUT NOCOPY item_typ ) );
/

CREATE TYPE BODY item_typ AS
  MAP MEMBER FUNCTION get_idno RETURN NUMBER IS
  BEGIN
    RETURN idno;
  END;
  MEMBER PROCEDURE display_details ( SELF IN OUT NOCOPY item_typ ) IS
  BEGIN
    -- use the put_line procedure of the DBMS_OUTPUT package to display details
    DBMS_OUTPUT.put_line(TO_CHAR(idno) || ' - '  || name || ' - '  || description);
  END;
END;
/

CREATE TYPE computer_typ AS TABLE OF item_typ; -- nested table type
/
--
--CREATE TABLE people_tab (
--    group_no NUMBER,
--    people_column people_typ )  -- an instance of nested table
--    NESTED TABLE people_column STORE AS people_column_nt; -- storage table for NT
--
--INSERT INTO people_tab VALUES (
--            100,
--            people_typ( person_typ(1, 'John Smith', '1-650-555-0135'),
--                        person_typ(2, 'Diane Smith', NULL)));

CREATE TABLE computer_tab (
    group_no NUMBER,
    computer_column computer_typ )  -- an instance of nested table
    NESTED TABLE computer_column STORE AS computer_column_nt; -- storage table for NT

INSERT INTO computer_tab VALUES (
            100,
            computer_typ( item_typ(1, 'Lenovo', '8GB Memory'),
                        item_typ(2, 'Asus', '4GB MEMORY')));
--
--CREATE TYPE email_list_arr AS VARRAY(10) OF VARCHAR2(80);
--/
CREATE TYPE contact_list_arr AS VARRAY(10) OF VARCHAR2(80);
/
--
--CREATE TYPE phone_typ AS OBJECT (
--    country_code   VARCHAR2(2), 
--    area_code      VARCHAR2(3),
--    ph_number      VARCHAR2(7));
--/
--CREATE TYPE phone_varray_typ AS VARRAY(5) OF phone_typ;
--/
--CREATE TABLE dept_phone_list (
--  dept_no NUMBER(5), 
--  phone_list phone_varray_typ);
--
--INSERT INTO dept_phone_list VALUES (
--   100,
--   phone_varray_typ( phone_typ ('01', '650', '5550123'),
--                      phone_typ ('01', '650', '5550148'),
--                      phone_typ ('01', '650', '5550192')));

CREATE TYPE phone_typ AS OBJECT (
    country_code   VARCHAR2(2), 
    area_code      VARCHAR2(3),
    ph_number      VARCHAR2(7));
/

CREATE TYPE phone_varray_typ AS VARRAY(5) OF phone_typ;
/
CREATE TABLE branch_phone_list (
  brach_no NUMBER(5), 
  phone_list phone_varray_typ);

INSERT INTO branch_phone_list VALUES (
   100,
   phone_varray_typ( phone_typ ('01', '650', '5550123'),
                      phone_typ ('01', '650', '5550148'),
                      phone_typ ('01', '650', '5550192')));

--CREATE TYPE people_typ AS TABLE OF person_typ;
CREATE TYPE computer_typ AS TABLE OF computer_typ;

--CREATE TABLE students (
--   graduation DATE, 
--   math_majors people_typ, -- nested tables (empty)
--   chem_majors people_typ, 
--   physics_majors people_typ)
--  NESTED TABLE math_majors STORE AS math_majors_nt  -- storage tables
--  NESTED TABLE chem_majors STORE AS chem_majors_nt
--  NESTED TABLE physics_majors STORE AS physics_majors_nt;
--
--CREATE INDEX math_idno_idx ON math_majors_nt(idno);
--CREATE INDEX chem_idno_idx ON chem_majors_nt(idno);
--CREATE INDEX physics_idno_idx ON physics_majors_nt(idno);
CREATE TABLE laptop (
   valid DATE, 
   feature_one computer_typ, -- nested tables (empty)
   feature_two computer_typ, 
   feature_three computer_typ)
  NESTED TABLE feature_one STORE AS feature_one_nt  -- storage tables
  NESTED TABLE feature_two STORE AS feature_two_nt
  NESTED TABLE feature_three STORE AS feature_three_nt;

CREATE INDEX feature_one_idno_idx ON feature_one_nt(idno);
CREATE INDEX feature_two_idno_idx ON feature_two_nt(idno);
CREATE INDEX feature_three_idno_idx ON feature_three_nt(idno);

--
--INSERT INTO students (graduation) VALUES ('01-JUN-03');
--UPDATE students
--  SET math_majors = 
--        people_typ (person_typ(12, 'Bob Jones', '650-555-0130'), 
--                    person_typ(31, 'Sarah Chen', '415-555-0120'),
--                    person_typ(45, 'Chris Woods', '415-555-0124')),
--      chem_majors = 
--        people_typ (person_typ(51, 'Joe Lane', '650-555-0140'), 
--                    person_typ(31, 'Sarah Chen', '415-555-0120'),
--                    person_typ(52, 'Kim Patel', '650-555-0135')),
--   physics_majors = 
--        people_typ (person_typ(12, 'Bob Jones', '650-555-0130'), 
--                    person_typ(45, 'Chris Woods', '415-555-0124'))
--WHERE graduation = '01-JUN-03';
--

INSERT INTO laptop (valid) VALUES ('01-JUN-03');
UPDATE students
  SET feature_one = 
        computer_typ (item_typ(12, 'ASUS', '2GB memory'), 
                    item_typ(13, 'ASUS', '4GB memory'),
                    item_typ(14, 'ASUS', '8GB memory')),
      feature_two = 
        computer_typ (item_typ(15, 'ACER', '2GB memory'), 
                    item_typ(16, 'ACER', '6GB memory'),
                    item_typ(17, 'ACER', '8GB memory')),
   feature_three = 
        computer_typ (item_typ(18, 'APPLE', '4GB memory'), 
                    item_typ(19, 'APPLE', '8GB memory'))
WHERE valid = '01-JUN-03';

--SELECT m.idno math_id, c.idno chem_id, p.idno physics_id  FROM students s,
-- TABLE(s.math_majors) m, TABLE(s.chem_majors) c, TABLE(s.physics_majors) p;

SELECT o.idno feature_one_idno_idx, t.idno feature_two_idno_idx, p.idno feature_three_idno_idx  FROM laptops s,
 TABLE(s.feature_one) o, TABLE(s.feature_two) t, TABLE(s.feature_three) p;

