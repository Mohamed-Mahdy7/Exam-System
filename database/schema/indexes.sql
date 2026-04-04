-- CREATED INDEXES ON QUESTIONS / CHOICE / STUDENT ANSWER
CREATE INDEX idx_questions_course ON Questions(CourseID);
CREATE INDEX idx_choice_question ON Choice(QuestionID);
CREATE INDEX idx_studentanswer_studentexam ON StudentAnswer(StudentExamID);