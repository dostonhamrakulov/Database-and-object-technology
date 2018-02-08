--
--CREATE TYPE SHOPS AS OBJECT (
--  S_NUM NUMBER,
--  S_NAME VARCHAR2(30),
--  TEL VARCHAR2(20),
--  ORDER MEMBER FUNCTION total_goods(x SHOPS) RETURN INTEGER
--);
--/
--CREATE OR REPLACE TYPE BODY SHOPS AS
--MEMBER FUNCTION total_goods(x SHOPS) RETURN INTEGER IS
--BEGIN
--  RETURN (SELECT SUM(G.G_NUM) FROM GOODS G, SHOP S WHERE S.S_NAME = x);
--END total_goods;
--END;
--/
--CREATE TYPE GOODS AS OBJECT(
--  G_NUM NUMBER,
--  G_NAME VARCHAR2(30),
--  G_QUANTITY NUMBER,
--  G_PRICE NUMBER,
--  NUM_SHOP NUMBER,
--    
--);
--/
--drop type SHOPS;
--/
--
--
--INTO total_number 
--
--
--



--------======================First question ============================

CREATE TYPE SHOPS_TYP_1 AS OBJECT (
  S_NUM NUMBER,
  S_NAME VARCHAR2(30),
  TEL VARCHAR2(20)
  );
/

CREATE TYPE GOODS_T_1 AS OBJECT(
  G_NUM NUMBER,
  G_NAME VARCHAR2(30),
  G_QUANTITY NUMBER,
  G_PRICE NUMBER,
  NUM_SHOP REF SHOPS_TYP_1,
  MEMBER FUNCTION total RETURN NUMBER
);
/



CREATE OR REPLACE TYPE BODY GOODS_TYP_1 AS 
  
  MEMBER FUNCTION total RETURN INTEGER IS

      g_result GOODS_TYP_1.G_NUM%TYPE;
   BEGIN
      SELECT COUNT(G_NUM) INTO g_result
      FROM GOODS
      WHERE GOODS.NUM_SHOP.S_NAME = 'Centrs';
      dbms_output.put_line('Total amount of goods: '|| g_result);
    RETURN total;
  END total;
END;
/

CREATE TABLE GOODS OF GOODS_TYP_1;


SELECT Value(A).total() from GOODS A;

INSERT INTO GOODS VALUES(1, 'T-shirt', 20, 50, SHOPS_TYP_1(1, 'Centrs', '+371 2878000'));

---============================== Second question ========================
CREATE TYPE FACULTY_TYP AS OBJECT(
  F_number NUMBER,
  F_name VARCHAR2(30),
  F_tel VARCHAR2(30)
);
/
CREATE TYPE STUDENT_TYP AS OBJECT(
  St_number NUMBER,
  St_name VARCHAR2(30),
  St_surname VARCHAR2(30),
  Faculty REF FACULTY_TYP
);
/

CREATE TABLE FACULTY_TAB OF FACULTY_TYP;
CREATE TABLE STUDENT_TAB OF STUDENT_TYP;


INSERT INTO FACULTY_TAB VALUES(201, 'COMPUTER SCIENCE', '+371 28786188');
INSERT INTO FACULTY_TAB VALUES(202, 'TELECOMMUNICATION', '+371 28786188');
INSERT INTO FACULTY_TAB VALUES(203, 'DITF', '+371 28786188');

INSERT INTO STUDENT_TAB VALUES(1001, 'SANJAR', 'ESHONOV', (SELECT REF(F) FROM FACULTY_TAB F WHERE F.F_number = 203));
INSERT INTO STUDENT_TAB VALUES(1002, 'JOHN', 'SMITH', (SELECT REF(F) FROM FACULTY_TAB F WHERE F.F_number = 203));
INSERT INTO STUDENT_TAB VALUES(1003, 'JANE', 'MARRY', (SELECT REF(F) FROM FACULTY_TAB F WHERE F.F_number = 203));
INSERT INTO STUDENT_TAB VALUES(1004, 'SANJAR', 'ESHONOV', (SELECT REF(F) FROM FACULTY_TAB F WHERE F.F_number = 201));
INSERT INTO STUDENT_TAB VALUES(1005, 'JOHN', 'SMITH', (SELECT REF(F) FROM FACULTY_TAB F WHERE F.F_number = 20));
INSERT INTO STUDENT_TAB VALUES(1006, 'KUTPUT', 'BAJAN', (SELECT REF(F) FROM FACULTY_TAB F WHERE F.F_number = 203));

SELECT COUNT(S.St_number) FROM STUDENT_TAB S WHERE S.FACULTY.F_name = 'DITF';






---==================== third question  =================================



CREATE TABLE SHOPPING(
S_NUM NUMBER PRIMARY KEY,
S_NAME VARCHAR2(30),
S_ADDRESS VARCHAR2(30)

);
/

INSERT INTO SHOPPING VALUES(1, 'ORIGO SHOPPING CENTER', 'CENTRAL STATION');
INSERT INTO SHOPPING VALUES(2, 'ORIGO SHOPPING CENTER', 'CENTRAL STATION');
INSERT INTO SHOPPING VALUES(3, 'ORIGO SHOPPING CENTER', 'CENTRAL STATION');
INSERT INTO SHOPPING VALUES(4, 'ORIGO SHOPPING CENTER', 'CENTRAL STATION');
INSERT INTO SHOPPING VALUES(5, 'ORIGO SHOPPING CENTER', 'CENTRAL STATION');

select COLUMN_NAME
from ALL_TAB_COLUMNS
where TABLE_NAME = 'SHOPPING';

declare
	cursor  KURSORS_A  is
select COLUMN_NAME
from ALL_TAB_COLUMNS
where TABLE_NAME = 'SHOPPING';
type  TAB_AR_KOL_TIPS  is table of  KURSORS_A%rowtype;
	tabula_ar_kol	TAB_AR_KOL_TIPS := TAB_AR_KOL_TIPS();
	i		number default  1;
begin
   	for  m_raksts  in  KURSORS_A  loop     
		tabula_ar_kol.extend; 		
tabula_ar_kol(i) := m_raksts;
        		DBMS_OUTPUT.PUT_LINE(tabula_ar_kol(i).COLUMN_NAME);
       		i := i +1;      
   	end loop;                                                                                       
end;

--- =================== fourth question =================================


CREATE TYPE GOODS_TYP AS OBJECT(
  G_NUM NUMBER,
  G_NAME VARCHAR2(30),
  G_QUANTITY NUMBER,
  NUM_SHOP NUMBER
    
);
/
DROP TABLE PURCHASE_TAB;
CREATE TYPE SHOPS_TYP AS OBJECT (
  S_NUM NUMBER,
  S_NAME VARCHAR2(30),
  TEL VARCHAR2(20)
);
/

CREATE TYPE PURCHASE AS OBJECT(
  GOODS_ID NUMBER,
  GOODS_DETAILS GOODS_TYP,
  SHOP_DETAILS SHOPS_TYP
);
/

CREATE TABLE PURCHASE_TAB OF PURCHASE;

INSERT INTO PURCHASE_TAB VALUES(1, GOODS_TYP(501, 'T-SHIRT', 5, 501), 
            SHOPS_TYP(501, 'Kurzeme', '+ 000000'));
            
INSERT INTO PURCHASE_TAB VALUES(2, GOODS_TYP(502, 'T-SHIRT', 5, 501), 
            SHOPS_TYP(501, 'Kurzeme', '+ 000000'));
            
INSERT INTO PURCHASE_TAB VALUES(3, GOODS_TYP(503, 'T-SHIRT', 5, 501), 
            SHOPS_TYP(501, 'Kurzeme', '+ 000000'));
            
INSERT INTO PURCHASE_TAB VALUES(4, GOODS_TYP(504, 'T-SHIRT', 5, 501), 
            SHOPS_TYP(501, 'Kurzeme', '+ 000000'));
            
            
SELECT P.GOODS_DETAILS.G_NAME FROM PURCHASE_TAB P WHERE P.SHOP_DETAILS.S_NAME = 'Kurzeme';


----------------- ========================= sixth =================
<Books>
  <Book>
    <author>Doston</author>
    <name>Java development</name>
  <Book>
</Books>

create table book_tab(
author varchar2(30),
name varchar2(30)
);
/


insert into book_tab (author, name)
select x.author, x.name
from xmltable(
'/Books/Book'
passing xmltype(
bfilename('MY_DIR', 'Books.xml'),
nls_charset_id('AL32UTF8')
)
columns id      integer      path '@cid',
author    varchar2(30) path 'author',
name varchar2(30) path 'name'
) x
;

select * from book_tab;
            