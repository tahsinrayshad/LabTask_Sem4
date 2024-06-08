
import java.sql.SQLException;

// Press Shift twice to open the Search Everywhere dialog and type `show whitespaces`,
// then press Enter. You can now see whitespace characters in your code.
public class Main {





    public static void main(String[] args) throws SQLException, ClassNotFoundException {

        jdbc_lab jdbcLab = new jdbc_lab();


        //task1
        jdbcLab.LoadInstructorIntoList();


        jdbcLab.instructorList.forEach(instructor -> {
            System.out.println(instructor.name);
        });

        jdbcLab.FetchTotalCreditsOfInstructor();
        System.out.println("Those whos salary remains unchanged: ");
        for(int i=0;i<jdbcLab.instructorList.size();i++)
        {
            if(jdbcLab.instructorList.get(i).totalCredits*9000==jdbcLab.instructorList.get(i).salary)
            {
                System.out.println(jdbcLab.instructorList.get(i).name);
            }
            jdbcLab.instructorList.get(i).setSalary(jdbcLab.instructorList.get(i).totalCredits*9000);

            if(jdbcLab.instructorList.get(i).getSalary()<=29000)
            {
                jdbcLab.instructorList.get(i).setSalary(30000);
            }
            jdbcLab.UpdateSalaryOfInstructor(jdbcLab.instructorList.get(i).getID(),jdbcLab.instructorList.get(i).getSalary());
        }
        //task1_ends_here



        //2. Considering the pre-requisite(s) for each course, print the course title and the names of the students who can enroll
        //in them.


        jdbcLab.ShowCourseTitleAndEligibleStudents();

        //3.Take the name of the student as input from the user. Then print the weekly routine for the student. Each class
        //should be printed in the following format:
        //<Day>
        //<Start Time> - <End Time>
        //<Course ID> - <Title>
        //<Building> - <Room>
        //The days should be sorted based on the regular order of weekdays starting from Monday. If there are multiple classes
        //scheduled on the same day, they should be sorted based on the starting time.
//task3
        //jdbcLab.printStudentSchedule("Zhang");


        //task4
      jdbcLab.assignStudentsToInstructors();

        //task 5
        jdbcLab.insertNewInstructor();

    }




}