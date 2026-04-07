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
$$

call InsertCourses ('python' , 40, 100 )


----------------------- update ----------------------------
create or replace procedure UpdateCourses(
    p_CourseID int,
    p_CourseName text,
	p_MinDegree int , 
  	p_MaxDegree int 
) LANGUAGE plpgsql
AS $$
BEGIN 
      UPDATE Course
    SET CourseName = p_CourseName,
		MinDegree = p_MinDegree,
        MaxDegree = p_MaxDegree
    WHERE CourseID = p_CourseID;
 END   
$$
call UpdateCourses ( 5 , 'Java', 60, 100)
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

call DeleteCourse(4 )

select * from Course ;

CREATE OR REPLACE PROCEDURE SelectCoursebyTrackID(INOUT ref refcursor , p_TrackID int   )
LANGUAGE plpgsql
AS $$
BEGIN
    OPEN ref FOR
   SELECT * FROM Course where 
  (select * from TrackCourse where TrackID = p_TrackID ) 
	 ;
END;
$$;
 
CALL SelectCoursebyTrackID('mycursor',1);
FETCH ALL FROM mycursor;
