-- Test StudentGrades Report

BEGIN;
	CALL Report_StudentGrades(5, 'cursure');
	FETCH ALL FROM cursure;
COMMIT;


-- Verify Data
SELECT c.CourseName,
		c.CourseID,
        e.ExamName,
		e.ExamID,
        COALESCE(se.TotalGrade, 0) AS TotalGrade,
        c.MaxDegree
FROM Course c
JOIN Exams e 
ON c.CourseID = e.CourseID
JOIN StudentExam se 
ON e.ExamID = se.ExamID
WHERE se.studentid = 5
ORDER BY e.ExamID DESC;