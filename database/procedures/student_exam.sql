-- SELECT ALL FROM StudentExam
CREATE OR REPLACE PROCEDURE se_s(INOUT ref refcursor)
LANGUAGE plpgsql
AS $$
BEGIN
	OPEN ref FOR
	SELECT * FROM StudentExam;
END;
$$;

-- 	CALL se_s('mycursor');
-- 	FETCH ALL FROM mycursor;


-- SELECT SrudentExam BY ExamID
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
END;
$$;

-- 	CALL se_s_eid(5, 'mycursor');
-- 	FETCH ALL FROM mycursor;


-- SELECT SrudentExam BY StudentID
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
END;
$$;

-- 	CALL se_s_sid(5, 'mycursor');
-- 	FETCH ALL FROM mycursor;


-- SELECT SrudentExam BY StudentExamID
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
END;
$$;

-- 	CALL se_s_seid(8, 'mycursor');
-- 	FETCH ALL FROM mycursor;
