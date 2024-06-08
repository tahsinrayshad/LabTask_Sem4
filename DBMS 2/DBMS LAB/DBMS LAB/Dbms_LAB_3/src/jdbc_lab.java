import oracle.jdbc.driver.OracleTypes;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class jdbc_lab {
    public List<Instructor> instructorList = new ArrayList<>();
    public void LoadInstructorIntoList() throws ClassNotFoundException, SQLException {

        instructorList.clear();
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection con = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:xe", "ONI", "7066");

        Statement stmt = con.createStatement();

//task-1
        //Now I will fetch all the instrcutors into instructor list

        String QUERY = "SELECT ID,name,dept_name,salary from Instructor";



        ResultSet rs = stmt.executeQuery(QUERY);

        while(rs.next())
        {
            int id = rs.getInt("ID");

            String name = rs.getString("name");

            String dept_name = rs.getString("dept_name");

            double salary = rs.getDouble("salary");

            Instructor instructor = new Instructor(id,name,dept_name,salary);
            instructorList.add(instructor);
        }
        con.close();
    }


    public void FetchTotalCreditsOfInstructor() throws ClassNotFoundException, SQLException {



        for(int i=0;i<instructorList.size();i++)
        {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection con = DriverManager.getConnection(
                    "jdbc:oracle:thin:@localhost:1521:xe", "ONI", "7066");

            Statement stmt = con.createStatement();

            String query = "Select  instructor.name,sum(credits)\n" +
                    "from instructor,teaches,COURSE\n" +
                    "where instructor.ID=teaches.ID AND teaches.course_id=course.course_id AND instructor.ID="+instructorList.get(i).ID+"\n" +
                    "group by  instructor.ID,instructor.name";

            ResultSet rs = stmt.executeQuery(query);

            while (rs.next())
            {
                String name = rs.getString(1);
                double total_cred = rs.getDouble(2);



                instructorList.get(i).setTotalCredits(total_cred);

            }

            con.close();
        }
    }

    public void UpdateSalaryOfInstructor(int id, double salary) throws SQLException, ClassNotFoundException {

            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection con = DriverManager.getConnection(
                    "jdbc:oracle:thin:@localhost:1521:xe", "ONI", "7066");

            Statement stmt = con.createStatement();

            String query = "Update Instructor set salary ="+salary+" where ID ="+id+"";

           stmt.executeUpdate(query);

    }

    public void ShowCourseTitleAndEligibleStudents() throws SQLException, ClassNotFoundException {
        Class.forName("oracle.jdbc.driver.OracleDriver");
        Connection con = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:xe", "ONI", "7066");

        Statement stmt = con.createStatement();

//task-1
        //Now I will fetch all the instrcutors into instructor list

        String QUERY = "select  distinct course.course_id,student.name\n" +
                "from student,takes,COURSE\n" +
                "where student.ID=takes.ID AND takes.course_id=course.course_id\n" +
                "AND takes.course_id in (select prereq_id from prereq)";



        ResultSet rs = stmt.executeQuery(QUERY);

        System.out.println("COURSE ID   STUDENT NAME");
        while(rs.next())
        {
            String course_id = rs.getString("Course_ID");
            String name = rs.getString("name");

            System.out.println(course_id+"      "+name);
        }
        con.close();
    }

    //task 3
    public static void printStudentSchedule(String studentName) {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection connection = DriverManager.getConnection(
                    "jdbc:oracle:thin:@localhost:1521:xe", "ONI", "7066");

            // Call the stored procedure
            try (CallableStatement statement = connection.prepareCall("{call GET_STUDENT_SCHEDULE(?, ?)}")) {
                statement.setString(1, studentName);
                statement.registerOutParameter(2, OracleTypes.CURSOR);
                statement.execute();

                // Process the result set
                try (ResultSet resultSet = (ResultSet) statement.getObject(2)) {
                    while (resultSet.next()) {
                        String day = resultSet.getString("day");
                        int startHour = resultSet.getInt("start_hr");
                        int startMinute = resultSet.getInt("start_min");
                        int endHour = resultSet.getInt("end_hr");
                        int endMinute = resultSet.getInt("end_min");
                        String courseID = resultSet.getString("course_id");
                        String title = resultSet.getString("title");
                        String building = resultSet.getString("building");
                        String room = resultSet.getString("room_number");

                        // Print the schedule information
                        System.out.println(day);
                        System.out.printf("%02d:%02d - %02d:%02d\n", startHour, startMinute, endHour, endMinute);
                        System.out.println(courseID + " - " + title);
                        System.out.println(building + " - " + room);
                        System.out.println();
                    }
                }
            }

            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    public  void assignStudentsToInstructors() {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection connection = DriverManager.getConnection(
                    "jdbc:oracle:thin:@localhost:1521:xe", "ONI", "7066");

            // Step 1: Find instructors with no students assigned
            try (Statement findInstructorsStatement = connection.createStatement();
                 ResultSet instructorsResultSet = findInstructorsStatement.executeQuery(
                         "SELECT ID, name, dept_name FROM instructor WHERE ID NOT IN " +
                                 "(SELECT DISTINCT ID FROM teaches)")) {

                while (instructorsResultSet.next()) {
                    String instructorID = instructorsResultSet.getString("ID");
                    String instructorName = instructorsResultSet.getString("name");
                    String department = instructorsResultSet.getString("dept_name");

                    // Step 2: Find students from the same department with no advisor
                    try (Statement findStudentsStatement = connection.createStatement();
                         ResultSet studentsResultSet = findStudentsStatement.executeQuery(
                                 "SELECT ID, name, tot_cred FROM student WHERE dept_name = '" + department +
                                         "' AND ID NOT IN (SELECT DISTINCT s_ID FROM advisor) ORDER BY tot_cred ASC")) {

                        if (studentsResultSet.next()) {
                            // Step 3: Select the student with the lowest tot_cred
                            String studentID = studentsResultSet.getString("ID");
                            String studentName = studentsResultSet.getString("name");

                            // Step 4: Assign the selected student to the instructor
                            try (PreparedStatement assignStudentStatement = connection.prepareStatement(
                                    "INSERT INTO advisor VALUES (?, ?)")) {
                                assignStudentStatement.setString(1, studentID);
                                assignStudentStatement.setString(2, instructorID);
                                assignStudentStatement.executeUpdate();

                                System.out.println("Assigned student " + studentName +
                                        " to instructor " + instructorName);
                            }
                        } else {
                            System.out.println("No available students in department " + department +
                                    " for instructor " + instructorName);
                        }
                    }
                }
            }

            // Step 5: Print the names of instructors who still do not have any students assigned
            try (Statement printInstructorsStatement = connection.createStatement();
                 ResultSet instructorsWithoutStudentsResultSet = printInstructorsStatement.executeQuery(
                         "SELECT ID, name FROM instructor WHERE ID NOT IN " +
                                 "(SELECT DISTINCT ID FROM teaches)")) {

                System.out.println("Instructors without students:");

                while (instructorsWithoutStudentsResultSet.next()) {
                    String instructorID = instructorsWithoutStudentsResultSet.getString("ID");
                    String instructorName = instructorsWithoutStudentsResultSet.getString("name");
                    System.out.println(instructorID + " - " + instructorName);
                }
            }

            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    public  void insertNewInstructor() {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            Connection connection = DriverManager.getConnection(
                    "jdbc:oracle:thin:@localhost:1521:xe", "ONI", "7066");

            // Step 1: Find the department with the highest number of students
            String highestStudentDepartment = getDepartmentWithHighestStudents(connection);

            // Step 2: Get the lowest ID value among existing instructors
            int lowestInstructorID = getLowestInstructorID(connection);

            // Step 3: Calculate the new instructor's ID as (X - 1)
            String newInstructorID = String.valueOf(lowestInstructorID - 1);

            // Step 4: Calculate the average salary of all instructors in the same department
            double averageSalary = getAverageSalaryInDepartment(connection, highestStudentDepartment);

            // Step 5: Insert the new instructor into the INSTRUCTOR table
            try (PreparedStatement insertInstructorStatement = connection.prepareStatement(
                    "INSERT INTO instructor VALUES (?, 'John Doe', ?, ?)")) {
                insertInstructorStatement.setString(1, newInstructorID);
                insertInstructorStatement.setString(2, highestStudentDepartment);
                insertInstructorStatement.setDouble(3, averageSalary);
                insertInstructorStatement.executeUpdate();

                // Step 6: Print the information of the newly inserted instructor
                System.out.println("New instructor inserted:");
                System.out.println("ID: " + newInstructorID);
                System.out.println("Name: John Doe");
                System.out.println("Department: " + highestStudentDepartment);
                System.out.println("Salary: " + averageSalary);
            }

            connection.close();
        } catch (SQLException e) {
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            throw new RuntimeException(e);
        }
    }

    private static String getDepartmentWithHighestStudents(Connection connection) throws SQLException {
        try (Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(
                     "SELECT dept_name FROM (SELECT dept_name FROM department ORDER BY budget DESC) WHERE ROWNUM = 1")) {
            return resultSet.next() ? resultSet.getString("dept_name") : null;
        }
    }


    private static int getLowestInstructorID(Connection connection) throws SQLException {
        try (Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(
                     "SELECT MIN(TO_NUMBER(ID)) AS min_id FROM instructor")) {
            return resultSet.next() ? resultSet.getInt("min_id") : 0;
        }
    }

    private static double getAverageSalaryInDepartment(Connection connection, String department) throws SQLException {
        try (Statement statement = connection.createStatement();
             ResultSet resultSet = statement.executeQuery(
                     "SELECT AVG(salary) AS avg_salary FROM instructor WHERE dept_name = '" + department + "'")) {
            return resultSet.next() ? resultSet.getDouble("avg_salary") : 0.0;
        }
    }


}
