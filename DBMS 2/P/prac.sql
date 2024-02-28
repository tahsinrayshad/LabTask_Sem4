SET SERVEROUTPUT ON;
DECLARE
    x NUMBER := 10;
BEGIN
    WHILE x <=50
    LOOP
        DBMS_OUTPUT.PUT_LINE(x);
        x := x + 10;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('After Loop ended, x = ' || x);
END;
/


SET SERVEROUTPUT ON;
DECLARE
    t NUMBER := 10;
    x number := 1;
BEGIN
    FOR x IN 1..5 LOOP
    DBMS_OUTPUT.PUT_LINE(t || ' ' || x);
    t := t + 10;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('After Loop ended, t = ' || t);
END;
/


