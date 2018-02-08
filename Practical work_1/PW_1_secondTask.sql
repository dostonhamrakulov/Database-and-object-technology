-- Creating different tables
CREATE OR REPLACE TYPE AddressType AS OBJECT(
    street VARCHAR2(15),
    city   VARCHAR2(15),
    state  CHAR(2),
    zip    VARCHAR2(5)
);
/

CREATE Or Replace TYPE PersonType AS OBJECT (
    id         NUMBER,
    first_name VARCHAR2(10),
    last_name  VARCHAR2(10),
    dob        DATE,
    phone      VARCHAR2(12),
    address    AddressType
);
/

CREATE TABLE object_reader OF PersonType;

INSERT INTO object_reader VALUES (
    PersonType(1, 'Doston', 'Hamrakulov', '04-SEP-1995', '800-555-5555', 
    AddressType('Kalku 1', 'City', 'LS', '12345')
  )
);
INSERT INTO object_reader VALUES (
    PersonType(2, 'John', 'White', '04-FEB-1945', '800-555-5555', 
    AddressType('2 Ave', 'City', 'UZ', '12345')
  )
);
-- Different style of input data
INSERT INTO object_reader (
    id, first_name, last_name, dob, phone,
    address
    ) VALUES (
    3, 'Bobosher', 'Hamroyev', '05-FEB-1968', '93-727-08-95',
    AddressType('Tashkent 2', 'Town', 'UZ', '12345')
);
INSERT INTO object_reader (
    id, first_name, last_name, dob, phone,
    address
    ) VALUES (
    4, 'Rustam', 'Yuldoshev', '13-NOV-1987', '888-888-8888',
    AddressType('UBBER 23', 'City', 'MA', '12345')
);


CREATE OR REPLACE TYPE BookType AS OBJECT (
    id NUMBER,
    name VARCHAR2(15),
    description VARCHAR2(22),
    price NUMBER(5, 2),
    days_valid NUMBER,
    MEMBER FUNCTION getByDate RETURN DATE
);
/
CREATE TABLE object_book OF BookType;
 
INSERT INTO object_book (
    id, name, description, price, days_valid
    ) VALUES (
    1, 'AAA', 'English Grammar', 2.99, 5
);
INSERT INTO object_book (
    id, name, description, price, days_valid
    ) VALUES (
    2, 'BBB', 'Detactive book', 9.99, 10
);
INSERT INTO object_book (
    id, name, description, price, days_valid
    ) VALUES (
    3, 'CCC', 'Romantic stories', 9.99, 10
);
/

CREATE TABLE borrow_book (
    id     NUMBER PRIMARY KEY,
    reader REF PersonType  SCOPE IS object_reader,
    book  REF BookType SCOPE IS object_book
);
/

INSERT INTO borrow_book (
    id,
    reader,
    book
    ) VALUES (
    1,
    (SELECT REF(o_r) FROM object_reader o_r WHERE o_r.id = 1),
    (SELECT REF(o_b) FROM object_book  o_b WHERE o_b.id = 1)
);
INSERT INTO borrow_book (
    id,
    reader,
    book
    ) VALUES (
    2,
    (SELECT REF(o_r) FROM object_reader o_r WHERE o_r.id = 2),
    (SELECT REF(o_b) FROM object_book  o_b WHERE o_b.id = 2)
);
INSERT INTO borrow_book (
    id,
    reader,
    book
    ) VALUES (
    3,
    (SELECT REF(o_r) FROM object_reader o_r WHERE o_r.id = 3),
    (SELECT REF(o_b) FROM object_book  o_b WHERE o_b.id = 3)
);
/

select * from borrow_book;

SELECT item_id, item_name, keywords
  FROM item_view i
  WHERE i.item_id =102;

