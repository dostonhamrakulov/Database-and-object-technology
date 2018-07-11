--CREATE OR REPLACE TYPE obj_map
--IS
--  OBJECT
--  (
--    obj_var1 NUMBER,
--    MEMBER PROCEDURE print,
--    MAP MEMBER FUNCTION func_map RETURN NUMBER);
--  /
--CREATE OR REPLACE TYPE body obj_map
--IS
--  MEMBER PROCEDURE print
--IS
--BEGIN
--  dbms_output.put_line(self.obj_var1);
--END;
--MAP MEMBER FUNCTION func_map RETURN NUMBER
--IS
--BEGIN
--  RETURN obj_var1;
--END;
--END;
--/

CREATE OR REPLACE TYPE empty_pool_typ AS OBJECT (
  length    INTEGER,
  width    INTEGER,
  height    INTEGER,
  MEMBER FUNCTION surface RETURN INTEGER,
  MEMBER FUNCTION volume RETURN INTEGER,
  MEMBER FUNCTION peremeter RETURN INTEGER,
  MEMBER PROCEDURE display (SELF IN OUT NOCOPY empty_pool_typ));
/

CREATE OR REPLACE TYPE BODY empty_pool_typ AS
  MEMBER FUNCTION volume RETURN INTEGER IS
  BEGIN
    RETURN length * width * height;
 -- RETURN SELF.len * SELF.wth * SELF.hgt; -- equivalent to previous line 
  END;
  MEMBER FUNCTION surface RETURN INTEGER IS
  BEGIN -- not necessary to include SELF in following line
    RETURN 2 * (length * width + length * height + width * height);
  END;
  MEMBER FUNCTION peremeter RETURN INTEGER IS
  BEGIN
    RETURN length + width + height;
  END;
  MEMBER PROCEDURE display (SELF IN OUT NOCOPY empty_pool_typ) IS
  BEGIN
    DBMS_OUTPUT.PUT_LINE('Length: ' || length || ' - '  || 'Width: ' || width 
                          || ' - '  || 'Height: ' || height);
    DBMS_OUTPUT.PUT_LINE('Volume: ' || volume || ' - ' || 'Surface area: ' 
                          || surface || ' - ' || 'Premeter: ' || peremeter);
  END;
END;
/


-- Table creation
CREATE TABLE empty_pool of empty_pool_typ;
-- Insertin data
INSERT INTO empty_pool VALUES(10, 10, 10);
INSERT INTO empty_pool VALUES(3, 4, 5);
INSERT INTO empty_pool VALUES(7, 8, 9);
INSERT INTO empty_pool VALUES(4, 5, 8);

SELECT * FROM empty_pool;

SELECT p.volume(), p.surface(), p.peremeter() FROM empty_pool p WHERE p.length = 10;
DECLARE
  pool empty_pool_typ;
BEGIN -- PL/SQL block for selecting a solid and displaying details
  SELECT VALUE(p) INTO pool FROM empty_pool p WHERE p.length = 10;
  pool.display();
END;
/