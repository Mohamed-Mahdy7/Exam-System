-- 1. INSERT: Create a fake instructor (ID 999) and assign them to Course 1
INSERT INTO Instructor (InstructorID, Name, Email, Phone) 
VALUES (999, 'Dr. Fake', 'drfake@test.com', '01111111111');

INSERT INTO InstructorCourse (InstructorID, CourseID) 
VALUES (999, 1);

-- 2. UPDATE the instructor's email
UPDATE Instructor 
SET Email = 'new_drfake@test.com' 
WHERE InstructorID = 999;

-- 3. elete the instructor
DELETE FROM Instructor WHERE InstructorID = 999;

-- 4. VERIFY CASCADE: Check if the InstructorCourse link was deleted automatically
SELECT * FROM InstructorCourse WHERE InstructorID = 999;

