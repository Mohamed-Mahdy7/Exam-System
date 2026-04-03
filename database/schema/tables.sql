create table Departments (
DepartmentID serial primary key ,
DepartmentName text,
dep_location text
);

create table Track (
TrackID serial primary key ,
TrackName text,
DepartmentID int references Departments(DepartmentID) on delete cascade

);


create table Course(
CourseID serial primary key,
CourseName  text,
MinDegree int ,
MaxDegree int
);

create table TrackCourse(
TrackID int references Track(TrackID) on delete cascade,
CourseID int references Course(CourseID) on delete cascade,
primary key (TrackID ,CourseID )
);