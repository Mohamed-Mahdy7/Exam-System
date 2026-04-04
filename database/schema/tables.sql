-- Create Table Exams

CREATE TABLE Exams (
    ExamID SERIAL PRIMARY KEY,
    ExamName TEXT,
    CourseID INT,
    CreatedDate TIMESTAMP DEFAULT NOW(),
    TotalQuestions INT
);

-- Create Table ExamQuestion

CREATE TABLE ExamQuestion (
    ExamID INT REFERENCES Exams(ExamID)
    ON DELETE CASCADE,
    QuestionID INT,
    OrderNo INT CHECK (OrderNo >= 1)
);

-- Create Table StudentExam

CREATE TABLE StudentExam (
    StudentExamID SERIAL PRIMARY KEY,
    StudentID INT,
    ExamID INT,
    StartTime TIMESTAMP,
    EndTime TIMESTAMP,
    TotalGrade INT
);
-- CREATE TABLE QUESTIONS
CREATE TABLE Questions (
    QuestionID SERIAL PRIMARY KEY,
    CourseID INT NOT NULL,
    QuestionText TEXT NOT NULL,
    Type TEXT CHECK (Type IN ('MCQ', 'TF')),
    Points INT DEFAULT 1
);

-- CREATE TABLE CHOICE
CREATE TABLE Choice (
    OptionID SERIAL PRIMARY KEY,
    QuestionID INT NOT NULL REFERENCES Questions(QuestionID) ON DELETE CASCADE,
    OptionText TEXT COLLATE "ar-x-icu" NOT NULL,
    OptionOrder INT
);

-- CREATE TABLE MODEL ANSWER
CREATE TABLE ModelAnswer (
    QuestionID INT PRIMARY KEY REFERENCES Questions(QuestionID) ON DELETE CASCADE,
    CorrectOptionID INT NOT NULL REFERENCES Choice(OptionID) ON DELETE CASCADE
);

-- CREATE TABLE STUDENT ANSWER
CREATE TABLE StudentAnswer (
    StudentAnswerID SERIAL PRIMARY KEY,
    StudentExamID INT NOT NULL REFERENCES StudentExam(StudentExamID) ON DELETE CASCADE,
    QuestionID INT NOT NULL REFERENCES Questions(QuestionID) ON DELETE CASCADE,
    ChosenOptionID INT REFERENCES Choice(OptionID) ON DELETE CASCADE,
       UNIQUE (StudentExamID, QuestionID)
);