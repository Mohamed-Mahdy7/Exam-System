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

