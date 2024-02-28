import java.sql.*;
import java.util.Scanner;

public class Task3 {
    public static void main(String[] args) throws ClassNotFoundException {
        System.out.println("Task-3");
        Scanner scanner = new Scanner(System.in);
        System.out.println("Enter the student's name:");
        String studentName = scanner.nextLine();

        try{
            // step1 load the driver class
            Class.forName("oracle.jdbc.driver.OracleDriver");

            // step2 create the connection object
            Connection con = DriverManager.getConnection(
                    "jdbc:oracle:thin:@localhost:1521:xe", "dbmslab3", "dbms");

            // step3 create the statement object
            Statement stmt = con.createStatement();
            String sql = "SELECT ts.day, ts.start_hr, ts.start_min, ts.end_hr, ts.end_min, s.course_id, c.title, s.building, s.room_number " +
                    "FROM student st " +
                    "JOIN takes t ON st.ID = t.ID " +
                    "JOIN section s ON t.course_id = s.course_id " +
                    "AND t.sec_id = s.sec_id " +
                    "AND t.semester = s.semester " +
                    "AND t.year = s.year " +
                    "JOIN time_slot ts ON s.time_slot_id = ts.time_slot_id " +
                    "JOIN course c ON s.course_id = c.course_id " +
                    "WHERE st.name = '" + studentName + "' " +
                    "ORDER BY CASE ts.day " +
                    "WHEN 'Monday' THEN 1 " +
                    "WHEN 'Tuesday' THEN 2 " +
                    "WHEN 'Wednesday' THEN 3 " +
                    "WHEN 'Thursday' THEN 4 " +
                    "WHEN 'Friday' THEN 5 " +
                    "WHEN 'Saturday' THEN 6 " +
                    "WHEN 'Sunday' THEN 7 " +
                    "END, ts.start_hr, ts.start_min";

            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                String day = rs.getString("day");
                String startTime = rs.getInt("start_hr") + ":" + rs.getInt("start_min");
                String endTime = rs.getInt("end_hr") + ":" + rs.getInt("end_min");
                String courseId = rs.getString("course_id");
                String title = rs.getString("title");
                String building = rs.getString("building");
                String roomNumber = rs.getString("room_number");

                System.out.println(day);
                System.out.println(startTime + " - " + endTime);
                System.out.println(courseId + " - " + title);
                System.out.println(building + " - " + roomNumber);
                System.out.println();
            }
            rs.close();
            con.close();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
