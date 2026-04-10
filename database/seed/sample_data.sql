-- Departments (5+)
INSERT INTO Departments (DepartmentName, Location) VALUES
('Software Engineering', 'Building A'),
('Networking', 'Building B'),
('Data Science', 'Building C'),
('Cyber Security', 'Building D'),
('Artificial Intelligence', 'Building E');

-- Tracks (4 per department = 20 total)
INSERT INTO Track (TrackName, DepartmentID) VALUES
-- Software Engineering (1)
('Web Development', 1),
('Mobile Development', 1),
('Desktop Applications', 1),
('DevOps Engineering', 1),

-- Networking (2)
('Network Administration', 2),
('Cloud Networking', 2),
('Wireless Networks', 2),
('Network Security', 2),

-- Data Science (3)
('Data Analysis', 3),
('Big Data Engineering', 3),
('Business Intelligence', 3),
('Data Visualization', 3),

-- Cyber Security (4)
('Ethical Hacking', 4),
('Digital Forensics', 4),
('Security Operations', 4),
('Cryptography', 4),

-- Artificial Intelligence (5)
('Machine Learning', 5),
('Deep Learning', 5),
('Natural Language Processing', 5),
('Computer Vision', 5);

-- Courses (10+ with valid Min/Max)
INSERT INTO Course (CourseName, MinDegree, MaxDegree) VALUES
('Programming Fundamentals', 0, 90),
('Data Structures', 20, 120),
('Databases', 30, 110),
('Operating Systems', 25, 150),
('Computer Networks', 20, 85),
('Cloud Computing', 30, 100),
('Machine Learning Basics', 40, 100),
('Deep Learning Advanced', 50, 100),
('Cyber Security Fundamentals', 20, 100),
('Ethical Hacking Advanced', 50, 100),
('Data Visualization Tools', 30, 100),
('Big Data Processing', 40, 100);

-- TrackCourse (junction links)
INSERT INTO TrackCourse (TrackID, CourseID) VALUES
-- Web Development
(1,1),(1,2),(1,3),

-- Mobile Development
(2,1),(2,2),(2,4),

-- Desktop Applications
(3,1),(3,2),(3,4),

-- DevOps
(4,4),(4,5),(4,6),

-- Network Administration
(5,5),(5,4),

-- Cloud Networking
(6,5),(6,6),

-- Wireless Networks
(7,5),

-- Network Security
(8,5),(8,9),

-- Data Analysis
(9,1),(9,2),(9,11),

-- Big Data Engineering
(10,2),(10,12),

-- Business Intelligence
(11,3),(11,11),

-- Data Visualization
(12,11),

-- Ethical Hacking
(13,9),(13,10),

-- Digital Forensics
(14,9),

-- Security Operations
(15,9),(15,5),

-- Cryptography
(16,9),

-- Machine Learning
(17,7),

-- Deep Learning
(18,7),(18,8),

-- NLP
(19,7),

-- Computer Vision
(20,7),(20,8);


INSERT INTO Instructor (Name, Email, DepartmentNo) VALUES 
('Dr. Magdy Youssef', 'magdy.youssef@university.edu', 1), 
('Dr. Rasha Ali', 'rasha.ali@university.edu', 2),       
('Dr. Tarek Emad', 'tarek.emad@university.edu', 3),      
('Dr. Heba Nabil', 'heba.nabil@university.edu', 4),     
('Dr. Khaled Wael', 'khaled.wael@university.edu', 5);    


INSERT INTO InstructorCourse (InstructorID, CourseID) VALUES 
(1, 1),  
(1, 2),  
(2, 5),  
(2, 6),  
(3, 11), 
(3, 12), 
(4, 9),  
(4, 10), 
(5, 7), 
(5, 8);

INSERT INTO Student (Name, Email, Phone) VALUES 
('Ahmed Ali', 'ahmed.ali@example.com', '01012345601'),
('Sara Hassan', 'sara.hassan@example.com', '01112345602'),
('Mohamed Mahmoud', 'mohamed.m@example.com', '01212345603'),
('Mona Adel', 'mona.adel@example.com', '01512345604'),
('Youssef Ibrahim', 'youssef.i@example.com', '01012345605'),
('Nada Khaled', 'nada.khaled@example.com', '01112345606'),
('Omar Mostafa', 'omar.m@example.com', '01212345607'),
('Aya Tarek', 'aya.tarek@example.com', '01512345608'),
('Karim Magdy', 'karim.magdy@example.com', '01012345609'),
('Salma Samir', 'salma.samir@example.com', '01112345610'),
('Amr Wael', 'amr.wael@example.com', '01212345611'),
('Hoda Yasser', 'hoda.yasser@example.com', '01512345612'),
('Tarek Nabil', 'tarek.nabil@example.com', '01012345613'),
('Rania Kamal', 'rania.kamal@example.com', '01112345614'),
('Ziad Fathy', 'ziad.fathy@example.com', '01212345615'),
('Dina Sherif', 'dina.sherif@example.com', '01512345616'),
('Moustafa Adel', 'moustafa.adel@example.com', '01012345617'),
('Nour Ehab', 'nour.ehab@example.com', '01112345618'),
('Yassin Omar', 'yassin.omar@example.com', '01212345619'),
('Mariam Sayed', 'mariam.sayed@example.com', '01512345620');

INSERT INTO StudentTrack (StudentID, TrackID) VALUES
(1, 1),  
(2, 1),   
(3, 1),   
(4, 4),  
(5, 5),  
(6, 6),  
(7, 7),  
(8, 8),   
(9, 9),   
(10, 10), 
(11, 11),
(12, 12), 
(13, 13),
(14, 14), 
(15, 15), 
(16, 16), 
(17, 17), 
(18, 18),
(19, 19), 
(20, 20); 

-- Exams (5 Exams)
INSERT INTO Exams (ExamName, CourseID, TotalQuestions)
VALUES 
    ('Fundamentals Exam', 1, 15),
    ('Data Structure Exam', 2, 15),
    ('DB Exam', 3, 10),
    ('OS Exam', 4, 10),
    ('Network Exam', 5, 10);

-- StudentExam (10 StudentExam  each Exam taken by 2 Students)
INSERT INTO StudentExam(StudentID, ExamID, StartTime, EndTime, TotalGrade)
VALUES 
    (1, 1, '2026-04-01 10:00:00', '2026-04-01 11:00:00', 50),
    (2, 2, '2026-04-01 10:05:00', '2026-04-01 11:02:00', 70),
    (3, 3, '2026-04-02 12:00:00', '2026-04-02 13:15:00', 90),
    (4, 4, '2026-04-02 12:10:00', '2026-04-02 13:05:00', 30),
    (5, 5, '2026-04-03 09:00:00', '2026-04-03 10:30:00', 65),
    (6, 1, '2026-04-01 10:00:00', '2026-04-01 11:00:00', 88),
    (7, 2, '2026-04-01 10:05:00', '2026-04-01 11:02:00', 37),
    (8, 3, '2026-04-02 12:00:00', '2026-04-02 13:15:00', 100),
    (9, 4, '2026-04-02 12:10:00', '2026-04-02 13:05:00', 33),
    (10, 5, '2026-04-03 09:00:00', '2026-04-03 10:30:00', 76);


-- PROGRAMMING FUNDAMENTALS QUESTIONS
INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (1, 'What is a variable?', 'MCQ', 1);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a variable?'), 'A storage location', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a variable?'), 'A loop', 2),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a variable?'), 'A function', 3),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a variable?'), 'A data type', 4);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
    (SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a variable?'),
    (SELECT OptionID FROM Choice WHERE OptionText = 'A storage location' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a variable?'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
1,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a variable?'),
(SELECT OptionID FROM Choice 
WHERE OptionText = 'A storage location' 
AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a variable?'))
);




INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
6,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a variable?'),
(SELECT OptionID FROM Choice 
WHERE OptionText = 'A function' 
AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a variable?'))
);
-------------------------------------------------------------------------------------------------------------------------------------------------------------------






INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (1, 'Which of the following is a loop structure?', 'MCQ', 1);

INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'Which of the following is a loop structure?'), 'If', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'Which of the following is a loop structure?'), 'For', 2),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'Which of the following is a loop structure?'), 'Switch', 3),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'Which of the following is a loop structure?'), 'Return', 4);

INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
    (SELECT QuestionID FROM Questions WHERE QuestionText = 'Which of the following is a loop structure?'),
    (SELECT OptionID FROM Choice WHERE OptionText = 'For' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'Which of the following is a loop structure?'))
);


INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
1,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'Which of the following is a loop structure?'),
(SELECT OptionID FROM Choice 
WHERE OptionText = 'For' 
AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'Which of the following is a loop structure?'))
);



INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
6,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'Which of the following is a loop structure?'),
(SELECT OptionID FROM Choice 
WHERE OptionText = 'Switch' 
AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'Which of the following is a loop structure?'))
);


--------------------------------------------------------------------------------------------------------------------------------------------



INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (1, 'What does IDE stand for?', 'MCQ', 1);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What does IDE stand for?'), 'Internal Design Engine', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What does IDE stand for?'), 'Integrated Development Environment', 2),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What does IDE stand for?'), 'Interactive Data Execution', 3),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What does IDE stand for?'), 'Internet Development Engine', 4);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
    (SELECT QuestionID FROM Questions WHERE QuestionText = 'What does IDE stand for?'),
    (SELECT OptionID FROM Choice WHERE OptionText = 'Integrated Development Environment' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What does IDE stand for?'))
);


INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
1,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'What does IDE stand for?'),
(SELECT OptionID FROM Choice 
WHERE OptionText = 'Integrated Development Environment' 
AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What does IDE stand for?'))
);


INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
6,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'What does IDE stand for?'),
(SELECT OptionID FROM Choice 
WHERE OptionText = 'Internal Design Engine' 
AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What does IDE stand for?'))
);



------------------------------------------------------------------------------------------
INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (1, 'Which data type is used for text?', 'MCQ', 1);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'Which data type is used for text?'), 'Integer', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'Which data type is used for text?'), 'Float', 2),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'Which data type is used for text?'), 'String', 3),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'Which data type is used for text?'), 'Boolean', 4);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
    (SELECT QuestionID FROM Questions WHERE QuestionText = 'Which data type is used for text?'),
    (SELECT OptionID FROM Choice WHERE OptionText = 'String' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'Which data type is used for text?'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
1,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'Which data type is used for text?'),
(SELECT OptionID FROM Choice 
WHERE OptionText = 'Integer' 
AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'Which data type is used for text?'))
);


INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
6,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'Which data type is used for text?'),
(SELECT OptionID FROM Choice 
WHERE OptionText = 'String' 
AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'Which data type is used for text?'))
);

------------------------------------------------------------------------------------------------------------------------
INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (1, 'What is the output of 5 modulo 2?', 'MCQ', 1);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What is the output of 5 modulo 2?'), '1', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What is the output of 5 modulo 2?'), '2', 2),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What is the output of 5 modulo 2?'), '2.5', 3),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What is the output of 5 modulo 2?'), '0', 4);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
    (SELECT QuestionID FROM Questions WHERE QuestionText = 'What is the output of 5 modulo 2?'),
    (SELECT OptionID FROM Choice WHERE OptionText = '1' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What is the output of 5 modulo 2?'))
);
INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
1,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'What is the output of 5 modulo 2?'),
(SELECT OptionID FROM Choice 
WHERE OptionText = '1' 
AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What is the output of 5 modulo 2?'))
);


INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
6,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'What is the output of 5 modulo 2?'),
(SELECT OptionID FROM Choice 
WHERE OptionText = '2.5' 
AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What is the output of 5 modulo 2?'))
);


-----------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (1, 'What is a function?', 'MCQ', 1);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a function?'), 'A reusable block of code', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a function?'), 'A hardware component', 2),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a function?'), 'A database table', 3),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a function?'), 'An operating system', 4);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
    (SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a function?'),
    (SELECT OptionID FROM Choice WHERE OptionText = 'A reusable block of code' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a function?'))
);


INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
1,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a function?'),
(SELECT OptionID FROM Choice 
WHERE OptionText = 'A reusable block of code' 
AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a function?'))
);
INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
6,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a function?'),
(SELECT OptionID FROM Choice 
WHERE OptionText = 'A reusable block of code' 
AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a function?'))
);
------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (1, 'Which symbol is typically used for assignment?', 'MCQ', 1);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'Which symbol is typically used for assignment?'), '==', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'Which symbol is typically used for assignment?'), '=', 2),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'Which symbol is typically used for assignment?'), '=>', 3),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'Which symbol is typically used for assignment?'), '<-', 4);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
    (SELECT QuestionID FROM Questions WHERE QuestionText = 'Which symbol is typically used for assignment?'),
    (SELECT OptionID FROM Choice WHERE OptionText = '=' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'Which symbol is typically used for assignment?'))
);
INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
1,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'Which symbol is typically used for assignment?'),
(SELECT OptionID FROM Choice WHERE OptionText = '=' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'Which symbol is typically used for assignment?'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
6,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'Which symbol is typically used for assignment?'),
(SELECT OptionID FROM Choice WHERE OptionText = '==' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'Which symbol is typically used for assignment?'))
);
-------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (1, 'What is an array?', 'MCQ', 1);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What is an array?'), 'A single variable', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What is an array?'), 'A collection of elements', 2),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What is an array?'), 'A mathematical operator', 3),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What is an array?'), 'A styling method', 4);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
    (SELECT QuestionID FROM Questions WHERE QuestionText = 'What is an array?'),
    (SELECT OptionID FROM Choice WHERE OptionText = 'A collection of elements' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What is an array?'))
);
INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
1,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'What is an array?'),
(SELECT OptionID FROM Choice WHERE OptionText = 'A collection of elements' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What is an array?'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
6,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'What is an array?'),
(SELECT OptionID FROM Choice WHERE OptionText = 'A collection of elements' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What is an array?'))
);
---------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (1, 'What does boolean mean?', 'MCQ', 1);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What does boolean mean?'), 'Text only', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What does boolean mean?'), 'Numbers only', 2),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What does boolean mean?'), 'True or False', 3),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What does boolean mean?'), 'Empty value', 4);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
    (SELECT QuestionID FROM Questions WHERE QuestionText = 'What does boolean mean?'),
    (SELECT OptionID FROM Choice WHERE OptionText = 'True or False' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What does boolean mean?'))
);


INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
1,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'What does boolean mean?'),
(SELECT OptionID FROM Choice WHERE OptionText = 'Numbers only' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What does boolean mean?'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
6,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'What does boolean mean?'),
(SELECT OptionID FROM Choice WHERE OptionText = 'True or False' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What does boolean mean?'))
);
----------------------------------------------------------------------------------------------------------------------------------------------------
INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (1, 'Which is a conditional statement?', 'MCQ', 1);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'Which is a conditional statement?'), 'If', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'Which is a conditional statement?'), 'Loop', 2),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'Which is a conditional statement?'), 'Print', 3),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'Which is a conditional statement?'), 'Declare', 4);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
    (SELECT QuestionID FROM Questions WHERE QuestionText = 'Which is a conditional statement?'),
    (SELECT OptionID FROM Choice WHERE OptionText = 'If' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'Which is a conditional statement?'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
1,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'Which is a conditional statement?'),
(SELECT OptionID FROM Choice WHERE OptionText = 'If' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'Which is a conditional statement?'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
6,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'Which is a conditional statement?'),
(SELECT OptionID FROM Choice WHERE OptionText = 'Loop' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'Which is a conditional statement?'))
);
--------------------------------------------------------------------------------------------------------------------------------------------------------
-- Q1 (EN / TF)
INSERT INTO Questions (CourseID, QuestionText, Type, Points) 
VALUES (1, 'A variable can store different values during program execution.', 'TF', 10);

INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'A variable can store different values during program execution.'), 'True', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'A variable can store different values during program execution.'), 'False', 2);

INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
(SELECT QuestionID FROM Questions WHERE QuestionText = 'A variable can store different values during program execution.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'True' 
AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'A variable can store different values during program execution.'))
);
INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
1,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'A variable can store different values during program execution.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'True' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'A variable can store different values during program execution.'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
6,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'A variable can store different values during program execution.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'True' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'A variable can store different values during program execution.'))
);



---------------------------------------------------------------------------------------------------------------------------------------------------------------



-- Q2 (AR / TF)
INSERT INTO Questions (CourseID, QuestionText, Type, Points) 
VALUES (1, 'المتغير لا يمكن تغيير قيمته أثناء تنفيذ البرنامج.', 'TF', 10);

INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'المتغير لا يمكن تغيير قيمته أثناء تنفيذ البرنامج.'), 'صح', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'المتغير لا يمكن تغيير قيمته أثناء تنفيذ البرنامج.'), 'خطأ', 2);

INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
(SELECT QuestionID FROM Questions WHERE QuestionText = 'المتغير لا يمكن تغيير قيمته أثناء تنفيذ البرنامج.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'خطأ' 
AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'المتغير لا يمكن تغيير قيمته أثناء تنفيذ البرنامج.'))
);
INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
1,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'المتغير لا يمكن تغيير قيمته أثناء تنفيذ البرنامج.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'صح' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'المتغير لا يمكن تغيير قيمته أثناء تنفيذ البرنامج.'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
6,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'المتغير لا يمكن تغيير قيمته أثناء تنفيذ البرنامج.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'خطأ' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'المتغير لا يمكن تغيير قيمته أثناء تنفيذ البرنامج.'))
);
-----------------------------------------------------------------------------------------------------------------------------------------------------------------



-- Q3 (EN / TF)
INSERT INTO Questions (CourseID, QuestionText, Type, Points) 
VALUES (1, 'An if statement is used for decision making.', 'TF', 10);

INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'An if statement is used for decision making.'), 'True', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'An if statement is used for decision making.'), 'False', 2);

INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
(SELECT QuestionID FROM Questions WHERE QuestionText = 'An if statement is used for decision making.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'True' 
AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'An if statement is used for decision making.'))
);


INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
1,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'An if statement is used for decision making.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'True' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'An if statement is used for decision making.'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
6,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'An if statement is used for decision making.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'True' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'An if statement is used for decision making.'))
);
------------------------------------------------------------------------------------------------------------------------------------------------------------------------



-- Q4 (AR / TF)
INSERT INTO Questions (CourseID, QuestionText, Type, Points) 
VALUES (1, 'الحلقة for تُستخدم لتكرار تنفيذ مجموعة من الأوامر.', 'TF', 10);

INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'الحلقة for تُستخدم لتكرار تنفيذ مجموعة من الأوامر.'), 'صح', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'الحلقة for تُستخدم لتكرار تنفيذ مجموعة من الأوامر.'), 'خطأ', 2);

INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
(SELECT QuestionID FROM Questions WHERE QuestionText = 'الحلقة for تُستخدم لتكرار تنفيذ مجموعة من الأوامر.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'صح' 
AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'الحلقة for تُستخدم لتكرار تنفيذ مجموعة من الأوامر.'))
);
INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
1,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'الحلقة for تُستخدم لتكرار تنفيذ مجموعة من الأوامر.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'صح' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'الحلقة for تُستخدم لتكرار تنفيذ مجموعة من الأوامر.'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
6,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'الحلقة for تُستخدم لتكرار تنفيذ مجموعة من الأوامر.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'خطأ' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'الحلقة for تُستخدم لتكرار تنفيذ مجموعة من الأوامر.'))
);
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Q5 (EN / TF)
INSERT INTO Questions (CourseID, QuestionText, Type, Points) 
VALUES (1, 'A function can return more than one value directly.', 'TF', 10);

INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'A function can return more than one value directly.'), 'True', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'A function can return more than one value directly.'), 'False', 2);

INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
(SELECT QuestionID FROM Questions WHERE QuestionText = 'A function can return more than one value directly.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'False' 
AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'A function can return more than one value directly.'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
1,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'A function can return more than one value directly.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'True' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'A function can return more than one value directly.'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
6,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'A function can return more than one value directly.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'True' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'A function can return more than one value directly.'))
);


----------------------------------------------------------------------------------------------------------------------------------------------------------
-- DATA STRUCTURES QUESTIONS

INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (2, 'What is a Stack?', 'MCQ', 1);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a Stack?'), 'A FIFO data structure', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a Stack?'), 'A LIFO data structure', 2),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a Stack?'), 'A hierarchical database', 3),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a Stack?'), 'A sorting algorithm', 4);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
    (SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a Stack?'),
    (SELECT OptionID FROM Choice WHERE OptionText = 'A LIFO data structure' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a Stack?'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
2,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a Stack?'),
(SELECT OptionID FROM Choice WHERE OptionText = 'A LIFO data structure' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a Stack?'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
7,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a Stack?'),
(SELECT OptionID FROM Choice WHERE OptionText = 'A FIFO data structure' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a Stack?'))
);
---------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (2, 'Which data structure uses FIFO?', 'MCQ', 1);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'Which data structure uses FIFO?'), 'Stack', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'Which data structure uses FIFO?'), 'Tree', 2),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'Which data structure uses FIFO?'), 'Queue', 3),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'Which data structure uses FIFO?'), 'Graph', 4);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
    (SELECT QuestionID FROM Questions WHERE QuestionText = 'Which data structure uses FIFO?'),
    (SELECT OptionID FROM Choice WHERE OptionText = 'Queue' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'Which data structure uses FIFO?'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
2,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'Which data structure uses FIFO?'),
(SELECT OptionID FROM Choice WHERE OptionText = 'Queue' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'Which data structure uses FIFO?'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
7,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'Which data structure uses FIFO?'),
(SELECT OptionID FROM Choice WHERE OptionText = 'Queue' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'Which data structure uses FIFO?'))
);
---------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (2, 'What is a linked list?', 'MCQ', 1);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a linked list?'), 'Nodes with data and pointers', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a linked list?'), 'A static array', 2),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a linked list?'), 'A binary search tree', 3),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a linked list?'), 'A hash function', 4);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
    (SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a linked list?'),
    (SELECT OptionID FROM Choice WHERE OptionText = 'Nodes with data and pointers' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a linked list?'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
2,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a linked list?'),
(SELECT OptionID FROM Choice WHERE OptionText = 'A static array' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a linked list?'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
7,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a linked list?'),
(SELECT OptionID FROM Choice WHERE OptionText = 'Nodes with data and pointers' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a linked list?'))
);
---------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (2, 'What is the time complexity of binary search?', 'MCQ', 1);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What is the time complexity of binary search?'), 'O(n)', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What is the time complexity of binary search?'), 'O(n log n)', 2),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What is the time complexity of binary search?'), 'O(1)', 3),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What is the time complexity of binary search?'), 'O(log n)', 4);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
    (SELECT QuestionID FROM Questions WHERE QuestionText = 'What is the time complexity of binary search?'),
    (SELECT OptionID FROM Choice WHERE OptionText = 'O(log n)' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What is the time complexity of binary search?'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
2,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'What is the time complexity of binary search?'),
(SELECT OptionID FROM Choice WHERE OptionText = 'O(log n)' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What is the time complexity of binary search?'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
7,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'What is the time complexity of binary search?'),
(SELECT OptionID FROM Choice WHERE OptionText = 'O(n)' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What is the time complexity of binary search?'))
);
---------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (2, 'What is a binary tree?', 'MCQ', 1);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a binary tree?'), 'A tree with infinite children', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a binary tree?'), 'A tree with at most two children', 2),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a binary tree?'), 'A linear data structure', 3),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a binary tree?'), 'A complete graph', 4);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
    (SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a binary tree?'),
    (SELECT OptionID FROM Choice WHERE OptionText = 'A tree with at most two children' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a binary tree?'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
2,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a binary tree?'),
(SELECT OptionID FROM Choice WHERE OptionText = 'A tree with at most two children' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a binary tree?'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
7,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a binary tree?'),
(SELECT OptionID FROM Choice WHERE OptionText = 'A tree with at most two children' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a binary tree?'))
);
---------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (2, 'Which data structure is best for hierarchical data?', 'MCQ', 1);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'Which data structure is best for hierarchical data?'), 'Array', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'Which data structure is best for hierarchical data?'), 'Queue', 2),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'Which data structure is best for hierarchical data?'), 'Tree', 3),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'Which data structure is best for hierarchical data?'), 'Stack', 4);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
    (SELECT QuestionID FROM Questions WHERE QuestionText = 'Which data structure is best for hierarchical data?'),
    (SELECT OptionID FROM Choice WHERE OptionText = 'Tree' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'Which data structure is best for hierarchical data?'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
2,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'Which data structure is best for hierarchical data?'),
(SELECT OptionID FROM Choice WHERE OptionText = 'Array' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'Which data structure is best for hierarchical data?'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
7,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'Which data structure is best for hierarchical data?'),
(SELECT OptionID FROM Choice WHERE OptionText = 'Tree' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'Which data structure is best for hierarchical data?'))
);

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (2, 'What does a graph consist of?', 'MCQ', 1);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What does a graph consist of?'), 'Only edges', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What does a graph consist of?'), 'Verticies and Edges', 2),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What does a graph consist of?'), 'Rows and Columns', 3),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What does a graph consist of?'), 'Tables and Keys', 4);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
    (SELECT QuestionID FROM Questions WHERE QuestionText = 'What does a graph consist of?'),
    (SELECT OptionID FROM Choice WHERE OptionText = 'Verticies and Edges' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What does a graph consist of?'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
2,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'What does a graph consist of?'),
(SELECT OptionID FROM Choice WHERE OptionText = 'Verticies and Edges' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What does a graph consist of?'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
7,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'What does a graph consist of?'),
(SELECT OptionID FROM Choice WHERE OptionText = 'Rows and Columns' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What does a graph consist of?'))
);

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (2, 'What is the main advantage of an array?', 'MCQ', 1);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What is the main advantage of an array?'), 'Dynamic sizing', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What is the main advantage of an array?'), 'Random access', 2),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What is the main advantage of an array?'), 'Fast insertion', 3),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What is the main advantage of an array?'), 'No memory usage', 4);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
    (SELECT QuestionID FROM Questions WHERE QuestionText = 'What is the main advantage of an array?'),
    (SELECT OptionID FROM Choice WHERE OptionText = 'Random access' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What is the main advantage of an array?'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
2,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'What is the main advantage of an array?'),
(SELECT OptionID FROM Choice WHERE OptionText = 'Random access' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What is the main advantage of an array?'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
7,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'What is the main advantage of an array?'),
(SELECT OptionID FROM Choice WHERE OptionText = 'Random access' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What is the main advantage of an array?'))
);

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (2, 'What is a hash table used for?', 'MCQ', 1);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a hash table used for?'), 'Sorting items', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a hash table used for?'), 'Fast key-value lookups', 2),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a hash table used for?'), 'Designing interfaces', 3),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a hash table used for?'), 'Compiling code', 4);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
    (SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a hash table used for?'),
    (SELECT OptionID FROM Choice WHERE OptionText = 'Fast key-value lookups' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a hash table used for?'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
2,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a hash table used for?'),
(SELECT OptionID FROM Choice WHERE OptionText = 'Sorting items' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a hash table used for?'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
7,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a hash table used for?'),
(SELECT OptionID FROM Choice WHERE OptionText = 'Fast key-value lookups' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a hash table used for?'))
);

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (2, 'Which sorting algorithm is typically fastest on average?', 'MCQ', 1);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'Which sorting algorithm is typically fastest on average?'), 'Bubble Sort', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'Which sorting algorithm is typically fastest on average?'), 'Selection Sort', 2),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'Which sorting algorithm is typically fastest on average?'), 'Quick Sort', 3),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'Which sorting algorithm is typically fastest on average?'), 'Insertion Sort', 4);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
    (SELECT QuestionID FROM Questions WHERE QuestionText = 'Which sorting algorithm is typically fastest on average?'),
    (SELECT OptionID FROM Choice WHERE OptionText = 'Quick Sort' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'Which sorting algorithm is typically fastest on average?'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
2,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'Which sorting algorithm is typically fastest on average?'),
(SELECT OptionID FROM Choice WHERE OptionText = 'Quick Sort' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'Which sorting algorithm is typically fastest on average?'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
7,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'Which sorting algorithm is typically fastest on average?'),
(SELECT OptionID FROM Choice WHERE OptionText = 'Bubble Sort' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'Which sorting algorithm is typically fastest on average?'))
);
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Q1 (EN / TF)
INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (2, 'A stack follows the LIFO principle.', 'TF', 10);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'A stack follows the LIFO principle.'), 'True', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'A stack follows the LIFO principle.'), 'False', 2);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
(SELECT QuestionID FROM Questions WHERE QuestionText = 'A stack follows the LIFO principle.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'True' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'A stack follows the LIFO principle.'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
2,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'A stack follows the LIFO principle.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'True' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'A stack follows the LIFO principle.'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
7,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'A stack follows the LIFO principle.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'True' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'A stack follows the LIFO principle.'))
);

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Q2 (AR / TF)

INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (2, 'الـ Queue تعمل بنظام FIFO.', 'TF', 10);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'الـ Queue تعمل بنظام FIFO.'), 'صح', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'الـ Queue تعمل بنظام FIFO.'), 'خطأ', 2);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
(SELECT QuestionID FROM Questions WHERE QuestionText = 'الـ Queue تعمل بنظام FIFO.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'صح' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'الـ Queue تعمل بنظام FIFO.'))
);
INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
2,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'الـ Queue تعمل بنظام FIFO.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'خطأ' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'الـ Queue تعمل بنظام FIFO.'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
7,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'الـ Queue تعمل بنظام FIFO.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'صح' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'الـ Queue تعمل بنظام FIFO.'))
);
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- Q3 (EN / TF)
INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (2, 'An array has a fixed size.', 'TF', 10);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'An array has a fixed size.'), 'True', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'An array has a fixed size.'), 'False', 2);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
(SELECT QuestionID FROM Questions WHERE QuestionText = 'An array has a fixed size.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'True' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'An array has a fixed size.'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
2,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'An array has a fixed size.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'True' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'An array has a fixed size.'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
7,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'An array has a fixed size.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'True' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'An array has a fixed size.'))
);
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------



-- Q4 (AR / TF)
INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (2, 'Linked List تسمح بتغيير الحجم ديناميكياً.', 'TF', 10);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'Linked List تسمح بتغيير الحجم ديناميكياً.'), 'صح', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'Linked List تسمح بتغيير الحجم ديناميكياً.'), 'خطأ', 2);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
(SELECT QuestionID FROM Questions WHERE QuestionText = 'Linked List تسمح بتغيير الحجم ديناميكياً.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'صح' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'Linked List تسمح بتغيير الحجم ديناميكياً.'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
2,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'Linked List تسمح بتغيير الحجم ديناميكياً.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'صح' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'Linked List تسمح بتغيير الحجم ديناميكياً.'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
7,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'Linked List تسمح بتغيير الحجم ديناميكياً.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'خطأ' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'Linked List تسمح بتغيير الحجم ديناميكياً.'))
);

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Q5 (EN / TF)
INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (2, 'A tree data structure has a root node.', 'TF', 10);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'A tree data structure has a root node.'), 'True', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'A tree data structure has a root node.'), 'False', 2);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
(SELECT QuestionID FROM Questions WHERE QuestionText = 'A tree data structure has a root node.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'True' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'A tree data structure has a root node.'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
2,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'A tree data structure has a root node.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'False' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'A tree data structure has a root node.'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
7,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'A tree data structure has a root node.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'True' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'A tree data structure has a root node.'))
);
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------
-- COURSE 3: DATABASE (10 Questions: Mix EN/AR, MCQ/TF)
---------------------------------------------------------

-- 1 (EN / MCQ)
INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (3, 'What is a Primary Key in a database?', 'MCQ', 10);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a Primary Key in a database?'), 'A unique identifier for a record', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a Primary Key in a database?'), 'A duplicate value', 2),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a Primary Key in a database?'), 'A network protocol', 3),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a Primary Key in a database?'), 'A storage device', 4);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
    (SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a Primary Key in a database?'),
    (SELECT OptionID FROM Choice WHERE OptionText = 'A unique identifier for a record' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a Primary Key in a database?'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
3,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a Primary Key in a database?'),
(SELECT OptionID FROM Choice WHERE OptionText = 'A unique identifier for a record' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a Primary Key in a database?'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
8,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a Primary Key in a database?'),
(SELECT OptionID FROM Choice WHERE OptionText = 'A duplicate value' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What is a Primary Key in a database?'))
);
-------------------------------------------------------------------------------------------------------------------------------------------------------

-- 2 (AR / MCQ)
INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (3, 'ماذا تعني اختصار RDBMS؟', 'MCQ', 10);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'ماذا تعني اختصار RDBMS؟'), 'Random Database Management System', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'ماذا تعني اختصار RDBMS؟'), 'Relational Database Management System', 2),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'ماذا تعني اختصار RDBMS؟'), 'Real Data Backup Management System', 3),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'ماذا تعني اختصار RDBMS؟'), 'Row Data Base Management System', 4);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
    (SELECT QuestionID FROM Questions WHERE QuestionText = 'ماذا تعني اختصار RDBMS؟'),
    (SELECT OptionID FROM Choice WHERE OptionText = 'Relational Database Management System' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'ماذا تعني اختصار RDBMS؟'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
3,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'ماذا تعني اختصار RDBMS؟'),
(SELECT OptionID FROM Choice WHERE OptionText = 'Relational Database Management System' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'ماذا تعني اختصار RDBMS؟'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
8,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'ماذا تعني اختصار RDBMS؟'),
(SELECT OptionID FROM Choice WHERE OptionText = 'Relational Database Management System' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'ماذا تعني اختصار RDBMS؟'))
);

-------------------------------------------------------------------------------------------------------------------------------------------------------

-- 3 (EN / TF)
INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (3, 'SQL stands for Structured Query Language.', 'TF', 10);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'SQL stands for Structured Query Language.'), 'True', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'SQL stands for Structured Query Language.'), 'False', 2);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
    (SELECT QuestionID FROM Questions WHERE QuestionText = 'SQL stands for Structured Query Language.'),
    (SELECT OptionID FROM Choice WHERE OptionText = 'True' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'SQL stands for Structured Query Language.'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
3,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'SQL stands for Structured Query Language.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'False' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'SQL stands for Structured Query Language.'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
8,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'SQL stands for Structured Query Language.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'True' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'SQL stands for Structured Query Language.'))
);

--------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 4 (AR / TF)
INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (3, 'المفتاح الأجنبي (Foreign Key) لا يمكن أن يحتوي على قيم فارغة (NULL) نهائيا.', 'TF', 10);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'المفتاح الأجنبي (Foreign Key) لا يمكن أن يحتوي على قيم فارغة (NULL) نهائيا.'), 'صح', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'المفتاح الأجنبي (Foreign Key) لا يمكن أن يحتوي على قيم فارغة (NULL) نهائيا.'), 'خطأ', 2);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
    (SELECT QuestionID FROM Questions WHERE QuestionText = 'المفتاح الأجنبي (Foreign Key) لا يمكن أن يحتوي على قيم فارغة (NULL) نهائيا.'),
    (SELECT OptionID FROM Choice WHERE OptionText = 'خطأ' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'المفتاح الأجنبي (Foreign Key) لا يمكن أن يحتوي على قيم فارغة (NULL) نهائيا.'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
3,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'المفتاح الأجنبي (Foreign Key) لا يمكن أن يحتوي على قيم فارغة (NULL) نهائيا.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'خطأ' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'المفتاح الأجنبي (Foreign Key) لا يمكن أن يحتوي على قيم فارغة (NULL) نهائيا.'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
8,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'المفتاح الأجنبي (Foreign Key) لا يمكن أن يحتوي على قيم فارغة (NULL) نهائيا.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'صح' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'المفتاح الأجنبي (Foreign Key) لا يمكن أن يحتوي على قيم فارغة (NULL) نهائيا.'))
);

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 5 (EN / MCQ)
INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (3, 'Which SQL command is used to remove a table entirely from the database?', 'MCQ', 10);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'Which SQL command is used to remove a table entirely from the database?'), 'DELETE', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'Which SQL command is used to remove a table entirely from the database?'), 'TRUNCATE', 2),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'Which SQL command is used to remove a table entirely from the database?'), 'DROP', 3),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'Which SQL command is used to remove a table entirely from the database?'), 'REMOVE', 4);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
    (SELECT QuestionID FROM Questions WHERE QuestionText = 'Which SQL command is used to remove a table entirely from the database?'),
    (SELECT OptionID FROM Choice WHERE OptionText = 'DROP' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'Which SQL command is used to remove a table entirely from the database?'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
3,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'Which SQL command is used to remove a table entirely from the database?'),
(SELECT OptionID FROM Choice WHERE OptionText = 'DELETE' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'Which SQL command is used to remove a table entirely from the database?'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
8,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'Which SQL command is used to remove a table entirely from the database?'),
(SELECT OptionID FROM Choice WHERE OptionText = 'DROP' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'Which SQL command is used to remove a table entirely from the database?'))
);

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 6 (AR / MCQ)
INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (3, 'أي من الأوامر التالية يستخدم لتحديث البيانات الموجودة في جدول؟', 'MCQ', 10);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'أي من الأوامر التالية يستخدم لتحديث البيانات الموجودة في جدول؟'), 'INSERT', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'أي من الأوامر التالية يستخدم لتحديث البيانات الموجودة في جدول؟'), 'UPDATE', 2),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'أي من الأوامر التالية يستخدم لتحديث البيانات الموجودة في جدول؟'), 'ALTER', 3),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'أي من الأوامر التالية يستخدم لتحديث البيانات الموجودة في جدول؟'), 'MODIFY', 4);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
    (SELECT QuestionID FROM Questions WHERE QuestionText = 'أي من الأوامر التالية يستخدم لتحديث البيانات الموجودة في جدول؟'),
    (SELECT OptionID FROM Choice WHERE OptionText = 'UPDATE' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'أي من الأوامر التالية يستخدم لتحديث البيانات الموجودة في جدول؟'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
3,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'أي من الأوامر التالية يستخدم لتحديث البيانات الموجودة في جدول؟'),
(SELECT OptionID FROM Choice WHERE OptionText = 'UPDATE' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'أي من الأوامر التالية يستخدم لتحديث البيانات الموجودة في جدول؟'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
8,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'أي من الأوامر التالية يستخدم لتحديث البيانات الموجودة في جدول؟'),
(SELECT OptionID FROM Choice WHERE OptionText = 'UPDATE' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'أي من الأوامر التالية يستخدم لتحديث البيانات الموجودة في جدول؟'))
);

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 7 (EN / TF)
INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (3, 'A View in SQL contains its own physical data.', 'TF', 10);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'A View in SQL contains its own physical data.'), 'True', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'A View in SQL contains its own physical data.'), 'False', 2);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
    (SELECT QuestionID FROM Questions WHERE QuestionText = 'A View in SQL contains its own physical data.'),
    (SELECT OptionID FROM Choice WHERE OptionText = 'False' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'A View in SQL contains its own physical data.'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
3,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'A View in SQL contains its own physical data.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'False' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'A View in SQL contains its own physical data.'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
8,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'A View in SQL contains its own physical data.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'True' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'A View in SQL contains its own physical data.'))
);

---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 8 (AR / TF)
INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (3, 'أمر COMMIT يحفظ التغييرات بشكل نهائي في قاعدة البيانات.', 'TF', 10);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'أمر COMMIT يحفظ التغييرات بشكل نهائي في قاعدة البيانات.'), 'صح', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'أمر COMMIT يحفظ التغييرات بشكل نهائي في قاعدة البيانات.'), 'خطأ', 2);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
    (SELECT QuestionID FROM Questions WHERE QuestionText = 'أمر COMMIT يحفظ التغييرات بشكل نهائي في قاعدة البيانات.'),
    (SELECT OptionID FROM Choice WHERE OptionText = 'صح' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'أمر COMMIT يحفظ التغييرات بشكل نهائي في قاعدة البيانات.'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
3,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'أمر COMMIT يحفظ التغييرات بشكل نهائي في قاعدة البيانات.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'صح' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'أمر COMMIT يحفظ التغييرات بشكل نهائي في قاعدة البيانات.'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
8,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'أمر COMMIT يحفظ التغييرات بشكل نهائي في قاعدة البيانات.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'صح' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'أمر COMMIT يحفظ التغييرات بشكل نهائي في قاعدة البيانات.'))
);

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 9 (EN / MCQ)

INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (3, 'What does the INNER JOIN do?', 'MCQ', 10);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What does the INNER JOIN do?'), 'Returns all records from both tables', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What does the INNER JOIN do?'), 'Returns only matched records from both tables', 2),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What does the INNER JOIN do?'), 'Returns records from the left table only', 3),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What does the INNER JOIN do?'), 'Deletes matching records', 4);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
    (SELECT QuestionID FROM Questions WHERE QuestionText = 'What does the INNER JOIN do?'),
    (SELECT OptionID FROM Choice WHERE OptionText = 'Returns only matched records from both tables' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What does the INNER JOIN do?'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
3,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'What does the INNER JOIN do?'),
(SELECT OptionID FROM Choice WHERE OptionText = 'Returns all records from both tables' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What does the INNER JOIN do?'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
8,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'What does the INNER JOIN do?'),
(SELECT OptionID FROM Choice WHERE OptionText = 'Returns only matched records from both tables' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What does the INNER JOIN do?'))
);
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 10 (AR / TF)
INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (3, 'لغة DDL تستخدم للتحكم في صلاحيات المستخدمين.', 'TF', 10);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'لغة DDL تستخدم للتحكم في صلاحيات المستخدمين.'), 'صح', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'لغة DDL تستخدم للتحكم في صلاحيات المستخدمين.'), 'خطأ', 2);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
    (SELECT QuestionID FROM Questions WHERE QuestionText = 'لغة DDL تستخدم للتحكم في صلاحيات المستخدمين.'),
    (SELECT OptionID FROM Choice WHERE OptionText = 'خطأ' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'لغة DDL تستخدم للتحكم في صلاحيات المستخدمين.'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
3,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'لغة DDL تستخدم للتحكم في صلاحيات المستخدمين.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'خطأ' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'لغة DDL تستخدم للتحكم في صلاحيات المستخدمين.'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
8,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'لغة DDL تستخدم للتحكم في صلاحيات المستخدمين.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'صح' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'لغة DDL تستخدم للتحكم في صلاحيات المستخدمين.'))
);
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------
-- COURSE 4: OPERATING SYSTEM (10 Questions: Mix EN/AR, MCQ/TF)
---------------------------------------------------------

-- 1 (EN / MCQ)
INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (4, 'What is the core component of a Linux Operating System called?', 'MCQ', 10);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What is the core component of a Linux Operating System called?'), 'Shell', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What is the core component of a Linux Operating System called?'), 'Kernel', 2),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What is the core component of a Linux Operating System called?'), 'Terminal', 3),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What is the core component of a Linux Operating System called?'), 'GUI', 4);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
    (SELECT QuestionID FROM Questions WHERE QuestionText = 'What is the core component of a Linux Operating System called?'),
    (SELECT OptionID FROM Choice WHERE OptionText = 'Kernel' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What is the core component of a Linux Operating System called?'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
4,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'What is the core component of a Linux Operating System called?'),
(SELECT OptionID FROM Choice WHERE OptionText = 'Kernel' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What is the core component of a Linux Operating System called?'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
9,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'What is the core component of a Linux Operating System called?'),
(SELECT OptionID FROM Choice WHERE OptionText = 'Shell' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What is the core component of a Linux Operating System called?'))
);

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 2 (AR / MCQ)
INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (4, 'ما هي وظيفة الـ RAM الأساسية في نظام التشغيل؟', 'MCQ', 10);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'ما هي وظيفة الـ RAM الأساسية في نظام التشغيل؟'), 'تخزين البيانات بشكل دائم', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'ما هي وظيفة الـ RAM الأساسية في نظام التشغيل؟'), 'معالجة الرسوميات', 2),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'ما هي وظيفة الـ RAM الأساسية في نظام التشغيل؟'), 'تخزين البيانات والبرامج قيد التشغيل مؤقتاً', 3),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'ما هي وظيفة الـ RAM الأساسية في نظام التشغيل؟'), 'تبريد المعالج', 4);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
    (SELECT QuestionID FROM Questions WHERE QuestionText = 'ما هي وظيفة الـ RAM الأساسية في نظام التشغيل؟'),
    (SELECT OptionID FROM Choice WHERE OptionText = 'تخزين البيانات والبرامج قيد التشغيل مؤقتاً' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'ما هي وظيفة الـ RAM الأساسية في نظام التشغيل؟'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
4,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'ما هي وظيفة الـ RAM الأساسية في نظام التشغيل؟'),
(SELECT OptionID FROM Choice WHERE OptionText = 'تخزين البيانات والبرامج قيد التشغيل مؤقتاً' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'ما هي وظيفة الـ RAM الأساسية في نظام التشغيل؟'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
9,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'ما هي وظيفة الـ RAM الأساسية في نظام التشغيل؟'),
(SELECT OptionID FROM Choice WHERE OptionText = 'تخزين البيانات والبرامج قيد التشغيل مؤقتاً' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'ما هي وظيفة الـ RAM الأساسية في نظام التشغيل؟'))
);

------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 3 (EN / TF)
INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (4, 'Ubuntu is an open-source operating system based on Debian.', 'TF', 10);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'Ubuntu is an open-source operating system based on Debian.'), 'True', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'Ubuntu is an open-source operating system based on Debian.'), 'False', 2);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
    (SELECT QuestionID FROM Questions WHERE QuestionText = 'Ubuntu is an open-source operating system based on Debian.'),
    (SELECT OptionID FROM Choice WHERE OptionText = 'True' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'Ubuntu is an open-source operating system based on Debian.'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
4,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'Ubuntu is an open-source operating system based on Debian.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'False' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'Ubuntu is an open-source operating system based on Debian.'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
9,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'Ubuntu is an open-source operating system based on Debian.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'True' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'Ubuntu is an open-source operating system based on Debian.'))
);

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 4 (AR / TF)
INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (4, 'نظام التشغيل هو البرنامج الوسيط بين المستخدم وعتاد الحاسوب (Hardware).', 'TF', 10);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'نظام التشغيل هو البرنامج الوسيط بين المستخدم وعتاد الحاسوب (Hardware).'), 'صح', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'نظام التشغيل هو البرنامج الوسيط بين المستخدم وعتاد الحاسوب (Hardware).'), 'خطأ', 2);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
    (SELECT QuestionID FROM Questions WHERE QuestionText = 'نظام التشغيل هو البرنامج الوسيط بين المستخدم وعتاد الحاسوب (Hardware).'),
    (SELECT OptionID FROM Choice WHERE OptionText = 'صح' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'نظام التشغيل هو البرنامج الوسيط بين المستخدم وعتاد الحاسوب (Hardware).'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
4,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'نظام التشغيل هو البرنامج الوسيط بين المستخدم وعتاد الحاسوب (Hardware).'),
(SELECT OptionID FROM Choice WHERE OptionText = 'صح' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'نظام التشغيل هو البرنامج الوسيط بين المستخدم وعتاد الحاسوب (Hardware).'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
9,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'نظام التشغيل هو البرنامج الوسيط بين المستخدم وعتاد الحاسوب (Hardware).'),
(SELECT OptionID FROM Choice WHERE OptionText = 'خطأ' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'نظام التشغيل هو البرنامج الوسيط بين المستخدم وعتاد الحاسوب (Hardware).'))
);

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------


-- 5 (EN / MCQ)
INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (4, 'Which command is used in Bash to print the current working directory?', 'MCQ', 10);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'Which command is used in Bash to print the current working directory?'), 'ls', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'Which command is used in Bash to print the current working directory?'), 'pwd', 2),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'Which command is used in Bash to print the current working directory?'), 'cd', 3),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'Which command is used in Bash to print the current working directory?'), 'mkdir', 4);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
    (SELECT QuestionID FROM Questions WHERE QuestionText = 'Which command is used in Bash to print the current working directory?'),
    (SELECT OptionID FROM Choice WHERE OptionText = 'pwd' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'Which command is used in Bash to print the current working directory?'))
);
INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
4,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'Which command is used in Bash to print the current working directory?'),
(SELECT OptionID FROM Choice WHERE OptionText = 'ls' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'Which command is used in Bash to print the current working directory?'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
9,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'Which command is used in Bash to print the current working directory?'),
(SELECT OptionID FROM Choice WHERE OptionText = 'pwd' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'Which command is used in Bash to print the current working directory?'))
);
--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 6 (AR / MCQ)
INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (4, 'أي من خوارزميات الجدولة (Scheduling) تعتمد على إعطاء وقت محدد لكل عملية؟', 'MCQ', 10);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'أي من خوارزميات الجدولة (Scheduling) تعتمد على إعطاء وقت محدد لكل عملية؟'), 'First-Come, First-Served', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'أي من خوارزميات الجدولة (Scheduling) تعتمد على إعطاء وقت محدد لكل عملية؟'), 'Round Robin', 2),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'أي من خوارزميات الجدولة (Scheduling) تعتمد على إعطاء وقت محدد لكل عملية؟'), 'Shortest Job Next', 3),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'أي من خوارزميات الجدولة (Scheduling) تعتمد على إعطاء وقت محدد لكل عملية؟'), 'Priority Scheduling', 4);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
    (SELECT QuestionID FROM Questions WHERE QuestionText = 'أي من خوارزميات الجدولة (Scheduling) تعتمد على إعطاء وقت محدد لكل عملية؟'),
    (SELECT OptionID FROM Choice WHERE OptionText = 'Round Robin' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'أي من خوارزميات الجدولة (Scheduling) تعتمد على إعطاء وقت محدد لكل عملية؟'))
);
INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
4,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'أي من خوارزميات الجدولة (Scheduling) تعتمد على إعطاء وقت محدد لكل عملية؟'),
(SELECT OptionID FROM Choice WHERE OptionText = 'Round Robin' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'أي من خوارزميات الجدولة (Scheduling) تعتمد على إعطاء وقت محدد لكل عملية؟'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
9,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'أي من خوارزميات الجدولة (Scheduling) تعتمد على إعطاء وقت محدد لكل عملية؟'),
(SELECT OptionID FROM Choice WHERE OptionText = 'Round Robin' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'أي من خوارزميات الجدولة (Scheduling) تعتمد على إعطاء وقت محدد لكل عملية؟'))
);

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 7 (EN / TF)
INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (4, 'A process in an operating system is defined as a program in execution.', 'TF', 10);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'A process in an operating system is defined as a program in execution.'), 'True', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'A process in an operating system is defined as a program in execution.'), 'False', 2);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
    (SELECT QuestionID FROM Questions WHERE QuestionText = 'A process in an operating system is defined as a program in execution.'),
    (SELECT OptionID FROM Choice WHERE OptionText = 'True' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'A process in an operating system is defined as a program in execution.'))
);
INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
4,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'A process in an operating system is defined as a program in execution.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'True' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'A process in an operating system is defined as a program in execution.'))
);
INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
9,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'A process in an operating system is defined as a program in execution.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'False' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'A process in an operating system is defined as a program in execution.'))
);

----------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 8 (AR / TF)
INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (4, 'الـ Deadlock يحدث عندما تنتظر عمليتان أو أكثر بعضهما البعض إلى ما لا نهاية.', 'TF', 10);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'الـ Deadlock يحدث عندما تنتظر عمليتان أو أكثر بعضهما البعض إلى ما لا نهاية.'), 'صح', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'الـ Deadlock يحدث عندما تنتظر عمليتان أو أكثر بعضهما البعض إلى ما لا نهاية.'), 'خطأ', 2);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
    (SELECT QuestionID FROM Questions WHERE QuestionText = 'الـ Deadlock يحدث عندما تنتظر عمليتان أو أكثر بعضهما البعض إلى ما لا نهاية.'),
    (SELECT OptionID FROM Choice WHERE OptionText = 'صح' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'الـ Deadlock يحدث عندما تنتظر عمليتان أو أكثر بعضهما البعض إلى ما لا نهاية.'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
4,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'الـ Deadlock يحدث عندما تنتظر عمليتان أو أكثر بعضهما البعض إلى ما لا نهاية.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'صح' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'الـ Deadlock يحدث عندما تنتظر عمليتان أو أكثر بعضهما البعض إلى ما لا نهاية.'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
9,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'الـ Deadlock يحدث عندما تنتظر عمليتان أو أكثر بعضهما البعض إلى ما لا نهاية.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'صح' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'الـ Deadlock يحدث عندما تنتظر عمليتان أو أكثر بعضهما البعض إلى ما لا نهاية.'))
);

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 9 (EN / MCQ)
INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (4, 'What does GUI stand for in Operating Systems?', 'MCQ', 10);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What does GUI stand for in Operating Systems?'), 'General User Integration', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What does GUI stand for in Operating Systems?'), 'Graphical User Interface', 2),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What does GUI stand for in Operating Systems?'), 'Generic Universal Interface', 3),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What does GUI stand for in Operating Systems?'), 'Graphic Utility Index', 4);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
    (SELECT QuestionID FROM Questions WHERE QuestionText = 'What does GUI stand for in Operating Systems?'),
    (SELECT OptionID FROM Choice WHERE OptionText = 'Graphical User Interface' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What does GUI stand for in Operating Systems?'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
4,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'What does GUI stand for in Operating Systems?'),
(SELECT OptionID FROM Choice WHERE OptionText = 'General User Integration' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What does GUI stand for in Operating Systems?'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
9,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'What does GUI stand for in Operating Systems?'),
(SELECT OptionID FROM Choice WHERE OptionText = 'Graphical User Interface' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What does GUI stand for in Operating Systems?'))
);
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 10 (AR / TF)
INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (4, 'الـ Virtual Memory تستخدم جزء من القرص الصلب كأنها ذاكرة عشوائية (RAM) إضافية.', 'TF', 10);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'الـ Virtual Memory تستخدم جزء من القرص الصلب كأنها ذاكرة عشوائية (RAM) إضافية.'), 'صح', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'الـ Virtual Memory تستخدم جزء من القرص الصلب كأنها ذاكرة عشوائية (RAM) إضافية.'), 'خطأ', 2);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
    (SELECT QuestionID FROM Questions WHERE QuestionText = 'الـ Virtual Memory تستخدم جزء من القرص الصلب كأنها ذاكرة عشوائية (RAM) إضافية.'),
    (SELECT OptionID FROM Choice WHERE OptionText = 'صح' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'الـ Virtual Memory تستخدم جزء من القرص الصلب كأنها ذاكرة عشوائية (RAM) إضافية.'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
4,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'الـ Virtual Memory تستخدم جزء من القرص الصلب كأنها ذاكرة عشوائية (RAM) إضافية.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'صح' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'الـ Virtual Memory تستخدم جزء من القرص الصلب كأنها ذاكرة عشوائية (RAM) إضافية.'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
9,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'الـ Virtual Memory تستخدم جزء من القرص الصلب كأنها ذاكرة عشوائية (RAM) إضافية.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'خطأ' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'الـ Virtual Memory تستخدم جزء من القرص الصلب كأنها ذاكرة عشوائية (RAM) إضافية.'))
);
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---------------------------------------------------------
-- COURSE 5: NETWORK (10 Questions: Mix EN/AR, MCQ/TF)
---------------------------------------------------------

-- 1 (EN / MCQ)
INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (5, 'What does IP stand for in networking?', 'MCQ', 10);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What does IP stand for in networking?'), 'Internal Protocol', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What does IP stand for in networking?'), 'Internet Protocol', 2),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What does IP stand for in networking?'), 'Intranet Provider', 3),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What does IP stand for in networking?'), 'Internet Provider', 4);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
    (SELECT QuestionID FROM Questions WHERE QuestionText = 'What does IP stand for in networking?'),
    (SELECT OptionID FROM Choice WHERE OptionText = 'Internet Protocol' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What does IP stand for in networking?'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
5,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'What does IP stand for in networking?'),
(SELECT OptionID FROM Choice WHERE OptionText = 'Internet Protocol' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What does IP stand for in networking?'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
10,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'What does IP stand for in networking?'),
(SELECT OptionID FROM Choice WHERE OptionText = 'Internal Protocol' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What does IP stand for in networking?'))
);

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 2 (AR / MCQ)

INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (5, 'في أي طبقة (Layer) من نموذج OSI يعمل جهاز الـ Router؟', 'MCQ', 10);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'في أي طبقة (Layer) من نموذج OSI يعمل جهاز الـ Router؟'), 'Data Link Layer', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'في أي طبقة (Layer) من نموذج OSI يعمل جهاز الـ Router؟'), 'Network Layer', 2),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'في أي طبقة (Layer) من نموذج OSI يعمل جهاز الـ Router؟'), 'Transport Layer', 3),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'في أي طبقة (Layer) من نموذج OSI يعمل جهاز الـ Router؟'), 'Physical Layer', 4);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
    (SELECT QuestionID FROM Questions WHERE QuestionText = 'في أي طبقة (Layer) من نموذج OSI يعمل جهاز الـ Router؟'),
    (SELECT OptionID FROM Choice WHERE OptionText = 'Network Layer' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'في أي طبقة (Layer) من نموذج OSI يعمل جهاز الـ Router؟'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
5,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'في أي طبقة (Layer) من نموذج OSI يعمل جهاز الـ Router؟'),
(SELECT OptionID FROM Choice WHERE OptionText = 'Network Layer' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'في أي طبقة (Layer) من نموذج OSI يعمل جهاز الـ Router؟'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
10,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'في أي طبقة (Layer) من نموذج OSI يعمل جهاز الـ Router؟'),
(SELECT OptionID FROM Choice WHERE OptionText = 'Network Layer' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'في أي طبقة (Layer) من نموذج OSI يعمل جهاز الـ Router؟'))
);

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 3 (EN / TF)
INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (5, 'TCP is considered a connection-oriented protocol.', 'TF', 10);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'TCP is considered a connection-oriented protocol.'), 'True', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'TCP is considered a connection-oriented protocol.'), 'False', 2);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
    (SELECT QuestionID FROM Questions WHERE QuestionText = 'TCP is considered a connection-oriented protocol.'),
    (SELECT OptionID FROM Choice WHERE OptionText = 'True' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'TCP is considered a connection-oriented protocol.'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
5,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'TCP is considered a connection-oriented protocol.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'False' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'TCP is considered a connection-oriented protocol.'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
10,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'TCP is considered a connection-oriented protocol.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'True' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'TCP is considered a connection-oriented protocol.'))
);

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 4 (AR / TF)
INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (5, 'بروتوكول HTTP يستخدم منفذ (Port) رقم 80 افتراضياً.', 'TF', 10);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'بروتوكول HTTP يستخدم منفذ (Port) رقم 80 افتراضياً.'), 'صح', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'بروتوكول HTTP يستخدم منفذ (Port) رقم 80 افتراضياً.'), 'خطأ', 2);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
    (SELECT QuestionID FROM Questions WHERE QuestionText = 'بروتوكول HTTP يستخدم منفذ (Port) رقم 80 افتراضياً.'),
    (SELECT OptionID FROM Choice WHERE OptionText = 'صح' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'بروتوكول HTTP يستخدم منفذ (Port) رقم 80 افتراضياً.'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
5,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'بروتوكول HTTP يستخدم منفذ (Port) رقم 80 افتراضياً.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'صح' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'بروتوكول HTTP يستخدم منفذ (Port) رقم 80 افتراضياً.'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
10,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'بروتوكول HTTP يستخدم منفذ (Port) رقم 80 افتراضياً.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'خطأ' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'بروتوكول HTTP يستخدم منفذ (Port) رقم 80 افتراضياً.'))
);

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 5 (EN / MCQ)
INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (5, 'Which protocol is responsible for translating domain names into IP addresses?', 'MCQ', 10);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'Which protocol is responsible for translating domain names into IP addresses?'), 'DHCP', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'Which protocol is responsible for translating domain names into IP addresses?'), 'DNS', 2),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'Which protocol is responsible for translating domain names into IP addresses?'), 'FTP', 3),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'Which protocol is responsible for translating domain names into IP addresses?'), 'SMTP', 4);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
    (SELECT QuestionID FROM Questions WHERE QuestionText = 'Which protocol is responsible for translating domain names into IP addresses?'),
    (SELECT OptionID FROM Choice WHERE OptionText = 'DNS' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'Which protocol is responsible for translating domain names into IP addresses?'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
5,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'Which protocol is responsible for translating domain names into IP addresses?'),
(SELECT OptionID FROM Choice WHERE OptionText = 'DHCP' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'Which protocol is responsible for translating domain names into IP addresses?'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
10,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'Which protocol is responsible for translating domain names into IP addresses?'),
(SELECT OptionID FROM Choice WHERE OptionText = 'DNS' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'Which protocol is responsible for translating domain names into IP addresses?'))
);

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- 6 (AR / MCQ)
INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (5, 'ما هو عنوان الـ MAC Address؟', 'MCQ', 10);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'ما هو عنوان الـ MAC Address؟'), 'عنوان منطقي يتغير حسب الشبكة', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'ما هو عنوان الـ MAC Address؟'), 'عنوان فيزيائي ثابت لكرت الشبكة', 2),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'ما هو عنوان الـ MAC Address؟'), 'بروتوكول لنقل الملفات', 3),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'ما هو عنوان الـ MAC Address؟'), 'كلمة مرور للراوتر', 4);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
    (SELECT QuestionID FROM Questions WHERE QuestionText = 'ما هو عنوان الـ MAC Address؟'),
    (SELECT OptionID FROM Choice WHERE OptionText = 'عنوان فيزيائي ثابت لكرت الشبكة' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'ما هو عنوان الـ MAC Address؟'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
5,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'ما هو عنوان الـ MAC Address؟'),
(SELECT OptionID FROM Choice WHERE OptionText = 'عنوان فيزيائي ثابت لكرت الشبكة' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'ما هو عنوان الـ MAC Address؟'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
10,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'ما هو عنوان الـ MAC Address؟'),
(SELECT OptionID FROM Choice WHERE OptionText = 'عنوان فيزيائي ثابت لكرت الشبكة' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'ما هو عنوان الـ MAC Address؟'))
);

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 7 (EN / TF)
INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (5, 'The UDP protocol guarantees the delivery of all packets.', 'TF', 10);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'The UDP protocol guarantees the delivery of all packets.'), 'True', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'The UDP protocol guarantees the delivery of all packets.'), 'False', 2);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
    (SELECT QuestionID FROM Questions WHERE QuestionText = 'The UDP protocol guarantees the delivery of all packets.'),
    (SELECT OptionID FROM Choice WHERE OptionText = 'False' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'The UDP protocol guarantees the delivery of all packets.'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
5,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'The UDP protocol guarantees the delivery of all packets.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'False' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'The UDP protocol guarantees the delivery of all packets.'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
10,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'The UDP protocol guarantees the delivery of all packets.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'True' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'The UDP protocol guarantees the delivery of all packets.'))
);

-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 8 (AR / TF)
INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (5, 'طبقة الـ Data Link تستخدم الـ IP Addresses لتوجيه البيانات بين الأجهزة.', 'TF', 10);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'طبقة الـ Data Link تستخدم الـ IP Addresses لتوجيه البيانات بين الأجهزة.'), 'صح', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'طبقة الـ Data Link تستخدم الـ IP Addresses لتوجيه البيانات بين الأجهزة.'), 'خطأ', 2);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
    (SELECT QuestionID FROM Questions WHERE QuestionText = 'طبقة الـ Data Link تستخدم الـ IP Addresses لتوجيه البيانات بين الأجهزة.'),
    (SELECT OptionID FROM Choice WHERE OptionText = 'خطأ' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'طبقة الـ Data Link تستخدم الـ IP Addresses لتوجيه البيانات بين الأجهزة.'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
5,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'طبقة الـ Data Link تستخدم الـ IP Addresses لتوجيه البيانات بين الأجهزة.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'خطأ' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'طبقة الـ Data Link تستخدم الـ IP Addresses لتوجيه البيانات بين الأجهزة.'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
10,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'طبقة الـ Data Link تستخدم الـ IP Addresses لتوجيه البيانات بين الأجهزة.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'خطأ' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'طبقة الـ Data Link تستخدم الـ IP Addresses لتوجيه البيانات بين الأجهزة.'))
);

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 9 (EN / MCQ)
INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (5, 'What is the primary function of a Firewall?', 'MCQ', 10);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What is the primary function of a Firewall?'), 'To speed up internet connection', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What is the primary function of a Firewall?'), 'To monitor and control incoming and outgoing network traffic', 2),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What is the primary function of a Firewall?'), 'To store database backups', 3),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'What is the primary function of a Firewall?'), 'To generate IP addresses', 4);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
    (SELECT QuestionID FROM Questions WHERE QuestionText = 'What is the primary function of a Firewall?'),
    (SELECT OptionID FROM Choice WHERE OptionText = 'To monitor and control incoming and outgoing network traffic' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What is the primary function of a Firewall?'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
5,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'What is the primary function of a Firewall?'),
(SELECT OptionID FROM Choice WHERE OptionText = 'To speed up internet connection' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What is the primary function of a Firewall?'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
10,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'What is the primary function of a Firewall?'),
(SELECT OptionID FROM Choice WHERE OptionText = 'To monitor and control incoming and outgoing network traffic' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'What is the primary function of a Firewall?'))
);

--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- 10 (AR / TF)
INSERT INTO Questions (CourseID, QuestionText, Type, Points) VALUES (5, 'الـ LAN (Local Area Network) تغطي مساحة جغرافية واسعة جداً مثل دولة كاملة.', 'TF', 10);
INSERT INTO Choice (QuestionID, OptionText, OptionOrder) VALUES
((SELECT QuestionID FROM Questions WHERE QuestionText = 'الـ LAN (Local Area Network) تغطي مساحة جغرافية واسعة جداً مثل دولة كاملة.'), 'صح', 1),
((SELECT QuestionID FROM Questions WHERE QuestionText = 'الـ LAN (Local Area Network) تغطي مساحة جغرافية واسعة جداً مثل دولة كاملة.'), 'خطأ', 2);
INSERT INTO ModelAnswer (QuestionID, CorrectOptionID) VALUES (
    (SELECT QuestionID FROM Questions WHERE QuestionText = 'الـ LAN (Local Area Network) تغطي مساحة جغرافية واسعة جداً مثل دولة كاملة.'),
    (SELECT OptionID FROM Choice WHERE OptionText = 'خطأ' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'الـ LAN (Local Area Network) تغطي مساحة جغرافية واسعة جداً مثل دولة كاملة.'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
5,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'الـ LAN (Local Area Network) تغطي مساحة جغرافية واسعة جداً مثل دولة كاملة.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'خطأ' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'الـ LAN (Local Area Network) تغطي مساحة جغرافية واسعة جداً مثل دولة كاملة.'))
);

INSERT INTO StudentAnswer (StudentExamID, QuestionID, ChosenOptionID) VALUES (
10,
(SELECT QuestionID FROM Questions WHERE QuestionText = 'الـ LAN (Local Area Network) تغطي مساحة جغرافية واسعة جداً مثل دولة كاملة.'),
(SELECT OptionID FROM Choice WHERE OptionText = 'صح' AND QuestionID = (SELECT QuestionID FROM Questions WHERE QuestionText = 'الـ LAN (Local Area Network) تغطي مساحة جغرافية واسعة جداً مثل دولة كاملة.'))
);
-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- ExamQuestion (Relaiton between Exam and it's Question and Question's order)
INSERT INTO ExamQuestion (ExamID, QuestionID, OrderNo)
VALUES 
    (1, 1, 1),
    (1, 2, 2),
    (1, 3, 3),
    (1, 4, 4),
    (1, 5, 5),
    (1, 6, 6),
    (1, 7, 7),
    (1, 8, 8),
    (1, 9, 9),
    (1, 10, 10),
    (1, 11, 11),
    (1, 12, 12),
    (1, 13, 13),
    (1, 14, 14),
    (1, 15, 15),

    (2, 16, 1),
    (2, 17, 2),
    (2, 18, 3),
    (2, 19, 4),
    (2, 20, 5),
    (2, 21, 6),
    (2, 22, 7),
    (2, 23, 8),
    (2, 24, 9),
    (2, 25, 10),
    (2, 26, 11),
    (2, 27, 12),
    (2, 28, 13),
    (2, 29, 14),
    (2, 30, 15),

    (3, 31, 1),
    (3, 32, 2),
    (3, 33, 3),
    (3, 34, 4),
    (3, 35, 5),
    (3, 36, 6),
    (3, 37, 7),
    (3, 38, 8),
    (3, 39, 9),
    (3, 40, 10),

    (4, 41, 1),
    (4, 42, 2),
    (4, 43, 3),
    (4, 44, 4),
    (4, 45, 5),
    (4, 46, 6),
    (4, 47, 7),
    (4, 48, 8),
    (4, 49, 9),
    (4, 50, 10),

    (5, 51, 1),
    (5, 52, 2),
    (5, 53, 3),
    (5, 54, 4),
    (5, 55, 5),
    (5, 56, 6),
    (5, 57, 7),
    (5, 58, 8),
    (5, 59, 9),
    (5, 60, 10);
