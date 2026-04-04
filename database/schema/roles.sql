-- Create admin role

CREATE ROLE admin_role
WITH LOGIN
PASSWORD "admin123"
SUPERUSER
CREATEDB
CREATEROLE;


--  Grant privilege for admin_role

GRANT CONNECT ON DATABASE exam_db TO admin_role;

GRANT USAGE ON SCHEMA public TO admin_role;

GRANT SELECT, INSERT, UPDATE, DELETE
ON ALL TABLES IN SCHEMA public
TO admin_role;


ALTER DEFAULT PRIVILEGES IN SCHEMA public
GRANT SELECT, INSERT, UPDATE, DELETE
ON TABLES TO admin_role;



CREATE ROLE instructor_role WITH LOGIN PASSWORD 'instructor123';
CREATE ROLE student_role WITH LOGIN PASSWORD 'student123';

GRANT SELECT , INSERT ,UPDATE ,DELETE ON Instructor TO instructor_role;
GRANT SELECT ON Instructor TO student_role;

GRANT SELECT , INSERT ,UPDATE ,DELETE ON Student TO instructor_role;
GRANT SELECT ON Student TO student_role;

GRANT SELECT ,INSERT ,UPDATE ,DELETE ON StudentTrack TO instructor_role;
GRANT SELECT ON StudentTrack TO student_role;

GRANT SELECT, INSERT, UPDATE, DELETE ON InstructorCourse TO instructor_role;
REVOKE ALL ON InstructorCourse FROM student_role;

REVOKE INSERT , UPDATE, DELETE ON Student FROM student_role;