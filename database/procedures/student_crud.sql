
-- ==========================================================
-- Procedure Name: InsertStudent
-- purpose: Adds new student
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

--BEGIN;
-- CALL InsertStudent('Dalia Ahmed', 'Dalia.ahmed@example.com', '01012345678');
-- COMMIT;

-- ==========================================================
-- Procedure Name: UpdateStudent
-- purpose: updates existing stue
-- parameters:
-- 		p_name : instructor name
-- 		p_email: instructor email
-- 		p_phone: student phone number
-- ==========================================================
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
        RAISE NOTICE 'Transaction failed';
END;
$$;

-- BEGIN;
-- CALL UpdateStudent(31,'Mona Ahmed', 'mona.ahmed@example.com', '01012345677');
-- COMMIT;


-- ==========================================================
-- Procedure Name: DeleteStudent
-- purpose: deletes existing student
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

--BEGIN;
-- CALL DeleteStudent(31);
-- COMMIT;

-- ==========================================================
-- Procedure Name: SelectStudents
-- purpose: updates existing student
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

EXCEPTION 
    WHEN OTHERS THEN
        RAISE EXCEPTION 'selection failed. Error: %', SQLERRM;

END; 
$$;

-- BEGIN;
-- CALL SelectStudents('all_students'); 
-- FETCH ALL FROM all_instructors; 
-- COMMIT;


-- ==========================================================
-- Procedure Name: SelectStudentsByTrack
-- purpose: Returns a list of students filtered by their track
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

EXCEPTION 
    WHEN OTHERS THEN
        RAISE EXCEPTION 'selection failed. Error: %', SQLERRM;
END; 
$$;



-- BEGIN;
-- CALL SelectStudentsByTrack('track_data', 2); 
-- FETCH ALL FROM track_data; 
-- COMMIT;


-- ==========================================================
-- Procedure Name: AssignStudentToTrack
-- purpose: Assigns a student to a specific track
-- parameters:
--      p_StudentID : The ID of the student being assigned
--      p_TrackID : The ID of the track they are assigned to
-- ==========================================================
CREATE OR REPLACE PROCEDURE AssignStudentToTrack(
    p_StudentID INT,
    p_TrackID INT
)
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO studenttrack (studentid, trackid)
    VALUES (p_StudentID, p_TrackID);
	
    RAISE NOTICE 'Student ID % was successfully assigned to Track ID %', p_StudentID, p_TrackID;

EXCEPTION 
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Assignment failed. Error: %', SQLERRM;
END; 
$$;

-- BEGIN;
-- CALL AssignStudentToTrack(1, 7);
-- COMMIT;
