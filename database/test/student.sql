-- 1. INSERT: Create a fake student (ID 999) and assign them to Track 1
INSERT INTO Student (StudentID, Name, Email, Phone) 
VALUES (999, 'Fake Student', 'fake@test.com', '01000000000');

INSERT INTO StudentTrack (StudentID, TrackID) 
VALUES (999, 1);

-- 2. UPDATE  the student's name
UPDATE Student 
SET Name = 'Updated Fake Student' 
WHERE StudentID = 999;

-- 3. Delete the student from the main table
DELETE FROM Student WHERE StudentID = 999;

-- 4. VERIFY CASCADE
SELECT * FROM StudentTrack WHERE StudentID = 999;

