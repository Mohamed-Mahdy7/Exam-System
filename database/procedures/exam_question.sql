-- SELECT ALL FROM ExamQuestion
CREATE OR REPLACE PROCEDURE exq_sa(INOUT ref refcursor)
LANGUAGE plpgsql
AS $$
BEGIN
	OPEN ref FOR
	SELECT * FROM ExamQuestion;
END;
$$;

-- BEGIN;
-- 	CALL exq_sa('mycursor');
-- 	FETCH ALL FROM mycursor;
-- COMMIT;


-- SELECT ExamQuestion BY ExamID
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
END;
$$;

-- BEGIN;
-- 	CALL exq_s_eid(5, 'mycursor');
-- 	FETCH ALL FROM mycursor;
-- 	CLOSE mycursor;
-- COMMIT;


-- INSERT INTO ExamQuestion
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
END;
$$;

-- CALL eq_i(1, 17, 20);


-- UPDATE ROW IN ExamQuestion
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
END;
$$;

-- CALL eq_u(1, 10, 50);


-- DELETE ROW FROM ExamQuestion
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
END;
$$;

-- CALL eq_d(1, 10);
