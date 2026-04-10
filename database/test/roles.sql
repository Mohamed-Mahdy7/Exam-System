SET ROLE instructor_role;

-- test access on procedure 
BEGIN;
CALL Report_InstructorCourses(1, 'instructor_test_report');
FETCH ALL FROM instructor_test_report;
COMMIT;

-- (Admin-only action)
TRUNCATE TABLE Departments;

-- (Admin-only action)
CREATE TABLE HackersTable (id INT);

-- (Admin-only action)
CREATE ROLE fake_admin;


SET ROLE student_role;

SELECT * FROM StudentExam;
SELECT * FROM StudentAnswer;
SELECT * FROM ModelAnswer;



--SELECT current_user;
--RESET ROLE;