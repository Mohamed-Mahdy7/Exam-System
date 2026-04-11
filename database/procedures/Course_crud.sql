-- ==========================================================
-- Procedure Name: InsertCourses
-- Description: Adds new course
-- parameters:
-- 		p_CourseName : Course Name
-- 		p_MinDegree: MinDegree of course
--      p_MaxDegree: MaxDegree of course
-- ==========================================================

create or replace procedure InsertCourses(
    p_CourseName text,
    p_MinDegree int , 
    p_MaxDegree int 
) LANGUAGE plpgsql
AS $$
BEGIN 
    begin
    INSERT INTO Course (CourseName,MinDegree,MaxDegree ) VALUES(p_CourseName,p_MinDegree,p_MaxDegree );
    raise notice 'course inserted successfully' ;
     exception 
        when others then 
            raise notice 'error inserting course : % ' , SQLERRM ; 
            raise;
            end; 
END   
$$;
--begin
-- call InsertCourses ('python' , 40, 100 )
--commit

-- ==========================================================
-- Procedure Name: UpdateCourses
-- Description: update existing Course
-- parameters:
-- 		p_CourseID : CourseID
-- 		p_CourseName: Course Name if want dont change insert null
--     p_MinDegree :MinDegree  if want dont change insert null
--      p_MaxDegree: MaxDegree if want dont change insert null
-- ==========================================================

CREATE OR REPLACE PROCEDURE UpdateCourses(
    p_CourseID int,
    p_CourseName text DEFAULT NULL,
    p_MinDegree int DEFAULT NULL, 
    p_MaxDegree int DEFAULT NULL
) LANGUAGE plpgsql
AS $$
BEGIN
      UPDATE Course
    SET CourseName = COALESCE(p_CourseName, CourseName),
        MinDegree = COALESCE(p_MinDegree, MinDegree),
        MaxDegree = COALESCE(p_MaxDegree, MaxDegree)
    WHERE CourseID = p_CourseID;
        raise notice 'course updated successfully' ;
     exception 
        when others then 
            raise notice 'error updating course : % ' , SQLERRM ; 
            raise;
END
$$;
--begin
-- call UpdateCourses ( 5 , 'Java', 60, 100)
--commit

-- ==========================================================
-- Procedure Name: DeleteCourse
-- Description: deletes existing course
-- parameters:
-- 		p_CourseID : Course ID of Course to delete 
-- ==========================================================
CREATE OR REPLACE PROCEDURE DeleteCourse(
    p_CourseID int
)
LANGUAGE plpgsql
AS $$
BEGIN
    begin
    DELETE FROM Course
    WHERE CourseID = p_CourseID;
        raise notice 'course deleted successfully' ;
     exception 
        when others then 
            raise notice 'error deleting course : % ' , SQLERRM ; 
            raise;
            end; 
END;
$$;
--begin
-- call DeleteCourse(4 )
--begin
-- ==========================================================
-- Procedure Name: SelectCoursebyTrackID
-- Description: selcet Course by Track id 
-- parameters:
--		p_TrackID: ID of Track to select by Track id 
-- ==========================================================

CREATE OR REPLACE PROCEDURE SelectCoursebyTrackID(INOUT ref refcursor , p_TrackID int   )
LANGUAGE plpgsql
AS $$
BEGIN
    begin
    OPEN ref FOR
SELECT * FROM Course 
WHERE CourseID IN ( SELECT CourseID  FROM TrackCourse  WHERE TrackID = p_TrackID);
    raise notice 'course selected successfully' ;
     exception 
        when others then 
            raise notice 'error selecting course : % ' , SQLERRM ; 
            raise;
            end; 
    
END;
$$;
--begin
-- CALL SelectCoursebyTrackID('mycursor',1);
-- FETCH ALL FROM mycursor;
--commit