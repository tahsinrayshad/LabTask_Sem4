import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.sql.ResultSet;
import java.sql.*;
public class Task1 {
    public static void main(String[] args) throws ClassNotFoundException {
        System.out.println("Task-1");
        try{
            // step1 load the driver class
            Class.forName("oracle.jdbc.driver.OracleDriver");

            // step2 create the connection object
            Connection con = DriverManager.getConnection(
                    "jdbc:oracle:thin:@localhost:1521:xe", "dbmslab3", "dbms");

            // step3 create the statement object
            Statement stmt = con.createStatement();
            String q1 = "update instructor\n" +
                    "set salary = 9000 *\n" +
                    "(select sum(credits) from course where course_id in\n" +
                    "(select course_id from teaches where teaches.ID = instructor.ID));";
            stmt.executeUpdate(q1);
            String q2 = "select name \n" +
                    "from instructor\n" +
                    "where salary > 9000;";
            ResultSet rs2 = stmt.executeQuery(q2);
            while (rs2.next()) {
                // Display values
                System.out.print("Name: " + rs2.getString("name"));
                System.out.println("\n");
            }
            rs2.close();
            con.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
