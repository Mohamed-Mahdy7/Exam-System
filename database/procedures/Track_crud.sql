------------- insert ----------------------
CREATE OR REPLACE PROCEDURE InsertTrack(
    p_TracktName TEXT,
    p_DepartmentID int
  
) LANGUAGE plpgsql
AS $$
BEGIN 
    INSERT INTO Track (TrackName,DepartmentID ) VALUES(p_TracktName,p_DepartmentID );
 END   
$$

call InsertTrack('work', 2);
call InsertTrack('park', 2);
call InsertTrack('shark', 2);

------------- update ----------------------


CREATE OR REPLACE PROCEDURE UpdateTrack(
p_trackID int,
    p_TracktName TEXT,
    p_DepartmentID int
  
) LANGUAGE plpgsql
AS $$
BEGIN 
      UPDATE Track
    SET TrackName = p_TracktName,
        DepartmentID = p_DepartmentID
    WHERE TrackID = p_trackID;
 END   
$$
call UpdateTrack (2, 'java',1 )
------------- delete ----------------------

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

call DeleteTrack(6)

select * from Track;
------------- select  ----------------------    


CREATE OR REPLACE PROCEDURE SelectTrack(INOUT ref refcursor , p_DepartmentID int )
LANGUAGE plpgsql
AS $$
BEGIN
    OPEN ref FOR
    SELECT * FROM Track where DepartmentID = p_DepartmentID ;
END;
$$;


CALL SelectTrack('mycursor',2);
FETCH ALL FROM mycursor;