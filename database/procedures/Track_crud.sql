-- ==========================================================
-- Procedure Name: InsertTrack
-- Description: Adds new track
-- parameters:
-- 		p_TracktName : track name
-- 		p_DepartmentID: DepartmentID 
-- ==========================================================
CREATE OR REPLACE PROCEDURE InsertTrack(
    p_TracktName TEXT,
    p_DepartmentID int

) LANGUAGE plpgsql
AS $$
BEGIN 
    INSERT INTO Track (TrackName,DepartmentID ) VALUES(p_TracktName,p_DepartmentID );
END   
$$;

-- call InsertTrack('work', 2);
-- call InsertTrack('park', 2);
-- call InsertTrack('shark', 2);
-- ==========================================================
-- Procedure Name: UpdateTrack
-- Description: update existing track
-- parameters:
-- 		p_trackID : trackID
-- 		p_TracktName: TracktName if want dont change insert null
--     p_DepartmentID :DepartmentID  if want dont change insert null
-- ==========================================================

CREATE OR REPLACE PROCEDURE UpdateTrack(
p_trackID int DEFAULT NULL,
    p_TracktName TEXT DEFAULT NULL,
    p_DepartmentID int DEFAULT NULL

) LANGUAGE plpgsql
AS $$
BEGIN 
    UPDATE Track
    SET TrackName = COALESCE(p_TracktName, TrackName),
        DepartmentID = COALESCE(p_DepartmentID, DepartmentID)
    WHERE TrackID = p_trackID;
END   
$$;
-- call UpdateTrack (2, 'java',1 )
-- ==========================================================
-- Procedure Name: DeleteTrack
-- Description: deletes existing track
-- parameters:
-- 		p_trackID : trackID of track to delete 
-- ==========================================================

CREATE OR REPLACE PROCEDURE DeleteTrack(
    p_trackID INTEGER
)
LANGUAGE plpgsql
AS $$
BEGIN
    DELETE FROM Track
    WHERE TrackID = p_trackID;
END;
$$;

-- call DeleteTrack(6)

-- select * from Track;
    
-- ==========================================================
-- Procedure Name: SelectTrack
-- Description: selcet track by department id 
-- parameters:
--		p_DepartmentID: ID of Department to select by department id 
-- ==========================================================
CREATE OR REPLACE PROCEDURE SelectTrack(INOUT ref refcursor , p_DepartmentID int )
LANGUAGE plpgsql
AS $$
BEGIN
    OPEN ref FOR
    SELECT * FROM Track where DepartmentID = p_DepartmentID ;
END;
$$;


-- CALL SelectTrack('mycursor',2);
-- FETCH ALL FROM mycursor;