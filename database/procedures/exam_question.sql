-- ---------------------------------------------------------------------------
-- 1. InsertQuestion
-- ---------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE InsertQuestion(
    IN p_course_id INT,
    IN p_question_text TEXT,
    IN p_type TEXT,
    IN p_points INT,
    OUT p_question_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF p_question_text IS NULL OR BTRIM(p_question_text) = '' THEN
        RAISE EXCEPTION 'question text cannot be empty';
    END IF;

    IF p_type NOT IN ('MCQ', 'TF') THEN
        RAISE EXCEPTION 'Invalid question type. Allowed values: MCQ, TF';
    END IF;

    IF p_points IS NULL OR p_points <= 0 THEN
        RAISE EXCEPTION 'Points must be greater than 0';
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM Course WHERE CourseID = p_course_id
    ) THEN
        RAISE EXCEPTION 'Course % does not exist', p_course_id;
    END IF;

    INSERT INTO Questions (CourseID, QuestionText, Type, Points)
    VALUES (p_course_id, p_question_text, p_type, p_points)
    RETURNING QuestionID INTO p_question_id;

EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END;
$$;

COMMENT ON PROCEDURE InsertQuestion(INT, TEXT, TEXT, INT)
IS 'Purpose: Insert a new question. Parameters: CourseID, QuestionText, Type, Points. Returns: QuestionID through OUT parameter. Exceptions: empty text, invalid type, invalid points, missing course.';


-- ---------------------------------------------------------------------------
-- 2. UpdateQuestion
-- ---------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE UpdateQuestion(
    IN p_question_id INT,
    IN p_course_id INT,
    IN p_question_text TEXT,
    IN p_type TEXT,
    IN p_points INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM Questions WHERE QuestionID = p_question_id
    ) THEN
        RAISE EXCEPTION 'Question % does not exist', p_question_id;
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM Course WHERE CourseID = p_course_id
    ) THEN
        RAISE EXCEPTION 'Course % does not exist', p_course_id;
    END IF;

    IF p_question_text IS NULL OR BTRIM(p_question_text) = '' THEN
        RAISE EXCEPTION 'Question text cannot be empty';
    END IF;

    IF p_type NOT IN ('MCQ', 'TF') THEN
        RAISE EXCEPTION 'Invalid question type. Allowed values: MCQ, TF';
    END IF;

    IF p_points IS NULL OR p_points <= 0 THEN
        RAISE EXCEPTION 'Points must be greater than 0';
    END IF;

    UPDATE Questions
    SET CourseID = p_course_id,
        QuestionText = p_question_text,
        Type = p_type,
        Points = p_points
    WHERE QuestionID = p_question_id;

EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END;
$$;

COMMENT ON PROCEDURE UpdateQuestion(INT, INT, TEXT, TEXT, INT)
IS 'Purpose: Update an existing question. Parameters: QuestionID, CourseID, QuestionText, Type, Points. Returns: none. Exceptions: missing question, missing course, empty text, invalid type, invalid points.';


-- ---------------------------------------------------------------------------
-- 3. DeleteQuestion
-- ---------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE DeleteQuestion(
    IN p_question_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM Questions WHERE QuestionID = p_question_id
    ) THEN
        RAISE EXCEPTION 'Question % does not exist', p_question_id;
    END IF;

    DELETE FROM Questions
    WHERE QuestionID = p_question_id;

EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END;
$$;

COMMENT ON PROCEDURE DeleteQuestion(INT)
IS 'Purpose: Delete a question by QuestionID. Parameters: QuestionID. Returns: none. Exceptions: question not found. Cascading behavior depends on foreign keys.';


-- ---------------------------------------------------------------------------
-- 4. SelectQuestion
-- ---------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION SelectQuestion(p_question_id INT)
RETURNS TABLE (
    QuestionID INT,
    CourseID INT,
    QuestionText TEXT,
    Type TEXT,
    Points INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT q.QuestionID, q.CourseID, q.QuestionText, q.Type, q.Points
    FROM Questions q
    WHERE q.QuestionID = p_question_id;
END;
$$;

COMMENT ON FUNCTION SelectQuestion(INT)
IS 'Purpose: Return one question by QuestionID. Parameters: QuestionID. Returns: QuestionID, CourseID, QuestionText, Type, Points. Exceptions: none.';


-- ---------------------------------------------------------------------------
-- 5. SelectQuestionsByCourse
-- ---------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION SelectQuestionsByCourse(p_course_id INT)
RETURNS TABLE (
    QuestionID INT,
    CourseID INT,
    QuestionText TEXT,
    Type TEXT,
    Points INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT q.QuestionID, q.CourseID, q.QuestionText, q.Type, q.Points
    FROM Questions q
    WHERE q.CourseID = p_course_id
    ORDER BY q.QuestionID;
END;
$$;

COMMENT ON FUNCTION SelectQuestionsByCourse(INT)
IS 'Purpose: Return all questions for a specific course. Parameters: CourseID. Returns: question rows. Exceptions: none.';


-- ---------------------------------------------------------------------------
-- 6. InsertOption
-- ---------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE InsertOption(
    IN p_question_id INT,
    IN p_option_text TEXT,
    IN p_option_order INT,
    OUT p_option_id INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_question_type TEXT;
    v_option_count INT;
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM Questions WHERE QuestionID = p_question_id
    ) THEN
        RAISE EXCEPTION 'Question % does not exist', p_question_id;
    END IF;

    IF p_option_text IS NULL OR BTRIM(p_option_text) = '' THEN
        RAISE EXCEPTION 'Option text cannot be empty';
    END IF;

    IF p_option_order IS NULL OR p_option_order <= 0 THEN
        RAISE EXCEPTION 'Option order must be greater than 0';
    END IF;

    IF EXISTS (
        SELECT 1
        FROM Choice
        WHERE QuestionID = p_question_id
          AND OptionOrder = p_option_order
    ) THEN
        RAISE EXCEPTION 'Option order % already exists for question %', p_option_order, p_question_id;
    END IF;

    SELECT Type
    INTO v_question_type
    FROM Questions
    WHERE QuestionID = p_question_id;

    SELECT COUNT(*)
    INTO v_option_count
    FROM Choice
    WHERE QuestionID = p_question_id;

    IF v_question_type = 'MCQ' AND v_option_count >= 4 THEN
        RAISE EXCEPTION 'MCQ question % cannot have more than 4 options', p_question_id;
    ELSIF v_question_type = 'TF' AND v_option_count >= 2 THEN
        RAISE EXCEPTION 'TF question % cannot have more than 2 options', p_question_id;
    END IF;

    INSERT INTO Choice (QuestionID, OptionText, OptionOrder)
    VALUES (p_question_id, p_option_text, p_option_order)
    RETURNING OptionID INTO p_option_id;

EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END;
$$;

COMMENT ON PROCEDURE InsertOption(INT, TEXT, INT)
IS 'Purpose: Insert a new option for a question. Parameters: QuestionID, OptionText, OptionOrder. Returns: OptionID through OUT parameter. Exceptions: missing question, empty text, invalid order, duplicate order, exceeded allowed option count.';


-- ---------------------------------------------------------------------------
-- 7. UpdateOption
-- ---------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE UpdateOption(
    IN p_option_id INT,
    IN p_question_id INT,
    IN p_option_text TEXT,
    IN p_option_order INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_question_type TEXT;
    v_final_option_count INT;
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM Choice WHERE OptionID = p_option_id
    ) THEN
        RAISE EXCEPTION 'Option % does not exist', p_option_id;
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM Questions WHERE QuestionID = p_question_id
    ) THEN
        RAISE EXCEPTION 'Question % does not exist', p_question_id;
    END IF;

    IF p_option_text IS NULL OR BTRIM(p_option_text) = '' THEN
        RAISE EXCEPTION 'Option text cannot be empty';
    END IF;

    IF p_option_order IS NULL OR p_option_order <= 0 THEN
        RAISE EXCEPTION 'Option order must be greater than 0';
    END IF;

    IF EXISTS (
        SELECT 1
        FROM Choice
        WHERE QuestionID = p_question_id
          AND OptionOrder = p_option_order
          AND OptionID <> p_option_id
    ) THEN
        RAISE EXCEPTION 'Option order % already exists for question %', p_option_order, p_question_id;
    END IF;

    SELECT Type
    INTO v_question_type
    FROM Questions
    WHERE QuestionID = p_question_id;

    SELECT COUNT(*)
    INTO v_final_option_count
    FROM Choice
    WHERE QuestionID = p_question_id
      AND OptionID <> p_option_id;

    v_final_option_count := v_final_option_count + 1;

    IF v_question_type = 'MCQ' AND v_final_option_count > 4 THEN
        RAISE EXCEPTION 'MCQ question % cannot have more than 4 options', p_question_id;
    ELSIF v_question_type = 'TF' AND v_final_option_count > 2 THEN
        RAISE EXCEPTION 'TF question % cannot have more than 2 options', p_question_id;
    END IF;

    UPDATE Choice
    SET QuestionID = p_question_id,
        OptionText = p_option_text,
        OptionOrder = p_option_order
    WHERE OptionID = p_option_id;

EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END;
$$;

COMMENT ON PROCEDURE UpdateOption(INT, INT, TEXT, INT)
IS 'Purpose: Update an existing option. Parameters: OptionID, QuestionID, OptionText, OptionOrder. Returns: none. Exceptions: missing option, missing question, empty text, invalid order, duplicate order, exceeded allowed option count.';


-- ---------------------------------------------------------------------------
-- 8. DeleteOption
-- ---------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE DeleteOption(
    IN p_option_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM Choice WHERE OptionID = p_option_id
    ) THEN
        RAISE EXCEPTION 'Option % does not exist', p_option_id;
    END IF;

    DELETE FROM Choice
    WHERE OptionID = p_option_id;

EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END;
$$;

COMMENT ON PROCEDURE DeleteOption(INT)
IS 'Purpose: Delete an option by OptionID. Parameters: OptionID. Returns: none. Exceptions: option not found.';


-- ---------------------------------------------------------------------------
-- 9. SetModelAnswer
-- ---------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE SetModelAnswer(
    IN p_question_id INT,
    IN p_correct_option_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM Questions WHERE QuestionID = p_question_id
    ) THEN
        RAISE EXCEPTION 'Question % does not exist', p_question_id;
    END IF;

    IF NOT EXISTS (
        SELECT 1 FROM Choice WHERE OptionID = p_correct_option_id
    ) THEN
        RAISE EXCEPTION 'Option % does not exist', p_correct_option_id;
    END IF;

    IF NOT EXISTS (
        SELECT 1
        FROM Choice
        WHERE OptionID = p_correct_option_id
          AND QuestionID = p_question_id
    ) THEN
        RAISE EXCEPTION 'Option % does not belong to question %', p_correct_option_id, p_question_id;
    END IF;

    INSERT INTO ModelAnswer (QuestionID, CorrectOptionID)
    VALUES (p_question_id, p_correct_option_id)
    ON CONFLICT (QuestionID)
    DO UPDATE SET CorrectOptionID = EXCLUDED.CorrectOptionID;

EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END;
$$;

COMMENT ON PROCEDURE SetModelAnswer(INT, INT)
IS 'Purpose: Insert or update the model answer for a question. Parameters: QuestionID, CorrectOptionID. Returns: none. Exceptions: missing question, missing option, or option not belonging to the question.';


-- ---------------------------------------------------------------------------
-- 10. SelectStudentAnswers
-- ---------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION SelectStudentAnswers(p_student_exam_id INT)
RETURNS TABLE (
    StudentAnswerID INT,
    StudentExamID INT,
    QuestionID INT,
    QuestionText TEXT,
    ChosenOptionID INT,
    ChosenOptionText TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT sa.StudentAnswerID,
           sa.StudentExamID,
           sa.QuestionID,
           q.QuestionText,
           sa.ChosenOptionID,
           c.OptionText
    FROM StudentAnswer sa
    JOIN Questions q
      ON q.QuestionID = sa.QuestionID
    LEFT JOIN Choice c
      ON c.OptionID = sa.ChosenOptionID
    WHERE sa.StudentExamID = p_student_exam_id
    ORDER BY sa.StudentAnswerID;
END;
$$;

COMMENT ON FUNCTION SelectStudentAnswers(INT)
IS 'Purpose: Return all submitted answers for a given StudentExam. Parameters: StudentExamID. Returns: StudentAnswerID, StudentExamID, QuestionID, QuestionText, ChosenOptionID, ChosenOptionText. Exceptions: none.';


-- ---------------------------------------------------------------------------
-- 11. Report_StudentsByDepartment
-- ---------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION Report_StudentsByDepartment(p_department_no INT)
RETURNS TABLE (
    StudentID INT,
    Name TEXT,
    Email TEXT,
    Phone TEXT,
    TrackName TEXT,
    BranchName TEXT
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT s.StudentID,
           s.Name,
           s.Email,
           s.Phone,
           t.TrackName,
           d.DepartmentName AS BranchName
    FROM Student s
    JOIN StudentTrack st
      ON st.StudentID = s.StudentID
    JOIN Track t
      ON t.TrackID = st.TrackID
    JOIN Departments d
      ON d.DepartmentID = t.DepartmentID
    WHERE d.DepartmentID = p_department_no
    ORDER BY s.Name;
END;
$$;

COMMENT ON FUNCTION Report_StudentsByDepartment(INT)
IS 'Purpose: Mandatory report - return students by department. Parameters: DepartmentNo. Returns: StudentID, Name, Email, Phone, TrackName, BranchName. Exceptions: none.';


-- ---------------------------------------------------------------------------
-- 12. Report_StudentGrades
-- ---------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION Report_StudentGrades(p_student_id INT)
RETURNS TABLE (
    CourseName TEXT,
    ExamName TEXT,
    TotalGrade INT,
    MaxDegree INT,
    Percentage DOUBLE PRECISION
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT c.CourseName,
           e.ExamName,
           COALESCE(se.TotalGrade, 0) AS TotalGrade,
           c.MaxDegree,
           CASE
               WHEN c.MaxDegree = 0 THEN 0
               ELSE (COALESCE(se.TotalGrade, 0)::FLOAT / c.MaxDegree::FLOAT) * 100
           END AS Percentage
    FROM StudentExam se
    JOIN Exams e
      ON e.ExamID = se.ExamID
    JOIN Course c
      ON c.CourseID = e.CourseID
    WHERE se.StudentID = p_student_id
    ORDER BY e.ExamID DESC;
END;
$$;

COMMENT ON FUNCTION Report_StudentGrades(INT)
IS 'Purpose: Mandatory report - return student grades. Parameters: StudentID. Returns: CourseName, ExamName, TotalGrade, MaxDegree, Percentage. Exceptions: none.';


-- ---------------------------------------------------------------------------
-- 13. Report_InstructorCourses
-- ---------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION Report_InstructorCourses(p_instructor_id INT)
RETURNS TABLE (
    CourseName TEXT,
    TrackName TEXT,
    StudentCount BIGINT
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT c.CourseName,
           t.TrackName,
           COUNT(DISTINCT st.StudentID) AS StudentCount
    FROM InstructorCourse ic
    JOIN Course c
      ON c.CourseID = ic.CourseID
    JOIN TrackCourse tc
      ON tc.CourseID = c.CourseID
    JOIN Track t
      ON t.TrackID = tc.TrackID
    LEFT JOIN StudentTrack st
      ON st.TrackID = t.TrackID
    WHERE ic.InstructorID = p_instructor_id
    GROUP BY c.CourseName, t.TrackName
    ORDER BY c.CourseName, t.TrackName;
END;
$$;

COMMENT ON FUNCTION Report_InstructorCourses(INT)
IS 'Purpose: Mandatory report - return instructor courses with track and student count. Parameters: InstructorID. Returns: CourseName, TrackName, StudentCount. Exceptions: none.';


-- ---------------------------------------------------------------------------
-- 14. Report_ExamQuestions
-- ---------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION Report_ExamQuestions(p_exam_id INT)
RETURNS TABLE (
    OrderNo INT,
    QuestionID INT,
    QuestionText TEXT,
    Type TEXT,
    Points INT,
    OptionID INT,
    OptionText TEXT,
    OptionOrder INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT eq.OrderNo,
           q.QuestionID,
           q.QuestionText,
           q.Type,
           q.Points,
           c.OptionID,
           c.OptionText,
           c.OptionOrder
    FROM ExamQuestion eq
    JOIN Questions q
      ON q.QuestionID = eq.QuestionID
    LEFT JOIN Choice c
      ON c.QuestionID = q.QuestionID
    WHERE eq.ExamID = p_exam_id
    ORDER BY eq.OrderNo, c.OptionOrder;
END;
$$;

COMMENT ON FUNCTION Report_ExamQuestions(INT)
IS 'Purpose: Optional report - return all questions in an exam with their choices. Parameters: ExamID. Returns: OrderNo, QuestionID, QuestionText, Type, Points, OptionID, OptionText, OptionOrder. Exceptions: none.';


-- ---------------------------------------------------------------------------
-- 15. Report_StudentExamAnswers
-- ---------------------------------------------------------------------------
CREATE OR REPLACE FUNCTION Report_StudentExamAnswers(
    p_exam_id INT,
    p_student_id INT
)
RETURNS TABLE (
    OrderNo INT,
    QuestionText TEXT,
    ChosenOptionText TEXT,
    Correct BOOLEAN
)
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT eq.OrderNo,
           q.QuestionText,
           c.OptionText AS ChosenOptionText,
           CASE
               WHEN sa.ChosenOptionID = ma.CorrectOptionID THEN TRUE
               ELSE FALSE
           END AS Correct
    FROM StudentExam se
    JOIN ExamQuestion eq
      ON eq.ExamID = se.ExamID
    JOIN Questions q
      ON q.QuestionID = eq.QuestionID
    LEFT JOIN StudentAnswer sa
      ON sa.StudentExamID = se.StudentExamID
     AND sa.QuestionID = eq.QuestionID
    LEFT JOIN Choice c
      ON c.OptionID = sa.ChosenOptionID
    LEFT JOIN ModelAnswer ma
      ON ma.QuestionID = q.QuestionID
    WHERE se.ExamID = p_exam_id
      AND se.StudentID = p_student_id
    ORDER BY eq.OrderNo;
END;
$$;

COMMENT ON FUNCTION Report_StudentExamAnswers(INT, INT)
IS 'Purpose: Optional report - return student answers in an exam with correctness. Parameters: ExamID, StudentID. Returns: OrderNo, QuestionText, ChosenOptionText, Correct. Exceptions: none.';