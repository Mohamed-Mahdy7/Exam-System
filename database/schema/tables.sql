<<<<<<< HEAD
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
	InstructorID INT REFERENCES Instructor(InstructorID),
	CourseID INT REFERENCES Course(CourseID),
	PRIMARY KEY (InstructorID,CourseID)
);

CREATE TABLE StudentTrack(
 	StudentID INT REFERENCES Student(StudentID) ON DELETE CASCADE,
	TrackID INT REFERENCES Track(TrackID) ON DELETE CASCADE,
	PRIMARY KEY (StudentID, TrackID)
);
=======
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
>>>>>>> d9194e43fc8411a2c18c5f17e06bed541b01d366
