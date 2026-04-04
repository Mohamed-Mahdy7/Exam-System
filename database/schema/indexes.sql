create index idx_track_department on Track (DepartmentID);
create index idx_trackcourse_track on TrackCourse (TrackID);
create index idx_trackcourse_course on TrackCourse (CourseID);

create index idx_instructor_department on Instructor(DepartmentNO);
CREATE INDEX idx_studentTrack_student ON StudentTrack(StudentID);
CREATE INDEX idx_studentTrack_track ON StudentTrack(TrackID);
CREATE INDEX idx_instructorCourse_course ON InstructorCourse(CourseID);
