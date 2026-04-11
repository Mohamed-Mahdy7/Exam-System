-- ---------------------------------------------------------------------------
-- 1. InsertOption
-- Purpose: Insert a new option for a question. 
-- Parameters: QuestionID, OptionText, OptionOrder. 
-- Returns: OptionID through OUT parameter. 
-- Exceptions: missing question, empty text, invalid order, duplicate order, exceeded allowed option count.
-- ---------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE InsertOption(
    IN p_question_id INT,
    IN p_option_text TEXT,
    IN p_option_order INT,
    OUT p_option_id INT
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_question_type TEXT;
    v_option_count INT;
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM Questions WHERE QuestionID = p_question_id
    ) THEN
        RAISE EXCEPTION 'Question % does not exist', p_question_id;
    END IF;

    IF p_option_text IS NULL OR BTRIM(p_option_text) = '' THEN
        RAISE EXCEPTION 'Option text cannot be empty';
    END IF;

    IF p_option_order IS NULL OR p_option_order <= 0 THEN
        RAISE EXCEPTION 'Option order must be greater than 0';
    END IF;

    IF EXISTS (
        SELECT 1
        FROM Choice
        WHERE QuestionID = p_question_id
        AND OptionOrder = p_option_order
    ) THEN
        RAISE EXCEPTION 'Option order % already exists for question %', p_option_order, p_question_id;
    END IF;

    SELECT Type
    INTO v_question_type
    FROM Questions
    WHERE QuestionID = p_question_id;

    SELECT COUNT(*)
    INTO v_option_count
    FROM Choice
    WHERE QuestionID = p_question_id;

    IF v_question_type = 'MCQ' AND v_option_count >= 4 THEN
        RAISE EXCEPTION 'MCQ question % cannot have more than 4 options', p_question_id;
    ELSIF v_question_type = 'TF' AND v_option_count >= 2 THEN
        RAISE EXCEPTION 'TF question % cannot have more than 2 options', p_question_id;
    END IF;

    INSERT INTO Choice (QuestionID, OptionText, OptionOrder)
    VALUES (p_question_id, p_option_text, p_option_order)
    RETURNING OptionID INTO p_option_id;

EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END;
$$;
---------------------------------- calling example for insertoption ----------------------------------

-- BEGIN;

-- CALL InsertOption(1, 'New Option Text', 1);

-- COMMIT;
-- ---------------------------------------------------------------------------
-- 2. UpdateOption
-- Purpose: Update an existing option. 
-- Any NULL input keeps the current value (partial update). 
-- Parameters: OptionID, QuestionID, OptionText, OptionOrder. 
-- Returns: none. 
-- Exceptions: missing option, missing question, empty text, invalid order, duplicate order, exceeded allowed option count.
-- ---------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE UpdateOption(
    IN p_option_id INT,
    IN p_question_id INT DEFAULT NULL,
    IN p_option_text TEXT DEFAULT NULL,
    IN p_option_order INT DEFAULT NULL
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_current_question_id INT;
    v_current_option_text TEXT;
    v_current_option_order INT;

    v_final_question_id INT;
    v_final_option_text TEXT;
    v_final_option_order INT;

    v_question_type TEXT;
    v_final_option_count INT;
BEGIN
    -- Get current values
    SELECT QuestionID, OptionText, OptionOrder
    INTO v_current_question_id, v_current_option_text, v_current_option_order
    FROM Choice
    WHERE OptionID = p_option_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Option % does not exist', p_option_id;
    END IF;

    -- Final values (partial update)
    v_final_question_id := COALESCE(p_question_id, v_current_question_id);
    v_final_option_text := COALESCE(p_option_text, v_current_option_text);
    v_final_option_order := COALESCE(p_option_order, v_current_option_order);

    -- Validate question exists
    IF NOT EXISTS (
        SELECT 1 FROM Questions WHERE QuestionID = v_final_question_id
    ) THEN
        RAISE EXCEPTION 'Question % does not exist', v_final_question_id;
    END IF;

    -- Validate text not empty
    IF v_final_option_text IS NULL OR BTRIM(v_final_option_text) = '' THEN
        RAISE EXCEPTION 'Option text cannot be empty';
    END IF;

    -- Validate order positive
    IF v_final_option_order IS NULL OR v_final_option_order <= 0 THEN
        RAISE EXCEPTION 'Option order must be greater than 0';
    END IF;

    IF EXISTS (
        SELECT 1
        FROM Choice
        WHERE QuestionID = v_final_question_id
        AND OptionOrder = v_final_option_order
        AND OptionID <> p_option_id
    ) THEN
        RAISE EXCEPTION 'Option order % already exists for question %',
            v_final_option_order, v_final_question_id;
    END IF;

    SELECT Type
    INTO v_question_type
    FROM Questions
    WHERE QuestionID = v_final_question_id;

    SELECT COUNT(*)
    INTO v_final_option_count
    FROM Choice
    WHERE QuestionID = v_final_question_id
    AND OptionID <> p_option_id;

    v_final_option_count := v_final_option_count + 1; -- Add current option back

    IF v_question_type = 'MCQ' AND v_final_option_count > 4 THEN
        RAISE EXCEPTION 'MCQ question % cannot have more than 4 options', v_final_question_id;
    ELSIF v_question_type = 'TF' AND v_final_option_count > 2 THEN
        RAISE EXCEPTION 'TF question % cannot have more than 2 options', v_final_question_id;
    END IF;

    UPDATE Choice
    SET QuestionID = v_final_question_id,
        OptionText = v_final_option_text,
        OptionOrder = v_final_option_order
    WHERE OptionID = p_option_id;

EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END;
$$;
-------------------------------------- calling example for updateoption --------------------------------------

-- BEGIN;

-- CALL UpdateOption(1,NULL,'Updated Option Text',NULL);

-- COMMIT;

-- ---------------------------------------------------------------------------
-- 3. DeleteOption
-- Purpose: Delete an option by OptionID. 
-- Parameters: OptionID. 
-- Returns: none. 
-- Exceptions: option not found.
-- ---------------------------------------------------------------------------
CREATE OR REPLACE PROCEDURE DeleteOption(
    IN p_option_id INT
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM Choice WHERE OptionID = p_option_id
    ) THEN
        RAISE EXCEPTION 'Option % does not exist', p_option_id;
    END IF;

    DELETE FROM Choice
    WHERE OptionID = p_option_id;

EXCEPTION
    WHEN OTHERS THEN
        RAISE;
END;
$$;
-------------------------------------- calling example for deleteoption --------------------------------------
-- BEGIN;

-- CALL DeleteOption(1);

-- COMMIT;
