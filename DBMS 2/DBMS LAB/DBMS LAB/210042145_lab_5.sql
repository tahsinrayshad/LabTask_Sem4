

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


insert into classroom values ('Packard', '101', '500');
insert into classroom values ('Painter', '514', '10');
insert into classroom values ('Taylor', '3128', '70');
insert into classroom values ('Watson', '100', '30');
insert into classroom values ('Watson', '120', '50');
insert into department values ('Biology', 'Watson', '90000');
insert into department values ('Comp. Sci.', 'Taylor', '100000');
insert into department values ('Elec. Eng.', 'Taylor', '85000');
insert into department values ('Finance', 'Painter', '120000');
insert into department values ('History', 'Painter', '50000');
insert into department values ('Music', 'Packard', '80000');
insert into department values ('Physics', 'Watson', '70000');
insert into course values ('BIO-101', 'Intro. to Biology', 'Biology', '4');
insert into course values ('BIO-301', 'Genetics', 'Biology', '4');
insert into course values ('BIO-399', 'Computational Biology', 'Biology', '3');
insert into course values ('CS-101', 'Intro. to Computer Science', 'Comp. Sci.', '4');
insert into course values ('CS-190', 'Game Design', 'Comp. Sci.', '4');
insert into course values ('CS-315', 'Robotics', 'Comp. Sci.', '3');
insert into course values ('CS-319', 'Image Processing', 'Comp. Sci.', '3');
insert into course values ('CS-347', 'Database System Concepts', 'Comp. Sci.', '3');
insert into course values ('EE-181', 'Intro. to Digital Systems', 'Elec. Eng.', '3');
insert into course values ('FIN-201', 'Investment Banking', 'Finance', '3');
insert into course values ('HIS-351', 'World History', 'History', '3');
insert into course values ('MU-199', 'Music Video Production', 'Music', '3');
insert into course values ('PHY-101', 'Physical Principles', 'Physics', '4');
insert into instructor values ('10101', 'Srinivasan', 'Comp. Sci.', '65000');
insert into instructor values ('12121', 'Wu', 'Finance', '90000');
insert into instructor values ('15151', 'Mozart', 'Music', '40000');
insert into instructor values ('22222', 'Einstein', 'Physics', '95000');
insert into instructor values ('32343', 'El Said', 'History', '60000');
insert into instructor values ('33456', 'Gold', 'Physics', '87000');
insert into instructor values ('45565', 'Katz', 'Comp. Sci.', '75000');
insert into instructor values ('58583', 'Califieri', 'History', '62000');
insert into instructor values ('76543', 'Singh', 'Finance', '80000');
insert into instructor values ('76766', 'Crick', 'Biology', '72000');
insert into instructor values ('83821', 'Brandt', 'Comp. Sci.', '92000');
insert into instructor values ('98345', 'Kim', 'Elec. Eng.', '80000');
insert into section values ('BIO-101', '1', 'Summer', '2017', 'Painter', '514', 'B');
insert into section values ('BIO-301', '1', 'Summer', '2018', 'Painter', '514', 'A');
insert into section values ('CS-101', '1', 'Fall', '2017', 'Packard', '101', 'H');
insert into section values ('CS-101', '1', 'Spring', '2018', 'Packard', '101', 'F');
insert into section values ('CS-190', '1', 'Spring', '2017', 'Taylor', '3128', 'E');
insert into section values ('CS-190', '2', 'Spring', '2017', 'Taylor', '3128', 'A');
insert into section values ('CS-315', '1', 'Spring', '2018', 'Watson', '120', 'D');
insert into section values ('CS-319', '1', 'Spring', '2018', 'Watson', '100', 'B');
insert into section values ('CS-319', '2', 'Spring', '2018', 'Taylor', '3128', 'C');
insert into section values ('CS-347', '1', 'Fall', '2017', 'Taylor', '3128', 'A');
insert into section values ('EE-181', '1', 'Spring', '2017', 'Taylor', '3128', 'C');
insert into section values ('FIN-201', '1', 'Spring', '2018', 'Packard', '101', 'B');
insert into section values ('HIS-351', '1', 'Spring', '2018', 'Painter', '514', 'C');
insert into section values ('MU-199', '1', 'Spring', '2018', 'Packard', '101', 'D');
insert into section values ('PHY-101', '1', 'Fall', '2017', 'Watson', '100', 'A');
insert into teaches values ('10101', 'CS-101', '1', 'Fall', '2017');
insert into teaches values ('10101', 'CS-315', '1', 'Spring', '2018');
insert into teaches values ('10101', 'CS-347', '1', 'Fall', '2017');
insert into teaches values ('12121', 'FIN-201', '1', 'Spring', '2018');
insert into teaches values ('15151', 'MU-199', '1', 'Spring', '2018');
insert into teaches values ('22222', 'PHY-101', '1', 'Fall', '2017');
insert into teaches values ('32343', 'HIS-351', '1', 'Spring', '2018');
insert into teaches values ('45565', 'CS-101', '1', 'Spring', '2018');
insert into teaches values ('45565', 'CS-319', '1', 'Spring', '2018');
insert into teaches values ('76766', 'BIO-101', '1', 'Summer', '2017');
insert into teaches values ('76766', 'BIO-301', '1', 'Summer', '2018');
insert into teaches values ('83821', 'CS-190', '1', 'Spring', '2017');
insert into teaches values ('83821', 'CS-190', '2', 'Spring', '2017');
insert into teaches values ('83821', 'CS-319', '2', 'Spring', '2018');
insert into teaches values ('98345', 'EE-181', '1', 'Spring', '2017');
insert into student values ('00128', 'Zhang', 'Comp. Sci.', '102');
insert into student values ('12345', 'Shankar', 'Comp. Sci.', '32');
insert into student values ('19991', 'Brandt', 'History', '80');
insert into student values ('23121', 'Chavez', 'Finance', '110');
insert into student values ('44553', 'Peltier', 'Physics', '56');
insert into student values ('45678', 'Levy', 'Physics', '46');
insert into student values ('54321', 'Williams', 'Comp. Sci.', '54');
insert into student values ('55739', 'Sanchez', 'Music', '38');
insert into student values ('70557', 'Snow', 'Physics', '0');
insert into student values ('76543', 'Brown', 'Comp. Sci.', '58');
insert into student values ('76653', 'Aoi', 'Elec. Eng.', '60');
insert into student values ('98765', 'Bourikas', 'Elec. Eng.', '98');
insert into student values ('98988', 'Tanaka', 'Biology', '120');
insert into takes values ('00128', 'CS-101', '1', 'Fall', '2017', 'A');
insert into takes values ('00128', 'CS-347', '1', 'Fall', '2017', 'A-');
insert into takes values ('12345', 'CS-101', '1', 'Fall', '2017', 'C');
insert into takes values ('12345', 'CS-190', '2', 'Spring', '2017', 'A');
insert into takes values ('12345', 'CS-315', '1', 'Spring', '2018', 'A');
insert into takes values ('12345', 'CS-347', '1', 'Fall', '2017', 'A');
insert into takes values ('19991', 'HIS-351', '1', 'Spring', '2018', 'B');
insert into takes values ('23121', 'FIN-201', '1', 'Spring', '2018', 'C+');
insert into takes values ('44553', 'PHY-101', '1', 'Fall', '2017', 'B-');
insert into takes values ('45678', 'CS-101', '1', 'Fall', '2017', 'F');
insert into takes values ('45678', 'CS-101', '1', 'Spring', '2018', 'B+');
insert into takes values ('45678', 'CS-319', '1', 'Spring', '2018', 'B');
insert into takes values ('54321', 'CS-101', '1', 'Fall', '2017', 'A-');
insert into takes values ('54321', 'CS-190', '2', 'Spring', '2017', 'B+');
insert into takes values ('55739', 'MU-199', '1', 'Spring', '2018', 'A-');
insert into takes values ('76543', 'CS-101', '1', 'Fall', '2017', 'A');
insert into takes values ('76543', 'CS-319', '2', 'Spring', '2018', 'A');
insert into takes values ('76653', 'EE-181', '1', 'Spring', '2017', 'C');
insert into takes values ('98765', 'CS-101', '1', 'Fall', '2017', 'C-');
insert into takes values ('98765', 'CS-315', '1', 'Spring', '2018', 'B');
insert into takes values ('98988', 'BIO-101', '1', 'Summer', '2017', 'A');
insert into takes values ('98988', 'BIO-301', '1', 'Summer', '2018', null);
insert into advisor values ('00128', '45565');
insert into advisor values ('12345', '10101');
insert into advisor values ('23121', '76543');
insert into advisor values ('44553', '22222');
insert into advisor values ('45678', '22222');
insert into advisor values ('76543', '45565');
insert into advisor values ('76653', '98345');
insert into advisor values ('98765', '98345');
insert into advisor values ('98988', '76766');
insert into time_slot values ('A', 'M', '8', '0', '8', '50');
insert into time_slot values ('A', 'W', '8', '0', '8', '50');
insert into time_slot values ('A', 'F', '8', '0', '8', '50');
insert into time_slot values ('B', 'M', '9', '0', '9', '50');
insert into time_slot values ('B', 'W', '9', '0', '9', '50');
insert into time_slot values ('B', 'F', '9', '0', '9', '50');
insert into time_slot values ('C', 'M', '11', '0', '11', '50');
insert into time_slot values ('C', 'W', '11', '0', '11', '50');
insert into time_slot values ('C', 'F', '11', '0', '11', '50');
insert into time_slot values ('D', 'M', '13', '0', '13', '50');
insert into time_slot values ('D', 'W', '13', '0', '13', '50');
insert into time_slot values ('D', 'F', '13', '0', '13', '50');
insert into time_slot values ('E', 'T', '10', '30', '11', '45 ');
insert into time_slot values ('E', 'R', '10', '30', '11', '45 ');
insert into time_slot values ('F', 'T', '14', '30', '15', '45 ');
insert into time_slot values ('F', 'R', '14', '30', '15', '45 ');
insert into time_slot values ('G', 'M', '16', '0', '16', '50');
insert into time_slot values ('G', 'W', '16', '0', '16', '50');
insert into time_slot values ('G', 'F', '16', '0', '16', '50');
insert into time_slot values ('H', 'W', '10', '0', '12', '30');
insert into prereq values ('BIO-301', 'BIO-101');
insert into prereq values ('BIO-399', 'BIO-101');
insert into prereq values ('CS-190', 'CS-101');
insert into prereq values ('CS-315', 'CS-101');
insert into prereq values ('CS-319', 'CS-101');
insert into prereq values ('CS-347', 'CS-101');
insert into prereq values ('EE-181', 'PHY-101');


-- now setup is done

--lets do task 1
--1. Set the salary of each instructor to 9000X where X is the total credits of the courses taught by the instructor. Print
-- the names of the instructors whose salaries remain unchanged.

--ins,teaches,course

select instructor.name,nvl(t.course_id,'n/a')
    from instructor left join teaches t on instructor.ID = t.ID;


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


-- --task 2
-- Considering the pre-requisite(s) for each course, print the course title and the names of the students who can enroll
-- in them.

Create or replace PROCEDURE find_student AS
    CURSOR c_course is
    select course.course_id,course.title
        from course;

    CURSOR c_pre_req is
    select prereq_id,course_id
        from prereq;
    CURSOR c_stXtakes is
    select distinct student.name,takes.course_id
        from student natural join takes;

begin
    for course_rec in c_course LOOP
        DBMS_OUTPUT.PUT_LINE('COURSE NAME :-' || course_rec.title);
        for prereq_rec in c_pre_req LOOP

            IF course_rec.course_id = prereq_rec.course_id then
                FOR sttakes_rec in c_stXtakes LOOP
                    IF prereq_rec.prereq_id = sttakes_rec.course_id then
                        DBMS_OUTPUT.PUT_LINE(sttakes_rec.name);
                    end if;
                    end loop;
                exit;
            ELSE
                 FOR sttakes_rec in c_stXtakes LOOP

                        DBMS_OUTPUT.PUT_LINE(sttakes_rec.name);
                    end loop;
            end if;
            end loop;
        end loop;
end;
/

--task 3
CREATE OR REPLACE FUNCTION GetWeeklyRoutineForStudent (p_student_name IN VARCHAR2) RETURN VARCHAR2 AS
  v_output VARCHAR2(4000);
BEGIN
  v_output := '';

  FOR schedule_rec IN (SELECT ts.day,
                               ts.start_hr,
                               ts.start_min,
                               ts.end_hr,
                               ts.end_min,
                               sec.course_id,
                               c.title,
                               sec.building,
                               sec.room_number
                        FROM student s
                        JOIN takes t ON s.ID = t.ID
                        JOIN section sec ON t.course_id = sec.course_id
                        JOIN time_slot ts ON sec.time_slot_id = ts.time_slot_id
                        JOIN course c ON sec.course_id = c.course_id
                        WHERE s.name = p_student_name
                        ORDER BY CASE ts.day
                                   WHEN 'M' THEN 1
                                   WHEN 'T' THEN 2
                                   WHEN 'W' THEN 3
                                   WHEN 'R' THEN 4
                                   WHEN 'F' THEN 5
                                 END, ts.start_hr, ts.start_min)
  LOOP
    -- Concatenate schedule information into output string
    v_output := v_output || schedule_rec.day || CHR(10) ||
                schedule_rec.start_hr || ':' || schedule_rec.start_min || ' - ' ||
                schedule_rec.end_hr || ':' || schedule_rec.end_min || CHR(10) ||
                schedule_rec.course_id || ' - ' || schedule_rec.title || CHR(10) ||
                schedule_rec.building || ' - ' || schedule_rec.room_number || CHR(10) || CHR(10);
  END LOOP;

  RETURN v_output;
END;
/



DECLARE
  v_student_name VARCHAR2(100) := 'Zhang';
  v_weekly_routine VARCHAR2(4000);
BEGIN
  v_weekly_routine := GetWeeklyRoutineForStudent(v_student_name);
  DBMS_OUTPUT.PUT_LINE(v_weekly_routine);
END;
/

--task 4


    select ID,tot_cred
    from
    (SELECT s.ID,s.tot_cred
    FROM student s
    WHERE s.dept_name = 'Physics'
    AND s.ID NOT IN (SELECT a.s_ID
                    FROM advisor a
                    WHERE a.s_ID = s.ID)
    order by s.tot_cred)
    where ROWNUM<=1;





CREATE OR REPLACE PROCEDURE AssignStudentsToInstructors AS
  CURSOR empty_instructor_cursor IS
    SELECT i.ID, i.name,i.dept_name
    FROM instructor i
    WHERE i.ID NOT IN (SELECT a.i_ID
                      FROM advisor a
                      WHERE a.i_ID = i.ID);

  v_student_ID STUDENT.ID%type;
  v_lowest_cred STUDENT.TOT_CRED%type;
BEGIN
  -- Assign students to empty instructors
  FOR empty_instructor_rec IN empty_instructor_cursor LOOP
    -- Find a student from the same department with no advisor and lowest total credits
    select ID,tot_cred
        INTO v_student_ID, v_lowest_cred
    from
    (SELECT s.ID,s.tot_cred
    FROM student s
    WHERE s.dept_name =empty_instructor_cursor.dept_name
    AND s.ID NOT IN (SELECT a.s_ID
                    FROM advisor a
                    WHERE a.s_ID = s.ID)
    order by s.tot_cred)
    where ROWNUM<=1;

    IF SQL%FOUND THEN
         INSERT INTO advisor VALUES (v_student_ID, empty_instructor_rec.ID);
    end if;
    -- Assign student to instructor

  END LOOP;
--   Print names of instructors who still do not have any students assigned to them
  FOR remaining_empty_instructor_rec IN (SELECT i.name,i.ID
                                         FROM instructor i
                                         WHERE i.ID NOT IN (SELECT a.i_ID
                                                           FROM advisor a
                                                           WHERE a.i_ID = i.ID)) LOOP
    DBMS_OUTPUT.PUT_LINE('Instructor ' || remaining_empty_instructor_rec.name || ' still does not have any students assigned.');
  END LOOP;
END;
/
BEGIN
  AssignStudentsToInstructors;
END;
/

--task 5



DECLARE
  v_highest_student_count INSTRUCTOR.dept_name%type;
  v_lowest_instructor_ID INSTRUCTOR.ID%type;
  v_avg_salary INSTRUCTOR.SALARY%type;
BEGIN

  SELECT dept_name
  INTO v_highest_student_count
  FROM (
    SELECT dept_name, COUNT(student.ID) AS student_count
    FROM student
    GROUP BY dept_name
    ORDER BY COUNT(student.ID) DESC
  )
  WHERE ROWNUM = 1;


  SELECT MIN(ID)
  INTO v_lowest_instructor_ID
  FROM instructor;

  INSERT INTO instructor (ID, name, dept_name)
  VALUES (v_lowest_instructor_ID -1, 'John Doe', v_highest_student_count);

  SELECT AVG(salary)
  INTO v_avg_salary
  FROM instructor
  WHERE dept_name = v_highest_student_count;

  UPDATE instructor
  SET salary = v_avg_salary
  WHERE ID = v_lowest_instructor_ID - 1;

  DBMS_OUTPUT.PUT_LINE('New Instructor Information:');
  FOR instructor_rec IN (
    SELECT ID, name, dept_name, salary
    FROM instructor
    WHERE ID = TO_CHAR(TO_NUMBER(v_lowest_instructor_ID) - 1)
  ) LOOP
    DBMS_OUTPUT.PUT_LINE('ID: ' || instructor_rec.ID);
    DBMS_OUTPUT.PUT_LINE('Name: ' || instructor_rec.name);
    DBMS_OUTPUT.PUT_LINE('Department: ' || instructor_rec.dept_name);
    DBMS_OUTPUT.PUT_LINE('Salary: ' || instructor_rec.salary);
  END LOOP;
END;
/
