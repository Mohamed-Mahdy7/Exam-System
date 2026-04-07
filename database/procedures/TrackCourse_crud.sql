
CREATE OR REPLACE PROCEDURE AssignTrackToCourse(
    IN p_TrackID INT,
    IN p_CourseID INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO TrackCourse (TrackID, CourseID)
    VALUES (p_TrackID, p_CourseID)
    ON CONFLICT DO NOTHING;

    RAISE NOTICE 'Done (or already exists)';
END;
$$;

call AssignTrackToCourse(2,4)
select * from TrackCourse ;


