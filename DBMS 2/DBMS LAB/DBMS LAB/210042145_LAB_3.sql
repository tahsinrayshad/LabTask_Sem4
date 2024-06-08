



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

---if u need array use cursor


---warmupppp
--1.a. Print your student ID.
Set serveroutput on;
BEGIN
    DBMS_OUTPUT.PUT_LINE('210042145');
end;


--2.b.
DECLARE
  v_first_name VARCHAR2(50);

BEGIN

  v_first_name := '&Enter_First_Name';


  DBMS_OUTPUT.PUT_LINE('The length of the first name is: ' || LENGTH(v_first_name));
END;
/

----------------------------------------(a)----------------------------------------
--Decrease the budget of the departments having a budget of more than 99999 by 10%. Then show the number
--of departments that did not get affected.

CREATE OR REPLACE PROCEDURE decrease_budget_and_count AS

    CURSOR c_departments IS
    SELECT dept_name, budget
    FROM department;
    v_uneffected NUMBER :=0;
BEGIN

  FOR department_rec IN c_departments LOOP
    IF department_rec.budget>99999 THEN
    UPDATE department
    SET budget = (department_rec.budget * 0.9)
    WHERE dept_name = department_rec.dept_name;
    ELSE
        v_uneffected:=v_uneffected+1;
    END IF;

  END LOOP;

  -- Display the number of departments that did not get affected
  DBMS_OUTPUT.PUT_LINE('Number of departments not affected: ' || (v_uneffected));
END decrease_budget_and_count;
/

--calling the procedure
BEGIN
     decrease_budget_and_count;
end;
/

----------------------------------------(b)----------------------------------------
--Take the day of the week, starting hour, and ending hour as input from the user. Then print the names of the
--instructors who will be taking classes during that time.
CREATE OR REPLACE PROCEDURE print_instructors_for_time(day IN TIME_SLOT.Day%type,start_hour IN NUMBER,end_Hour IN NUMBER)AS
  v_day VARCHAR2(1);
  v_start_hour NUMBER;
  v_end_hour NUMBER;
  v_instructor_names VARCHAR2(4000);
  CURSOR c_instructors_for_time IS
    SELECT DISTINCT i.name
    FROM instructor i
    JOIN teaches t ON i.ID = t.ID
    JOIN section s ON t.course_id = s.course_id
                  AND t.sec_id = s.sec_id
                  AND t.semester = s.semester
                  AND t.year = s.year
    JOIN time_slot ts ON s.time_slot_id = ts.time_slot_id
    WHERE s.semester IN ('Fall', 'Winter', 'Spring', 'Summer')
      AND v_day = ts.day
      AND ts.start_hr >= v_start_hour
      AND ts.END_HR<=v_end_hour;
BEGIN


  v_instructor_names := '';
v_day:=day;
  v_start_hour:=start_hour;
  v_end_hour:=end_Hour;

  FOR instructor_rec IN c_instructors_for_time LOOP
    v_instructor_names := v_instructor_names || instructor_rec.name || ', ';
  END LOOP;

  -- Remove trailing comma and space
  IF LENGTH(v_instructor_names) > 0 THEN
    v_instructor_names := RTRIM(v_instructor_names, ', ');

    -- Print the result
    DBMS_OUTPUT.PUT_LINE('Instructors for the specified time: ' || v_instructor_names);
  ELSE
    DBMS_OUTPUT.PUT_LINE('No instructors for the specified time.');
  END IF;
END print_instructors_for_time;
/


BEGIN
    print_instructors_for_time('T',14,15);
end;
/


-----------------------(C)----------------------

-- c. Find the top N students based on the number of courses they are enrolled in. You should take N as input and
-- print the ID, name, department name, and the number of courses taken by the student. If N is larger than the
-- total number of students, print the information for all the students.
select *
    from
(select student.name,count(takes.course_ID) as total_courses
    from student,takes
where student.ID=takes.ID
group by takes.ID,student.name
ORDER BY total_courses DESC )
where ROWNUM<=2;



Create Or REPLACE procedure FIND_TOP_N_STUDENT(N IN NUMBER) AS

    CURSOR c_student_course is
select *
    from
(select student.name,count(takes.course_ID) as total_courses
    from student,takes
where student.ID=takes.ID
group by takes.ID,student.name
ORDER BY total_courses DESC )
where ROWNUM<=N;

BEGIN
  FOR c_st_rec IN c_student_course LOOP
    DBMS_OUTPUT.PUT_LINE('STUDENT NAME: '|| c_st_rec.name||' TOTAL ENROLLED COURSE '||c_st_rec.total_courses);
  END LOOP;

end FIND_TOP_N_STUDENT;
/

BEGIN

    FIND_TOP_N_STUDENT(2);
end;
/

------------------------(D)------------------------
-- d. Insert a new student named ‘Jane Doe’ in the STUDENT table. The student should be enrolled in the department
-- having the lowest number of students. The ID of the student will be (X + 1), where X is the highest ID value
-- among the existing students.

--used sql queries
select dep_name
 from   (
select department.dept_name as dep_name,Count(student.ID) as total_st
    from DEPARTMENT,student
where student.dept_name=department.dept_name
group by department.dept_name
order by total_st)
where ROWNUM<=1 ;

--




Create or REPLACE PROCEDURE insert_student(Name IN student.name%type) AS
v_dept_name department.dept_name%type;
v_st_id student.ID%type;
v_tot_cred NUMBER:=0;
BEGIN
select dep_name into v_dept_name
 from   (
select department.dept_name as dep_name,Count(student.ID) as total_st
    from DEPARTMENT,student
where student.dept_name=department.dept_name
group by department.dept_name
order by total_st)A
where ROWNUM<=1 ;

select max(student.ID)+1 into v_st_id
from STUDENT;

insert into student VALUES (v_st_id,name,v_dept_name,v_tot_cred);
end insert_student;
/
BEGIN
    insert_student('John Doe');
end;
/


------------------(E)-------------
-- e. Find out the list of students who do not have any advisor assigned to them. Then assign them an advisor from
-- their department. In case there are multiple instructors from a certain department, the advisor should be selected
-- based on the least number of students advised. Finally, print the name of the students, the name of their advisor,
-- and the number of students advised by the said advisor.

--used sql
--
-- --finding the student name and the dept_name of that student who dont have any advisor
-- select student.ID,student.name,dept_name
--     from student
-- where student.ID not in (select s_ID from advisor);
--
-- --finding the advisor with lowest student advised to them
--
-- SELECT ID,name,cnt_st from
-- (select instructor.ID,instructor.name, nvl(count(s_ID),0) as cnt_st
--     from instructor left join advisor a2 on instructor.ID = a2.i_ID
-- where instructor.dept_name='Music'
-- group by instructor.ID,instructor.name
-- ORDER BY cnt_st)
-- where ROWNUM<=1;
-- --
-- select instructor.ID,instructor.name,instructor.dept_name,count(nvl(advisor.s_id,0)) as cnt_st
--     from advisor right join instructor on advisor.i_ID = instructor.ID
-- group by instructor.ID,instructor.name, instructor.dept_name
-- ORDER BY cnt_st;
--
-- --
-- select instructor.ID,instructor.name,count(advisor.s_id) as cnt_st
--     from advisor, instructor
-- where advisor.i_ID=instructor.ID
-- group by instructor.ID,instructor.name, instructor.dept_name
-- ORDER BY cnt_st;
--
-- --
-- select instructor.ID,instructor.name, nvl(count(s_ID),0) as cnt_st
--     from instructor left join advisor a2 on instructor.ID = a2.i_ID
-- where instructor.dept_name='Music'
-- group by instructor.ID,instructor.name
-- ORDER BY cnt_st;
-- --now  a particular student to particular advisor


CREATE OR REPLACE PROCEDURE assign_advisors AS
CURSOR c_un_advised_stdnt is
  select student.ID,student.name,dept_name
from student
where student.ID not in (select s_ID from advisor);
v_ins_id instructor.ID%type;
v_ins_name instructor.name%type;
v_st_cnt Number;

BEGIN

  FOR c_st_rec IN c_un_advised_stdnt LOOP
    SELECT ID,name,cnt_st into v_ins_id,v_ins_name,v_st_cnt  from
    (select instructor.ID,instructor.name, nvl(count(s_ID),0) as cnt_st
    from instructor left join advisor a2 on instructor.ID = a2.i_ID
    where instructor.dept_name=c_st_rec.dept_name
    group by instructor.ID,instructor.name
    ORDER BY cnt_st)
    where ROWNUM<=1;
    --now inserting into advisor table
      Insert into advisor values (c_st_rec.ID,v_ins_id);
    DBMS_OUTPUT.PUT_LINE('Student Name: '||c_st_rec.name);
    DBMS_OUTPUT.PUT_LINE('Advisor Name: '||v_ins_name);
    DBMS_OUTPUT.PUT_LINE('Total advised student: '||v_st_cnt);

  END LOOP;
END assign_advisors;
/

