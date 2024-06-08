public class Instructor {

    public int ID;

    public String name;

    public String dept_name;

    public double salary;

    public double totalCredits;
    public int getID() {
        return ID;
    }

    public String getName() {
        return name;
    }

    public String getDept_name() {
        return dept_name;
    }

    public double getSalary() {
        return salary;
    }

    public void setID(int ID) {
        this.ID = ID;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setDept_name(String dept_name) {
        this.dept_name = dept_name;
    }

    public void setSalary(double salary) {
        this.salary = salary;
    }

    public double getTotalCredits() {
        return totalCredits;
    }

    public void setTotalCredits(double totalCredits) {
        this.totalCredits = totalCredits;
    }

    public Instructor(int ID, String name, String dept_name, double salary) {
        this.ID = ID;
        this.name = name;
        this.dept_name = dept_name;
        this.salary = salary;
        totalCredits=0;
    }
}
