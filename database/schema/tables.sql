create table Departments (
    DepartmentID serial primary key,
    DepartmentName text not null,
    Location text
);

create table Track (
    TrackID serial primary key,
    TrackName text not null,
    DepartmentID int not null references Departments(DepartmentID) on delete restrict
);

create table Course(
    CourseID serial primary key,
    CourseName text not null,
    MinDegree int not null,
    MaxDegree int not null,
    CHECK (MinDegree >= 0),
    CHECK (MaxDegree > MinDegree)

CREATE TABLE Instructor(
	InstructorID SERIAL PRIMARY KEY ,
	Name TEXT,
	Email TEXT UNIQUE,
	DepartmentNo INT REFERENCES Departments(DepartmentID) ON DELETE RESTRICT
);

CREATE TABLE Student (
	StudentID SERIAL PRIMARY KEY,
	Name TEXT,
	Email TEXT UNIQUE,
	Phone TEXT
);

CREATE TABLE InstructorCourse (
	InstructorID INT REFERENCES Instructor(InstructorID) ON DELETE CASCADE,,
	CourseID INT REFERENCES Course(CourseID) ON DELETE CASCADE,
	PRIMARY KEY (InstructorID,CourseID)
);

create table TrackCourse(
    TrackID int not null references Track(TrackID) on delete cascade,
    CourseID int not null references Course(CourseID) on delete cascade,
    primary key (TrackID, CourseID)
);

-- Create Table Exams
CREATE TABLE Exams (
    ExamID SERIAL PRIMARY KEY,
    ExamName TEXT,
    CourseID INT,
    CreatedDate TIMESTAMP DEFAULT NOW(),
    TotalQuestions INT


CREATE TABLE StudentTrack(
    StudentID INT REFERENCES Student(StudentID) ON DELETE CASCADE,
	TrackID INT REFERENCES Track(TrackID) ON DELETE RESTRICT,
	PRIMARY KEY (StudentID, TrackID)
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
-- Create Table ExamQuestion
CREATE TABLE ExamQuestion (
    ExamID INT REFERENCES Exams(ExamID) ON DELETE CASCADE,
    QuestionID INT,
    OrderNo INT CHECK (OrderNo >= 1)

-- Create Table ModelAnswer
CREATE TABLE ModelAnswer (
    ModelAnswerID SERIAL PRIMARY KEY,
    QuestionID INT UNIQUE NOT NULL REFERENCES Questions(QuestionID) ON DELETE CASCADE,
    CorrectOptionID INT NOT NULL REFERENCES Choice(OptionID) ON DELETE CASCADE
);
-- Create Table StudentExam
CREATE TABLE StudentExam (
    StudentExamID SERIAL PRIMARY KEY,
    StudentID INT,
    ExamID INT,
    StartTime TIMESTAMP,
    EndTime TIMESTAMP,
    TotalGrade INT

-- Create Table StudentAnswer

CREATE TABLE StudentAnswer (
    StudentAnswerID SERIAL PRIMARY KEY,
    StudentExamID INT NOT NULL REFERENCES StudentExam(StudentExamID) ON DELETE CASCADE, 
    QuestionID INT NOT NULL REFERENCES Questions(QuestionID) ON DELETE RESTRICT, 
    ChosenOptionID INT REFERENCES Choice(OptionID) ON DELETE RESTRICT, 
    UNIQUE (StudentExamID, QuestionID)
);