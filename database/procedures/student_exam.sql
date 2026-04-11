-- ===========================================================
-- Purpose: SELECT ALL FROM StudentExam
-- parameters: ref refcursor
-- returns: All data from Table StudentExam
-- exception raised : 'Error in select from Exams: %'
-- ===========================================================

CREATE OR REPLACE PROCEDURE se_s(INOUT ref refcursor)
LANGUAGE plpgsql
AS $$
BEGIN
	OPEN ref FOR
	SELECT * FROM StudentExam;

	EXCEPTION WHEN OTHERS
	THEN
		RAISE NOTICE 'Error in select from StudentExam: %', SQLERRM;
		RAISE;
END;
$$;

-- 	CALL se_s('mycursor');
-- 	FETCH ALL FROM mycursor;


-- ==================================================================================
-- Purpose: SELECT SrudentExam BY ExamID
-- parameters: p_exam_id INT, ref refcursor
-- returns: All data from Table StudentExam where ExamID = p_exam_id
-- exception raised : 'Exam With ID % does not exist!', p_exam_id;
-- 						'Error while selecting studentexam by ExamID: %', SQLERRM;
-- ==================================================================================

CREATE OR REPLACE PROCEDURE se_s_eid(IN p_exam_id INT, INOUT ref refcursor)
LANGUAGE plpgsql
AS $$
BEGIN

	IF NOT EXISTS (
		SELECT 1 FROM StudentExam WHERE ExamID = p_exam_id
	) THEN
		RAISE EXCEPTION 'Exam With ID % does not exist!', p_exam_id;
	END IF;
	
	OPEN ref FOR
	SELECT * 
	FROM StudentExam
	WHERE ExamID = p_exam_id;

	EXCEPTION WHEN OTHERS
	THEN
		RAISE NOTICE 'Error while selecting studentexam by ExamID: %', SQLERRM;
		RAISE;
END;
$$;

-- 	CALL se_s_eid(5, 'mycursor');
-- 	FETCH ALL FROM mycursor;


-- ==================================================================================
-- Purpose: SELECT StudentExam BY StudentID
-- parameters: p_student_id INT, ref refcursor
-- returns: All data from Table StudentExam where StudentID = p_student_id
-- exception raised : 'Student With ID % does not exist!', p_student_id;
-- 						'Error while selecting studentexam by StudentID: %', SQLERRM;
-- ==================================================================================

CREATE OR REPLACE PROCEDURE se_s_sid(IN p_student_id INT, INOUT ref refcursor)
LANGUAGE plpgsql
AS $$
BEGIN

	IF NOT EXISTS (
		SELECT 1 FROM StudentExam WHERE StudentID = p_student_id
	) THEN
		RAISE EXCEPTION 'Student With ID % does not exist!', p_student_id;
	END IF;
	
	OPEN ref FOR
	SELECT * 
	FROM StudentExam
	WHERE StudentID = p_student_id;

	EXCEPTION WHEN OTHERS
	THEN
		RAISE NOTICE 'Error while selecting studentexam by StudentID: %', SQLERRM;
		RAISE;
END;
$$;

-- 	CALL se_s_sid(5, 'mycursor');
-- 	FETCH ALL FROM mycursor;


-- ==================================================================================
-- Purpose: SELECT SrudentExam BY StudentExamID
-- parameters: p_studentexam_id INT, ref refcursor
-- returns: All data from Table StudentExam where StudentExamID = p_studentexam_id
-- exception raised : 'Student With ID % does not exist!', p_studentexam_id;
-- 						'Error while selecting studentexam by StudentExamID: %', SQLERRM;
-- ==================================================================================

CREATE OR REPLACE PROCEDURE se_s_seid(IN p_studentexam_id INT, INOUT ref refcursor)
LANGUAGE plpgsql
AS $$
BEGIN

	IF NOT EXISTS (
		SELECT 1 FROM StudentExam WHERE StudentExamID = p_studentexam_id
	) THEN
		RAISE EXCEPTION 'Student With ID % does not exist!', p_studentexam_id;
	END IF;
	
	OPEN ref FOR
	SELECT * 
	FROM StudentExam
	WHERE StudentExamID = p_studentexam_id;

	EXCEPTION WHEN OTHERS
	THEN
		RAISE NOTICE 'Error while selecting studentexam by StudentExamID: %', SQLERRM;
		RAISE;
END;
$$;

-- 	CALL se_s_seid(8, 'mycursor');
-- 	FETCH ALL FROM mycursor;
