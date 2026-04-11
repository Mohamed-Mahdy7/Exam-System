-- ---------------------------------------------------------------------------
-- 1. InsertQuestion
-- Purpose: Insert a new question. 
-- Parameters: CourseID, QuestionText, Type, Points. 
-- Returns: QuestionID through OUT parameter. 
-- Exceptions: empty text, invalid type, invalid points, missing course.
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

    IF NOT EXISTS (SELECT 1 FROM Course WHERE CourseID = p_course_id) THEN
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
------------------------ insert question example ------------------------------

-- BEGIN;

-- CALL InsertQuestion(1, 'What is a variable?', 'MCQ', 2);

-- COMMIT;

-- ---------------------------------------------------------------------------
-- 2. UpdateQuestion
-- Purpose: Update an existing question partially or fully. 
-- Parameters: QuestionID, CourseID, QuestionText, Type, Points. 
-- Null parameters keep old values. 
-- Returns: none. 
-- Exceptions: missing question, missing course, empty text, invalid type, invalid points.
-- ---------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE UpdateQuestion(
    IN p_question_id INT,
    IN p_course_id INT DEFAULT NULL,
    IN p_question_text TEXT DEFAULT NULL,
    IN p_type TEXT DEFAULT NULL,
    IN p_points INT DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_old_course_id INT;
    v_old_question_text TEXT;
    v_old_type TEXT;
    v_old_points INT;

    v_final_course_id INT;
    v_final_question_text TEXT;
    v_final_type TEXT;
    v_final_points INT;
BEGIN
    SELECT CourseID, QuestionText, Type, Points
    INTO v_old_course_id, v_old_question_text, v_old_type, v_old_points
    FROM Questions
    WHERE QuestionID = p_question_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Question % does not exist', p_question_id;
    END IF;

    v_final_course_id := COALESCE(p_course_id, v_old_course_id);
    v_final_question_text := COALESCE(p_question_text, v_old_question_text);
    v_final_type := COALESCE(p_type, v_old_type);
    v_final_points := COALESCE(p_points, v_old_points);

    IF NOT EXISTS (SELECT 1 FROM Course WHERE CourseID = v_final_course_id) THEN
        RAISE EXCEPTION 'Course % does not exist', v_final_course_id;
    END IF;

    IF v_final_question_text IS NULL OR BTRIM(v_final_question_text) = '' THEN
        RAISE EXCEPTION 'Question text cannot be empty';
    END IF;

    IF v_final_type NOT IN ('MCQ', 'TF') THEN
        RAISE EXCEPTION 'Invalid question type. Allowed values: MCQ, TF';
    END IF;

    IF v_final_points IS NULL OR v_final_points <= 0 THEN
        RAISE EXCEPTION 'Points must be greater than 0';
    END IF;

    UPDATE Questions
    SET CourseID = v_final_course_id,
        QuestionText = v_final_question_text,
        Type = v_final_type,
        Points = v_final_points
    WHERE QuestionID = p_question_id;
END;
$$;
-- ------------------------------ update question example ------------------------------
-- BEGIN;

-- CALL UpdateQuestion(1, NULL, 'What is a variable?', NULL, NULL);

-- COMMIT;
-- ---------------------------------------------------------------------------
-- 3. DeleteQuestion
-- Purpose: Delete a question by QuestionID. 
-- Parameters: QuestionID. 
-- Returns: none. 
-- Exceptions: question not found. 
-- Cascading behavior depends on foreign keys.
-- ---------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE DeleteQuestion(IN p_question_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (SELECT 1 FROM Questions WHERE QuestionID = p_question_id) THEN
        RAISE EXCEPTION 'Question % does not exist', p_question_id;
    END IF;

    DELETE FROM Questions
    WHERE QuestionID = p_question_id;

EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END;
$$;
------------------------------- delete question example ------------------------------

-- BEGIN;

-- CALL DeleteQuestion(1);

-- COMMIT;

-- ---------------------------------------------------------------------------
-- 4. SelectQuestion
-- Purpose: Select one question by QuestionID. 
-- Parameters: QuestionID, cursor. 
-- Returns: cursor with question row. 
-- Exceptions: none.
-- ---------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE SelectQuestion(
    IN p_question_id INT,
    INOUT p_cur REFCURSOR
)
LANGUAGE plpgsql
AS $$
BEGIN
    OPEN p_cur FOR
        SELECT q.QuestionID, q.CourseID, q.QuestionText, q.Type, q.Points
        FROM Questions q
        WHERE q.QuestionID = p_question_id;
END;
$$;
----------------------------------- select question example ------------------------------

-- BEGIN;

-- CALL SelectQuestion(1, 'my_cursor');
-- FETCH ALL FROM my_cursor;

-- COMMIT;

-- ---------------------------------------------------------------------------
-- 5. SelectQuestionsByCourse
-- Purpose: Return all questions for a specific course. 
-- Parameters: CourseID, cursor. 
-- Returns: cursor with question rows. 
-- Exceptions: none.
-- ---------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE SelectQuestionsByCourse(
    IN p_course_id INT,
    INOUT p_cur REFCURSOR
)
LANGUAGE plpgsql
AS $$
BEGIN
    OPEN p_cur FOR
        SELECT q.QuestionID, q.CourseID, q.QuestionText, q.Type, q.Points
        FROM Questions q
        WHERE q.CourseID = p_course_id
        ORDER BY q.QuestionID;
EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END;
$$;
----------------------------------- select questions by course example ------------------------------

-- BEGIN;

-- CALL SelectQuestionsByCourse(1, 'my_cursor');
-- FETCH ALL FROM my_cursor;

-- COMMIT;