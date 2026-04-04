create table Departments (
DepartmentID serial primary key ,
DepartmentName text not null,
Location text
);


create table Track (
TrackID serial primary key ,
TrackName text not null,
DepartmentID int not null references Departments(DepartmentID) on delete restrict

);


create table Course(
CourseID serial primary key,
CourseName  text not null,
MinDegree int not null,
MaxDegree int not null ,
CHECK (MinDegree >= 0),
CHECK (MaxDegree > MinDegree)
);

create table TrackCourse(
TrackID int not null references Track(TrackID) on delete cascade,
CourseID int not null references Course(CourseID) on delete cascade,
primary key (TrackID ,CourseID )
);

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
