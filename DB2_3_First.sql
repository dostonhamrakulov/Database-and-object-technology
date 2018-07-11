CREATE OR REPLACE FUNCTION Student RETURN VARCHAR2 AS
  LANGUAGE JAVA NAME 'Student.myStr () return java.lang.String';
/

VARIABLE myString VARCHAR2(50);
CALL Student() INTO :myString;

PRINT myString;


select  OBJECT_NAME, OBJECT_TYPE, STATUS, CREATED, 
GENERATED from  USER_OBJECTS 
where CREATED >= TO_DATE('25-11-2017', 'DD-MM-YYYY'); 


CREATE or replace JAVA source named "Billionaire" AS 
  public class Billionaire {
	

	public static String myStr() {

		//Creating array from objects
		String billionaire[] = new String[5];
		
		
		String myString = "";

		//Filling array based on Object Construction
		billionaire[0] = "Doston";
		billionaire[1] = "Hamrakulov";
		billionaire[2] = "$1 000 000 000 000 000m";
		billionaire[3] = "Samarkand";
		billionaire[4] = "Uzbekistan";

		for (int i = 0; i < billionaire.length; i++) {
			myString = myString + billionaire[i] + "  ";
		}
		return myString;
	}
	
	public static void main(String[] args) {
		Billionaire st = new Billionaire();
		System.out.println(st.myStr());
	}
}
/

CREATE OR REPLACE FUNCTION Billionaire RETURN VARCHAR2 AS
  LANGUAGE JAVA NAME 'Billionaire.myStr () return java.lang.String';
/

VARIABLE myString VARCHAR2(50);
CALL Student() INTO :myString;

PRINT myString;

--Metadata
select  OBJECT_NAME, OBJECT_TYPE, STATUS, CREATED, 
GENERATED from  USER_OBJECTS 
where CREATED >= TO_DATE('25-11-2017', 'DD-MM-YYYY');

--
--select status, count(status) from all_objects where object_type='JAVA CLASS' group by status;
--
--create or replace directory JAVADIR as 'C:\Java_files_for_database';
--
--

--
--BEGIN
--   FOR cur_rec IN (SELECT object_name, object_type
--                     FROM user_objects
--                    WHERE object_type IN
--                             ('TABLE',
--                              'VIEW',
--                              'PACKAGE',
--                              'PROCEDURE',
--                              'FUNCTION',
--                              'SEQUENCE',
--                              'SYNONYM',
--                              'PACKAGE BODY'
--                             ))
--   LOOP
--      BEGIN
--         IF cur_rec.object_type = 'TABLE'
--         THEN
--            EXECUTE IMMEDIATE    'DROP '
--                              || cur_rec.object_type
--                              || ' "'
--                              || cur_rec.object_name
--                              || '" CASCADE CONSTRAINTS';
--         ELSE
--            EXECUTE IMMEDIATE    'DROP '
--                              || cur_rec.object_type
--                              || ' "'
--                              || cur_rec.object_name
--                              || '"';
--         END IF;
--      EXCEPTION
--         WHEN OTHERS
--         THEN
--            DBMS_OUTPUT.put_line (   'FAILED: DROP '
--                                  || cur_rec.object_type
--                                  || ' "'
--                                  || cur_rec.object_name
--                                  || '"'
--                                 );
--      END;
--   END LOOP;
--END;
/









CREATE TABLE University (
Univ_id NUMBER(3) NOT NULL,
Title VARCHAR2(30) NOT NULL,
Street VARCHAR2(20) NOT NULL,
City VARCHAR2(20) NOT NULL,
State CHAR(2) NOT NULL,
Zip VARCHAR2(10) NOT NULL,
Phone VARCHAR2(12),
PRIMARY KEY (Univ_id)
);
/

--
CREATE TABLE Applicant ( 
Applicant_id NUMBER(3) NOT NULL,
Name VARCHAR2(30) NOT NULL,
Surname VARCHAR2(30) NOT NULL,
Country VARCHAR2(30) NOT NULL,
University NUMBER(3) REFERENCES University,
PRIMARY KEY (Applicant_id)
);
/

CREATE TABLE Scholarship (
Scholar_id NUMBER(4) PRIMARY KEY,
Description VARCHAR2(20),
Duration VARCHAR2(30),
Grant_amount NUMBER(3)
);
/

CREATE TABLE LineApplications (
LineNo NUMBER(2),
Applicant_id NUMBER(3) REFERENCES Applicant,
Scholar_id NUMBER(4) REFERENCES Scholarship,
Deadline VARCHAR2(20),
PRIMARY KEY (LineNo, Applicant_id)
);
/



CREATE OR REPLACE PACKAGE scholar_mgr AUTHID CURRENT_USER AS
PROCEDURE add_university (univ_id NUMBER, title VARCHAR2, 
street VARCHAR2, city VARCHAR2, state CHAR, zip VARCHAR2, phone VARCHAR2);
PROCEDURE add_scholarship (scholar_id NUMBER, description VARCHAR2,
duration VARCHAR2, grant_amount NUMBER);
PROCEDURE enter_applicant (applicant_id NUMBER, name VARCHAR2,
surname VARCHAR2, country VARCHAR2, university NUMBER);
PROCEDURE add_line_application( lineNo NUMBER, applicant_id NUMBER, 
scholar_id NUMBER, deadline VARCHAR);
PROCEDURE total_applications;
PROCEDURE delete_application (applicant_id NUMBER);
END scholar_mgr;
/





CREATE OR REPLACE PACKAGE BODY scholar_mgr AS
--University
PROCEDURE add_university (univ_id NUMBER, title VARCHAR2, 
street VARCHAR2, city VARCHAR2, state CHAR, zip VARCHAR2, phone VARCHAR2) AS LANGUAGE JAVA
NAME 'ScholarshipManager.addUniversity(int, java.lang.String, java.lang.String,
			   java.lang.String, java.lang.String, java.lang.String, java.lang.String)';
--Scholarship
PROCEDURE add_scholarship (scholar_id NUMBER, description VARCHAR2,
duration VARCHAR2, grant_amount NUMBER) AS LANGUAGE JAVA
NAME 'ScholarshipManager.addScholarship(int, java.lang.String, java.lang.String, int)';

--Applicant
PROCEDURE enter_applicant (applicant_id NUMBER, name VARCHAR2,
surname VARCHAR2, country VARCHAR2, university NUMBER) AS LANGUAGE JAVA
NAME 'ScholarshipManager.enterApplicant(int, java.lang.String, java.lang.String, java.lang.String, int)';

--LineApplications
PROCEDURE add_line_application(lineNo NUMBER, applicant_id NUMBER, 
scholar_id NUMBER, deadline VARCHAR) AS LANGUAGE JAVA
NAME 'ScholarshipManager.addLineApplication(int, int, int, java.lang.String)';

--total_application for totalApplication method in Java
PROCEDURE total_applications AS LANGUAGE JAVA
NAME 'ScholarshipManager.totalApplications()';

--for delete application method in Java
PROCEDURE delete_application (applicant_id NUMBER) AS LANGUAGE JAVA
NAME 'ScholarshipManager.deleteApplication(int)';
END scholar_mgr;





select A.* from LineApplications A;



BEGIN
  scholar_mgr.add_scholarship(2010, 'New UzbekGrant', '6 month', 900);
  scholar_mgr.add_scholarship(2011, 'Young UzbekGrant', '6 month', 800);
  scholar_mgr.add_scholarship(2012, 'New UzbekGrant', '6 month', 900);
  scholar_mgr.add_scholarship(2013, 'Korean Grant', '6 month', 900);
  scholar_mgr.add_scholarship(2014, 'German Grant', '6 month', 100);
  scholar_mgr.add_scholarship(2015, 'Samarkand Grant', '6 month', 300);
  scholar_mgr.add_scholarship(2016, 'Latvian Grant', '2 month', 500);
  COMMIT;
END;



BEGIN
  scholar_mgr.add_university(100, 'Uzbek National Uni', 'Beruniy 12', 'Tashkent', 'UZ', '07000', '+99893777703');
  scholar_mgr.add_university(101, 'Westmenester', 'Nurota 34', 'Samarkand', 'UZ', '04450', '+99893777703');
  scholar_mgr.add_university(102, 'RTU', 'KALKU 1', 'RIGA', 'LV', '07000', '+371232323');  
  COMMIT;
END;


BEGIN
  scholar_mgr.enter_applicant(500, 'Doston', 'Hamrakulov', 'Uzbekistan', 100);
  scholar_mgr.add_line_application(01, 500, 2010, '21-SEP-2019');
  scholar_mgr.add_line_application(02, 500, 2012, '21-SEP-2019');
  scholar_mgr.add_line_application(03, 500, 2015, '21-SEP-2019');
  
  scholar_mgr.enter_applicant(501, 'Orif', 'Doniyarov', 'Uzbekistan', 101);
  scholar_mgr.add_line_application(04, 501, 2012, '21-SEP-2019');
  scholar_mgr.add_line_application(05, 501, 2013, '21-DEC-2019');
  scholar_mgr.add_line_application(06, 501, 2016, '21-OCT-2019');
  
  scholar_mgr.enter_applicant(502, 'John', 'Smith', 'UK', 102);
  scholar_mgr.add_line_application(07, 502, 2012, '21-JUN-2018');
  scholar_mgr.add_line_application(08, 502, 2011, '21-JUN-2018');
  scholar_mgr.add_line_application(09, 502, 2013, '21-JUN-2018');
  COMMIT;
END;




SET SERVEROUTPUT ON
CALL dbms_java.set_output(2000);

CALL scholar_mgr.total_applications();











CREATE OR REPLACE AND COMPILE JAVA SOURCE NAMED "ScholarshipManager" AS
import java.sql.*;
import java.io.*;
import oracle.jdbc.*;

public class ScholarshipManager
{
	public static void addUniversity (int univer_id, String Title, String street,
			   String city, String state, String zipCode, String phoneNo) throws SQLException
			  {
			    String sql = "INSERT INTO Customers VALUES (?,?,?,?,?,?,?)";
			    try
			    {
			      Connection conn = DriverManager.getConnection("jdbc:default:connection:");
			      PreparedStatement pstmt = conn.prepareStatement(sql);
			      pstmt.setInt(1, univer_id);
			      pstmt.setString(2, Title);
			      pstmt.setString(3, street);
			      pstmt.setString(4, city);
			      pstmt.setString(5, state);
			      pstmt.setString(6, zipCode);
			      pstmt.setString(7, phoneNo);
			      pstmt.executeUpdate();
			      pstmt.close();
			    }
			    catch (SQLException e) 
			    {
			      System.err.println(e.getMessage());
			    }
			  }

  public static void addScholarship (int scholar_id, String description, String duration, int grant_amount)
                                                               throws SQLException
  {
    String sql = "INSERT INTO StockItems VALUES (?,?,?,?)";
    try
    {
      Connection conn = DriverManager.getConnection("jdbc:default:connection:");
      PreparedStatement pstmt = conn.prepareStatement(sql);
      pstmt.setInt(1, scholar_id);
      pstmt.setString(2, description);
      pstmt.setString(3, duration);
      pstmt.setInt(4, grant_amount);
      pstmt.executeUpdate();
      pstmt.close();
    }
    catch (SQLException e)
    {
      System.err.println(e.getMessage());
    }
  }

  
  public static void enterApplicant (int applicant_id, String name, String surname, String country, int university) throws SQLException
  {
    String sql = "INSERT INTO Customers VALUES (?,?,?,?,?)";
    try
    {
      Connection conn = DriverManager.getConnection("jdbc:default:connection:");
      PreparedStatement pstmt = conn.prepareStatement(sql);
      pstmt.setInt(1, applicant_id);
      pstmt.setString(2, name);
      pstmt.setString(3, surname);
      pstmt.setString(4, country);
      pstmt.setInt(5, university);
      pstmt.executeUpdate();
      pstmt.close();
    }
    catch (SQLException e) 
    {
      System.err.println(e.getMessage());
    }
  }

  public static void addLineApplication (int lineNo, int applicant_id, int scholar_id, String deadline) throws SQLException
  {
    String sql = "INSERT INTO LineItems VALUES (?,?,?,?)";
    try
    {
      Connection conn = DriverManager.getConnection("jdbc:default:connection:");
      PreparedStatement pstmt = conn.prepareStatement(sql);
      pstmt.setInt(1, lineNo);
      pstmt.setInt(2, applicant_id);
      pstmt.setInt(3, scholar_id);
      pstmt.setString(4, deadline);
      pstmt.executeUpdate();
      pstmt.close();
    }
    catch (SQLException e)
    {
      System.err.println(e.getMessage());
    }
  }

  public static void totalApplications () throws SQLException 
  {
    
   String sql = "SELECT A.Applicant_id, ROUND(SUM(S.Grant_amount * S.Grant_amount)) AS TOTAL " + 
    		"FROM Applicant A, LineApplications L, Scholarship S " + 
    		"WHERE A.Applicant_id = L.Applicant_id AND L.Scholar_id = S.Scholar_id " +
    		"GROUP BY A.Applicant_id";
    try
    {
      Connection conn = DriverManager.getConnection("jdbc:default:connection:");
      PreparedStatement pstmt = conn.prepareStatement(sql);
      ResultSet rset = pstmt.executeQuery();
      
       while (rset.next()) {
          ++count;
          
      }

      if (count == 0) {
          System.out.println("No records found");
      }
      System.out.println(count);
      rset.close();
      pstmt.close();
    }
    catch (SQLException e)
    {
      System.err.println(e.getMessage());
    }
  }

  static void printResults (ResultSet rset) throws SQLException
  {
    String buffer = "";
    try
    {
      ResultSetMetaData meta = rset.getMetaData();
      int cols = meta.getColumnCount(), rows = 0;
      for (int i = 1; i <= cols; i++)
      {
        int size = meta.getPrecision(i);
        String label = meta.getColumnLabel(i);
        if (label.length() > size)
          size = label.length();
        while (label.length() < size)
          label += " ";
        buffer = buffer + label + " ";
      }
      buffer = buffer + "\n";
      while (rset.next())
      {
        rows++;
        for (int i = 1; i <= cols; i++)
        {
          int size = meta.getPrecision(i);
          String label = meta.getColumnLabel(i);
          String value = rset.getString(i);
          if (label.length() > size) 
            size = label.length();
          while (value.length() < size)
            value += " ";
          buffer = buffer + value + " ";
        }
        buffer = buffer + "\n";
      }
      if (rows == 0)
        buffer = "No data found!\n";
      System.out.println(buffer);
    }
    catch (SQLException e)
    {
      System.err.println(e.getMessage());
    }
  }

  public static void deleteApplication (int applicantNo) throws SQLException
  {
    String sql = "DELETE FROM LineApplications WHERE Applicant_id = ?";
    try
    {
      Connection conn = DriverManager.getConnection("jdbc:default:connection:");
      PreparedStatement pstmt = conn.prepareStatement(sql);
      pstmt.setInt(1, applicantNo);
      pstmt.executeUpdate();
      sql = "DELETE FROM Applicant WHERE Applicant_id = ?";
      pstmt = conn.prepareStatement(sql);
      pstmt.setInt(1, applicantNo);
      pstmt.executeUpdate();
      pstmt.close();
    }
    catch (SQLException e)
    {
      System.err.println(e.getMessage());
    }
  }
}
/


