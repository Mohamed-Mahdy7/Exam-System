
-- ==========================================================
-- Procedure Name: AssignTrackToCourse
-- Description: Adds new Track To Course
-- parameters:
-- 		p_TrackID : Track ID
-- 		p_CourseID: Course ID 
-- ==========================================================


CREATE OR REPLACE PROCEDURE AssignTrackToCourse(
    IN p_TrackID INT,
    IN p_CourseID INT
)
LANGUAGE plpgsql
AS $$
BEGIN

    IF NOT EXISTS (
        SELECT 1 FROM Track WHERE TrackID = p_TrackID
    ) THEN
        RAISE EXCEPTION 'Invalid TrackID: %', p_TrackID;
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM Course WHERE CourseID = p_CourseID
    ) THEN
        RAISE EXCEPTION 'Invalid CourseID: %', p_CourseID;
    END IF;

    IF EXISTS (
        SELECT 1 
        FROM TrackCourse 
        WHERE TrackID = p_TrackID 
        AND CourseID = p_CourseID
    ) THEN
        RAISE EXCEPTION 'This course is already assigned to this track';
    END IF;

    INSERT INTO TrackCourse (TrackID, CourseID)
    VALUES (p_TrackID, p_CourseID);

    RAISE NOTICE 'Course assigned to track successfully';

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Error';
        RAISE;
END;
$$;
-- call AssignTrackToCourse(2,4)
-- select * from TrackCourse ;


