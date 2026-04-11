-- =========================
-- TEST 3: SetModelAnswer
--   Valid CorrectOptionID   → ModelAnswer row created
--   OptionID from different question → exception raised
-- =========================
BEGIN;

-- Valid
CALL SetModelAnswer(1, 1);

-- Invalid: option 1 belongs to question 1, NOT question 2 → must raise exception
CALL SetModelAnswer(2, 1);

ROLLBACK;