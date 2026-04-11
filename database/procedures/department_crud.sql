-- ==========================================================
-- Procedure Name: InsertDepartment
-- Description: Adds new Department
-- parameters:
-- 		p_DepartmentName : Department Name
-- 		p_Location: Location 
-- ========================================================== 
CREATE OR REPLACE PROCEDURE InsertDepartment(
    p_DepartmentName text,
    p_Location text

) LANGUAGE plpgsql
AS $$
BEGIN 
    INSERT INTO Departments (DepartmentName,Location ) VALUES(p_DepartmentName,p_Location );
END   
$$;
-- call InsertDepartment('testing', 'Building b');

-- ==========================================================
-- Procedure Name: UpdateDepartment
-- Description: update existing Department
-- parameters:
-- 		p_DepartmentID :  Department ID if want dont change insert null
-- 		p_DepartmentName: Department Name if want dont change insert null
--     p_Location : Location  if want dont change insert null
-- ==========================================================
CREATE OR REPLACE PROCEDURE UpdateDepartment(
    p_DepartmentID int default null,
    p_DepartmentName text default null,
    p_Location text default null
)
LANGUAGE plpgsql
AS $$
BEGIN
    UPDATE Departments
    SET DepartmentName =COALESCE(p_DepartmentName, DepartmentName),
        Location = COALESCE(p_Location, Location)   
    WHERE DepartmentID = p_DepartmentID;
END;
$$;
-- call UpdateDepartment(4,'Arabic', 'Building c');
-- ==========================================================
-- Procedure Name: DeleteDepartment
-- Description: deletes existing Department
-- parameters:
-- 		p_DepartmentID : Department ID of Department to delete 
-- ==========================================================

CREATE OR REPLACE PROCEDURE DeleteDepartment(
    p_DepartmentID int
)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM Departments
    WHERE DepartmentID = p_DepartmentID;
END;
$$;

-- call DeleteDepartment(4)

-- ==========================================================
-- Procedure Name: SelectDepartments
-- Description: selcet all
-- parameters:
--		just call 
-- ==========================================================

CREATE OR REPLACE PROCEDURE SelectDepartments(INOUT ref refcursor)
LANGUAGE plpgsql
AS $$
BEGIN
    OPEN ref FOR
    SELECT * FROM Departments;
END;
$$;

-- BEGIN;
-- CALL SelectDepartments('mycursor');
-- FETCH ALL FROM mycursor;
-- COMMIT;
-- call SelectDepartments ()


-- select * from Departments ;