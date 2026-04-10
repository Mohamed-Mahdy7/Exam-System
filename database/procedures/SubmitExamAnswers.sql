/*
===============================================================================
Procedure Name : SubmitExamAnswers
===============================================================================
 Purpose:
-----------
This procedure handles the full submission process of a student's exam attempt.
It records the exam session and stores each submitted answer individually.
The procedure ensures data integrity by executing all operations within a
transactional block.
-------------------------------------------------------------------------------
Parameters:
--------------
p_StudentID   INT
    - The unique identifier of the student submitting the exam.

p_ExamID      INT
    - The unique identifier of the exam being submitted.

p_StartTime   TIMESTAMP
    - The timestamp indicating when the student started the exam.

p_EndTime     TIMESTAMP
    - The timestamp indicating when the student finished the exam.

p_Answers     JSONB
    - A JSONB array containing the student's answers.
    - Format:
        [
          {"question_id": <INT>, "chosen_option_id": <INT>},
          ...
        ]
-------------------------------------------------------------------------------
Returns:
-----------
VOID (no direct return value)

However:
- Inserts a new record into StudentExam table.
- Inserts multiple records into StudentAnswer table (one per answered question).
-------------------------------------------------------------------------------
 Behavior:
-------------
1. Creates a new exam attempt in StudentExam.
2. Parses the JSONB answers array.
3. Inserts each answer into StudentAnswer.
4. Skips unanswered questions (no row inserted → implicitly scored as 0).
5. Ensures atomicity using a transactional block.

-------------------------------------------------------------------------------
 Exceptions:
--------------
The procedure raises exceptions in the following cases:

- ANY UNEXPECTED ERROR (WHEN OTHERS)
     Logs the error message using RAISE NOTICE.
     he exception to allow outer transaction rollback.
Recommended additional validations (if implemented):
- Invalid ExamID
- Invalid StudentID
- Duplicate exam submission
- Malformed JSON structure
-------------------------------------------------------------------------------
Transaction Notes:
---------------------
- This procedure uses a BEGIN...EXCEPTION block (subtransaction behavior).
- A full COMMIT / ROLLBACK must be controlled by the caller.

Example usage:
    BEGIN;
    CALL SubmitExamAnswers(...);
    COMMIT;
If an error occurs:
    ROLLBACK;
===============================================================================
*/


CREATE OR REPLACE PROCEDURE SubmitExamAnswers(
    IN p_StudentID INT,
    IN p_ExamID INT,
    IN p_StartTime TIMESTAMP,
    IN p_EndTime TIMESTAMP,
    IN p_Answers JSONB
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_StudentExamID INT;
    answer JSONB;
BEGIN

    BEGIN

        INSERT INTO StudentExam (StudentID, ExamID, StartTime, EndTime)
        VALUES (p_StudentID, p_ExamID, p_StartTime, p_EndTime)
        RETURNING StudentExamID INTO v_StudentExamID;

        FOR answer IN
            SELECT * FROM jsonb_array_elements(p_Answers)
        LOOP
            INSERT INTO StudentAnswer (
                StudentExamID,
                QuestionID,
                ChosenOptionID
            )
            VALUES (
                v_StudentExamID,
                (answer->>'question_id')::INT,
                (answer->>'chosen_option_id')::INT
            );
        END LOOP;

        RAISE NOTICE 'Exam submitted successfully';

    EXCEPTION
        WHEN OTHERS THEN
            RAISE NOTICE 'Error in PROCEDURE: % ' , SQLERRM ;
            RAISE; 
    END;

END;
$$;



-- CALL SubmitExamAnswers(
--     2,
--     1,
--     '2026-04-08 10:00:00',
--     '2026-04-08 11:00:00',
--     '[
--     {"question_id":1,"chosen_option_id":1},
--     {"question_id":2,"chosen_option_id":4},
--     {"question_id":3,"chosen_option_id":8},
--     {"question_id":4,"chosen_option_id":3},
--     {"question_id":5,"chosen_option_id":3},
--     {"question_id":6,"chosen_option_id":3},
--     {"question_id":7,"chosen_option_id":3},
--     {"question_id":8,"chosen_option_id":3},
--     {"question_id":9,"chosen_option_id":7},
--     {"question_id":1,"chosen_option_id":7},
--     {"question_id":9,"chosen_option_id":7},
--     {"question_id":9,"chosen_option_id":7},
--     {"question_id":9,"chosen_option_id":7},
--     {"question_id":9,"chosen_option_id":7}
--     ]'
-- );