drop table prereq;
drop table time_slot;
drop table advisor;
drop table takes;
drop table student;
drop table teaches;
drop table section;
drop table instructor;
drop table course;
drop table department;
drop table classroom;



create table classroom
	(building		varchar(15),
	 room_number		varchar(7),
	 capacity		numeric(4,0),
	 primary key (building, room_number)
	);

create table department
	(dept_name		varchar(20), 
	 building		varchar(15), 
	 budget		        numeric(12,2) check (budget > 0),
	 primary key (dept_name)
	);

create table course
	(course_id		varchar(8), 
	 title			varchar(50), 
	 dept_name		varchar(20),
	 credits		numeric(2,0) check (credits > 0),
	 primary key (course_id),
	 foreign key (dept_name) references department (dept_name)
		on delete set null
	);

create table time_slot
	(time_slot_id		varchar(4),
	 day			varchar(1),
	 start_hr		numeric(2) check (start_hr >= 0 and start_hr < 24),
	 start_min		numeric(2) check (start_min >= 0 and start_min < 60),
	 end_hr			numeric(2) check (end_hr >= 0 and end_hr < 24),
	 end_min		numeric(2) check (end_min >= 0 and end_min < 60),
	 primary key (time_slot_id, day, start_hr, start_min)
	);

create table prereq
	(course_id		varchar(8), 
	 prereq_id		varchar(8),
	 primary key (course_id, prereq_id),
	 foreign key (course_id) references course (course_id)
		on delete cascade,
	 foreign key (prereq_id) references course (course_id)
	);

create table instructor
	(ID			varchar(5), 
	 name			varchar(20) not null, 
	 dept_name		varchar(20), 
	 salary			numeric(8,2) check (salary > 29000),
	 primary key (ID),
	 foreign key (dept_name) references department (dept_name)
		on delete set null
	);

create table section
	(course_id		varchar(8), 
         sec_id			varchar(8),
	 semester		varchar(6)
		check (semester in ('Fall', 'Winter', 'Spring', 'Summer')), 
	 year			numeric(4,0) check (year > 1701 and year < 2100), 
	 building		varchar(15),
	 room_number		varchar(7),
	 time_slot_id		varchar(4),
	 primary key (course_id, sec_id, semester, year),
	 foreign key (course_id) references course (course_id)
		on delete cascade,
	 foreign key (building, room_number) references classroom (building, room_number)
		on delete set null
	);

create table teaches
	(ID			varchar(5), 
	 course_id		varchar(8),
	 sec_id			varchar(8), 
	 semester		varchar(6),
	 year			numeric(4,0),
	 primary key (ID, course_id, sec_id, semester, year),
	 foreign key (course_id, sec_id, semester, year) references section (course_id, sec_id, semester, year)
		on delete cascade,
	 foreign key (ID) references instructor (ID)
		on delete cascade
	);

create table student
	(ID			varchar(5), 
	 name			varchar(20) not null, 
	 dept_name		varchar(20), 
	 tot_cred		numeric(3,0) check (tot_cred >= 0),
	 primary key (ID),
	 foreign key (dept_name) references department (dept_name)
		on delete set null
	);

create table takes
	(ID			varchar(5), 
	 course_id		varchar(8),
	 sec_id			varchar(8), 
	 semester		varchar(6),
	 year			numeric(4,0),
	 grade		        varchar(2),
	 primary key (ID, course_id, sec_id, semester, year),
	 foreign key (course_id, sec_id, semester, year) references section (course_id, sec_id, semester, year)
		on delete cascade,
	 foreign key (ID) references student (ID)
		on delete cascade
	);

create table advisor
	(s_ID			varchar(5),
	i_ID			varchar(5),
	primary key (s_ID),
	foreign key (i_ID) references instructor (ID)
		on delete set null,
	foreign key (s_ID) references student (ID)
		on delete cascade
	);

/*
Set the salary of each instructor to 9000X where X is the total credits of the courses taught by the instructor. Print
the names of the instructors whose salaries remain unchanged. Need Procedure
*/

SET SERVEROUTPUT ON;
DECLARE
  CURSOR c_instructors IS
    SELECT i.ID, i.name, i.salary, SUM(c.credits) as total_credits
    FROM instructor i
    JOIN teaches t ON i.ID = t.ID
    JOIN course c ON t.course_id = c.course_id
    GROUP BY i.ID, i.name, i.salary;

  v_id instructor.ID%TYPE;
  v_name instructor.name%TYPE;
  v_salary instructor.salary%TYPE;
  v_total_credits course.credits%TYPE;
  v_new_salary instructor.salary%TYPE;
BEGIN
  OPEN c_instructors;

  LOOP
    FETCH c_instructors INTO v_id, v_name, v_salary, v_total_credits;
    EXIT WHEN c_instructors%NOTFOUND;

    v_new_salary := v_total_credits * 9000;

    IF v_new_salary = v_salary THEN
      DBMS_OUTPUT.PUT_LINE('Instructor whose salary remains unchanged: ' || v_name);
    END IF;

    UPDATE instructor
    SET salary = v_new_salary
    WHERE ID = v_id;
  END LOOP;

  CLOSE c_instructors;
END;
/




CREATE OR REPLACE PROCEDURE UpdateInstructorSalaries AS
	CURSOR instructor_cursor IS
    SELECT ID, name
    FROM instructor;

	v_total_credits NUMBER;
	v_new_salary    NUMBER;
BEGIN
	FOR instructor_rec IN instructor_cursor LOOP
    -- Calculate total credits taught by the instructor
    SELECT SUM(credits) INTO v_total_credits
    FROM teaches t
    JOIN course c ON t.course_id = c.course_id
    WHERE t.ID = instructor_rec.ID;

    -- Calculate new salary
    v_new_salary := 9000 * v_total_credits;
    if v_new_salary <29000 then
        v_new_salary:=30000;
    end if;
    -- Update salary for the instructor
    UPDATE instructor
    SET salary = v_new_salary
    WHERE ID = instructor_rec.ID;

    -- Check if salary remains unchanged
    IF SQL%ROWCOUNT = 0 THEN
    	DBMS_OUTPUT.PUT_LINE('Salary for ' || instructor_rec.name || ' remains unchanged.');
    END IF;
	END LOOP;

	COMMIT;
END;
/


/*
Considering the pre-requisite(s) for each course, print the course title and the names of the students who can enroll
in them.
*/

SET SERVEROUTPUT ON;
DECLARE
    CURSOR c_courses IS
	SELECT c.course_id, c.title, p.prereq_id
	FROM course c
	LEFT JOIN prereq p ON c.course_id = p.course_id;

    v_course_id course.course_id%TYPE;
    v_title course.title%TYPE;
    v_prereq_id course.course_id%TYPE;
    v_student_id student.ID%TYPE;
    v_student_name student.name%TYPE;
BEGIN
    OPEN c_courses;

    LOOP
	FETCH c_courses INTO v_course_id, v_title, v_prereq_id;
	EXIT WHEN c_courses%NOTFOUND;

	IF v_prereq_id IS NULL THEN
	    DBMS_OUTPUT.PUT_LINE('Course: ' || v_title);
	    DBMS_OUTPUT.PUT_LINE('Students who can enroll: ');

	    FOR v_student_rec IN (SELECT s.ID, s.name
							FROM student s
							WHERE s.tot_cred >= 0) LOOP
		DBMS_OUTPUT.PUT_LINE(v_student_rec.ID || ' ' || v_student_rec.name);
	    END LOOP;
	END IF;
    END LOOP;

    CLOSE c_courses;
END;