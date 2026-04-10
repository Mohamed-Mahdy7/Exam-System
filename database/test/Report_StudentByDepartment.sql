-- Test StudentByDepartment Report

BEGIN;
	CALL Report_StudentsByDepartment(1, 'cursure');
	FETCH ALL FROM cursure;
COMMIT;


-- Verfiy Data
SELECT s.StudentID,
        s.Name,
        s.Email,
        s.Phone,
        t.TrackName,
        d.DepartmentName AS BranchName
FROM Student s
JOIN StudentTrack st ON st.StudentID = s.StudentID
JOIN Track t ON t.TrackID = st.TrackID
JOIN Departments d ON d.DepartmentID = t.DepartmentID
WHERE d.DepartmentID = 1
ORDER BY s.Name;