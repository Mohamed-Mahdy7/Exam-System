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
    begin
    INSERT INTO Track (TrackName,DepartmentID ) VALUES(p_TracktName,p_DepartmentID );
        raise notice 'track inserted successfully' ;
     exception 
        when others then 
            raise notice 'error inserting track : % ' , SQLERRM ; 
            raise;
            end; 
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
    begin
      UPDATE Track
    SET TrackName = COALESCE(p_TracktName, TrackName),
        DepartmentID = COALESCE(p_DepartmentID, DepartmentID)
    WHERE TrackID = p_trackID;
    raise notice 'track updated successfully' ;
     exception 
        when others then 
            raise notice 'error updating track : % ' , SQLERRM ; 
            raise;
            end; 
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
    begin
    DELETE FROM Track
    WHERE TrackID = p_trackID;
    raise notice 'track deleted successfully' ;
     exception 
        when others then 
            raise notice 'error deleting track : % ' , SQLERRM ; 
            raise;
            end; 
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
    begin
    OPEN ref FOR
    SELECT * FROM Track where DepartmentID = p_DepartmentID ;
    raise notice 'track selected successfully' ;
     exception 
        when others then 
            raise notice 'error selecting track : % ' , SQLERRM ; 
            raise;
            end; 
END;
$$;


-- CALL SelectTrack('mycursor',2);
-- FETCH ALL FROM mycursor;