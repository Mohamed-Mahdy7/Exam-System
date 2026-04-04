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

-- Create Table Questions
CREATE TABLE Questions (
    QuestionID SERIAL PRIMARY KEY,
    CourseID INT NOT NULL, 
    QuestionText TEXT COLLATE "ar-x-icu" NOT NULL,
    Type TEXT CHECK (Type IN ('MCQ', 'TF')),
    Points INT DEFAULT 1
);
-- Create Table Choice
CREATE TABLE Choice (
    OptionID SERIAL PRIMARY KEY,
    QuestionID INT NOT NULL REFERENCES Questions(QuestionID) ON DELETE CASCADE,
    OptionText TEXT COLLATE "ar-x-icu" NOT NULL,
    OptionOrder INT
);

-- Create Table ModelAnswer
CREATE TABLE ModelAnswer (
    ModelAnswerID SERIAL PRIMARY KEY,
    QuestionID INT UNIQUE NOT NULL REFERENCES Questions(QuestionID) ON DELETE CASCADE,
    CorrectOptionID INT NOT NULL REFERENCES Choice(OptionID) ON DELETE CASCADE
);

-- Create Table StudentAnswer

CREATE TABLE StudentAnswer (
    StudentAnswerID SERIAL PRIMARY KEY,
    StudentExamID INT NOT NULL REFERENCES StudentExam(StudentExamID) ON DELETE CASCADE, 
    QuestionID INT NOT NULL REFERENCES Questions(QuestionID) ON DELETE RESTRICT, 
    ChosenOptionID INT REFERENCES Choice(OptionID) ON DELETE RESTRICT, 
    UNIQUE (StudentExamID, QuestionID)
);