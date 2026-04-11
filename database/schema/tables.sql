-- Create Table Departments if not exists
create table IF NOT EXISTS Departments (
    DepartmentID serial primary key,
    DepartmentName text collate "ar-x-icu" not null,
    Location text collate "ar-x-icu"  
);

-- Create Table Track if not exists
create table IF NOT EXISTS Track (
    TrackID serial primary key,
    TrackName text  collate "ar-x-icu" not null,
    DepartmentID int not null references Departments(DepartmentID) on delete restrict
);

-- Create Table Course if not exists
create table IF NOT EXISTS Course(
    CourseID serial primary key,
    CourseName text collate "ar-x-icu" not null,
    MinDegree int not null,
    MaxDegree int not null,
    CHECK (MinDegree >= 0),
    CHECK (MaxDegree > MinDegree)
);

-- Create Table TrackCourse if not exists
create table IF NOT EXISTS TrackCourse(
    TrackID int not null references Track(TrackID) on delete cascade,
    CourseID int not null references Course(CourseID) on delete cascade,
    primary key (TrackID, CourseID)
);

-- Create Table Instructor if not exists
CREATE TABLE IF NOT EXISTS Instructor(
	InstructorID SERIAL PRIMARY KEY ,
	Name TEXT COLLATE "ar-x-icu" NOT NULL,
	Email TEXT UNIQUE,
	DepartmentNo INT REFERENCES Departments(DepartmentID) ON DELETE RESTRICT
);

-- Create Table Student if not exists
CREATE TABLE IF NOT EXISTS Student (
	StudentID SERIAL PRIMARY KEY,
	Name TEXT COLLATE "ar-x-icu" NOT NULL,
	Email TEXT UNIQUE,
	Phone TEXT
);

-- Create Table InstructorCourse if not exists
CREATE TABLE IF NOT EXISTS InstructorCourse (
	InstructorID INT REFERENCES Instructor(InstructorID) ON DELETE CASCADE,
	CourseID INT REFERENCES Course(CourseID) ON DELETE CASCADE,
	PRIMARY KEY (InstructorID,CourseID)
);

-- Create Table Exams if not exists
CREATE TABLE IF NOT EXISTS Exams (
    ExamID SERIAL PRIMARY KEY,
    ExamName TEXT COLLATE "ar-x-icu" NOT NULL,
    CourseID INT,
    CreatedDate TIMESTAMP DEFAULT NOW(),
    TotalQuestions INT
);

-- Create Table StudentTrack if not exists
CREATE TABLE IF NOT EXISTS StudentTrack(
    StudentID INT REFERENCES Student(StudentID) ON DELETE CASCADE,
	TrackID INT REFERENCES Track(TrackID) ON DELETE RESTRICT,
	PRIMARY KEY (StudentID, TrackID)
);

-- Create Table Questions if not exists
CREATE TABLE IF NOT EXISTS Questions (
    QuestionID SERIAL PRIMARY KEY,
    CourseID INT NOT NULL, 
    QuestionText TEXT COLLATE "ar-x-icu" NOT NULL,
    Type TEXT NOT NULL CHECK (Type IN ('MCQ','TF')),
    Points INT NOT NULL CHECK (Points > 0)
);

-- Create Table Choice if not exists
CREATE TABLE IF NOT EXISTS Choice (
    OptionID SERIAL PRIMARY KEY,
    QuestionID INT NOT NULL REFERENCES Questions(QuestionID) ON DELETE CASCADE,
    OptionText TEXT COLLATE "ar-x-icu" NOT NULL,
    OptionOrder INT NOT NULL CHECK (OptionOrder BETWEEN 1 AND 4)
);

-- Create Table ExamQuestion if not exists
CREATE TABLE IF NOT EXISTS ExamQuestion (
    ExamID INT REFERENCES Exams(ExamID) ON DELETE CASCADE,
    QuestionID INT REFERENCES Questions(QuestionID) ON DELETE RESTRICT,
    OrderNo INT CHECK (OrderNo >= 1) NOT NULL
);

-- Create Table ModelAnswer if not exists
CREATE TABLE IF NOT EXISTS ModelAnswer (
    QuestionID INT UNIQUE NOT NULL REFERENCES Questions(QuestionID) ON DELETE CASCADE,
    CorrectOptionID INT NOT NULL REFERENCES Choice(OptionID) ON DELETE RESTRICT
);

-- Create Table StudentExam if not exists
CREATE TABLE IF NOT EXISTS StudentExam (
    StudentExamID SERIAL PRIMARY KEY,
    StudentID INT,
    ExamID INT,
    StartTime TIMESTAMP,
    EndTime TIMESTAMP,
    TotalGrade INT
);

-- Create Table StudentAnswer if not exists
CREATE TABLE IF NOT EXISTS StudentAnswer (
    StudentAnswerID SERIAL PRIMARY KEY,
    StudentExamID INT NOT NULL REFERENCES StudentExam(StudentExamID) ON DELETE CASCADE, 
    QuestionID INT NOT NULL REFERENCES Questions(QuestionID) ON DELETE RESTRICT, 
    ChosenOptionID INT REFERENCES Choice(OptionID) ON DELETE RESTRICT, 
    UNIQUE (StudentExamID, QuestionID)
);
