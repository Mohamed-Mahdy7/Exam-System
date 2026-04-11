-- ---------------------------------------------------------------------------
-- 1. Report_StudentsByDepartment
-- Purpose: Mandatory report - return students by department. Parameters: DepartmentNo, cursor. Returns: cursor with StudentID, Name, Email, Phone, TrackName, BranchName. Exceptions: none.
-- ---------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE Report_StudentsByDepartment(
    IN p_department_no INT,
    INOUT p_cur REFCURSOR
)
LANGUAGE plpgsql
AS $$
BEGIN
    OPEN p_cur FOR
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
    WHERE d.DepartmentID = p_department_no
    ORDER BY s.Name;
EXCEPTION WHEN OTHERS THEN
    RAISE;
END;
$$;


--BEGIN;
--CALL Report_StudentsByDepartment(1, 'dept_report');
--FETCH ALL FROM dept_report;
--COMMIT;



-- ---------------------------------------------------------------------------
-- 2. Report_StudentGrades
-- Purpose: Mandatory report - return student grades. Parameters: StudentID, cursor. Returns: cursor with CourseName, ExamName, TotalGrade, MaxDegree, Percentage. Exceptions: none.
-- ---------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE Report_StudentGrades(
    IN p_student_id INT,
    INOUT p_cur REFCURSOR
)
LANGUAGE plpgsql
AS $$
BEGIN
    OPEN p_cur FOR
    SELECT c.CourseName,
        e.ExamName,
        COALESCE(se.TotalGrade, 0) AS TotalGrade,
        c.MaxDegree,
        CASE
            WHEN c.MaxDegree = 0 THEN 0
            ELSE (COALESCE(se.TotalGrade, 0)::FLOAT / c.MaxDegree::FLOAT) * 100
        END AS Percentage
    FROM StudentExam se
    JOIN Exams e ON e.ExamID = se.ExamID
    JOIN Course c ON c.CourseID = e.CourseID
    WHERE se.StudentID = p_student_id
    ORDER BY e.ExamID DESC;
EXCEPTION WHEN OTHERS THEN
    RAISE;
END;
$$;



--BEGIN;
--CALL Report_StudentGrades(1, 'grades_report');
--FETCH ALL FROM grades_report;
--COMMIT;


-- ---------------------------------------------------------------------------
-- 3. Report_InstructorCourses
-- Purpose: Mandatory report - return instructor courses with track and student count. Parameters: InstructorID, cursor. Returns: cursor with CourseName, TrackName, StudentCount. Exceptions: none.
-- ---------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE Report_InstructorCourses(
    IN p_instructor_id INT,
    INOUT p_cur REFCURSOR
)
LANGUAGE plpgsql
AS $$
BEGIN
    OPEN p_cur FOR
    SELECT c.CourseName,
        t.TrackName,
        COUNT(DISTINCT st.StudentID) AS StudentCount
    FROM InstructorCourse ic
    JOIN Course c ON c.CourseID = ic.CourseID
    JOIN TrackCourse tc ON tc.CourseID = c.CourseID
    JOIN Track t ON t.TrackID = tc.TrackID
    LEFT JOIN StudentTrack st ON st.TrackID = t.TrackID
    WHERE ic.InstructorID = p_instructor_id
    GROUP BY c.CourseName, t.TrackName
    ORDER BY c.CourseName, t.TrackName;
EXCEPTION WHEN OTHERS THEN
    RAISE;
END;
$$;


--BEGIN;
--CALL Report_InstructorCourses(1, 'instructor_report');
--FETCH ALL FROM instructor_report;
--COMMIT;



-- ---------------------------------------------------------------------------
-- 4. Report_ExamQuestions
-- Purpose: Optional report - return all exam questions with choices. Parameters: ExamID, cursor. Returns: cursor with OrderNo, QuestionID, QuestionText, Type, Points, OptionID, OptionText, OptionOrder. Exceptions: none.
-- ---------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE Report_ExamQuestions(
    IN p_exam_id INT,
    INOUT p_cur REFCURSOR
)
LANGUAGE plpgsql
AS $$
BEGIN
    OPEN p_cur FOR
    SELECT eq.OrderNo,
        q.QuestionID,
        q.QuestionText,
        q.Type,
        q.Points,
        c.OptionID,
        c.OptionText,
        c.OptionOrder
    FROM ExamQuestion eq
    JOIN Questions q ON q.QuestionID = eq.QuestionID
    LEFT JOIN Choice c ON c.QuestionID = q.QuestionID
    WHERE eq.ExamID = p_exam_id
    ORDER BY eq.OrderNo, c.OptionOrder;
EXCEPTION WHEN OTHERS THEN
    RAISE;
END;
$$;

-- BEGIN;

-- CALL Report_ExamQuestions(1, 'exam_q_report');
-- FETCH ALL FROM exam_q_report;

-- COMMIT;

-- ---------------------------------------------------------------------------
-- 5. Report_StudentExamAnswers
-- Purpose: Optional report - return student exam answers with correctness. Parameters: ExamID, StudentID, cursor. Returns: cursor with OrderNo, QuestionText, ChosenOptionText, Correct. Exceptions: none.
-- ---------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE Report_StudentExamAnswers(
    IN p_exam_id INT,
    IN p_student_id INT,
    INOUT p_cur REFCURSOR
)
LANGUAGE plpgsql
AS $$
BEGIN
    OPEN p_cur FOR
    SELECT eq.OrderNo,
        q.QuestionText,
        c.OptionText AS ChosenOptionText,
        CASE WHEN sa.ChosenOptionID = ma.CorrectOptionID THEN TRUE ELSE FALSE END AS Correct
    FROM StudentExam se
    JOIN ExamQuestion eq ON eq.ExamID = se.ExamID
    JOIN Questions q ON q.QuestionID = eq.QuestionID
    LEFT JOIN StudentAnswer sa
        ON sa.StudentExamID = se.StudentExamID
    AND sa.QuestionID = eq.QuestionID
    LEFT JOIN Choice c ON c.OptionID = sa.ChosenOptionID
    LEFT JOIN ModelAnswer ma ON ma.QuestionID = q.QuestionID
    WHERE se.ExamID = p_exam_id
    AND se.StudentID = p_student_id
    ORDER BY eq.OrderNo;
EXCEPTION WHEN OTHERS THEN
    RAISE;
END;
$$;

-- BEGIN;

-- CALL Report_StudentExamAnswers(1, 1, 'student_exam_ans_report');
-- FETCH ALL FROM student_exam_ans_report;

-- COMMIT;