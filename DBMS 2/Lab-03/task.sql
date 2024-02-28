-- Task 1 --

update instructor
set salary = 9000 *
(select sum(credits) from course where course_id in
(select course_id from teaches where teaches.ID = instructor.ID));

select name 
from instructor
where salary > 9000;


-- Task 2 --

select title, name
from course, student, takes
where course.course_id = takes.course_id 
and takes.ID = student.ID 
and course.course_id 
not in (select prereq_id from prereq where prereq.course_id = course.course_id);

-- Task 3 --

select day, start_hr, start_min, end_hr, end_min, title
from time_slot, section, course, takes
where time_slot.time_slot_id = section.time_slot_id
and section.course_id = course.course_id
and takes.course_id = course.course_id
and takes.ID = '12345'
order by day, start_hr, start_min;







