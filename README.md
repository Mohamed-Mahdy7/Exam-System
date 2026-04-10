# ITI Student Examination Management System

> A fully database-driven exam management solution built on **PostgreSQL**.  
> All business logic lives inside stored procedures — no application layer required.

---

## Project Overview

| Item | Detail |
|---|---|
| **Course** | ITI Database Track |
| **Database** | PostgreSQL |
| **Tables** | 15 |
| **Stored Procedures** | 30+ |
| **Timeline** | 10 days / 3 sprints |
| **Team size** | 4 members |

The system manages the full examination lifecycle for ITI branches:

- Departments, tracks, courses, instructors and students are defined in the organisational schema
- Instructors build a question bank (MCQ and True/False) per course
- Exams are **randomly generated** from the question bank via `GenerateExam`
- Students submit answers as a JSONB payload via `SubmitExamAnswers`
- The system auto-grades each attempt via `CorrectExam` and stores the final score
- Staff run structured reports to monitor student and instructor activity

---

## Team

| Member | Role | Tables Owned |
|---|---|---|
| **Mahdy** | ERD · DB Dictionary · `GenerateExam` · Admin role · Testing · README | `Exams` · `ExamQuestion` · `StudentExam` |
| **Samy** | Org schema · `SubmitExamAnswers` · `CorrectExam` · Backup | `Departments` · `Track` · `TrackCourse` · `Course` |
| **Mariam** | People schema · Roles & security · Reports · | `Instructor` · `InstructorCourse` · `Student` · `StudentTrack` |
| **Omar** | Question schema · Question CRUD · Reports · Seed data · Delivery | `Questions` · `Choice` · `ModelAnswer` · `StudentAnswer` |

## Repository Structure

```
database/
├── backup/
│   ├── backup.sql          # pg_dump script — run to create a full backup
│   └── restore.sql         # pg_restore instructions and script
├── procedures/
│   ├── exam_crud.sql       # CRUD procedures for Exams, ExamQuestion, StudentExam
│   ├── GenerateExam.sql    # GenerateExam, SubmitExamAnswers, CorrectExam
│   ├── exam_question.sql   # Question, Choice, ModelAnswer CRUD + SetModelAnswer
│   └── ...                 # Rest fo the procedures as the same structure for each table
├── reports/
│   └── reports.sql         # All mandatory and optional report procedures
├── schema/
│   ├── tables.sql          # All 15 CREATE TABLE statements
│   ├── constraints.sql     # FK constraints, CHECK constraints, UNIQUE constraints
│   ├──  indexes.sql        # Indexes on all FK columns
│   └── roles.sql           # Roles and Securety
└── seed/
│   └── sample_data.txt     # Minimum required seed data (departments → students → questions)
│
└── test/
    └── GenerateExam.sql
    └── SubmitExamAnswers.sql
    └── CorrectExam.sql
    └── Report_InstructorCourses.sql
    └── Report_StudentByDepartment.sql
    └── Report_StudentGrades.sql
    └── ...

docs/
├── DB project.pdf                      # Original SRS / project brief
├── PostgresSQL Project.drawio          # Editable ERD source file
├── PostgresSQL Project.drawio.pdf      # ERD export (PDF)
├── PostgresSQL Project.drawio.png      # ERD export (PNG)
└── data_dictionary.md                  # Full DB Dictionary (all 15 tables)

.gitignore
README.md
```

---

## Database Schema

### Entity overview

```
Departments ──< Track ──< TrackCourse >── Course ──< Questions ──< Choice
                                            │               │
                                            │           ModelAnswer
                                            │
                                        Instructor
                                            │
                                       InstructorCourse
                                            │
                                         Student
                                            │
                                       StudentTrack
                                            │
                                          Exams ──< ExamQuestion
                                            │
                                       StudentExam ──< StudentAnswer
```

### All 15 tables

| # | Table | Owner | Type | Primary Key |
|---|---|---|---|---|
| 1 | `Departments` | Samy | Entity | `DepartmentID SERIAL` |
| 2 | `Track` | Samy | Entity | `TrackID SERIAL` |
| 3 | `TrackCourse` | Samy | Junction | `(TrackID, CourseID)` |
| 4 | `Course` | Samy | Entity | `CourseID SERIAL` |
| 5 | `Instructor` | Mariam | Entity | `InstructorID SERIAL` |
| 6 | `InstructorCourse` | Mariam | Junction | `(InstructorID, CourseID)` |
| 7 | `Student` | Mariam | Entity | `StudentID SERIAL` |
| 8 | `StudentTrack` | Mariam | Junction | `(StudentID, TrackID)` |
| 9 | `Questions` | Omar | Entity | `QuestionID SERIAL` |
| 10 | `Choice` | Omar | Entity | `OptionID SERIAL` |
| 11 | `ModelAnswer` | Omar | Entity | `QuestionID` (UNIQUE) |
| 12 | `StudentAnswer` | Omar | Entity | `StudentAnswerID SERIAL` |
| 13 | `Exams` | Mahdy | Entity | `ExamID SERIAL` |
| 14 | `ExamQuestion` | Mahdy | Junction | `(ExamID, QuestionID)` |
| 15 | `StudentExam` | Mahdy | Entity | `StudentExamID SERIAL` |

> Junction tables use composite PKs only — no `SERIAL` column.  
> All `TEXT` columns use `ar-x-icu` collation to support Arabic and English.

---

## Getting Started

### Prerequisites

- PostgreSQL 14 or higher
- `psql` CLI or pgAdmin / DBeaver

### Setup (run in order)

```sql
-- 1. Create the database
CREATE DATABASE exam_db;

-- 2. Connect to it
\c exam_db

-- 3. Create tables
\i <your path to this repo>/database/schema/tables.sql

-- 4. Apply constraints and indexes
\i <your path to this repo>/database/schema/constraints.sql
\i <your path to this repo>/database/schema/indexes.sql

-- 5. Create roles
CREATE ROLE admin_role      WITH LOGIN SUPERUSER;
CREATE ROLE instructor_role WITH LOGIN;
CREATE ROLE student_role    WITH LOGIN;

-- 6. Load seed data
\i <your path to this repo>/database/seed/sample_data.sql

-- 7. Load all stored procedures
\i <your path to this repo>/database/procedures/exam_crud.sql
\i <your path to this repo>/database/procedures/exam_generation.sql
\i <your path to this repo>/database/procedures/exam_question.sql
\i <your path to this repo>/database/procedures/...                  # The same for the rest of the tables
\i <your path to this repo>/database/reports/reports.sql
```

---

## Stored Procedures

> Every procedure uses `BEGIN ... COMMIT` with `EXCEPTION WHEN OTHERS THEN ROLLBACK`.  
> Every procedure has a full `COMMENT` block: purpose, parameters, returns, exceptions.

### Critical procedures

#### `GenerateExam` — owned by Mahdy

Randomly selects questions from the question bank and creates a new exam.

```sql
SELECT GenerateExam(
    CourseID  => 1,
    ExamName  => 'Midterm Exam 2025',
    NumMCQ    => 10,
    NumTF     => 5
);
```

| Parameter | Type | Description |
|---|---|---|
| `CourseID` | INT | The course to generate an exam for |
| `ExamName` | TEXT | Display name for the exam |
| `NumMCQ` | INT | Number of MCQ questions to include |
| `NumTF` | INT | Number of True/False questions to include |

> Raises an exception and performs a full rollback if the question bank does not have
> enough questions of either type. No partial data is inserted.

---

#### `SubmitExamAnswers` — owned by Samy

Submits a student's answers for an exam attempt.

```sql
SELECT SubmitExamAnswers(
    StudentID  => 3,
    ExamID     => 1,
    StartTime  => '2025-06-01 09:00:00',
    EndTime    => '2025-06-01 10:30:00',
    Answers    => '[
        {"question_id": 1, "chosen_option_id": 4},
        {"question_id": 2, "chosen_option_id": 7},
        {"question_id": 3, "chosen_option_id": 9}
    ]'::JSONB
);
```

| Parameter | Type | Description |
|---|---|---|
| `StudentID` | INT | The student submitting the answers |
| `ExamID` | INT | The exam being submitted |
| `StartTime` | TIMESTAMP | When the student started |
| `EndTime` | TIMESTAMP | When the student submitted |
| `Answers` | JSONB | Array of `{"question_id": N, "chosen_option_id": N}` — unanswered questions are omitted |

---

#### `CorrectExam` — owned by Samy

Grades a submitted exam by comparing student answers against `ModelAnswer`.  
Updates `StudentExam.TotalGrade` with the computed score.

```sql
SELECT CorrectExam(StudentExamID => 5);
```

| Parameter | Type | Description |
|---|---|---|
| `StudentExamID` | INT | The exam attempt to grade |

> Awards `Question.Points` for each correct answer, 0 for wrong or unanswered questions.

---

### CRUD procedures

Each member owns the CRUD for their tables. The pattern is consistent across all entities:

```sql
-- Department example (Samy)
SELECT InsertDepartment('Software Development', 'Cairo');
SELECT UpdateDepartment(1, 'Software Engineering', 'Cairo');
SELECT DeleteDepartment(1);
SELECT * FROM SelectDepartments();

-- Student example (Mariam)
SELECT InsertStudent('Ahmed Hassan', 'ahmed@iti.eg', '01012345678');
SELECT AssignStudentToTrack(StudentID => 1, TrackID => 2);

-- Question example (Omar)
SELECT InsertQuestion(
    CourseID      => 2,
    QuestionText  => 'What does SQL stand for?',
    Type          => 'MCQ',
    Points        => 2
);
SELECT InsertOption(QuestionID => 1, OptionText => 'Structured Query Language', OptionOrder => 1);
SELECT SetModelAnswer(QuestionID => 1, CorrectOptionID => 1);
```

> `SetModelAnswer` raises an exception if `CorrectOptionID` does not belong to the given `QuestionID`.

---

## Reports

All three reports below are mandatory and implemented as stored procedures.

### `Report_StudentsByDepartment` — Mariam / Omar

```sql
SELECT * FROM Report_StudentsByDepartment(DepartmentNo => 1);
```

Returns: `StudentID`, `Name`, `Email`, `Phone`, `TrackName`, `BranchName`

---

### `Report_StudentGrades` — Mariam / Omar

```sql
SELECT * FROM Report_StudentGrades(StudentID => 3);
```

Returns: `CourseName`, `ExamName`, `TotalGrade`, `MaxDegree`, `Percentage`

> `Percentage` is computed as `TotalGrade::FLOAT / MaxDegree * 100`

---

### `Report_InstructorCourses` — Mariam / Omar

```sql
SELECT * FROM Report_InstructorCourses(InstructorID => 2);
```

Returns: `CourseName`, `TrackName`, `StudentCount`

---

### Optional reports (bonus) — Omar

```sql
-- All questions and choices for a given exam
SELECT * FROM Report_ExamQuestions(ExamID => 1);

-- A specific student's answers for a specific exam
SELECT * FROM Report_StudentExamAnswers(ExamID => 1, StudentID => 3);
```

---

## Database Roles & Security

| Role | Created by | Access level |
|---|---|---|
| `admin_role` | Mahdy | Full superuser access to all tables and procedures |
| `instructor_role` | Mariam | Read/write on all course and student data via procedures |
| `student_role` | Mariam | Read-only on own rows in `StudentExam` and `StudentAnswer` |

### Key security rules

- `ModelAnswer` is completely hidden from `student_role` — `REVOKE ALL` enforced by Omar
- Row-Level Security (RLS) is enabled on `Student`, `StudentExam`, and `StudentAnswer` to prevent students from reading other students' data
- All client interactions must go through stored procedures — direct table queries from clients are not permitted

### Assign a role to a user

```sql
-- Grant instructor access
GRANT instructor_role TO your_db_user;

-- Grant student access
GRANT student_role TO your_db_user;
```

---

## Backup & Restore

### Create a backup

```bash
pg_dump -U postgres -d exam_db -F c -f database/backup/backup.dump
```

Or using the provided script:

```bash
psql -U postgres -d exam_db -f database/backup/backup.sql
```

### Restore from backup

```bash
pg_restore -U postgres -d exam_db database/backup/backup.dump
```

Or using the provided script:

```bash
psql -U postgres -f database/backup/restore.sql
```

---

## Documentation

| File | Description |
|---|---|
| `docs/db_dictionary.txt` | Full DB Dictionary — all 15 tables, every column with type, constraints and description |
| `docs/PostgresSQL Project.drawio` | Editable ERD source file |
| `docs/PostgresSQL Project.drawio.pdf` | ERD export for review |
| `docs/DB project.pdf` | Original SRS / project requirements |

---

*ITI Student Examination Management System — PostgreSQL Project*
