create index idx_track_department on Track (DepartmentID);
create index idx_trackcourse_track on TrackCourse (TrackID);
create index idx_trackcourse_course on TrackCourse (CourseID);