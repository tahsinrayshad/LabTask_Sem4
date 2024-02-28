-- create user dbmslab4 identified by dbms;
-- grant all privileges to dbmslab4;
-- connect dbmslab4/dbms;


-- Tahsin Islam (210042137)


-- Warmup 1

set serveroutput on;
begin
    dbms_output.put_line('Student ID: 210042137');
end;
/

-- Warmup 2: Take your first name as input and print its length.

set serveroutput on;
declare
    v_name varchar2(20);
begin
    v_name := '&name';
    dbms_output.put_line('Length of ' || v_name || ' is ' || length(v_name));
end;
/

-- Task 1
DECLARE 
	unaffected_departments_count NUMBER;
BEGIN
	
	SELECT COUNT(*)
	INTO unaffected_departments_count
	FROM department
	WHERE budget < 99999;
	
	UPDATE department
	SET budget = budget * 0.9
	WHERE budget > 99999;

	DBMS_OUTPUT.PUT_LINE('Number of departments that did not get affected: ' || unaffected_departments_count);
END;
/

-- Task 2

SET SERVEROUTPUT ON;
DECLARE 
    v_day VARCHAR2(1);
    v_start_hr NUMBER;
    v_end_hr NUMBER;

    CURSOR c_instructors IS
    SELECT DISTINCT i.name
    FROM instructor i
    WHERE i.ID IN (
        SELECT t.ID
        FROM teaches t
        WHERE t.course_id IN (
            SELECT s.course_id
            FROM section s
            WHERE s.time_slot_id IN (
                SELECT ts.time_slot_id
                FROM time_slot ts
                WHERE ts.day = v_day AND ts.start_hr >= v_start_hr AND ts.end_hr <= v_end_hr
            )
            AND t.sec_id = s.sec_id AND t.semester = s.semester AND t.year = s.year
        )
    );
    v_instructor_name instructor.name%TYPE;
BEGIN
    -- Get the input values
    v_day := '&day';
    v_start_hr := '&start_hr';
    v_end_hr := '&end_hr';

    -- Fetch the names of the instructors
    DBMS_OUTPUT.PUT_LINE('Instructors who teach between ' || v_start_hr || ' and ' || v_end_hr || ' on ' || v_day || ':');
    OPEN c_instructors;
    LOOP
    FETCH c_instructors INTO v_instructor_name;
    EXIT WHEN c_instructors%NOTFOUND;
    
    -- Output the name of the instructor
    DBMS_OUTPUT.PUT_LINE(v_instructor_name);
    END LOOP;
    CLOSE c_instructors;
END;
/

-- Task 3

SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE top_students (N IN NUMBER) IS
    CURSOR c_students IS
        SELECT s.ID, s.name, s.dept_name, COUNT(*) as num_courses
        FROM student s
        JOIN takes t ON s.ID = t.ID
        GROUP BY s.ID, s.name, s.dept_name
        ORDER BY num_courses DESC;
    v_student c_students%ROWTYPE;
    i NUMBER := 0;
BEGIN
    OPEN c_students;
    LOOP
        FETCH c_students INTO v_student;
        EXIT WHEN c_students%NOTFOUND OR i = N;
        DBMS_OUTPUT.PUT_LINE('ID: ' || v_student.ID || ', Name: ' || v_student.name || ', Department: ' || v_student.dept_name || ', Number of courses: ' || v_student.num_courses);
        i := i + 1;
    END LOOP;
    CLOSE c_students;
END;
/
BEGIN
    top_students(5);
END;
/

-- Task 4

SET SERVEROUTPUT ON;
DECLARE 
    v_dept_name department.dept_name%TYPE;
    v_max_id student.ID%TYPE;
BEGIN
    -- Finding department with least number of students
    SELECT dept_name INTO v_dept_name
    FROM (
        SELECT dept_name, COUNT(*) as num_students
        FROM student
        GROUP BY dept_name
        ORDER BY num_students ASC
    )
    WHERE ROWNUM = 1;

    -- FInding the max ID
    SELECT MAX(ID) INTO v_max_id
    FROM student;

    -- Inserting the new student
    INSERT INTO student (ID, name, dept_name, tot_cred)
    VALUES (v_max_id + 1, 'Jane Doe', v_dept_name, 0);

END;
/
select * from student
WHERE name = 'Jane Doe';

-- Task 5

SET SERVEROUTPUT ON;
DECLARE 
    CURSOR c_students IS
        SELECT s.ID, s.name, s.dept_name
        FROM student s
        LEFT JOIN advisor a ON s.ID = a.s_ID
        WHERE a.s_ID IS NULL;
    v_student c_students%ROWTYPE;
    v_instructor_id instructor.ID%TYPE;
BEGIN
    OPEN c_students;
    LOOP
        FETCH c_students INTO v_student;
        EXIT WHEN c_students%NOTFOUND;
        
        -- Finding least advised instructor
        SELECT i.ID INTO v_instructor_id
        FROM instructor i
        LEFT JOIN advisor a ON i.ID = a.i_ID
        WHERE i.dept_name = v_student.dept_name
        GROUP BY i.ID
        ORDER BY COUNT(a.s_ID) ASC
        FETCH FIRST ROW ONLY;
        
        -- Assigning the student to the instructor
        INSERT INTO advisor (s_ID, i_ID)
        VALUES (v_student.ID, v_instructor_id);
        
        DBMS_OUTPUT.PUT_LINE('Student: ' || v_student.name || ', Advisor: ' || (SELECT name FROM instructor WHERE ID = v_instructor_id) || ', Number of students advised: ' || (SELECT COUNT(*) FROM advisor WHERE i_ID = v_instructor_id));
    END LOOP;
    CLOSE c_students;
END;
/
