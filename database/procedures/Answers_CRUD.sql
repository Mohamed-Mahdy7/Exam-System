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
CREATE OR REPLACE PROCEDURE SelectStudentAnswers(
    IN p_student_exam_id INT,
    INOUT p_cur REFCURSOR
)
LANGUAGE plpgsql
AS $$
BEGIN
    OPEN p_cur FOR
    SELECT sa.StudentAnswerID,
           sa.StudentExamID,
           sa.QuestionID,
           q.QuestionText,
           sa.ChosenOptionID,
           c.OptionText AS ChosenOptionText
    FROM StudentAnswer sa
    JOIN Questions q ON q.QuestionID = sa.QuestionID
    LEFT JOIN Choice c ON c.OptionID = sa.ChosenOptionID
    WHERE sa.StudentExamID = p_student_exam_id
    ORDER BY sa.StudentAnswerID;
EXCEPTION WHEN OTHERS THEN
    RAISE;
END;
$$;

COMMENT ON PROCEDURE SelectStudentAnswers(INT, REFCURSOR)
IS 'Purpose: Return all submitted answers for a StudentExam. Parameters: StudentExamID, cursor. Returns: cursor with answers. Exceptions: none.';