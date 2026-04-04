create index idx_track_department on Track (DepartmentID);
create index idx_trackcourse_track on TrackCourse (TrackID);
create index idx_trackcourse_course on TrackCourse (CourseID);

CREATE index idx_exam_couse ON Exam(CourseID);
CREATE index idx_examquestion_exam ON ExamQuestion(ExamID);
CREATE index idx_examquestion_question ON ExamQuestion(QuestionID);
CREATE index idx_studentexam_student ON StudentExam(StudentID)
CREATE index idx_studentexam_exam ON StudentExam(ExamID)
