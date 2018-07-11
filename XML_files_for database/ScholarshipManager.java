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
      int count = 0;

      while (rset.next()) {
          ++count;
          
      }

      if (count == 0) {
          System.out.println("9");
      }
      //System.out.println(count);
      rset.close();
      pstmt.close();
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