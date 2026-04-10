-- Test InstructorCourses Report

BEGIN;
	CALL Report_InstructorCourses(5, 'cursure');
	FETCH ALL FROM cursure;
COMMIT;

-- Verify Data
SELECT tc.trackID, tc.courseID, t.trackName, c.courseName
FROM track t
JOIN trackcourse tc
ON tc.trackID = t.trackID
JOIN course c
ON c.courseID = tc.CourseID
WHERE c.CourseID IN (7, 8);