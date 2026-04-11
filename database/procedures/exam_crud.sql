-- ===========================================================
-- Purpose: SELECT ALL EXAMS
-- parameters: ref refcursor
-- returns: All data from Table Exams
-- exception raised : 'Error in select from Exams: %'
-- ===========================================================

CREATE OR REPLACE PROCEDURE ex_sa(INOUT ref refcursor)
LANGUAGE plpgsql
AS $$
BEGIN
	OPEN ref FOR
	SELECT * FROM Exams;

	EXCEPTION WHEN OTHERS
	THEN
		RAISE NOTICE 'Error in select from Exams: %', SQLERRM;
		RAISE;
END;
$$;

-- BEGIN;
-- 	CALL ex_sa('mycursor');
-- 	FETCH ALL FROM mycursor;
-- COMMIT;


-- ====================================================================
-- purpose: SELECT EXAM BY ExamID
-- parameters: p_exam_id INT, ref refcursor
-- returns: all values from Exams that has the passed ExamID
-- exceptions raised: 'Exam With ID % does not exist!', p_exam_id,
--					 'Error in ex_S procedure: %', SQLERRM
-- ====================================================================

CREATE OR REPLACE PROCEDURE ex_s(IN p_exam_id INT, INOUT ref refcursor)
LANGUAGE plpgsql
AS $$
BEGIN
	-- Check if Exam exist
	IF NOT EXISTS (
		SELECT 1 FROM Exams WHERE ExamID = p_exam_id
	) THEN
		RAISE EXCEPTION 'Exam With ID % does not exist!', p_exam_id;
	END IF;
	
	OPEN ref FOR
	SELECT * 
	FROM Exams
	WHERE ExamID = p_exam_id;

	EXCEPTION WHEN OTHERS
	THEN
		RAISE NOTICE 'Error in ex_S procedure: %', SQLERRM;
		RAISE;
END;
$$;

-- BEGIN;
-- 	CALL ex_s(5, 'mycursor');
-- 	FETCH ALL FROM mycursor;
-- COMMIT;


-- =============================================================================
-- purpose: SELECT EXAM BY CourseID
-- parameters: p_course_id INT,  ref refcursor
-- returns: all values from Exams that has the passed CourseID
-- exceptions raised: 'Course With ID % does not exist!', p_course_id
--					 'Error in ex_cid procedure: %', SQLERRM
-- =============================================================================

CREATE OR REPLACE PROCEDURE ex_cid(IN p_course_id INT, INOUT ref refcursor)
LANGUAGE plpgsql
AS $$
BEGIN
	-- Check if Exam exist
	IF NOT EXISTS (
		SELECT 1 FROM Exams WHERE CourseID = p_course_id
	) THEN
		RAISE EXCEPTION 'Course With ID % does not exist!', p_course_id;
	END IF;
	
	OPEN ref FOR
	SELECT * 
	FROM Exams
	WHERE CourseID = p_course_id;

	EXCEPTION WHEN OTHERS
	THEN
		RAISE NOTICE 'Error in ex_cid procedure: %', SQLERRM;
		RAISE;
END;
$$;

-- BEGIN;
-- 	CALL ex_cid(3, 'mycursor');
-- 	FETCH ALL FROM mycursor;
-- COMMIT;


-- =====================================================================
-- purpose: INSERT INTO Exams
-- parameters: p_exam_name TEXT, p_course_id INT, p_total_questions INT
-- returns: Insert values to Exam table without returning
-- exceptions raised: 'Exam name cannot be empty';
-- 					'Course with ID % does not exist', p_course_id;
-- 					'TotalQuestions must be greater than 0';
--					 'Error while inserting into Exams: %', SQLERRM;
-- =====================================================================

CREATE OR REPLACE PROCEDURE ex_i(
	p_exam_name TEXT,
	p_course_id INT,
	p_total_questions INT)
LANGUAGE plpgsql
AS $$
BEGIN
    IF p_exam_name IS NULL OR trim(p_exam_name) = '' THEN
        RAISE EXCEPTION 'Exam name cannot be empty';
    END IF;

    IF NOT EXISTS (SELECT 1 FROM Course WHERE CourseID = p_course_id) THEN
        RAISE EXCEPTION 'Course with ID % does not exist', p_course_id;
    END IF;

    IF p_total_questions <= 0 THEN
        RAISE EXCEPTION 'TotalQuestions must be greater than 0';
    END IF;
	
	INSERT INTO Exams (ExamName, CourseID, TotalQuestions)
	VALUES (p_exam_name, p_course_id, p_total_questions);

	EXCEPTION WHEN OTHERS
	THEN
		RAISE NOTICE 'Error while inserting into Exams: %', SQLERRM;
		RAISE;
END;
$$;

-- BEGIN;
-- 	CALL ex_i('test', 1, 10);
-- COMMIT;


-- ============================================================================================
-- purpose: UPDATE EXAM ROW
-- parameters: p_exam_id INT,
-- 				p_exam_name TEXT DEFAULT NULL,
-- 				p_course_id INT DEFAULT NULL,
-- 				p_total_questions INT DEFAULT NULL
-- returns: Update the chosen columns without returning
-- exceptions raised: 'Exam with ID % does not exist', p_exam_id;
--					'Error while updating into Exams: %', SQLERRM;
-- ============================================================================================

CREATE OR REPLACE PROCEDURE ex_u(
	p_exam_id INT,
	p_exam_name TEXT DEFAULT NULL,
	p_course_id INT DEFAULT NULL,
	p_total_questions INT DEFAULT NULL
	)
LANGUAGE plpgsql
AS $$
BEGIN
	IF p_exam_id IS NULL OR NOT EXISTS(SELECT 1 FROM Exams WHERE ExamID = p_exam_id) THEN
		RAISE EXCEPTION 'Exam with ID % does not exist', p_exam_id;
	END IF;
	
	UPDATE Exams
	SET 
		ExamName = COALESCE(p_exam_name, ExamName),
		CourseID = COALESCE(p_course_id, CourseID),
		TotalQuestions = COALESCE(p_total_questions, TotalQuestions)
	WHERE ExamID = p_exam_id;

	EXCEPTION WHEN OTHERS
	THEN
		RAISE NOTICE 'Error while updating into Exams: %', SQLERRM;
		RAISE;
END;
$$;

-- BEGIN;
-- 	CALL ex_u(7, 'Advanced OS Exam', NULL, NULL);
-- COMMIT;


-- ===================================================================
-- purpose: DELETE ROW FROM EXAM
-- parameters: p_exam_id INT
-- returns: DELETE the row of the ExamID columns without returning
-- exceptions raised: 'Exam with ID % does not exist', p_exam_id;
--					'Error while deleting from Exams: %', SQLERRM;
-- ===================================================================

CREATE OR REPLACE PROCEDURE ex_d(p_exam_id INT)
LANGUAGE plpgsql
AS $$
BEGIN
	IF p_exam_id IS NULL OR NOT EXISTS(SELECT 1 FROM Exams WHERE ExamID = p_exam_id) THEN
		RAISE EXCEPTION 'Exam with ID % does not exist', p_exam_id;
	END IF;
	
	DELETE FROM Exams
	WHERE ExamID = p_exam_id;

	EXCEPTION WHEN OTHERS
	THEN
		RAISE NOTICE 'Error while deleting from Exams: %', SQLERRM;
		RAISE;
END;
$$;

-- BEGIN;
-- 	CALL ex_d(7);
-- COMMIT;
