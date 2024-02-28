import java.sql.*;

public class Task2 {
    public static void main(String[] args) throws ClassNotFoundException {
        System.out.println("Task-2");
        try{
            // step1 load the driver class
            Class.forName("oracle.jdbc.driver.OracleDriver");

            // step2 create the connection object
            Connection con = DriverManager.getConnection(
                    "jdbc:oracle:thin:@localhost:1521:xe", "dbmslab3", "dbms");

            // step3 create the statement object
            Statement stmt = con.createStatement();
            String q3 = "select title, name\n" +
                    "from course, student, takes\n" +
                    "where course.course_id = takes.course_id \n" +
                    "and takes.ID = student.ID \n" +
                    "and course.course_id \n" +
                    "not in (select prereq_id from prereq where prereq.course_id = course.course_id);";
            ResultSet rs3 = stmt.executeQuery(q3);
            while (rs3.next()) {
                // Display values
                System.out.print("Title: " + rs3.getString("title"));
                System.out.print(", Name: " + rs3.getString("name"));
                System.out.println("\n");
            }
            rs3.close();

            con.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
