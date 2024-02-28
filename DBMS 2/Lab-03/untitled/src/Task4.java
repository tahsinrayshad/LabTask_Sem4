import java.sql.*;

public class Task4 {
    public static void main(String args[]) {
        System.out.println("Task-4");
        try{
            // step1 load the driver class
            Class.forName("oracle.jdbc.driver.OracleDriver");

            // step2 create the connection object
            Connection con = DriverManager.getConnection(
                    "jdbc:oracle:thin:@localhost:1521:xe", "dbmslab3", "dbms");

            // step3 create the statement object
            Statement stmt = con.createStatement();
            try {
                String sql = "SELECT i.ID, i.name " +
                        "FROM instructor i " +
                        "LEFT JOIN advisor a ON i.ID = a.i_ID " +
                        "WHERE a.s_ID IS NULL";

                ResultSet rs = stmt.executeQuery(sql);

                while (rs.next()) {
                    String instructorId = rs.getString("ID");
                    String instructorName = rs.getString("name");

                    System.out.println("Instructor ID: " + instructorId + ", Name: " + instructorName);


                    sql = "SELECT s.ID " +
                            "FROM student s " +
                            "LEFT JOIN advisor a ON s.ID = a.s_ID " +
                            "WHERE a.i_ID IS NULL AND s.dept_name = (SELECT dept_name FROM instructor WHERE ID = '" + instructorId + "') " +
                            "ORDER BY s.tot_cred ASC";

                    ResultSet rs2 = stmt.executeQuery(sql);
                    if (rs2.next()) {
                        String studentId = rs2.getString("ID");
                        System.out.println("Student ID: " + studentId);
                        // Assign the instructor to the student
                        sql = "INSERT INTO advisor (s_ID, i_ID) VALUES ('" + studentId + "', '" + instructorId + "')";
                        stmt.executeUpdate(sql);
                    } else {
                        // Print the names of the instructors who still do not have any students assigned to them
                        System.out.println(instructorName);
                    }

                    rs2.close();
                }

                rs.close();
                stmt.close();
                con.close();

            } catch (SQLException e) {
                e.printStackTrace();
            }

        } catch (SQLException | ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }
}

