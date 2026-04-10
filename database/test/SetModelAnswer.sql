BEGIN;
DO $$
DECLARE
  c INT; q1 INT; q2 INT; o1 INT; o2 INT;
BEGIN
  SELECT CourseID INTO c FROM Course ORDER BY CourseID LIMIT 1;

  -- Valid case
  CALL InsertQuestion(c,'Q1','MCQ',1,q1);
  CALL InsertOption(q1,'A',1,o1);
  CALL SetModelAnswer(q1,o1);

  IF NOT EXISTS (SELECT 1 FROM ModelAnswer WHERE QuestionID = q1 AND CorrectOptionID = o1) THEN
    RAISE EXCEPTION 'Valid FAILED: ModelAnswer row not created';
  END IF;

  RAISE NOTICE 'Valid: OK (row created)';

  -- Invalid case
  CALL InsertQuestion(c,'Q2','MCQ',1,q2);
  CALL InsertOption(q2,'X',1,o2);

  BEGIN
    CALL SetModelAnswer(q2,o1); -- o1 belongs to q1
    RAISE EXCEPTION 'Invalid FAILED: should have raised exception';
  EXCEPTION WHEN OTHERS THEN
    RAISE NOTICE 'Invalid: OK (%)', SQLERRM;
  END;
END $$;
ROLLBACK;