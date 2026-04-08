----------------------- insert ----------------------------

create or replace procedure InsertCourses(
    p_CourseName text,
	p_MinDegree int , 
  	p_MaxDegree int 
) LANGUAGE plpgsql
AS $$
BEGIN 
    INSERT INTO Course (CourseName,MinDegree,MaxDegree ) VALUES(p_CourseName,p_MinDegree,p_MaxDegree );
 END   
$$;

-- call InsertCourses ('python' , 40, 100 )


----------------------- update ----------------------------




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
 END
$$;

-- call UpdateCourses ( 5 , 'Java', 60, 100)
----------------------- delete  ----------------------------
CREATE OR REPLACE PROCEDURE DeleteCourse(
     p_CourseID int
)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM Course
    WHERE CourseID = p_CourseID;
END;
$$;

-- call DeleteCourse(4 )

-- select * from Course ;

CREATE OR REPLACE PROCEDURE SelectCoursebyTrackID(INOUT ref refcursor , p_TrackID int   )
LANGUAGE plpgsql
AS $$
BEGIN
    OPEN ref FOR
 SELECT * FROM Course 
WHERE CourseID IN ( SELECT CourseID  FROM TrackCourse  WHERE TrackID = p_TrackID);
	 
END;
$$;
-- CALL SelectCoursebyTrackID('mycursor',1);
-- FETCH ALL FROM mycursor;
