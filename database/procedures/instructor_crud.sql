-- ==========================================================
-- Procedure Name: InsertInstructor
-- Description: Adds new instructor
-- parameters:
-- 		p_name : instructor name
-- 		p_email: instructor email
-- 		p_DepartmentNo: instructor department
-- ==========================================================
CREATE OR REPLACE PROCEDURE InsertInstructor(
	p_Name TEXT,
    p_Email TEXT,
    p_departmentNo INT 
)
LANGUAGE plpgsql
AS $$
BEGIN
	INSERT INTO Instructor (Name, Email,DepartmentNo)
	VALUES (p_Name, p_Email,p_DepartmentNo );

	COMMIT;
	RAISE NOTICE 'Instructor % added successfully', p_Name;

EXCEPTION 
	WHEN OTHERS THEN
		ROLLBACK;
		RAISE NOTICE 'Transaction failed';

END 
$$


-- ==========================================================
-- Procedure Name: UpdateInstructor
-- Description: updates existing instructor
-- parameters:
--		p_InstructorID: ID of instructor to update
-- 		p_name : instructor name
-- 		p_email: instructor email
-- 		p_DepartmentNo: instructor department
-- ==========================================================
CREATE OR REPLACE PROCEDURE UpdateInstructor(
	p_InstructorID INT,
	p_Name TEXT,
    p_Email TEXT,
    p_DepartmentNo INT 
)
LANGUAGE plpgsql
AS $$
BEGIN
	UPDATE Instructor 
	SET NAME = p_Name, 
		Email = p_Email,
		DepartmentNo = p_DepartmentNo 
	WHERE InstructorID = p_InstructorID;

	COMMIT;
	RAISE NOTICE 'Instructor % upated successfully', p_Name;

EXCEPTION 
	WHEN OTHERS THEN
		ROLLBACK;
		RAISE NOTICE 'Transaction failed';

END 
$$



-- ==========================================================
-- Procedure Name: DeleteInstructor
-- Description: deletes existing instructor
-- parameters:
-- 		p_InstructorID : ID of instructor to delete 
-- ==========================================================
CREATE OR REPLACE PROCEDURE DeleteInstructor( p_InstructorID INT)
LANGUAGE plpgsql
AS $$
BEGIN
	DELETE FROM Instructor
	WHERE InstructorID = p_InstructorID;

	COMMIT;
	RAISE NOTICE 'Instructor % deleted successfully', p_Name;

EXCEPTION 
	WHEN OTHERS THEN
		ROLLBACK;
		RAISE NOTICE 'Transaction failed';

END 
$$



-- ==========================================================
-- Procedure Name: SelectInstructors
-- Description: updates existing instructor
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

	COMMIT;

END 
$$


BEGIN;
CALL SelectInstructors('data'); 
FETCH ALL FROM data; 

COMMIT;

-- ==========================================================
-- Procedure Name: SelectInstructorsByDept
-- Description: Returns instructors filtered by their department
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