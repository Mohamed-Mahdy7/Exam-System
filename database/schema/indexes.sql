-- Indexes for the QUESTIONS and CHOICE tables
CREATE INDEX idx_questions_course ON Questions(CourseID);
CREATE INDEX idx_choice_question ON Choice(QuestionID);