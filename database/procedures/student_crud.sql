
-- ==========================================================
-- Procedure Name: InsertStudent
-- Description: Adds new student
-- parameters:
-- 		p_name : instructor name
-- 		p_email: instructor email
-- 		p_phone: student phone number
-- ==========================================================
CREATE OR REPLACE PROCEDURE InsertStudent(
	p_Name TEXT,
    p_Email TEXT,
    p_phone TEXT 
)
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO Student (Name, Email,Phone)
	VALUES (p_Name, p_Email,p_phone );

	RAISE NOTICE 'Student % added successfully', p_Name;

EXCEPTION 
	WHEN OTHERS THEN
		RAISE NOTICE 'Transaction failed';

END;
$$;


-- ==========================================================
-- Procedure Name: UpdateStudent
-- Description: updates existing stue
-- parameters:
-- 		p_name : instructor name
-- 		p_email: instructor email
-- 		p_phone: student phone number
-- ==========================================================
CREATE OR REPLACE PROCEDURE UpdateStudent(
CREATE OR REPLACE PROCEDURE UpdateStudent(
    p_StudentID INT,
    p_Name TEXT DEFAULT NULL,
    p_Email TEXT DEFAULT NULL,
    p_Phone TEXT DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE Student 
    SET Name = COALESCE(p_Name, Name), 
        Email = COALESCE(p_Email, Email),
        Phone = COALESCE(p_Phone, Phone)
    WHERE StudentID = p_StudentID;

    RAISE NOTICE 'Student ID % updated successfully', p_StudentID;

EXCEPTION 
    WHEN OTHERS THEN
        RAISE NOTICE 'Transaction failed: %', SQLERRM;
END;
$$;



-- ==========================================================
-- Procedure Name: DeleteStudent
-- Description: deletes existing student
-- parameters:
-- 		p_name : instructor name
-- 		p_email: instructor email
-- 		p_phone: student phone number
-- ==========================================================
CREATE OR REPLACE PROCEDURE DeleteStudent( p_StudentID INT)
LANGUAGE plpgsql
AS $$
BEGIN
	DELETE FROM Student
	WHERE StudentID = p_StudentID;

	RAISE NOTICE 'Student % deleted successfully',p_StudentID;

EXCEPTION 
	WHEN OTHERS THEN
		RAISE NOTICE 'Transaction failed';

END;
$$;



-- ==========================================================
-- Procedure Name: SelectStudents
-- Description: updates existing student
-- parameters:
--		ref : The cursor used to point to the data
-- ==========================================================
CREATE OR REPLACE PROCEDURE SelectStudents( INOUT ref refcursor )
LANGUAGE plpgsql
AS $$
BEGIN
	OPEN ref FOR 
    SELECT StudentID, Name, Email, Phone 
    FROM Student;


END; 
$$;




-- ==========================================================
-- Procedure Name: SelectStudentsByTrack
-- Description: Returns a list of students filtered by their track
-- parameters:
--      ref : The cursor used to point to the data
--      p_TrackID : The ID of the track to filter by
-- ==========================================================
CREATE OR REPLACE PROCEDURE SelectStudentsByTrack( 
    INOUT ref refcursor,
    p_TrackID INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    OPEN ref FOR 
    SELECT StudentID, Name, Email, Phone 
    FROM Student
    WHERE TrackID = p_TrackID; 
END; 
$$;