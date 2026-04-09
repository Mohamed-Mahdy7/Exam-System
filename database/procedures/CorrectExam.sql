CREATE OR REPLACE PROCEDURE CorrectExam(
    IN p_StudentExamID INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_TotalGrade INT;
BEGIN
    BEGIN

        SELECT COALESCE(SUM(
            CASE
                WHEN sa.ChosenOptionID = ma.CorrectOptionID THEN q.Points
                ELSE 0
            END
        ), 0)
        INTO v_TotalGrade
        FROM StudentExam se
        JOIN ExamQuestion eq 
            ON se.ExamID = eq.ExamID
        JOIN Questions q 
            ON eq.QuestionID = q.QuestionID
        JOIN ModelAnswer ma 
            ON q.QuestionID = ma.QuestionID
        LEFT JOIN StudentAnswer sa 
            ON sa.QuestionID = q.QuestionID
           AND sa.StudentExamID = se.StudentExamID
        WHERE se.StudentExamID = p_StudentExamID;

        UPDATE StudentExam
        SET TotalGrade = v_TotalGrade
        WHERE StudentExamID = p_StudentExamID;

        RAISE NOTICE 'Exam corrected successfully. Total Grade: %', v_TotalGrade;

    EXCEPTION
        WHEN OTHERS THEN
            RAISE NOTICE 'Error during correction % ', SQLERRM ;
            RAISE;
    END;

END;
$$;



CALL CorrectExam(3);
