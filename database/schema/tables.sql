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