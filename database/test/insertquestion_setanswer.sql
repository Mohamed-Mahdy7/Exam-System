    -- =========================
    -- TEST 1 (Linux MCQ):
    -- InsertQuestion (MCQ) + 4 options + reject 5th
    -- SetModelAnswer with valid option
    -- =========================
 BEGIN;

DO $$
DECLARE
    v_course_id INT;
    v_qid       INT;
    v_opt_out   INT;
    v_ls_opt    INT;
    v_correct   INT;
BEGIN
    SELECT CourseID INTO v_course_id
    FROM Course
    ORDER BY CourseID
    LIMIT 1;

    IF v_course_id IS NULL THEN
        RAISE EXCEPTION 'No Course rows found. Run seed.sql first.';
    END IF;

    RAISE NOTICE 'TEST 1: Linux MCQ (4 options) + reject 5th + SetModelAnswer(valid)';

    CALL InsertQuestion(
        v_course_id,
        'Linux: Which command lists files in the current directory?',
        'MCQ',
        2,
        v_qid
    );

    CALL InsertOption(v_qid, 'ls',  1, v_opt_out);
    CALL InsertOption(v_qid, 'cd',  2, v_opt_out);
    CALL InsertOption(v_qid, 'pwd', 3, v_opt_out);
    CALL InsertOption(v_qid, 'rm',  4, v_opt_out);

    IF (SELECT COUNT(*) FROM Choice WHERE QuestionID = v_qid) <> 4 THEN
        RAISE EXCEPTION 'TEST 1 FAILED: Expected 4 options';
    END IF;

    BEGIN
        CALL InsertOption(v_qid, 'mkdir', 5, v_opt_out);
        RAISE EXCEPTION 'TEST 1 FAILED: MCQ accepted 5th option';
    EXCEPTION WHEN OTHERS THEN
        RAISE NOTICE 'TEST 1 OK: 5th option rejected: %', SQLERRM;
    END;

    SELECT OptionID INTO v_ls_opt
    FROM Choice
    WHERE QuestionID = v_qid AND OptionOrder = 1;

    IF v_ls_opt IS NULL THEN
        RAISE EXCEPTION 'TEST 1 FAILED: could not find option order 1';
    END IF;

    CALL SetModelAnswer(v_qid, v_ls_opt);

    SELECT CorrectOptionID INTO v_correct
    FROM ModelAnswer
    WHERE QuestionID = v_qid;

    IF v_correct IS NULL OR v_correct <> v_ls_opt THEN
        RAISE EXCEPTION 'TEST 1 FAILED: ModelAnswer mismatch';
    END IF;

    RAISE NOTICE 'TEST 1 PASSED';
END $$;

ROLLBACK;
-------------------------------------- test 2 on TF question with 2 options + reject 3rd + SetModelAnswer(valid) --------------------------------------
BEGIN;

DO $$
DECLARE
    v_course_id INT;
    v_qid INT;
    v_opt_id INT;
    v_choice_count INT;
    v_correct INT;
    v_true_opt INT;
BEGIN
    SELECT CourseID INTO v_course_id
    FROM Course
    ORDER BY CourseID
    LIMIT 1;

    IF v_course_id IS NULL THEN
        RAISE EXCEPTION 'No Course rows found. Run seed.sql first.';
    END IF;

    RAISE NOTICE 'TEST 2: Linux TF (2 options) + reject 3rd + SetModelAnswer(valid)';

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

    BEGIN
        CALL InsertOption(v_qid, 'Maybe', 3, v_opt_id);
        RAISE EXCEPTION 'TEST 2 FAILED: TF accepted a 3rd option (should reject)';
    EXCEPTION WHEN OTHERS THEN
        RAISE NOTICE 'TEST 2 OK: Expected exception on 3rd TF option: %', SQLERRM;
    END;

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
END $$;

ROLLBACK;