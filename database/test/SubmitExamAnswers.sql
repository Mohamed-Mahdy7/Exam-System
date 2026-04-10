


-- CALL SubmitExamAnswers(
--     8,
--     1,
--     '2026-04-08 10:00:00',
--     '2026-04-08 11:00:00',
--     '[
-- 	  {"question_id":1,"chosen_option_id":1},
--    {"question_id":2,"chosen_option_id":6},
-- 	  {"question_id":3,"chosen_option_id":10},
-- 	  {"question_id":4,"chosen_option_id":15},
-- 	  {"question_id":5,"chosen_option_id":17},
-- 	  {"question_id":6,"chosen_option_id":21},
-- 	  {"question_id":7,"chosen_option_id":26},
-- 	  {"question_id":8,"chosen_option_id":30},
-- 	  {"question_id":9,"chosen_option_id":35},
-- 	  {"question_id":10,"chosen_option_id":37},
-- 	  {"question_id":11,"chosen_option_id":41},
-- 	  {"question_id":12,"chosen_option_id":44},
-- 	  {"question_id":13,"chosen_option_id":45},
-- 	  {"question_id":14,"chosen_option_id":47},
-- 	  {"question_id":15,"chosen_option_id":50}

-- 	  ]'
-- );


-- to display answers of exam and answer not found equal null 

-- SELECT q.QuestionID, sa.ChosenOptionID
-- FROM ExamQuestion eq
-- JOIN Question q ON q.QuestionID = eq.QuestionID
-- LEFT JOIN StudentAnswer sa 
--     ON sa.QuestionID = q.QuestionID
--    AND sa.StudentExamID = 10
-- WHERE eq.ExamID = 1;





-- CALL SubmitExamAnswers(
--     8,
--     1,
--     '2026-04-08 10:00:00',
--     '2026-04-08 11:00:00',
--     '[
-- 	  {"question_id":1,"chosen_option_id":1},
--    {"question_id":2,"chosen_option_id":6},
-- 	  {"question_id":3,"chosen_option_id":10},
-- 	  {"question_id":4,"chosen_option_id":15},
-- 	  {"question_id":5,"chosen_option_id":17},
-- 	  {"question_id":6,"chosen_option_id":21},
-- 	  {"question_id":7,"chosen_option_id":26},
-- 	  {"question_id":8,"chosen_option_id":30},
-- 	  {"question_id":9,"chosen_option_id":35},
-- 	  {"question_id":10,"chosen_option_id":37},
-- 	  {"question_id":11,"chosen_option_id":41}

-- 	  ]'
-- );



-- to know number of question that answered 
-- SELECT QuestionID
-- FROM StudentAnswer
-- WHERE StudentExamID = 42;


-- BEGIN;

-- CALL SubmitExamAnswers(
--     3,
--     1,
--     '2026-04-08 10:00:00',
--     '2026-04-08 11:00:00',
--     '[]'::JSONB
-- );

-- COMMIT;
