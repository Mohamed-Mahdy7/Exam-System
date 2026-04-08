------------- insert ----------------------
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

------------- update ----------------------

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
------------- delete ----------------------

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

------------- select  ----------------------


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