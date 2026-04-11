-- Indexes for the QUESTIONS and CHOICE tables
CREATE INDEX idx_questions_course ON Questions(CourseID);
CREATE INDEX idx_choice_question ON Choice(QuestionID);

CREATE index idx_track_department on Track (DepartmentID);
CREATE index idx_trackcourse_track on TrackCourse (TrackID);
CREATE index idx_trackcourse_course on TrackCourse (CourseID);

CREATE index idx_instructor_department on Instructor(DepartmentNO);
CREATE INDEX idx_studentTrack_student ON StudentTrack(StudentID);
CREATE INDEX idx_studentTrack_track ON StudentTrack(TrackID);
CREATE INDEX idx_instructorCourse_course ON InstructorCourse(CourseID);

CREATE index idx_exam_couse ON Exams(CourseID);
CREATE index idx_examquestion_exam ON ExamQuestion(ExamID);
CREATE index idx_examquestion_question ON ExamQuestion(QuestionID);
CREATE index idx_studentexam_student ON StudentExam(StudentID);
CREATE index idx_studentexam_exam ON StudentExam(ExamID);
