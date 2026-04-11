-- ================================================================
-- Purpose: SELECT ALL ExamQuestion
-- parameters: ref refcursor
-- returns: All data from Table ExamQuestion
-- exception raised : 'Error in select from Exams: %'
-- ================================================================

CREATE OR REPLACE PROCEDURE exq_sa(INOUT ref refcursor)
LANGUAGE plpgsql
AS $$
BEGIN
	OPEN ref FOR
	SELECT * FROM ExamQuestion;

	EXCEPTION WHEN OTHERS
	THEN
		RAISE NOTICE 'Error in select from Exams: %', SQLERRM;
		RAISE;
END;
$$;

-- BEGIN;
-- 	CALL exq_sa('mycursor');
-- 	FETCH ALL FROM mycursor;
-- COMMIT;


-- ==============================================================================
-- Purpose: SELECT ExamQuestion BY ExamID
-- parameters: p_exam_id INT, ref refcursor
-- returns: All data from Table ExamQuestion where ExamID = p_exam_id
-- exception raised : 'Exam With ID % does not exist!', p_exam_id;
-- ==============================================================================

CREATE OR REPLACE PROCEDURE exq_s_eid(IN p_exam_id INT, INOUT ref refcursor)
LANGUAGE plpgsql
AS $$
BEGIN
	-- Check if Exam exist
	IF NOT EXISTS (
		SELECT 1 FROM ExamQuestion WHERE ExamID = p_exam_id
	) THEN
		RAISE EXCEPTION 'Exam With ID % does not exist!', p_exam_id;
	END IF;
	
	OPEN ref FOR
	SELECT * 
	FROM ExamQuestion
	WHERE ExamID = p_exam_id;

	EXCEPTION WHEN OTHERS
	THEN
		RAISE NOTICE 'Error while selecting from ExamQuestion by ExamID: %', SQLERRM;
		RAISE;
END;
$$;

-- BEGIN
-- 	CALL exq_s_eid(5, 'mycursor');
-- 	FETCH ALL FROM mycursor;
-- COMMIT;


-- ================================================================================
-- Purpose: INSERT INTO ExamQuestion
-- parameters: p_exam_id INT, rp_question_id INT, p_order_no INT
-- returns: insert values into ExamQuestion without returning any data
-- exception raised : RAISE EXCEPTION 'QuestionID cannot be empty';
-- 					RAISE EXCEPTION 'Exam with ID % does not exist', p_exam_id;
-- 					RAISE EXCEPTION 'OrderNo must be greater than 0';
-- 					'Error while inserting into ExamQuestion: %', SQLERRM;
-- ================================================================================

CREATE OR REPLACE PROCEDURE eq_i(
	p_exam_id INT,
	p_question_id INT,
	p_order_no INT)
LANGUAGE plpgsql
AS $$
BEGIN
    IF p_question_id IS NULL THEN
        RAISE EXCEPTION 'QuestionID cannot be empty';
    END IF;

    IF NOT EXISTS (SELECT 1 FROM Exams WHERE ExamID = p_exam_id) THEN
        RAISE EXCEPTION 'Exam with ID % does not exist', p_exam_id;
    END IF;

    IF p_order_no <= 0 THEN
        RAISE EXCEPTION 'OrderNo must be greater than 0';
    END IF;
	
	INSERT INTO ExamQuestion (ExamID, QuestionID, OrderNo)
	VALUES (p_exam_id, p_question_id, p_order_no);

	EXCEPTION WHEN OTHERS
	THEN
		RAISE NOTICE 'Error while inserting into ExamQuestion: %', SQLERRM;
		RAISE;
END;
$$;

-- BEGIN
-- CALL eq_i(1, 17, 20);
-- COMMIT;


-- ===============================================================================
-- Purpose: UPDATE ROW IN ExamQuestion
-- parameters: p_exam_id INT, rp_question_id INT, p_order_no INT DEFAULT NULL
-- returns: Updates values in ExamQuestion without returning any data
-- exception raised : RAISE EXCEPTION 'Exam with ID % does not exist', p_exam_id;
-- 					'Question with ID % does not exist', p_question_id;
-- 					'Error while updating values in ExamQuestion: %', SQLERRM;
-- ===============================================================================

CREATE OR REPLACE PROCEDURE eq_u(
	p_exam_id INT,
	p_question_id INT,
	p_order_no INT DEFAULT NULL)
LANGUAGE plpgsql
AS $$
BEGIN

    IF NOT EXISTS (SELECT 1 FROM Exams WHERE ExamID = p_exam_id) THEN
        RAISE EXCEPTION 'Exam with ID % does not exist', p_exam_id;
    END IF;

	IF NOT EXISTS (SELECT 1 FROM ExamQuestion WHERE ExamID = p_exam_id AND QuestionID = p_question_id) THEN
        RAISE EXCEPTION 'Question with ID % does not exist', p_question_id;
    END IF;
	
	UPDATE ExamQuestion 
	SET
		OrderNo= COALESCE(p_order_no)
	WHERE ExamID = p_exam_id AND QuestionID = p_question_id;

	EXCEPTION WHEN OTHERS
	THEN
		RAISE NOTICE 'Error while updating values in ExamQuestion: %', SQLERRM;
		RAISE;
END;
$$;

-- BEGIN
-- CALL eq_u(1, 10, 50);
-- COMMIT;


-- ================================================================================
-- Purpose: DELETE ROW FROM ExamQuestion
-- parameters: p_exam_id INT, rp_question_id INT
-- returns: Delete from table ExamQuestion without retutning
-- exception raised : RAISE EXCEPTION 'Exam with ID % does not exist', p_exam_id;
-- 					'Question with ID % does not exist', p_question_id;
-- 					'Error while deleting from ExamQuestion: %', SQLERRM;
-- ===============================================================================

CREATE OR REPLACE PROCEDURE eq_d(
	p_exam_id INT,
	p_question_id INT)
LANGUAGE plpgsql
AS $$
BEGIN

    IF NOT EXISTS (SELECT 1 FROM Exams WHERE ExamID = p_exam_id) THEN
        RAISE EXCEPTION 'Exam with ID % does not exist', p_exam_id;
    END IF;

	IF NOT EXISTS (SELECT 1 FROM ExamQuestion WHERE ExamID = p_exam_id AND QuestionID = p_question_id) THEN
        RAISE EXCEPTION 'Question with ID % does not exist', p_question_id;
    END IF;
	
	DELETE FROM ExamQuestion 
	WHERE ExamID = p_exam_id AND QuestionID = p_question_id;

	EXCEPTION WHEN OTHERS
	THEN
		RAISE NOTICE 'Error while deleting from ExamQuestion: %', SQLERRM;
		RAISE;
END;
$$;

-- BEGIN
-- CALL eq_d(1, 10);
-- COMMIT;
