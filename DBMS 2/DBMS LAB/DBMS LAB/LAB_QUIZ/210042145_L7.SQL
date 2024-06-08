--1.
SET SERVEROUTPUT ON;
BEGIN
    DBMS_OUTPUT.PUT_LINE('DELTA');
end;
/

--2. FInd the most popular genre.
-- select GEN_TITLE
--     from
-- (
-- select GEN_TITLE,count(RATING.REV_STARS)
--     from GENRES ,MTYPE ,RATING
--     where GENRES.GEN_ID=MTYPE.GEN_ID AND MTYPE.MOV_ID=RATING.MOV_ID
-- group by  GEN_TITLE
-- order by count(RATING.REV_STARS) DESC)
-- where ROWNUM<=1;


   select GEN_TITLE,total_rev
    from
    (
    SELECT g.GEN_TITLE,AVG(r.REV_STARS) as total_rev
    FROM GENRES g
    JOIN MTYPE mt ON g.GEN_ID = mt.GEN_ID
    JOIN MOVIE m ON mt.MOV_ID = m.MOV_ID
    JOIN RATING r ON m.MOV_ID = r.MOV_ID
    GROUP BY g.GEN_TITLE
    ORDER BY AVG(r.REV_STARS) DESC)
    where ROWNUM<=1;

--3.
select actor_name
from
(
select ACT_FIRSTNAME || ' '|| ACT_LASTNAME as actor_name, COUNT(CASTS.MOV_ID)
from ACTOR,CASTS,(select MOV_ID,MIN(REV_STARS)
FROM RATING
GROUP BY MOV_ID
ORDER BY Min(REV_STARS))S
where ACTOR.ACT_ID=CASTS.ACT_ID AND CASTS.MOV_ID=S.MOV_ID
group by ACT_FIRSTNAME,ACT_LASTNAME
order by  COUNT(CASTS.MOV_ID) DESC)
where Rownum<=1;



--4.


CREATE OR REPLACE PROCEDURE highest_rated_genre_count(
    start_date IN DATE,
    end_date IN DATE
)
IS
    highest_genre GENRES.GEN_TITLE%type;
    movie_count NUMBER;
BEGIN

    select GEN_TITLE into highest_genre
    from
    (
    SELECT g.GEN_TITLE
    FROM GENRES g
    JOIN MTYPE mt ON g.GEN_ID = mt.GEN_ID
    JOIN MOVIE m ON mt.MOV_ID = m.MOV_ID
    JOIN RATING r ON m.MOV_ID = r.MOV_ID
    WHERE m.MOV_RELEASEDATE BETWEEN start_date AND end_date
    GROUP BY g.GEN_TITLE
    ORDER BY AVG(r.REV_STARS) DESC)
    where ROWNUM<=1;

    SELECT count(MOV_ID) into movie_count
    from MTYPE,GENRES
    where MTYPE.GEN_ID=GENRES.GEN_ID and GEN_TITLE=highest_genre;

    DBMS_OUTPUT.PUT_LINE('Highest Rated Genre: ' || highest_genre);
    DBMS_OUTPUT.PUT_LINE('Number of Movies Released: ' || movie_count);
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('No movies found between the given dates.');
END;
/
DECLARE
    start_date DATE := TO_DATE('2023-01-01', 'YYYY-MM-DD');
    end_date DATE := TO_DATE('2023-12-31', 'YYYY-MM-DD');
BEGIN
    highest_rated_genre_count(start_date, end_date);
END;
/


--5.
CREATE or REPLACE trigger isNew before
insert on RATING FOR EACH ROW
DECLARE
    v_isNew varchar2(20):='notNew';
    v_genre GENRES.GEN_TITLE%type;
    v_total_genre_rated number:=0;
    v_avg_genre_rating number;
begin
    select GENRES.GEN_TITLE into v_genre
        from MTYPE,GENRES
            where MTYPE.GEN_ID=GENRES.GEN_ID AND MTYPE.MOV_ID=:NEW.MOV_ID;
    IF SQL%notfound then
        DBMS_OUTPUT.PUT_LINE('UNKNOWN GENRE');
    else
  select count(MTYPE.MOV_ID) into v_total_genre_rated
        from RATING,MTYPE,GENRES
            where RATING.MOV_ID=MTYPE.MOV_ID AND MTYPE.GEN_ID=GENRES.GEN_ID AND
                  GENRES.GEN_TITLE=v_genre AND RATING.REV_ID=:NEW.REV_ID;

    IF v_total_genre_rated=0 then
        v_isNew:='New';
    end if;


    IF v_isNew='New' THEN--now print the average rating of that genre from all reviewers
        select avg(REV_STARS) into v_avg_genre_rating
            from RATING,MTYPE,GENRES
                where RATING.MOV_ID=MTYPE.MOV_ID AND MTYPE.GEN_ID=GENRES.GEN_ID AND GEN_TITLE=v_genre;


    ELSE--now print the average rating of this genre rated by this reviewr only
         select avg(REV_STARS) into v_avg_genre_rating
            from RATING,MTYPE,GENRES
                where RATING.MOV_ID=MTYPE.MOV_ID AND MTYPE.GEN_ID=GENRES.GEN_ID AND GEN_TITLE=v_genre AND RATING.REV_ID=:NEW.REV_ID;
    end if;
    DBMS_OUTPUT.PUT_LINE('Average rating of ' || v_genre || ' :'||v_avg_genre_rating);
    end if;




end;
/


--6.
CREATE OR REPLACE TRIGGER suggest_rating_trigger
BEFORE INSERT OR UPDATE ON RATING
FOR EACH ROW
DECLARE
    reviewer_id NUMBER := :NEW.REV_ID;
    movie_id NUMBER := :NEW.MOV_ID;
    suggested_rating NUMBER;
BEGIN

    SELECT
        NVL((--now find the sm
            select avg_rev_str
                from
            (SELECT AVG(REV_STARS) as avg_rev_str
            FROM RATING
            WHERE MOV_ID = movie_id
            AND REV_ID IN (
                SELECT REV_ID
                FROM RATING
                WHERE MOV_ID = movie_id
                GROUP BY REV_ID
                ORDER BY COUNT(*) DESC
            ))
            where ROWNUM<=1
        ), 0) * 0.23 +
        NVL(( select avg_rev_str --now FInd the SG
                from (SELECT AVG(REV_STARS) as avg_rev_str
                      FROM RATING
                      WHERE MOV_ID = movie_id
                        AND REV_ID IN (SELECT REV_ID
                                       FROM RATING
                                                JOIN MTYPE ON RATING.MOV_ID = MTYPE.MOV_ID
                                       WHERE MTYPE.GEN_ID IN (SELECT GEN_ID
                                                              FROM MTYPE
                                                              WHERE MOV_ID = movie_id)
                                       GROUP BY REV_ID
                                       ORDER BY COUNT(*) DESC)) where ROWNUM<=1
        ), 0) * 0.18 +
        NVL((

            select avg_rev_str -- now find ASM
                from (SELECT AVG(REV_STARS) as avg_rev_str
                      FROM RATING
                      WHERE MOV_ID = movie_id
                        AND REV_ID IN (SELECT REV_ID
                                       FROM RATING
                                       WHERE MOV_ID = movie_id
                                       GROUP BY REV_ID
                                       ORDER BY ABS(AVG(REV_STARS) - (SELECT AVG(REV_STARS)
                                                                      FROM RATING
                                                                      WHERE MOV_ID = movie_id
                                                                        AND REV_ID = reviewer_id
                                                                      GROUP BY REV_ID)) ASC)) where ROWNUM<=1
        ), 0) * 0.32 +
        NVL((
            select avg_rev_str --NOW FIND ASG
            from (SELECT AVG(REV_STARS) as avg_rev_str
                  FROM RATING
                  WHERE MOV_ID = movie_id
                    AND REV_ID IN (SELECT REV_ID
                                   FROM RATING
                                            JOIN MTYPE ON RATING.MOV_ID = MTYPE.MOV_ID
                                   WHERE MTYPE.GEN_ID IN (SELECT GEN_ID
                                                          FROM MTYPE
                                                          WHERE MOV_ID = movie_id)
                                   GROUP BY REV_ID
                                   ORDER BY ABS(AVG(REV_STARS) - (SELECT AVG(REV_STARS)
                                                                  FROM RATING
                                                                  WHERE MOV_ID = movie_id
                                                                    AND REV_ID = reviewer_id
                                                                  GROUP BY REV_ID)) ASC)) where ROWNUM<=1
        ), 0) * 0.27
    INTO suggested_rating
    FROM DUAL;


    :NEW.REV_STARS := suggested_rating;
END;
/


select next_day(sysdate,'SAT') from dual;

CREATE sequence sq_1
start with 1
maxvalue 100
increment by 1;


select sq_1.currval as cur_val from DUAL;

select to_char(sysdate,'DAY') from dual;





----

create or replace FUNCTION CountActor(p_x IN NUMBER)
return NUMBER as
v_x number:=p_x;
v_totalActors Number:=0;
cursor c_x is
    select * from ACTOR;
begin

    for i in c_x loop
        v_totalActors:=v_totalActors+1;
        end loop;
    return v_totalActors-v_x;
end;
/

begin
    DBMS_OUTPUT.PUT_LINE(COUNTACTOR(2));
end;