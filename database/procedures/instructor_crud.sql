-- ==========================================================
-- Procedure Name: InsertInstructor
-- purpose: Adds new instructor
-- parameters:
-- 		p_name : instructor name
-- 		p_email: instructor email
-- 		p_DepartmentNo: instructor department
-- ==========================================================
CREATE OR REPLACE PROCEDURE InsertInstructor(
	p_Name TEXT,
    p_Email TEXT,
    p_DepartmentNo INT 
)
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO Instructor (Name, Email,DepartmentNo)
	VALUES (p_Name, p_Email,p_DepartmentNo );

	RAISE NOTICE 'Instructor % added successfully', p_Name;

EXCEPTION 
	WHEN OTHERS THEN
		RAISE EXCEPTION 'Transaction failed';

END;
$$;


-- ==========================================================
-- Procedure Name: UpdateInstructor
-- purpose: updates existing instructor
-- parameters:
--		p_InstructorID: ID of instructor to update
-- 		p_name : instructor name
-- 		p_email: instructor email
-- 		p_DepartmentNo: instructor department
-- ==========================================================
CREATE OR REPLACE PROCEDURE UpdateInstructor(
    p_InstructorID INT,
    p_Name TEXT DEFAULT NULL,
    p_Email TEXT DEFAULT NULL,
    p_DepartmentNo INT DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE Instructor 
    SET Name = COALESCE(p_Name, Name), 
        Email = COALESCE(p_Email, Email),
        DepartmentNo = COALESCE(p_DepartmentNo, DepartmentNo)
    WHERE InstructorID = p_InstructorID;

    RAISE NOTICE 'Instructor ID % updated successfully', p_InstructorID;

EXCEPTION 
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Transaction failed ';
END;
$$;



-- ==========================================================
-- Procedure Name: DeleteInstructor
-- purpose: deletes existing instructor
-- parameters:
-- 		p_InstructorID : ID of instructor to delete 
-- ==========================================================
CREATE OR REPLACE PROCEDURE DeleteInstructor( p_InstructorID INT)
LANGUAGE plpgsql
AS $$
BEGIN
	DELETE FROM Instructor
	WHERE InstructorID = p_InstructorID;

	RAISE NOTICE 'Instructor % deleted successfully', p_InstructorID;

EXCEPTION 
	WHEN OTHERS THEN
		RAISE EXCEPTION 'Transaction failed';

END;
$$;



-- ==========================================================
-- Procedure Name: SelectInstructors
-- purpose: updates existing instructor
-- parameters:
--		p_InstructorID: ID of instructor to update
-- 		p_name : instructor name
-- 		p_email: instructor email
-- 		p_DepartmentNo: instructor department
-- ==========================================================
CREATE OR REPLACE PROCEDURE SelectInstructors( INOUT ref refcursor )
LANGUAGE plpgsql
AS $$
BEGIN
	OPEN ref FOR 
    SELECT InstructorID, Name, Email, DepartmentNo 
    FROM Instructor; 


END;
$$;

-- ==========================================================
-- Procedure Name: SelectInstructorsByDept
-- purpose: Returns instructors filtered by their department
-- parameters:
--      ref : The cursor used to point to the data
--      p_DepartmentNo : The ID of the department to filter by
-- ==========================================================
CREATE OR REPLACE PROCEDURE SelectInstructorsByDept( 
    INOUT ref refcursor,
    p_DepartmentNo INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    OPEN ref FOR 
    SELECT InstructorID, Name, Email, DepartmentNo 
    FROM Instructor
    WHERE DepartmentNo = p_DepartmentNo; 

END; 
$$;


-- ==========================================================
-- Procedure Name: AssignInstructorToCourse
-- purpose: Links an existing instructor to a specific course
-- parameters:
--      p_InstructorID : The ID of the instructor to assign
--      p_CourseID : The ID of the course they will teach
-- ==========================================================
CREATE OR REPLACE PROCEDURE AssignInstructorToCourse(
    p_InstructorID INT,
    p_CourseID INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO InstructorCourse (InstructorID, CourseID) 
    VALUES (p_InstructorID, p_CourseID);
    RAISE NOTICE 'Instructor ID % was successfully assigned to Course ID %', p_InstructorID, p_CourseID;

EXCEPTION 
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Assignment failed. Error: %', SQLERRM;
END; 
$$;




-- ==========================================================
-- Testing : Call Procedures
-- ==========================================================

/*
SELECT * FROM instructor;
SELECT * FROM Departments;


DO $$
BEGIN
    CALL InsertInstructor('DR. Mahmoud Ahmed', 'mahmoud.ahmed@university.com', 1);
    RAISE NOTICE 'Insert committed successfully.';

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Insert failed. Error: %', SQLERRM;
END;
$$;

--=================================================================================------

DO $$
BEGIN
    CALL UpdateInstructor(17,'DR Mona Ahmed', 'mona.ahmed@university.com',1);
    RAISE NOTICE 'Update committed successfully.';

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Update failed. Error: %', SQLERRM;
END;
$$;

--=================================================================================------

DO $$
BEGIN
    CALL DeleteInstructor(17);
    RAISE NOTICE 'Delete committed successfully.';

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Delete failed. Error: %', SQLERRM;
END;
$$;

--=================================================================================------

BEGIN;
CALL SelectInstructors('all_instructors'); 
FETCH ALL FROM all_instructors; 
COMMIT;

--=================================================================================------

BEGIN;
CALL SelectInstructorsByDept('dept_data', 1); 
FETCH ALL FROM dept_data; 
COMMIT;


--=================================================================================------

SELECT * FROM Course;
SELECT * FROM InstructorCourse;


DO $$
BEGIN
    CALL AssignInstructorToCourse(2, 12);  
EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Assignment failed. Error: %', SQLERRM;
END;
$$;


*\
