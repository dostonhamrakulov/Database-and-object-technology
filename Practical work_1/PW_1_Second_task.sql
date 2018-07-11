CREATE TYPE employee_type AS OBJECT(
employee_id NUMBER,
first_name VARCHAR2(30),
last_name VARCHAR2(30),
email VARCHAR2(30),
hire_date DATE,
job_id varchar2(30),
salar NUMBER(8, 2),
department VARCHAR2(20)
);
create table employee of employee_type;
drop table jobs;
drop type employee_type;
ALTER TABLE employee
ADD PRIMARY KEY (employee_id);

ALTER TABLE employee
ADD FOREIGN KEY (department) REFERENCES department(department_id);

INSERT INTO employee values(employee_type(1, 'Doston', 'Hamrakulov', 'doston@gmail.com', '01-AUG-04', 'SA_REP', 9000, 'AAA'));
INSERT INTO employee values(employee_type(2, 'Ever', 'Boston', 'ever@gmail.com', '09-SEP-12', 'SA_REP', 7000, 'AAA'));
INSERT INTO employee values(employee_type(3, 'Adburahim', 'Salim', 'abdu2498r@gmail.com', '24-JAN-10', 'RTU_ABD', 8000, 'BBB'));
INSERT INTO employee values(employee_type(4, 'Bek', 'Asim', 'BEK@gmail.com', '09-JUN-11', 'SA_REP', 7000, 'BBB'));
INSERT INTO employee values(employee_type(5, 'Sher', 'Utkur', 'sher7709@gmail.com', '15-MAY-15', 'SA_REP', 7700, 'AAA'));
INSERT INTO employee values(employee_type(6, 'Akosh', 'Rustamov', 'otash@gmail.com', '09-SEP-12', 'SA_REP', 7000, 'CCC'));

-- beginig second task

CREATE TABLE department (
    department_id       VARCHAR2(20) PRIMARY KEY,
    department_name     VARCHAR2(30),
    department_street   VARCHAR2(20),
    department_city     VARCHAR2(10),
    department_state    CHAR(2),
    department_zip      VARCHAR2(10));

drop table department;
ALTER TABLE employee
ADD FOREIGN KEY (department) REFERENCES department(department_name);

CREATE TYPE address_t AS OBJECT (
   street   VARCHAR2(20),
    city    VARCHAR2(10),
    state   CHAR(2),
    zip     VARCHAR2(10));
/
CREATE TYPE department_t AS OBJECT (
   department_id     NUMBER,
   department_name   VARCHAR2(20),
   address    address_t );
/

CREATE VIEW department_view OF department_t WITH OBJECT IDENTIFIER (department_if) AS
    SELECT d.department_id, d.department_name,
      address_t(d.deptstreet,d.deptcity,d.deptstate,d.deptzip) AS 
      deptaddr
      FROM dept d
--



