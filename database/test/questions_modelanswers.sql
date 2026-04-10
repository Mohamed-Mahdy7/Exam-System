BEGIN;

DO $$
DECLARE
    v_course_id INT;
BEGIN
    SELECT CourseID INTO v_course_id
    FROM Course
    WHERE CourseName ILIKE '%Operating Systems%'
    ORDER BY CourseID
    LIMIT 1;

    IF v_course_id IS NULL THEN
        SELECT CourseID INTO v_course_id
        FROM Course
        ORDER BY CourseID
        LIMIT 1;
    END IF;

    IF v_course_id IS NULL THEN
        RAISE EXCEPTION 'No Course rows found. Run seed.sql first.';
    END IF;

    -- =========================
    -- TEST 1 (Linux MCQ):
    -- InsertQuestion (MCQ) + 4 options + reject 5th
    -- SetModelAnswer with valid option
    -- =========================
    RAISE NOTICE 'TEST 1: Linux MCQ + 4 options + reject 5th + SetModelAnswer(valid)';

    DECLARE
        v_qid INT;
        v_opt_id INT;
        v_choice_count INT;
        v_correct INT;
        v_ls_opt INT;
    BEGIN
        CALL InsertQuestion(
            v_course_id,
            'Linux: Which command lists files in the current directory?',
            'MCQ',
            2,
            v_qid
        );

        CALL InsertOption(v_qid, 'ls',  1, v_opt_id);
        CALL InsertOption(v_qid, 'cd',  2, v_opt_id);
        CALL InsertOption(v_qid, 'pwd', 3, v_opt_id);
        CALL InsertOption(v_qid, 'rm',  4, v_opt_id);

        SELECT COUNT(*) INTO v_choice_count
        FROM Choice
        WHERE QuestionID = v_qid;

        IF v_choice_count <> 4 THEN
            RAISE EXCEPTION 'TEST 1 FAILED: Expected 4 options, got %', v_choice_count;
        END IF;

        -- try 5th option (must fail)
        BEGIN
            CALL InsertOption(v_qid, 'mkdir', 5, v_opt_id);
            RAISE EXCEPTION 'TEST 1 FAILED: MCQ accepted a 5th option (should reject)';
        EXCEPTION WHEN OTHERS THEN
            RAISE NOTICE 'TEST 1 OK: Expected exception on 5th option: %', SQLERRM;
        END;

        -- valid model answer = ls
        SELECT OptionID INTO v_ls_opt
        FROM Choice
        WHERE QuestionID = v_qid AND OptionOrder = 1;

        CALL SetModelAnswer(v_qid, v_ls_opt);

        SELECT CorrectOptionID INTO v_correct
        FROM ModelAnswer
        WHERE QuestionID = v_qid;

        IF v_correct IS DISTINCT FROM v_ls_opt THEN
            RAISE EXCEPTION 'TEST 1 FAILED: ModelAnswer because of mismatch';
        END IF;

        RAISE NOTICE 'TEST 1 PASSED';
    END;

    -- =========================
    -- TEST 2 (Linux TF):
    -- InsertQuestion (TF) + 2 options + reject 3rd
    -- SetModelAnswer with valid option
    -- =========================
    RAISE NOTICE 'TEST 2: Linux TF + 2 options + reject 3rd + SetModelAnswer(valid)';

    DECLARE
        v_qid INT;
        v_opt_id INT;
        v_choice_count INT;
        v_correct INT;
        v_true_opt INT;
    BEGIN
        CALL InsertQuestion(
            v_course_id,
            'Linux: The command "pwd" prints the current working directory.',
            'TF',
            1,
            v_qid
        );

        CALL InsertOption(v_qid, 'True',  1, v_opt_id);
        CALL InsertOption(v_qid, 'False', 2, v_opt_id);

        SELECT COUNT(*) INTO v_choice_count
        FROM Choice
        WHERE QuestionID = v_qid;

        IF v_choice_count <> 2 THEN
            RAISE EXCEPTION 'TEST 2 FAILED: Expected 2 options, got %', v_choice_count;
        END IF;

        -- try 3rd option 
        BEGIN
            CALL InsertOption(v_qid, 'Maybe', 3, v_opt_id);
            RAISE EXCEPTION 'TEST 2 FAILED: TF accepted a 3rd option (should reject)';
        EXCEPTION WHEN OTHERS THEN
            RAISE NOTICE 'TEST 2 OK: Expected exception on 3rd TF option: %', SQLERRM;
        END;

        -- valid model answer = True
        SELECT OptionID INTO v_true_opt
        FROM Choice
        WHERE QuestionID = v_qid AND OptionOrder = 1;

        CALL SetModelAnswer(v_qid, v_true_opt);

        SELECT CorrectOptionID INTO v_correct
        FROM ModelAnswer
        WHERE QuestionID = v_qid;

        IF v_correct IS DISTINCT FROM v_true_opt THEN
            RAISE EXCEPTION 'TEST 2 FAILED: ModelAnswer because of mismatch';
        END IF;

        RAISE NOTICE 'TEST 2 PASSED';
    END;

    -- =========================
    -- TEST 3 (Linux validation):
    -- SetModelAnswer with OptionID from different question -> must raise exception
    -- =========================
    RAISE NOTICE 'TEST 3: SetModelAnswer rejects option from different question';

    DECLARE
        v_q1 INT;
        v_q2 INT;
        v_opt_id INT;
        v_q1_opt1 INT;
    BEGIN
        CALL InsertQuestion(
            v_course_id,
            'Linux: Which command changes the current directory?',
            'MCQ',
            1,
            v_q1
        );

        CALL InsertOption(v_q1, 'cd',  1, v_opt_id);
        CALL InsertOption(v_q1, 'ls',  2, v_opt_id);
        CALL InsertOption(v_q1, 'rm',  3, v_opt_id);
        CALL InsertOption(v_q1, 'pwd', 4, v_opt_id);

        SELECT OptionID INTO v_q1_opt1
        FROM Choice
        WHERE QuestionID = v_q1 AND OptionOrder = 1; 

        CALL InsertQuestion(
            v_course_id,
            'Linux: Which command shows running processes?',
            'MCQ',
            1,
            v_q2
        );

        CALL InsertOption(v_q2, 'ps',  1, v_opt_id);
        CALL InsertOption(v_q2, 'top', 2, v_opt_id);
        CALL InsertOption(v_q2, 'ls',  3, v_opt_id);
        CALL InsertOption(v_q2, 'cd',  4, v_opt_id);

        BEGIN
            CALL SetModelAnswer(v_q2, v_q1_opt1);
            RAISE EXCEPTION 'TEST 3 FAILED: SetModelAnswer accepted option from another question';
        EXCEPTION WHEN OTHERS THEN
            RAISE NOTICE 'TEST 3 PASSED: Expected exception: %', SQLERRM;
        END;

    END;

    -- =========================
    -- TEST 4 (Linux Delete cascade):
    -- DeleteQuestion must cascade to Choice and ModelAnswer
    -- =========================
    RAISE NOTICE 'TEST 4: DeleteQuestion cascades to Choice and ModelAnswer';

    DECLARE
        v_qid INT;
        v_opt_id INT;
        v_opt1 INT;
        v_c_before INT;
        v_m_before INT;
        v_c_after INT;
        v_m_after INT;
    BEGIN
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
    END;

END;
$$;

ROLLBACK;