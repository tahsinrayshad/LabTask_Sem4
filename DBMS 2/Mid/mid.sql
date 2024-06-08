-- create user semfourmid identified by semfourmid;
-- grant all privileges to semfourmid;
-- connect semfourmid/semfourmid;


-- todo: printing my name

set serveroutput on;
-- DECLARE
--     fname varchar2(20) := 'Tahsin';
--     lname varchar2(20) := 'Islam';
-- BEGIN
--     dbms_output.put_line('My name is ' || fname || ' ' || lname);
-- END;
-- /


-- TODO: VARIABLES AND DATATYPES

-- declare 
--     v_num NUMBER := 37;
--     v_float NUMBER := 37.37;
--     v_char CHAR := 'A';
--     v_varchar VARCHAR2(20) := 'Bla Bla';
-- BEGIN
--     dbms_output.put_line('Number = ' || v_num);
--     dbms_output.put_line('FLoat = ' || v_float);
--     dbms_output.put_line('Char = ' || v_char);
--     dbms_output.put_line('Varchar = ' || v_varchar);
-- END;
-- /

-- TODO: Numeric

-- DECLARE
--     A Number := 5;
--     B number := 6;
--     C number;
--     D number;
--     E number;
--     F number;
--     G number;
-- BEGIN
--     C := A * B;
--     D := A / B;
--     E := A+B;
--     F := B-A;
--     G := MOD(B,A);
--     dbms_output.put_line(C);
--     dbms_output.put_line(D);
--     dbms_output.put_line(E);
--     dbms_output.put_line(F);
--     dbms_output.put_line(G);
-- end;
-- /


-- TODO : STRING OPERATIONS + USER INPUT
-- DECLARE
--     fname varchar2(20);
--     lname varchar2(20);
-- BEGIN
--     fname := '&fname';
--     lname := '&lname';
--     dbms_output.put_line(fname || ' ' || lname);
-- END;
-- /

-- ! IF & CASE

-- TODO : CASE
-- DECLARE
--     A number;
--     B number;
--     v_ans varchar2(20);
-- BEGIN
--     A := '&A';
--     B := '&B';

--     CASE
--         when A>B then v_ans := 'Big Daddy';
--         when A<B then v_ans := 'Small Daddy';
--         else v_ans := 'Equal Daddy';
--     end case;

--     dbms_output.put_line(v_ans);
-- end;
-- /

-- TODO : IF ELSE
-- DECLARE
--     A number;
--     B number;
--     v_ans varchar2(20);
-- BEGIN
--     A := '&A';
--     B := '&B';

--     IF A>B then 
--         v_ans := 'Big Daddy';
--     ELSIF A<B then 
--         v_ans := 'Small Daddy';
--     else 
--         v_ans := 'Equal Daddy';
    
--     end if;

--     dbms_output.put_line(v_ans);
-- end;
-- /


-- ! LOOP

-- TODO : WHILE LOOP
-- DECLARE
--     x number :=10;
-- BEGIN
--     while x <= 100 LOOP
--         dbms_output.put_line(x);
--         x := x+10;
--     end LOOP;

--     dbms_output.put_line('After Loop ended x= '|| x);
-- end;
-- /

-- TODO : PRINT ODD NUMBERS
-- declare 
--     x number := 0;
-- BEGIN
--     while x < 20 LOOP
--         if MOD(x,2) <> 1 THEN
--             dbms_output.put_line(x+1);
--         end if;
--         x := x+1;
--     end loop;
-- end;
-- /

-- TODO : FOR LOOP
-- declare 
--     x number := 10;
--     counter number :=1;
-- begin
--     for counter in 1 .. 10 LOOP
--         dbms_output.put_line(x);
--         x := x + 10;
--     end LOOP;
-- end;
-- /

-- ! PROCEDURE

-- TODO : PROC - PRINT CURRENT DATE
-- create or replace PROCEDURE cur_date
-- AS
--     D date;
-- BEGIN
--     SELECT SYSDATE into D from dual;

--     dbms_output.put_line('Date: ' || TO_CHAR(D, 'DD-MM-YYYY'));
-- end;
-- /

-- BEGIN
--     cur_date;
-- end;
-- /


-- TODO : SEE ALL THE PROCS
-- select object_name
-- from all_procedures
-- where object_type = 'PROCEDURE'
-- and owner = 'semfourmid';

-- TODO : CREATE PROCEDURE TO PRINT FIBONACCI NUMBERS UPTO N
-- TODO : CREATE PROCEDURE TO PRINT FIBONACCI NUMBERS UPTO N
-- CREATE OR REPLACE PROCEDURE Fibonacchi(N IN NUMBER)
-- AS
--     A NUMBER := 0;
--     B NUMBER := 1;
--     C NUMBER;

-- BEGIN
--     FOR I IN 1..N LOOP
--         DBMS_OUTPUT.PUT_LINE(A);
--         C := A + B;
--         A := B;
--         B := C;
--     END LOOP;
-- END;
-- /
-- BEGIN
--     Fibonacchi;
-- end;
-- /


-- ! FUNCTION

-- TODO : CREATE A Function TO PRINT STUDENT NAME GIVEN ID
-- create or replace function studenter (s_id student.ID%TYPE)
-- return student.name%TYPE 
-- is
--     s_name student.name%type;
-- BEGIN
--     select name into s_name from student where id = s_id;
--     return s_name;
-- end;
-- /

-- DECLARE
--     s_id student.ID%TYPE;
--     s_name student.name%type;
-- BEGIN
--     s_name := studenter('00128');
--     dbms_output.put_line(s_name);
-- end;
-- /


--! CURSOR

-- TODO : PRINT ALL INSTRUCTOR NAME

-- DECLARE
--     cursor inst_sal IS
--         select name from instructor
--         where salary > 75000;

--     vname instructor.name%type;    
-- BEGIN
--     open inst_sal;
--     loop
--         fetch inst_sal into vname;
--         dbms_output.put_line('Name: ' || vname);
--         exit when inst_sal%notfound;
--     end loop;

--     close inst_sal;
-- end;
-- /



-- todo 

create or replace PROCEDURE timeslot(v_week time_slot.day%type, sthour time_slot.start_hr%type, ehour time_slot.end_hr%type)
IS
DECLARE
    cursor time_slots IS
    select name from instructor
    where id = 
        (select id from teaches
        where course_id = 
            (select course_id from section
            where time_slot_id = 
                (select time_slot_id from time_slot
                where day = v_week
                and start_hr = sthour 
                and end_hr = ehour)
            )
        );

    vname instructor.name%type;
BEGIN
    open time_slots;
    loop
        fetch time_slots into vname;
        dbms_output.put_line('Name: ' || vname);
        exit when time_slots%notfound;
    end loop;
    close time_slots;
end;
/

-- DECLARE
--     v_week time_slot.day%type;
--     sthour time_slot.start_hr%type;
--     ehour time_slot.end_hr%type;
--     vname instructor.name%type;

-- BEGIN
--     time_slots('M', '8', '11');
-- end;
-- /

create or replace procedure id_gen(new_id out student.id%type)
IS
    last_id student.id%type := 0;
    seq number;
    today varchar2(8);
BEGIN
    today = TO_CHAR(SYSDATE, 'DDMMYYYY');

    select max(id) into last_id from student;
    if substr(last_id, 1, 8) = today THEN
        seq = TO_NUMBER(SUBSTR(last_id,10)) + 1;
    ELSE
        seq := 1;

    new_id:= today || '.' || LPAD(seq, 5, '0');
end;
/