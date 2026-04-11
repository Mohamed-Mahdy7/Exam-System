--  Add foreign key for Course in Exams table
ALTER TABLE Exams
ADD CONSTRAINT fk_course
FOREIGN KEY (CourseID)
REFERENCES Course(CourseID)
ON DELETE RESTRICT;

-- Add foreign key and primary key for ExamQuestion
ALTER TABLE ExamQuestion
ADD CONSTRAINT fk_question
FOREIGN KEY (QuestionID)
REFERENCES Questions(QuestionID)
ON DELETE RESTRICT,
ADD CONSTRAINT  pk_examquestion
PRIMARY KEY (ExamID, QuestionID);

-- Add foreign keys for StudentExam
ALTER TABLE StudentExam
ADD CONSTRAINT fk_student
FOREIGN KEY (StudentID)
REFERENCES Student(StudentID)
ON DELETE CASCADE,
ADD CONSTRAINT fk_exam
FOREIGN KEY (ExamID)
REFERENCES Exams(ExamID)
ON DELETE RESTRICT;

-- Add foreign key for Question
ALTER TABLE Questions 
ADD CONSTRAINT FK_Questions_Course 
FOREIGN KEY (CourseID) REFERENCES Course(CourseID) 
ON DELETE CASCADE;
