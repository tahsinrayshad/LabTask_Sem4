
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




--Find the names of courses offered by the ‘Comp. Sci.’ department which has 3 credits.
select title from course where dept_name = 'Comp. Sci.' and credits = 3;

-- For each student, list their ID, name, and total credits s/he has taken. Do not include the students who did not register for any course.
select ID, name, tot_cred 
from student 
where ID in (select ID from takes);


-- Find the names and the department names of all instructors who have not taught a course.
select name, dept_name
from instructor
where ID not in (select ID from teaches);

--Find all the course titles that do not have any prerequisites.
select title
from course
where course_id not in (select course_id from prereq);

-- Find the name of the student who takes 2nd, 3rd, and 5th maximum total credits.
select name, tot_cred
from (
    select name, tot_cred, ROWNUM as row_num
    from (select name, tot_cred
        from student  
        order by tot_cred desc)
)
where row_num in (2, 3, 5);

--Find the names of the instructors who are taking courses with no students enrolled. Also, show the name of the courses.
select i.name, c.title
from instructor i, course c
where i.ID in 
	(select ID from teaches where (course_id, sec_id, semester, year) 
	not in (select course_id, sec_id, semester, year from takes))
	and i.ID in (select ID from teaches where course_id = c.course_id);


--Retrieve the course titles and the percentage of students who earned an ’A’ grade in each course.
select c.title, count(*)*100/(select count(*) from takes where grade = 'A') as percentage
from course c, takes t
where c.course_id = t.course_id and t.grade = 'A'
group by t.course_id;

select A.Good*100/B.Total as percentage, A.course_id from
(select course_id, count(ID) as Good from takes where grade = 'A' group by course_id)A,
(select course_id, count(ID) as Total from takes group by course_id)B
where A.course_id = B.course_id;

-- Find the number of instructors who have taught the same course in consecutive years.
select count(distinct t1.ID) as Number_of_instructors
from teaches t1 join teaches t2 on t1.ID = t2.ID 
and t1.course_id = t2.course_id 
and t1.year = t2.year - 1;


--  Insert each student as a student with total credit set to 0 in the same department they are teaching.
insert into student (ID, name, dept_name, tot_cred)
select ID, name, dept_name, 0
from instructor
where ID not in (select ID from student);

-- Update the ‘tot_cred’ for each student based on the credits taken.
update student
set tot_cred = (
	select sum(credits) 
	from takes 
	join course on takes.course_id = course.course_id
	where takes.ID = student.ID);

-- . Update the salary of each instructor to 10000 times the number of course sections they have taught.
update instructor
set salary = (
	select count(*)*10000
	from teaches
	where teaches.ID = instructor.ID);

-- Find all rooms that have been assigned to more than one section at the same time.
select DISTINCT room.building, room.room_number
from section AS sec1
join classroom AS room ON sec1.building = room.building AND sec1.room_number = room.room_number
where EXISTS (
	select 1
	from section AS sec2
	where sec1.time_slot_id = sec2.time_slot_id
	AND sec1.day = sec2.day
	AND sec1.building = sec2.building
	AND sec1.room_number = sec2.room_number
);

/*Create a view that will show the instructor-wise time slot for ‘Fall, 2017’ sorted by the instructor_Id, course_ID, section_-
ID (Instructor_ID, name, his/her course information, section_ID, count of students in that section for the course, and
time_slot).
*/

CREATE VIEW instructor_time_slot AS
SELECT 
    i.ID AS Instructor_ID, 
    i.name AS Instructor_Name, 
    c.course_id AS Course_ID, 
    c.title AS Course_Title, 
    s.sec_id AS Section_ID, 
    COUNT(ta.ID) AS Student_Count, 
    t.time_slot_id AS Time_Slot
FROM 
    instructor i
JOIN 
    teaches te ON i.ID = te.ID
JOIN 
    course c ON te.course_id = c.course_id
JOIN 
    section s ON te.course_id = s.course_id AND te.sec_id = s.sec_id AND te.semester = s.semester AND te.year = s.year
JOIN 
    time_slot t ON s.time_slot_id = t.time_slot_id
LEFT JOIN 
    takes ta ON s.course_id = ta.course_id AND s.sec_id = ta.sec_id AND s.semester = ta.semester AND s.year = ta.year
WHERE 
    s.semester = 'Fall' AND s.year = 2017
GROUP BY 
    i.ID, i.name, c.course_id, c.title, s.sec_id, t.time_slot_id
ORDER BY 
    i.ID, c.course_id, s.sec_id;





/*
Decrease the budget of the departments having a budget of more than 99999 by 10%. Then show the number
of departments that did not get affected. Write a PL/SQl block to do this.
*/
SET SERVEROUTPUT ON;
DECLARE
	CURSOR c1 IS
		SELECT dept_name, budget
		FROM department
		WHERE budget > 99999;
	v_dept_name department.dept_name%TYPE;
	v_budget department.budget%TYPE;
	v_count NUMBER := 0;
BEGIN
	OPEN c1;
	LOOP
		FETCH c1 INTO v_dept_name, v_budget;
		EXIT WHEN c1%NOTFOUND;
		UPDATE department
		SET budget = budget * 0.9
		WHERE dept_name = v_dept_name;
		v_count := v_count + 1;
	END LOOP;
	CLOSE c1;
	DBMS_OUTPUT.PUT_LINE('Number of departments that did not get affected: ' || v_count);
END;