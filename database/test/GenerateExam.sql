-- Test Case 1 => Valid data

BEGIN;
	CALL GenerateExam(1, 'test 1', 5, 10);
COMMIT;

-- Result display

SELECT e.examid, e.examname, e.courseid, eq.questionid
FROM Exams as e
LEFT JOIN ExamQuestion as eq
ON e.examid = eq.examid
ORDER BY e.examid DESC;

-- Test Case 2 => insufficient questions

BEGIN;
	CALL GenerateExam(1, 'test 2', 10, 10);
COMMIT;

-- validate no row entered

SELECT e.examid, e.examname, e.courseid, eq.questionid
FROM Exams as e
LEFT JOIN ExamQuestion as eq
ON e.examid = eq.examid
ORDER BY e.examid DESC;