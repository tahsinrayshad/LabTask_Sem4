import java.sql.*;

public class Task5 {
    public static void main(String[] args) throws ClassNotFoundException {
        System.out.println("Task-5");
        try{
            // step1 load the driver class
            Class.forName("oracle.jdbc.driver.OracleDriver");

            // step2 create the connection object
            Connection con = DriverManager.getConnection(
                    "jdbc:oracle:thin:@localhost:1521:xe", "dbmslab3", "dbms");

            // step3 create the statement object
            Statement stmt = con.createStatement();
            try{
                String sql = "SELECT dept_name " +
                        "FROM (SELECT dept_name FROM student GROUP BY dept_name ORDER BY COUNT(*) DESC) " +
                        "WHERE ROWNUM <= 1";


                ResultSet rs = stmt.executeQuery(sql);

                if (rs.next()) {
                    String deptName = rs.getString("dept_name");

                    // Find the lowest ID value among the existing instructors
                    sql = "SELECT MIN(ID) AS min_id " +
                            "FROM instructor";

                    rs = stmt.executeQuery(sql);

                    if (rs.next()) {
                        String instructorId = String.valueOf(Integer.parseInt(rs.getString("min_id")) - 1);

                        // Calculate the average salary among all the instructors of the same department
                        sql = "SELECT AVG(salary) AS avg_salary " +
                                "FROM instructor " +
                                "WHERE dept_name = '" + deptName + "'";

                        rs = stmt.executeQuery(sql);

                        if (rs.next()) {
                            double salary = rs.getDouble("avg_salary");

                            // Insert the new instructor
                            sql = "INSERT INTO instructor (ID, name, dept_name, salary) VALUES ('" + instructorId + "', 'John Doe', '" + deptName + "', " + salary + ")";
                            stmt.executeUpdate(sql);

                            // Print the information of the instructor
                            System.out.println("Instructor ID: " + instructorId);
                            System.out.println("Name: John Doe");
                            System.out.println("Department Name: " + deptName);
                            System.out.println("Salary: " + salary);
                        }
                    }
                }
                rs.close();
                stmt.close();
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
