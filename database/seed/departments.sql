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
('Programming Fundamentals', 0, 100),
('Data Structures', 20, 100),
('Databases', 30, 100),
('Operating Systems', 25, 100),
('Computer Networks', 20, 100),
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