-- Tahsin Islam (210042137)

-- create user dbms2lab1 identified by dbms;
-- grant all privileges to dbms2lab1;
connect dbms2lab1/dbms;

--1--
select title from course where dept_name = 'Comp. Sci.' and credits = 3;

--2--
select ID, name, tot_cred 
from student 
where ID in (select ID from takes);

--3--
select name, dept_name
from instructor
where ID not in (select ID from teaches);

--4--
select title
from course
where course_id not in (select course_id from prereq);

--5--
select name, tot_cred
from (
    select name, tot_cred, ROWNUM as row_num
    from (select name, tot_cred
        from student  
        order by tot_cred desc)
)
where row_num in (2, 3, 5);

--6--
select c.name, c.title
from 
(select B.name, B.title, B.course_id
from takes left join 
    (   select c.title, A.name, A.course_id
        from course c left join 
        (   select i.name, t.course_id
            from teaches t left join instructor i on t.ID = i.ID
        )A
            on c.course_id = A.course_id
    )B
on takes.course_id = B.course_id
)C
where C.course_id not in(select course_id from course);

--7--
select A.Good*100/B.Total as percentage, A.course_id from
(select course_id, count(ID) as Good from takes where grade = 'A' group by course_id)A,
(select course_id, count(ID) as Total from takes group by course_id)B
where A.course_id = B.course_id;

--8--
select count(distinct t1.ID) as Number_of_instructors
from teaches t1 join teaches t2 on t1.ID = t2.ID 
and t1.course_id = t2.course_id 
and t1.year = t2.year - 1;

--9--
insert into student (ID, name, dept_name, tot_cred)
select ID, name, dept_name, 0
from instructor
where ID not in (select ID from student);

--10--
update student
set tot_cred = (
	select sum(credits) 
	from takes 
	join course on takes.course_id = course.course_id
	where takes.ID = student.ID);

--11--
update instructor
set salary = (
	select count(*)*10000
	from teaches
	where teaches.ID = instructor.ID);

--12--
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

--13--
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













