
CREATE TABLE items (
   item_id INTEGER NOT NULL,
   item_name VARCHAR2(512),
   item_type VARCHAR2(12),
   price INTEGER,
   CONSTRAINT item_pk PRIMARY KEY (item_id));
/
CREATE TABLE keywords (
   item_id INTEGER NOT NULL,
   keyword VARCHAR2(45) NOT NULL,
   CONSTRAINT keywords_pk PRIMARY KEY (item_id, keyword),
   CONSTRAINT keywords_for_item FOREIGN KEY (item_id)
      REFERENCES items (item_id));
/
CREATE TYPE Keyword_tab_t AS TABLE OF VARCHAR2(45);

CREATE TYPE items_t AS OBJECT (
    item_id INTEGER,
    item_name VARCHAR2(512),
    item_t    VARCHAR2(12),
    price INTEGER,
    keywords Keyword_tab_t,
    MEMBER FUNCTION set_attributes (new_item_name IN VARCHAR2,
       new_item_type IN VARCHAR2, new_price IN INTEGER)
       RETURN items_t,
    MEMBER FUNCTION set_keywords (new_keywords IN Keyword_tab_t)
       RETURN items_t,
    PRAGMA RESTRICT_REFERENCES (DEFAULT, RNDS, WNDS, RNPS, WNPS)
);
/
-- Here is a body
CREATE TYPE BODY items_t
AS
   MEMBER FUNCTION set_attributes (new_item_name IN VARCHAR2,
       new_item_type IN VARCHAR2, new_price IN INTEGER)
       RETURN items_t
   IS
      item_holder items_t := SELF;
   BEGIN
      item_holder.item_name := new_item_name;
      item_holder.item_t := new_item_type;
      item_holder.price := new_price;
      RETURN item_holder;
   END;
   MEMBER FUNCTION set_keywords (new_keywords IN Keyword_tab_t)
       RETURN items_t
   IS
      item_holder items_t := SELF;
   BEGIN
      item_holder.keywords := new_keywords;
      RETURN item_holder;
   END;
END;
/
-- Finally, to create the object view, we use the following statement:
CREATE VIEW item_view
   OF items_t
   WITH OBJECT OID (item_id)
AS
   SELECT i.item_id, i.item_name, i.item_type, i.price,
      CAST (MULTISET (SELECT keyword
                        FROM keywords k
                       WHERE k.item_id = i.item_id)
        AS Keyword_tab_t)
     FROM items i;
     
-- Inserting data
INSERT INTO items VALUES (101, 'Lenova', 'LAPTOP', 813);
INSERT INTO items VALUES (102, 'ASUS', 'LAPTOP', 972);

INSERT INTO KEYWORDS VALUES (101, 'new 8GB');
INSERT INTO KEYWORDS VALUES (101, 'Intel Core i7');

INSERT INTO KEYWORDS VALUES (102, 'used 4GB MEMORY');
INSERT INTO KEYWORDS VALUES (102, 'Intel Intel Core i3');
INSERT INTO KEYWORDS VALUES (102, 'SSD driver, 512GB');

SELECT item_id, item_name, keywords
  FROM item_view;
