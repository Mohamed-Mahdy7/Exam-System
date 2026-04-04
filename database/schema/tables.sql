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
