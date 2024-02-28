-- create user dbmslab06 identified by dbms;
-- grant all privileges to dbmslab06;
-- connect dbmslab06/dbms;

-- Task 1
CREATE SEQUENCE biology_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE comp_sci_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE elec_eng_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE finance_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE history_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE music_seq START WITH 1 INCREMENT BY 1;
CREATE SEQUENCE physics_seq START WITH 1 INCREMENT BY 1;

-- Create the function
SET SERVEROUTPUT ON;
CREATE OR REPLACE FUNCTION generate_student_id(dept_name IN VARCHAR2) RETURN VARCHAR2 IS
    dept_id VARCHAR2(1);
    seq_name VARCHAR2(20);
    student_id VARCHAR2(6);
BEGIN
    -- Assign department ID based on department name
    CASE dept_name
        WHEN 'Biology' THEN dept_id := '1';
        WHEN 'Comp. Sci.' THEN dept_id := '2';
        WHEN 'Elec. Eng.' THEN dept_id := '3';
        WHEN 'Finance' THEN dept_id := '4';
        WHEN 'History' THEN dept_id := '5';
        WHEN 'Music' THEN dept_id := '6';
        WHEN 'Physics' THEN dept_id := '7';
    END CASE;

    -- Assign sequence name based on department name
    CASE dept_name
        WHEN 'Biology' THEN seq_name := 'biology_seq';
        WHEN 'Comp. Sci.' THEN seq_name := 'comp_sci_seq';
        WHEN 'Elec. Eng.' THEN seq_name := 'elec_eng_seq';
        WHEN 'Finance' THEN seq_name := 'finance_seq';
        WHEN 'History' THEN seq_name := 'history_seq';
        WHEN 'Music' THEN seq_name := 'music_seq';
        WHEN 'Physics' THEN seq_name := 'physics_seq';
    END CASE;

    -- Generate student ID using dynamic SQL to fetch next sequence value
    EXECUTE IMMEDIATE 'SELECT :1 || LPAD(TO_CHAR(' || seq_name || '.NEXTVAL), 4, ''0'') FROM DUAL'
        INTO student_id
        USING dept_id;

    RETURN student_id;
END;
/


-- Use
DECLARE
    student_dept VARCHAR2(20) := 'Comp. Sci.';
    new_student_id VARCHAR2(6);
BEGIN
    new_student_id := generate_student_id(student_dept);
    DBMS_OUTPUT.PUT_LINE('New student ID: ' || new_student_id);
END;
/


-- Task 2
SET SERVEROUTPUT ON;
DECLARE
    v_dept_name department.dept_name%TYPE;
    v_id instructor.ID%TYPE;
	v_new_id instructor.ID%TYPE;
	CURSOR dept_cursor IS
		SELECT dept_name
		FROM department;

	CURSOR inst_cursor (dept_name_var VARCHAR2) IS
        SELECT ID
        FROM instructor
        WHERE dept_name = dept_name_var
        ORDER BY name;
BEGIN
	FOR dept_rec IN dept_cursor LOOP
		v_dept_name := dept_rec.dept_name;
		
		FOR inst_rec IN inst_cursor(v_dept_name) LOOP
			V_id := inst_rec.ID;

			-- Generate new ID using the function
			v_new_id := generate_student_id(v_dept_name);

			-- Update the ID
			UPDATE instructor
			SET ID = v_new_id
			WHERE ID = v_id;
	
			DBMS_OUTPUT.PUT_LINE('Updated ID for ' || v_id || ' to ' || v_new_id || ' in ' || v_dept_name);
		END LOOP;
	END LOOP;
END;
/


-- Task 3
CREATE OR REPLACE TRIGGER instructor_id_trigger
BEFORE INSERT ON instructor
FOR EACH ROW
DECLARE
    v_new_id instructor.ID%TYPE;
BEGIN
    v_new_id := generate_student_id(:new.dept_name);

    :NEW.ID := v_new_id;
END;
/

-- Just Checking
INSERT INTO instructor (ID, name, dept_name, salary)
VALUES ('', 'ARMK', 'Comp. Sci.', 500000);

select * from instructor where name = 'ARMK';