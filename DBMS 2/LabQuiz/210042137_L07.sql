create user labquiz identified by labquiz;
grant all privileges to labquiz;
connect labquiz/labquiz;

-- TASK 1 
set serveroutput on;
declare
    set_name varchar(20) := 'Delta';
begin
    dbms_output.put_line('The set name is ' || set_name);
end;
/

-- TASK 2
SELECT * 
FROM (SELECT GEN_TITLE, COUNT(*) AS MOVIE_COUNT
FROM GENRES JOIN MTYPE
ON MTYPE.GEN_ID = GENRES.GEN_ID
GROUP BY GEN_TITLE
ORDER BY MOVIE_COUNT DESC)
WHERE ROWNUM = 1;

-- TASK 3

SELECT ACT_FIRSTNAME || ' ' || ACT_LASTNAME AS ACTOR_NAME
FROM ACTOR
WHERE ACT_ID IN (SELECT ACT_ID 
FROM CASTS
WHERE MOV_ID = 
    (SELECT MOV_ID
    FROM RATING
    GROUP BY MOV_ID
    HAVING MIN(REV_STARS) = 
        (SELECT MIN(REV_STARS) AS LOWEST_RATING
        FROM RATING)
    ))
AND ROWNUM = 1
ORDER BY ACTOR_NAME ASC;

-- TASK 4 
SET SERVEROUTPUT ON;
CREATE OR REPLACE PROCEDURE HIGHEST_RATED_GENRE(
    DATE1 IN DATE,
    DATE2 IN DATE
) AS
    GEN_TITLE VARCHAR2(20);
    MOVIE_COUNT NUMBER;
BEGIN
    SELECT GEN_TITLE, MOVIE_COUNT INTO GEN_TITLE, MOVIE_COUNT
    FROM (
        SELECT GEN_TITLE, COUNT(*) AS MOVIE_COUNT, AVG(REV_STARS) AS AVG_RATING
        FROM MTYPE
        JOIN GENRES ON MTYPE.GEN_ID = GENRES.GEN_ID
        JOIN MOVIE ON MTYPE.MOV_ID = MOVIE.MOV_ID
        JOIN RATING ON MOVIE.MOV_ID = RATING.MOV_ID
        WHERE MOV_RELEASEDATE BETWEEN DATE1 AND DATE2
        GROUP BY GEN_TITLE
        ORDER BY AVG_RATING DESC, MOVIE_COUNT DESC
    )
    WHERE ROWNUM = 1;
    
    DBMS_OUTPUT.PUT_LINE('Highest rated genre: ' || GEN_TITLE);
    DBMS_OUTPUT.PUT_LINE('Number of movies: ' || MOVIE_COUNT);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No data found for the given date range.');
END HIGHEST_RATED_GENRE;
/

-- CALL THE PROCEDURE
SET SERVEROUTPUT ON;
BEGIN
    HIGHEST_RATED_GENRE(TO_DATE('01-FEB-2020', 'DD-MON-YYYY'), TO_DATE('31-DEC-2021', 'DD-MON-YYYY'));
END;


-- TASK 5
SET SERVEROUTPUT ON;
CREATE OR REPLACE TRIGGER RATING_INSERT 
AFTER INSERT ON RATING
