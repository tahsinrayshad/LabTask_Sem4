create table classroom (
    building varchar(15),
    room_number varchar(7),
    capacity numeric(4, 0),
    primary key (building, room_number)
);

create table department (
    dept_name varchar(20),
    building varchar(15),
    budget numeric(12, 2) check (budget > 0),
    primary key (dept_name)
);

create table course (
    course_id varchar(8),
    title varchar(50),
    dept_name varchar(20),
    credits numeric(2, 0) check (credits > 0),
    primary key (course_id),
    foreign key (dept_name) references department (dept_name) on delete
    set
        null
);

create table time_slot (
    time_slot_id varchar(4),
    day varchar(1),
    start_hr numeric(2) check (
        start_hr >= 0
        and start_hr < 24
    ),
    start_min numeric(2) check (
        start_min >= 0
        and start_min < 60
    ),
    end_hr numeric(2) check (
        end_hr >= 0
        and end_hr < 24
    ),
    end_min numeric(2) check (
        end_min >= 0
        and end_min < 60
    ),
    primary key (time_slot_id, day, start_hr, start_min)
);

create table prereq (
    course_id varchar(8),
    prereq_id varchar(8),
    primary key (course_id, prereq_id),
    foreign key (course_id) references course (course_id) on delete cascade,
    foreign key (prereq_id) references course (course_id)
);

create table instructor (
    ID varchar(5),
    name varchar(20) not null,
    dept_name varchar(20),
    salary numeric(8, 2) check (salary > 29000),
    primary key (ID),
    foreign key (dept_name) references department (dept_name) on delete
    set
        null
);

create table section (
    course_id varchar(8),
    sec_id varchar(8),
    semester varchar(6) check (
        semester in ('Fall', 'Winter', 'Spring', 'Summer')
    ),
    year numeric(4, 0) check (
        year > 1701
        and year < 2100
    ),
    building varchar(15),
    room_number varchar(7),
    time_slot_id varchar(4),
    primary key (course_id, sec_id, semester, year),
    foreign key (course_id) references course (course_id) on delete cascade,
    foreign key (building, room_number) references classroom (building, room_number) on delete
    set
        null
);

create table teaches (
    ID varchar(5),
    course_id varchar(8),
    sec_id varchar(8),
    semester varchar(6),
    year numeric(4, 0),
    primary key (ID, course_id, sec_id, semester, year),
    foreign key (course_id, sec_id, semester, year) references section (course_id, sec_id, semester, year) on delete cascade,
    foreign key (ID) references instructor (ID) on delete cascade
);

create table student (
    ID varchar(5),
    name varchar(20) not null,
    dept_name varchar(20),
    tot_cred numeric(3, 0) check (tot_cred >= 0),
    primary key (ID),
    foreign key (dept_name) references department (dept_name) on delete
    set
        null
);

create table takes (
    ID varchar(5),
    course_id varchar(8),
    sec_id varchar(8),
    semester varchar(6),
    year numeric(4, 0),
    grade varchar(2),
    primary key (ID, course_id, sec_id, semester, year),
    foreign key (course_id, sec_id, semester, year) references section (course_id, sec_id, semester, year) on delete cascade,
    foreign key (ID) references student (ID) on delete cascade
);

create table advisor (
    s_ID varchar(5),
    i_ID varchar(5),
    primary key (s_ID),
    foreign key (i_ID) references instructor (ID) on delete
    set
        null,
        foreign key (s_ID) references student (ID) on delete cascade
);

insert into
    classroom
values
    ('Packard', '101', '500');

insert into
    classroom
values
    ('Painter', '514', '10');

insert into
    classroom
values
    ('Taylor', '3128', '70');

insert into
    classroom
values
    ('Watson', '100', '30');

insert into
    classroom
values
    ('Watson', '120', '50');

insert into
    department
values
    ('Biology', 'Watson', '90000');

insert into
    department
values
    ('Comp. Sci.', 'Taylor', '100000');

insert into
    department
values
    ('Elec. Eng.', 'Taylor', '85000');

insert into
    department
values
    ('Finance', 'Painter', '120000');

insert into
    department
values
    ('History', 'Painter', '50000');

insert into
    department
values
    ('Music', 'Packard', '80000');

insert into
    department
values
    ('Physics', 'Watson', '70000');

insert into
    course
values
    ('BIO-101', 'Intro. to Biology', 'Biology', '4');

insert into
    course
values
    ('BIO-301', 'Genetics', 'Biology', '4');

insert into
    course
values
    (
        'BIO-399',
        'Computational Biology',
        'Biology',
        '3'
    );

insert into
    course
values
    (
        'CS-101',
        'Intro. to Computer Science',
        'Comp. Sci.',
        '4'
    );

insert into
    course
values
    ('CS-190', 'Game Design', 'Comp. Sci.', '4');

insert into
    course
values
    ('CS-315', 'Robotics', 'Comp. Sci.', '3');

insert into
    course
values
    ('CS-319', 'Image Processing', 'Comp. Sci.', '3');

insert into
    course
values
    (
        'CS-347',
        'Database System Concepts',
        'Comp. Sci.',
        '3'
    );

insert into
    course
values
    (
        'EE-181',
        'Intro. to Digital Systems',
        'Elec. Eng.',
        '3'
    );

insert into
    course
values
    ('FIN-201', 'Investment Banking', 'Finance', '3');

insert into
    course
values
    ('HIS-351', 'World History', 'History', '3');

insert into
    course
values
    ('MU-199', 'Music Video Production', 'Music', '3');

insert into
    course
values
    ('PHY-101', 'Physical Principles', 'Physics', '4');

insert into
    instructor
values
    ('10101', 'Srinivasan', 'Comp. Sci.', '65000');

insert into
    instructor
values
    ('12121', 'Wu', 'Finance', '90000');

insert into
    instructor
values
    ('15151', 'Mozart', 'Music', '40000');

insert into
    instructor
values
    ('22222', 'Einstein', 'Physics', '95000');

insert into
    instructor
values
    ('32343', 'El Said', 'History', '60000');

insert into
    instructor
values
    ('33456', 'Gold', 'Physics', '87000');

insert into
    instructor
values
    ('45565', 'Katz', 'Comp. Sci.', '75000');

insert into
    instructor
values
    ('58583', 'Califieri', 'History', '62000');

insert into
    instructor
values
    ('76543', 'Singh', 'Finance', '80000');

insert into
    instructor
values
    ('76766', 'Crick', 'Biology', '72000');

insert into
    instructor
values
    ('83821', 'Brandt', 'Comp. Sci.', '92000');

insert into
    instructor
values
    ('98345', 'Kim', 'Elec. Eng.', '80000');

insert into
    section
values
    (
        'BIO-101',
        '1',
        'Summer',
        '2017',
        'Painter',
        '514',
        'B'
    );

insert into
    section
values
    (
        'BIO-301',
        '1',
        'Summer',
        '2018',
        'Painter',
        '514',
        'A'
    );

insert into
    section
values
    (
        'CS-101',
        '1',
        'Fall',
        '2017',
        'Packard',
        '101',
        'H'
    );

insert into
    section
values
    (
        'CS-101',
        '1',
        'Spring',
        '2018',
        'Packard',
        '101',
        'F'
    );

insert into
    section
values
    (
        'CS-190',
        '1',
        'Spring',
        '2017',
        'Taylor',
        '3128',
        'E'
    );

insert into
    section
values
    (
        'CS-190',
        '2',
        'Spring',
        '2017',
        'Taylor',
        '3128',
        'A'
    );

insert into
    section
values
    (
        'CS-315',
        '1',
        'Spring',
        '2018',
        'Watson',
        '120',
        'D'
    );

insert into
    section
values
    (
        'CS-319',
        '1',
        'Spring',
        '2018',
        'Watson',
        '100',
        'B'
    );

insert into
    section
values
    (
        'CS-319',
        '2',
        'Spring',
        '2018',
        'Taylor',
        '3128',
        'C'
    );

insert into
    section
values
    (
        'CS-347',
        '1',
        'Fall',
        '2017',
        'Taylor',
        '3128',
        'A'
    );

insert into
    section
values
    (
        'EE-181',
        '1',
        'Spring',
        '2017',
        'Taylor',
        '3128',
        'C'
    );

insert into
    section
values
    (
        'FIN-201',
        '1',
        'Spring',
        '2018',
        'Packard',
        '101',
        'B'
    );

insert into
    section
values
    (
        'HIS-351',
        '1',
        'Spring',
        '2018',
        'Painter',
        '514',
        'C'
    );

insert into
    section
values
    (
        'MU-199',
        '1',
        'Spring',
        '2018',
        'Packard',
        '101',
        'D'
    );

insert into
    section
values
    (
        'PHY-101',
        '1',
        'Fall',
        '2017',
        'Watson',
        '100',
        'A'
    );

insert into
    teaches
values
    ('10101', 'CS-101', '1', 'Fall', '2017');

insert into
    teaches
values
    ('10101', 'CS-315', '1', 'Spring', '2018');

insert into
    teaches
values
    ('10101', 'CS-347', '1', 'Fall', '2017');

insert into
    teaches
values
    ('12121', 'FIN-201', '1', 'Spring', '2018');

insert into
    teaches
values
    ('15151', 'MU-199', '1', 'Spring', '2018');

insert into
    teaches
values
    ('22222', 'PHY-101', '1', 'Fall', '2017');

insert into
    teaches
values
    ('32343', 'HIS-351', '1', 'Spring', '2018');

insert into
    teaches
values
    ('45565', 'CS-101', '1', 'Spring', '2018');

insert into
    teaches
values
    ('45565', 'CS-319', '1', 'Spring', '2018');

insert into
    teaches
values
    ('76766', 'BIO-101', '1', 'Summer', '2017');

insert into
    teaches
values
    ('76766', 'BIO-301', '1', 'Summer', '2018');

insert into
    teaches
values
    ('83821', 'CS-190', '1', 'Spring', '2017');

insert into
    teaches
values
    ('83821', 'CS-190', '2', 'Spring', '2017');

insert into
    teaches
values
    ('83821', 'CS-319', '2', 'Spring', '2018');

insert into
    teaches
values
    ('98345', 'EE-181', '1', 'Spring', '2017');

insert into
    student
values
    ('00128', 'Zhang', 'Comp. Sci.', '102');

insert into
    student
values
    ('12345', 'Shankar', 'Comp. Sci.', '32');

insert into
    student
values
    ('19991', 'Brandt', 'History', '80');

insert into
    student
values
    ('23121', 'Chavez', 'Finance', '110');

insert into
    student
values
    ('44553', 'Peltier', 'Physics', '56');

insert into
    student
values
    ('45678', 'Levy', 'Physics', '46');

insert into
    student
values
    ('54321', 'Williams', 'Comp. Sci.', '54');

insert into
    student
values
    ('55739', 'Sanchez', 'Music', '38');

insert into
    student
values
    ('70557', 'Snow', 'Physics', '0');

insert into
    student
values
    ('76543', 'Brown', 'Comp. Sci.', '58');

insert into
    student
values
    ('76653', 'Aoi', 'Elec. Eng.', '60');

insert into
    student
values
    ('98765', 'Bourikas', 'Elec. Eng.', '98');

insert into
    student
values
    ('98988', 'Tanaka', 'Biology', '120');

insert into
    takes
values
    ('00128', 'CS-101', '1', 'Fall', '2017', 'A');

insert into
    takes
values
    ('00128', 'CS-347', '1', 'Fall', '2017', 'A-');

insert into
    takes
values
    ('12345', 'CS-101', '1', 'Fall', '2017', 'C');

insert into
    takes
values
    ('12345', 'CS-190', '2', 'Spring', '2017', 'A');

insert into
    takes
values
    ('12345', 'CS-315', '1', 'Spring', '2018', 'A');

insert into
    takes
values
    ('12345', 'CS-347', '1', 'Fall', '2017', 'A');

insert into
    takes
values
    ('19991', 'HIS-351', '1', 'Spring', '2018', 'B');

insert into
    takes
values
    ('23121', 'FIN-201', '1', 'Spring', '2018', 'C+');

insert into
    takes
values
    ('44553', 'PHY-101', '1', 'Fall', '2017', 'B-');

insert into
    takes
values
    ('45678', 'CS-101', '1', 'Fall', '2017', 'F');

insert into
    takes
values
    ('45678', 'CS-101', '1', 'Spring', '2018', 'B+');

insert into
    takes
values
    ('45678', 'CS-319', '1', 'Spring', '2018', 'B');

insert into
    takes
values
    ('54321', 'CS-101', '1', 'Fall', '2017', 'A-');

insert into
    takes
values
    ('54321', 'CS-190', '2', 'Spring', '2017', 'B+');

insert into
    takes
values
    ('55739', 'MU-199', '1', 'Spring', '2018', 'A-');

insert into
    takes
values
    ('76543', 'CS-101', '1', 'Fall', '2017', 'A');

insert into
    takes
values
    ('76543', 'CS-319', '2', 'Spring', '2018', 'A');

insert into
    takes
values
    ('76653', 'EE-181', '1', 'Spring', '2017', 'C');

insert into
    takes
values
    ('98765', 'CS-101', '1', 'Fall', '2017', 'C-');

insert into
    takes
values
    ('98765', 'CS-315', '1', 'Spring', '2018', 'B');

insert into
    takes
values
    ('98988', 'BIO-101', '1', 'Summer', '2017', 'A');

insert into
    takes
values
    ('98988', 'BIO-301', '1', 'Summer', '2018', null);

insert into
    advisor
values
    ('00128', '45565');

insert into
    advisor
values
    ('12345', '10101');

insert into
    advisor
values
    ('23121', '76543');

insert into
    advisor
values
    ('44553', '22222');

insert into
    advisor
values
    ('45678', '22222');

insert into
    advisor
values
    ('76543', '45565');

insert into
    advisor
values
    ('76653', '98345');

insert into
    advisor
values
    ('98765', '98345');

insert into
    advisor
values
    ('98988', '76766');

insert into
    time_slot
values
    ('A', 'M', '8', '0', '8', '50');

insert into
    time_slot
values
    ('A', 'W', '8', '0', '8', '50');

insert into
    time_slot
values
    ('A', 'F', '8', '0', '8', '50');

insert into
    time_slot
values
    ('B', 'M', '9', '0', '9', '50');

insert into
    time_slot
values
    ('B', 'W', '9', '0', '9', '50');

insert into
    time_slot
values
    ('B', 'F', '9', '0', '9', '50');

insert into
    time_slot
values
    ('C', 'M', '11', '0', '11', '50');

insert into
    time_slot
values
    ('C', 'W', '11', '0', '11', '50');

insert into
    time_slot
values
    ('C', 'F', '11', '0', '11', '50');

insert into
    time_slot
values
    ('D', 'M', '13', '0', '13', '50');

insert into
    time_slot
values
    ('D', 'W', '13', '0', '13', '50');

insert into
    time_slot
values
    ('D', 'F', '13', '0', '13', '50');

insert into
    time_slot
values
    ('E', 'T', '10', '30', '11', '45 ');

insert into
    time_slot
values
    ('E', 'R', '10', '30', '11', '45 ');

insert into
    time_slot
values
    ('F', 'T', '14', '30', '15', '45 ');

insert into
    time_slot
values
    ('F', 'R', '14', '30', '15', '45 ');

insert into
    time_slot
values
    ('G', 'M', '16', '0', '16', '50');

insert into
    time_slot
values
    ('G', 'W', '16', '0', '16', '50');

insert into
    time_slot
values
    ('G', 'F', '16', '0', '16', '50');

insert into
    time_slot
values
    ('H', 'W', '10', '0', '12', '30');

insert into
    prereq
values
    ('BIO-301', 'BIO-101');

insert into
    prereq
values
    ('BIO-399', 'BIO-101');

insert into
    prereq
values
    ('CS-190', 'CS-101');

insert into
    prereq
values
    ('CS-315', 'CS-101');

insert into
    prereq
values
    ('CS-319', 'CS-101');

insert into
    prereq
values
    ('CS-347', 'CS-101');

insert into
    prereq
values
    ('EE-181', 'PHY-101');

--task 1
-- 1. Create a function that takes the department name of an instructor as input and generates an ID in the form: XYYYY.
-- Here, X is 1 for Physics, 2 for Music, 3 for History, 4 for Finance, 5 for Elec. Eng., 6 for Comp. Sci., and 7 for Biology.
-- Again, for each department, YYYY will be generated from a sequence starting from 1. If the digit count of the number
-- generated by the sequence is less than 4, then 0s will be padded to the left of the number to make it 4 digits.
CREATE SEQUENCE instructor_id_seq_phy START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE instructor_id_seq_music START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE instructor_id_seq_History START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE instructor_id_seq_Finance START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE instructor_id_seq_Elec_Eng START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE instructor_id_seq_cs START WITH 1 INCREMENT BY 1;

CREATE SEQUENCE instructor_id_seq_Biology START WITH 1 INCREMENT BY 1;

CREATE
OR REPLACE FUNCTION generate_instructor_id_func(p_dept_name IN INSTRUCTOR.DEPT_NAME % type) RETURN VARCHAR2 AS 

v_dept_prefix VARCHAR2(1);

v_new_id instructor.ID % type;

BEGIN CASE
    p_dept_name
    WHEN 'Physics' THEN v_dept_prefix := '1';

SELECT
    v_dept_prefix || LPAD(instructor_id_seq_phy.NEXTVAL, 4, '0') INTO v_new_id
FROM
    dual;

WHEN 'Music' THEN v_dept_prefix := '2';

SELECT
    v_dept_prefix || LPAD(instructor_id_seq_music.NEXTVAL, 4, '0') INTO v_new_id
FROM
    dual;

WHEN 'History' THEN v_dept_prefix := '3';

SELECT
    v_dept_prefix || LPAD(instructor_id_seq_History.NEXTVAL, 4, '0') INTO v_new_id
FROM
    dual;

WHEN 'Finance' THEN v_dept_prefix := '4';

SELECT
    v_dept_prefix || LPAD(instructor_id_seq_Finance.NEXTVAL, 4, '0') INTO v_new_id
FROM
    dual;

WHEN 'Elec. Eng.' THEN v_dept_prefix := '5';

SELECT
    v_dept_prefix || LPAD(instructor_id_seq_Elec_Eng.NEXTVAL, 4, '0') INTO v_new_id
FROM
    dual;

WHEN 'Comp. Sci.' THEN v_dept_prefix := '6';

SELECT
    v_dept_prefix || LPAD(instructor_id_seq_cs.NEXTVAL, 4, '0') INTO v_new_id
FROM
    dual;

WHEN 'Biology' THEN v_dept_prefix := '7';

SELECT
    v_dept_prefix || LPAD(instructor_id_seq_Biology.NEXTVAL, 4, '0') INTO v_new_id
FROM
    dual;

ELSE v_dept_prefix := '0';

END CASE
;

RETURN v_new_id;

END;

/
Set
    serveroutput on;

BEGIN DBMS_OUTPUT.PUT_LINE(generate_instructor_id_func('History'));

end;

/ -- CREATE OR REPLACE TRIGGER generate_instructor_id
-- BEFORE INSERT ON instructor
-- FOR EACH ROW
-- DECLARE
--     v_dept_prefix VARCHAR2(1);
--     v_new_id INSTRUCTOR.ID%type;
-- BEGIN
--     -- Assigning department prefix based on department name
--     CASE :NEW.DEPT_NAME
--         WHEN 'Physics' THEN
--             v_dept_prefix := '1';
--         WHEN 'Music' THEN
--             v_dept_prefix := '2';
--         WHEN 'History' THEN
--             v_dept_prefix := '3';
--         WHEN 'Finance' THEN
--             v_dept_prefix := '4';
--         WHEN 'Elec. Eng.' THEN
--             v_dept_prefix := '5';
--         WHEN 'Comp. Sci.' THEN
--             v_dept_prefix := '6';
--         WHEN 'Biology' THEN
--             v_dept_prefix := '7';
--         ELSE
--             v_dept_prefix := '0';
--     END CASE;
--
--
--     SELECT v_dept_prefix || LPAD(instructor_id_seq.NEXTVAL, 4, '0') INTO v_new_id FROM dual;
--
--     :NEW.ID := v_new_id;
-- END;
-- /


--task 2
-- Using the function created in task 1, update the IDs of the existing instructors. Assume that the instructors of a
-- particular department are employed in the alphabetical order of their names.
Create
or replace PROCEDURE Update_All_Instructor is CURSOR instructor_cursor IS
SELECT
    *
FROM
    instructor
order by
    name;

v_new_id INSTRUCTOR.ID % type;

v_teaches_cons varchar2(50);

v_advisor_cons varchar2(50);

BEGIN --dropping foreign key of teaches referencing instructor
SELECT
    constraint_name INTO v_teaches_cons
FROM
    user_constraints
WHERE
    table_name = 'TEACHES'
    AND r_constraint_name IN (
        SELECT
            constraint_name
        FROM
            user_constraints
        WHERE
            table_name = 'INSTRUCTOR'
            AND constraint_type = 'P'
    );

EXECUTE IMMEDIATE 'ALTER TABLE TEACHES DROP CONSTRAINT ' || v_teaches_cons;

--dropping foreign key of advisor referencing instructor
SELECT
    constraint_name INTO v_advisor_cons
FROM
    user_constraints
WHERE
    table_name = 'ADVISOR'
    AND r_constraint_name IN (
        SELECT
            constraint_name
        FROM
            user_constraints
        WHERE
            table_name = 'INSTRUCTOR'
            AND constraint_type = 'P'
    );

EXECUTE IMMEDIATE 'ALTER TABLE ADVISOR DROP CONSTRAINT ' || v_advisor_cons;

--now main game
FOR instructor_rec IN instructor_cursor LOOP 

v_new_id := generate_instructor_id_func(instructor_rec.dept_name);

Update
    teaches
SET
    teaches.ID = v_new_id
where
    teaches.ID = instructor_rec.ID;

Update
    ADVISOR
SET
    advisor.i_ID = v_new_id
where
    advisor.i_ID = instructor_rec.ID;

COMMIT;

--lastly
UPDATE
    INSTRUCTOR
set
    instructor.ID = v_new_id
where
    instructor.ID = instructor_rec.ID;

DBMS_OUTPUT.PUT_LINE(
    'Updated ID for ' || instructor_rec.name || ': ' || v_new_id
);

END LOOP;

--reinstate constraints
execute immediate 'ALTER TABLE teaches ADD CONSTRAINT' || ' fk_instructor_id_t ' || 'FOREIGN KEY (ID)  REFERENCES instructor(ID)ON DELETE CASCADE';

execute immediate 'ALTER TABLE advisor ADD CONSTRAINT' || ' fk_instructor_id_a ' || 'FOREIGN KEY (i_ID) REFERENCES instructor(ID) ON DELETE CASCADE';

END;
/ 

--task 3
-- 3. Write a trigger to automatically generate the IDs of the newly employed instructor.
CREATE
OR REPLACE TRIGGER generate_instructor_id BEFORE
INSERT
    ON instructor FOR EACH ROW DECLARE v_dept_prefix VARCHAR2(1);

v_new_id INSTRUCTOR.ID % type;

BEGIN -- Assigning department prefix based on department name
CASE
    :NEW.DEPT_NAME
    WHEN 'Physics' THEN v_dept_prefix := '1';

SELECT
    v_dept_prefix || LPAD(instructor_id_seq_phy.NEXTVAL, 4, '0') INTO v_new_id
FROM
    dual;

WHEN 'Music' THEN v_dept_prefix := '2';

SELECT
    v_dept_prefix || LPAD(instructor_id_seq_music.NEXTVAL, 4, '0') INTO v_new_id
FROM
    dual;

WHEN 'History' THEN v_dept_prefix := '3';

SELECT
    v_dept_prefix || LPAD(instructor_id_seq_History.NEXTVAL, 4, '0') INTO v_new_id
FROM
    dual;

WHEN 'Finance' THEN v_dept_prefix := '4';

SELECT
    v_dept_prefix || LPAD(instructor_id_seq_Finance.NEXTVAL, 4, '0') INTO v_new_id
FROM
    dual;

WHEN 'Elec. Eng.' THEN v_dept_prefix := '5';

SELECT
    v_dept_prefix || LPAD(instructor_id_seq_Elec_Eng.NEXTVAL, 4, '0') INTO v_new_id
FROM
    dual;

WHEN 'Comp. Sci.' THEN v_dept_prefix := '6';

SELECT
    v_dept_prefix || LPAD(instructor_id_seq_cs.NEXTVAL, 4, '0') INTO v_new_id
FROM
    dual;

WHEN 'Biology' THEN v_dept_prefix := '7';

SELECT
    v_dept_prefix || LPAD(instructor_id_seq_Biology.NEXTVAL, 4, '0') INTO v_new_id
FROM
    dual;

ELSE v_dept_prefix := '0';

END CASE
;

:NEW.ID := v_new_id;

END;

/ --task4
-- Consider that the salary of the instructor will be determined based on the formula:
-- max(min(40000, 10000X), 1000000)
--
-- Here, X is the number of courses offered by the instructor. Write a trigger that updates the salary of the instructor
-- each time they offer a new course.
CREATE
OR REPLACE TRIGGER update_instructor_salary
AFTER
INSERT
    ON teaches FOR EACH ROW DECLARE v_course_count NUMBER;

v_new_salary NUMBER;

BEGIN -- Count the number of courses offered by the instructor
SELECT
    COUNT(*) INTO v_course_count
FROM
    teaches
WHERE
    ID = :NEW.ID;

-- Calculate the new salary based on the formula
v_new_salary := LEAST(40000, 10000 * v_course_count);

v_new_salary := GREATEST(v_new_salary, 1000000);

-- Update the salary in the instructor table
UPDATE
    instructor
SET
    salary = v_new_salary
WHERE
    ID = :NEW.ID;

-- Commit the transaction
COMMIT;

END;

/ --task 5
-- Write a trigger that assigns a newly employed instructor to the course offered by their own department. While
-- assigning, the course that has not been offered before should get the highest priority. If that does not exist, then
-- the course that was offered at the earliest (in terms of year) should be assigned. A new section will be created for
-- the course. The semester will be Winter if the current date falls between November to February, Summer if it falls
-- between March to July, and Fall if it falls between August to October. The selected room should reside in the same
-- building as the department. The time slot must be empty and selected sequentially from Monday to Friday.
CREATE
OR REPLACE TRIGGER assign_instructor_to_course
AFTER
INSERT
    ON instructor FOR EACH ROW DECLARE v_department_course_id teaches.course_id % type := -1;

--1. first work to find the course ID that is not in teaches
v_course_id VARCHAR2(8);

v_room_number VARCHAR2(7);

v_time_slot_id VARCHAR2(4);

v_semester VARCHAR2(6);

v_year NUMBER;

BEGIN -- Determine the semester based on the current date
SELECT
    CASE
        WHEN TO_CHAR(SYSDATE, 'MM') IN ('11', '12', '01', '02') THEN 'Winter'
        WHEN TO_CHAR(SYSDATE, 'MM') IN ('03', '04', '05', '06', '07') THEN 'Summer'
        ELSE 'Fall'
    END INTO v_semester
FROM
    dual;

-- Determine the year
v_year := TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY'));

-- Find a course offered by the instructor's department that meets the criteria
SELECT
    course_id INTO v_department_course_id
FROM
    course
WHERE
    dept_name = :NEW.dept_name
    AND course_id NOT IN (
        SELECT
            course_id
        FROM
            teaches
    );

IF SQL % ROWCOUNT = 0 THEN
select
    course_id into v_department_course_id
from
    (
        SELECT
            teaches.course_id
        FROM
            course,
            teaches
        WHERE
            dept_name = :NEW.dept_name
            AND course.course_id = teaches.course_id
        ORDER BY
            teaches.year
    )
where
    ROWNUM <= 1;

end if;

-- If a course is found, assign the instructor to it
IF v_department_course_id IS NOT NULL THEN -- Find a room in the same building as the department
SELECT
    room_number INTO v_room_number
FROM
    classroom
WHERE
    building = (
        SELECT
            building
        FROM
            department
        WHERE
            dept_name = :NEW.dept_name
    )
    AND ROWNUM = 1;

-- Select the first available room
select
    time_slot.time_slot_id into v_time_slot_id
from
    TIME_SLOT
where
    time_slot.time_slot_id NOT IN(
        SELECT
            time_slot_id
        FROM
            section
        WHERE
            semester = v_semester
            AND year = v_year
    )
order by
    CASE
        WHEN day = 'M' THEN 1
        WHEN day = 'T' THEN 2
        WHEN day = 'W' THEN 3
        WHEN day = 'R' THEN 4
        WHEN day = 'F' THEN 5
        ELSE 6
    END
    AND rownum = 1;

-- Insert a new section for the course
INSERT INTO
    section (
        course_id,
        sec_id,
        semester,
        year,
        building,
        room_number,
        time_slot_id
    )
VALUES
    (
        v_department_course_id,
        (
            SELECT
                MAX(sec_id) + 1
            FROM
                section
            WHERE
                course_id = v_department_course_id
        ),
        v_semester,
        v_year,
        (
            SELECT
                building
            FROM
                department
            WHERE
                dept_name = :NEW.dept_name
        ),
        v_room_number,
        v_time_slot_id
    );

END IF;

END;

/