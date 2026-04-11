-- Create Admin Role
CREATE ROLE admin_role
WITH LOGIN
PASSWORD 'admin123'
SUPERUSER
CREATEDB
CREATEROLE;

--  Grant privileges for admin_role
GRANT CONNECT ON DATABASE exam_db TO admin_role;
GRANT USAGE ON SCHEMA public TO admin_role;
GRANT SELECT, INSERT, UPDATE, DELETE
ON ALL TABLES IN SCHEMA public
TO admin_role;


ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT SELECT, INSERT, UPDATE, DELETE
ON TABLES TO admin_role;


-- Create Instructor Role
CREATE ROLE instructor_role WITH LOGIN PASSWORD 'instructor123';

-- Grant privileges for instructor_role
GRANT SELECT ON InstructorCourse, Course, TrackCourse, Track, StudentTrack TO instructor_role;
GRANT SELECT , INSERT ,UPDATE ,DELETE ON Instructor TO instructor_role;
GRANT SELECT , INSERT ,UPDATE ,DELETE ON Student TO instructor_role;
GRANT SELECT ,INSERT ,UPDATE ,DELETE ON StudentTrack TO instructor_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON InstructorCourse TO instructor_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON Departments TO instructor_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON Track TO instructor_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON TrackCourse TO instructor_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON Course TO instructor_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON Questions TO instructor_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON Choice TO instructor_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON ModelAnswer TO instructor_role;
GRANT SELECT, INSERT, UPDATE, DELETE ON StudentAnswer TO instructor_role;


-- Create Student Role
CREATE ROLE student_role WITH LOGIN PASSWORD 'student123';

-- Grant privileges for student_role
GRANT SELECT ON Instructor TO student_role;
GRANT SELECT ON StudentTrack TO student_role;
GRANT SELECT ON Student TO student_role;
GRANT SELECT ON Track TO student_role;
GRANT SELECT ON Departments TO student_role;
GRANT SELECT ON TrackCourse TO student_role;
GRANT SELECT ON Course TO student_role;
GRANT SELECT ON Questions TO student_role;
GRANT SELECT ON Choice TO student_role;
GRANT SELECT, INSERT ON StudentAnswer TO student_role;

-- Revoke privileges for student_role
REVOKE INSERT , UPDATE, DELETE ON Student FROM student_role;
REVOKE ALL ON InstructorCourse FROM student_role;
REVOKE INSERT, UPDATE, DELETE ON Departments FROM student_role;
REVOKE INSERT, UPDATE, DELETE ON Track FROM student_role;
REVOKE INSERT, UPDATE, DELETE ON TrackCourse FROM student_role;
REVOKE INSERT, UPDATE, DELETE ON Course FROM student_role;
REVOKE ALL ON ModelAnswer FROM student_role;
REVOKE UPDATE, DELETE ON StudentAnswer FROM student_role;
