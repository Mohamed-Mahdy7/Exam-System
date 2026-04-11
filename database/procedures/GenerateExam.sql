-- ===================================================================================================
-- Purpose: GENERATE Exam
-- parameters: p_CourseID INT, ExamName TEXT, NumMCQ INT, NumTF INT
-- returns: Insert Exam Data into Exam Table then Questions into ExamQuestion Table without returning
-- exception raised : 'Course with ID % not found!', p_CourseID;
--                     'Exam name cannot be empty';
--                     'Not enough questions';
-- ===================================================================================================

CREATE OR REPLACE PROCEDURE GenerateExam(
    p_CourseID INT,
    ExamName TEXT,
    NumMCQ INT,
    NumTF INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_total INT := NumMCQ + NumTF;
    v_count INT;
    v_exam_id INT;
BEGIN
    BEGIN

		IF NOT EXISTS (SELECT * FROM Course WHERE CourseID = p_CourseID ) THEN
			RAISE EXCEPTION 'Course with ID % not found!', p_CourseID;
		END IF;

		IF ExamName IS NULL OR trim(ExamName) = '' THEN
            RAISE EXCEPTION 'Exam name cannot be empty';
        END IF;

        -- check available questions
        SELECT COUNT(*) INTO v_count
        FROM Questions
        WHERE CourseID = p_CourseID;

        IF v_count < v_total THEN
            RAISE EXCEPTION 'Not enough questions';
        END IF;

        -- insert exam
        INSERT INTO Exams (ExamName, CourseID, TotalQuestions)
        VALUES (ExamName, p_CourseID, v_total)
        RETURNING ExamID INTO v_exam_id;

        -- insert random questions
        INSERT INTO ExamQuestion (ExamID, QuestionID)
        SELECT v_exam_id, QuestionID
        FROM Questions
        WHERE CourseID = p_CourseID
        ORDER BY RANDOM()
        LIMIT v_total;

    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END;
END;
$$;

-- BEGIN;
-- 	CALL GenerateExam(1, 'Mid Exam', 5, 5);
-- COMMIT;

-- SELECT * FROM ExamQuestion;