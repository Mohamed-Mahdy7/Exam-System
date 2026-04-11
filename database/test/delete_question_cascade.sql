-- =========================
-- TEST 4 (Linux Delete cascade):
-- DeleteQuestion must cascade to Choice and ModelAnswer
-- =========================
BEGIN;
DO $$
DECLARE
    v_course_id INT;
    v_qid INT;
    v_opt_id INT;
    v_opt1 INT;
    v_c_before INT;
    v_m_before INT;
    v_c_after INT;
    v_m_after INT;
BEGIN
    SELECT CourseID INTO v_course_id
    FROM Course
    ORDER BY CourseID
    LIMIT 1;
    IF v_course_id IS NULL THEN
        RAISE EXCEPTION 'No Course rows found. Run seed.sql first.';
    END IF;
    RAISE NOTICE 'TEST 4: DeleteQuestion cascades to Choice and ModelAnswer';
    CALL InsertQuestion(
        v_course_id,
        'Linux: Which file contains user account information?',
        'MCQ',
        1,
        v_qid
    );
    CALL InsertOption(v_qid, '/etc/passwd', 1, v_opt_id);
    CALL InsertOption(v_qid, '/etc/shadow', 2, v_opt_id);
    CALL InsertOption(v_qid, '/etc/hosts',  3, v_opt_id);
    CALL InsertOption(v_qid, '/var/log/syslog', 4, v_opt_id);
    SELECT OptionID INTO v_opt1
    FROM Choice
    WHERE QuestionID = v_qid AND OptionOrder = 1;
    CALL SetModelAnswer(v_qid, v_opt1);
    SELECT COUNT(*) INTO v_c_before FROM Choice WHERE QuestionID = v_qid;
    SELECT COUNT(*) INTO v_m_before FROM ModelAnswer WHERE QuestionID = v_qid;
    IF v_c_before <> 4 OR v_m_before <> 1 THEN
        RAISE EXCEPTION 'TEST 4 SETUP FAILED: expected 4 choices and 1 modelanswer, got choices=% model=%',
            v_c_before, v_m_before;
    END IF;
    CALL DeleteQuestion(v_qid);
    SELECT COUNT(*) INTO v_c_after FROM Choice WHERE QuestionID = v_qid;
    SELECT COUNT(*) INTO v_m_after FROM ModelAnswer WHERE QuestionID = v_qid;
    IF v_c_after <> 0 THEN
        RAISE EXCEPTION 'TEST 4 FAILED: Choice rows still exist after delete (%).', v_c_after;
    END IF;
    IF v_m_after <> 0 THEN
        RAISE EXCEPTION 'TEST 4 FAILED: ModelAnswer rows still exist after delete (%).', v_m_after;
    END IF;
    RAISE NOTICE 'TEST 4 PASSED';
END $$;
ROLLBACK;