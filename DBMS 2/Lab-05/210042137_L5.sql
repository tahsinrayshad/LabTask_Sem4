-- connect dbmslab4/dbms;

-- Task 1
set serveroutput on;

declare
    cursor c_instructors is
        select i.id, i.name, i.salary, sum(c.credits) as total_credits
        from instructor i
        join teaches t on i.id = t.id
        join course c on t.course_id = c.course_id
        group by i.id, i.name, i.salary;

    v_id instructor.ID%type;
    v_name instructor.name%type;
    v_salary instructor.salary%type;
    v_total_credits course.credits%type;
    v_new_salary instructor.salary%type;

begin
    open c_instructors;

    loop 
        fetch c_instructors into v_id, v_name, v_salary, v_total_credits;
        exit when c_instructors%notfound;

        v_new_salary := 9000 * v_total_credits;
        if v_new_salary < 29000 then
            v_new_salary := 30000;
        end if;

        if v_new_salary = v_salary then 
            dbms_output.put_line(v_name || ' salary remains unchanged');
        else
            update instructor
            set salary = v_new_salary
            where id = v_id;
        end if;
    end loop;
    close c_instructors;
end;
/


--Task 2:
CREATE
OR REPLACE PROCEDURE print_course_students IS BEGIN FOR course_rec IN (
    SELECT
        c.course_id,
        c.title,
        p.prereq_id
    FROM
        course c
        LEFT JOIN prereq p ON c.course_id = p.course_id
) LOOP DBMS_OUTPUT.PUT_LINE('Course: ' || course_rec.title);

FOR student_rec IN (
    SELECT
        s.name
    FROM
        student s
        JOIN takes t ON s.ID = t.ID
    WHERE
        t.course_id = course_rec.prereq_id
) LOOP DBMS_OUTPUT.PUT_LINE('   Student: ' || student_rec.name);

END LOOP;

DBMS_OUTPUT.PUT_LINE('--------------------------');

END LOOP;

END;

/ BEGIN print_course_students;

END;

/ 


--Task 3:
CREATE
OR REPLACE PROCEDURE print_routine(p_student_name IN VARCHAR2) IS BEGIN FOR day_rec IN (
    SELECT
        DISTINCT ts.day
    FROM
        time_slot ts
        JOIN section sec ON ts.time_slot_id = sec.time_slot_id
        JOIN takes t ON sec.course_id = t.course_id
        AND sec.sec_id = t.sec_id
        JOIN student s ON t.ID = s.ID
    WHERE
        s.name = p_student_name
    ORDER BY
        ts.day,
        ts.start_hr,
        ts.start_min
) LOOP DBMS_OUTPUT.PUT_LINE(day_rec.day);

FOR class_rec IN (
    SELECT
        ts.start_hr || ':' || ts.start_min AS start_time,
        ts.end_hr || ':' || ts.end_min AS end_time,
        c.course_id,
        c.title,
        sec.building,
        sec.room_number
    FROM
        time_slot ts
        JOIN section sec ON ts.time_slot_id = sec.time_slot_id
        JOIN takes t ON sec.course_id = t.course_id
        AND sec.sec_id = t.sec_id
        JOIN course c ON sec.course_id = c.course_id
        JOIN student s ON t.ID = s.ID
    WHERE
        s.name = p_student_name
        AND ts.day = day_rec.day
    ORDER BY
        ts.start_hr,
        ts.start_min
) LOOP DECLARE v_start_time VARCHAR2(10);

v_end_time VARCHAR2(10);

v_course_id VARCHAR2(8);

v_title VARCHAR2(50);

v_building VARCHAR2(15);

v_room_number VARCHAR2(7);

BEGIN -- Assign values to variables
v_start_time := class_rec.start_time;

v_end_time := class_rec.end_time;

v_course_id := class_rec.course_id;

v_title := class_rec.title;

v_building := class_rec.building;

v_room_number := class_rec.room_number;

-- Print the information using variables
DBMS_OUTPUT.PUT_LINE(v_start_time || ' - ' || v_end_time);

DBMS_OUTPUT.PUT_LINE(v_course_id || ' - ' || v_title);

DBMS_OUTPUT.PUT_LINE(v_building || ' - ' || v_room_number);

DBMS_OUTPUT.PUT_LINE('');

END;

END LOOP;

DBMS_OUTPUT.PUT_LINE('--------------------------');

END LOOP;

END;

/
SET
    SERVEROUTPUT ON;

BEGIN print_routine('Zhang');

END;

/ 

-- Task 4:
CREATE
OR REPLACE FUNCTION printStudentRoutine (p_student_name IN VARCHAR2) RETURN VARCHAR2 AS v_output VARCHAR2(4000);

BEGIN v_output := '';

FOR schedule_rec IN (
    SELECT
        ts.day,
        ts.start_hr,
        ts.start_min,
        ts.end_hr,
        ts.end_min,
        sec.course_id,
        c.title,
        sec.building,
        sec.room_number
    FROM
        student s
        JOIN takes t ON s.ID = t.ID
        JOIN section sec ON t.course_id = sec.course_id
        JOIN time_slot ts ON sec.time_slot_id = ts.time_slot_id
        JOIN course c ON sec.course_id = c.course_id
    WHERE
        s.name = p_student_name
    ORDER BY
        CASE
            ts.day
            WHEN 'M' THEN 1
            WHEN 'T' THEN 2
            WHEN 'W' THEN 3
            WHEN 'R' THEN 4
            WHEN 'F' THEN 5
        END,
        ts.start_hr,
        ts.start_min
) LOOP 

-- Printing the information:
v_output := v_output || schedule_rec.day || CHR(10) || schedule_rec.start_hr || ':' || schedule_rec.start_min || ' - ' || schedule_rec.end_hr || ':' || schedule_rec.end_min || CHR(10) || schedule_rec.course_id || ' - ' || schedule_rec.title || CHR(10) || schedule_rec.building || ' - ' || schedule_rec.room_number || CHR(10) || CHR(10);

END LOOP;

RETURN v_output;

END;

/ DECLARE v_student_name VARCHAR2(100) := 'Zhang';

v_weekly_routine VARCHAR2(4000);

BEGIN v_weekly_routine := printStudentRoutine(v_student_name);

DBMS_OUTPUT.PUT_LINE(v_weekly_routine);

END;

/


-- Task 5:

DECLARE
    v_highest_dept_name VARCHAR2(20);
    v_lowest_instructor_id VARCHAR2(5);
    v_new_instructor_id VARCHAR2(5);
    v_new_instructor_salary NUMBER;
BEGIN
    -- first, find the department with the highest number of students
    SELECT dept_name
    INTO v_highest_dept_name
    FROM (
        SELECT dept_name, COUNT(*) AS student_count
        FROM student
        GROUP BY dept_name
        ORDER BY COUNT(*) DESC
    )
    WHERE ROWNUM = 1;

    -- Then, find the lowest ID value among the existing instructors
    SELECT MIN(ID)
    INTO v_lowest_instructor_id
    FROM instructor;

    -- then insert a new instructor with the specified details
    v_new_instructor_id := TO_CHAR(TO_NUMBER(v_lowest_instructor_id) - 1);
    INSERT INTO instructor (ID, name, dept_name, salary)
    VALUES (v_new_instructor_id, 'John Doe', v_highest_dept_name, NULL);

    -- Calculate the average salary of instructors in the same department
    SELECT AVG(salary)
    INTO v_new_instructor_salary
    FROM instructor
    WHERE dept_name = v_highest_dept_name;

    -- Update the salary for the newly inserted instructor
    UPDATE instructor
    SET salary = v_new_instructor_salary
    WHERE ID = v_new_instructor_id;

    -- Print the information of the new instructor
    DBMS_OUTPUT.PUT_LINE('New Instructor Information:');
    DBMS_OUTPUT.PUT_LINE('ID: ' || v_new_instructor_id);
    DBMS_OUTPUT.PUT_LINE('Name: John Doe');
    DBMS_OUTPUT.PUT_LINE('Department: ' || v_highest_dept_name);
    DBMS_OUTPUT.PUT_LINE('Salary: ' || TO_CHAR(v_new_instructor_salary));

END;
/
