# app.py
from flask import Flask, render_template, request, jsonify, send_file, redirect, url_for, session
import psycopg2
from psycopg2.extras import RealDictCursor
from fpdf import FPDF
import io
import json
import os

app = Flask(__name__)
app.secret_key = os.environ.get('SECRET_KEY', 'dev-secret-key-change-in-production')

# --- Database Connection ---
DB_CONFIG = {
    'host': os.environ.get('DB_HOST', 'localhost'),
    'port': os.environ.get('DB_PORT', '5432'),
    'dbname': os.environ.get('DB_NAME', 'exam_db'),
    'user': os.environ.get('DB_USER', 'postgres'),
    'password': os.environ.get('DB_PASSWORD', '257322'),
}

def get_db():
    conn = psycopg2.connect(**DB_CONFIG)
    conn.autocommit = False
    return conn

def fetch_cursor_results(conn, proc_call, params):
    """Helper to call a procedure that returns a REFCURSOR and fetch results."""
    cur = conn.cursor(cursor_factory=RealDictCursor)
    cur.execute("BEGIN;")
    cur.execute(proc_call, params)
    cursor_name = cur.fetchone()
    if cursor_name:
        name = list(cursor_name.values())[0]
        cur.execute(f'FETCH ALL FROM "{name}";')
        rows = cur.fetchall()
    else:
        rows = []
    cur.execute("COMMIT;")
    cur.close()
    return rows

def query_db(sql, params=None, fetchall=True):
    conn = get_db()
    cur = conn.cursor(cursor_factory=RealDictCursor)
    try:
        cur.execute(sql, params)
        if fetchall:
            rows = cur.fetchall()
        else:
            rows = cur.fetchone()
        conn.commit()
        return rows
    except Exception as e:
        conn.rollback()
        raise e
    finally:
        cur.close()
        conn.close()

def execute_db(sql, params=None):
    conn = get_db()
    cur = conn.cursor()
    try:
        cur.execute(sql, params)
        conn.commit()
    except Exception as e:
        conn.rollback()
        raise e
    finally:
        cur.close()
        conn.close()


# ======================== AUTH ========================
@app.route('/')
def landing():
    return render_template('index.html')

@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    email = data.get('email', '').lower()
    password = data.get('password', '')

    # Role detection from email (as per original mock logic)
    if 'admin' in email:
        role = 'admin'
    elif 'instructor' in email:
        role = 'instructor'
    else:
        role = 'student'

    session['role'] = role
    session['email'] = email
    return jsonify({"role": role, "redirect": f"/{role}_dashboard"})

@app.route('/logout')
def logout():
    session.clear()
    return redirect('/')


# ======================== DASHBOARDS ========================
@app.route('/admin_dashboard')
def admin_dashboard():
    return render_template('admin.html')

@app.route('/instructor_dashboard')
def instructor_dashboard():
    return render_template('instructor.html')

@app.route('/student_dashboard')
def student_dashboard():
    return render_template('student.html')


# ======================== DEPARTMENTS CRUD ========================
@app.route('/api/departments', methods=['GET'])
def get_departments():
    rows = query_db("SELECT departmentid, departmentname, location FROM departments ORDER BY departmentid;")
    return jsonify(rows)

@app.route('/api/departments', methods=['POST'])
def add_department():
    data = request.get_json()
    execute_db("CALL InsertDepartment(%s, %s);", (data['name'], data.get('location', '')))
    return jsonify({"status": "success"}), 201

@app.route('/api/departments/<int:dept_id>', methods=['PUT'])
def update_department(dept_id):
    data = request.get_json()
    execute_db("CALL UpdateDepartment(%s, %s, %s);", (dept_id, data.get('name'), data.get('location')))
    return jsonify({"status": "success"})

@app.route('/api/departments/<int:dept_id>', methods=['DELETE'])
def delete_department(dept_id):
    execute_db("CALL DeleteDepartment(%s);", (dept_id,))
    return jsonify({"status": "success"})


# ======================== TRACKS CRUD ========================
@app.route('/api/tracks', methods=['GET'])
def get_tracks():
    rows = query_db("""
        SELECT t.trackid, t.trackname, t.departmentid, d.departmentname
        FROM track t JOIN departments d ON t.departmentid = d.departmentid
        ORDER BY t.trackid;
    """)
    return jsonify(rows)

@app.route('/api/tracks', methods=['POST'])
def add_track():
    data = request.get_json()
    execute_db("CALL InsertTrack(%s, %s);", (data['name'], data['department_id']))
    return jsonify({"status": "success"}), 201

@app.route('/api/tracks/<int:track_id>', methods=['PUT'])
def update_track(track_id):
    data = request.get_json()
    execute_db("CALL UpdateTrack(%s, %s, %s);", (track_id, data.get('name'), data.get('department_id')))
    return jsonify({"status": "success"})

@app.route('/api/tracks/<int:track_id>', methods=['DELETE'])
def delete_track(track_id):
    execute_db("CALL DeleteTrack(%s);", (track_id,))
    return jsonify({"status": "success"})


# ======================== COURSES CRUD ========================
@app.route('/api/courses', methods=['GET'])
def get_courses():
    rows = query_db("SELECT courseid, coursename, mindegree, maxdegree FROM course ORDER BY courseid;")
    return jsonify(rows)

@app.route('/api/courses', methods=['POST'])
def add_course():
    data = request.get_json()
    execute_db("CALL InsertCourses(%s, %s, %s);", (data['name'], data['min_degree'], data['max_degree']))
    return jsonify({"status": "success"}), 201

@app.route('/api/courses/<int:course_id>', methods=['PUT'])
def update_course(course_id):
    data = request.get_json()
    execute_db("CALL UpdateCourses(%s, %s, %s, %s);", (course_id, data.get('name'), data.get('min_degree'), data.get('max_degree')))
    return jsonify({"status": "success"})

@app.route('/api/courses/<int:course_id>', methods=['DELETE'])
def delete_course(course_id):
    execute_db("CALL DeleteCourse(%s);", (course_id,))
    return jsonify({"status": "success"})


# ======================== INSTRUCTORS CRUD ========================
@app.route('/api/instructors', methods=['GET'])
def get_instructors():
    rows = query_db("""
        SELECT i.instructorid, i.name, i.email, i.departmentno, d.departmentname
        FROM instructor i LEFT JOIN departments d ON i.departmentno = d.departmentid
        ORDER BY i.instructorid;
    """)
    return jsonify(rows)

@app.route('/api/instructors', methods=['POST'])
def add_instructor():
    data = request.get_json()
    execute_db("CALL InsertInstructor(%s, %s, %s);", (data['name'], data['email'], data['department_id']))
    return jsonify({"status": "success"}), 201

@app.route('/api/instructors/<int:inst_id>', methods=['PUT'])
def update_instructor(inst_id):
    data = request.get_json()
    execute_db("CALL UpdateInstructor(%s, %s, %s, %s);", (inst_id, data.get('name'), data.get('email'), data.get('department_id')))
    return jsonify({"status": "success"})

@app.route('/api/instructors/<int:inst_id>', methods=['DELETE'])
def delete_instructor(inst_id):
    execute_db("CALL DeleteInstructor(%s);", (inst_id,))
    return jsonify({"status": "success"})


# ======================== STUDENTS CRUD ========================
@app.route('/api/students', methods=['GET'])
def get_students():
    rows = query_db("SELECT studentid, name, email, phone FROM student ORDER BY studentid;")
    return jsonify(rows)

@app.route('/api/students', methods=['POST'])
def add_student():
    data = request.get_json()
    execute_db("CALL InsertStudent(%s, %s, %s);", (data['name'], data['email'], data.get('phone', '')))
    return jsonify({"status": "success"}), 201

@app.route('/api/students/<int:stu_id>', methods=['PUT'])
def update_student(stu_id):
    data = request.get_json()
    execute_db("CALL UpdateStudent(%s, %s, %s, %s);", (stu_id, data.get('name'), data.get('email'), data.get('phone')))
    return jsonify({"status": "success"})

@app.route('/api/students/<int:stu_id>', methods=['DELETE'])
def delete_student(stu_id):
    execute_db("CALL DeleteStudent(%s);", (stu_id,))
    return jsonify({"status": "success"})


# ======================== EXAMS ========================
@app.route('/api/exams', methods=['GET'])
def get_exams():
    rows = query_db("""
        SELECT e.examid, e.examname, e.courseid, c.coursename, e.createddate, e.totalquestions
        FROM exams e LEFT JOIN course c ON e.courseid = c.courseid
        ORDER BY e.examid DESC;
    """)
    return jsonify(rows)

@app.route('/api/exams/generate', methods=['POST'])
def generate_exam():
    data = request.get_json()
    execute_db("CALL GenerateExam(%s, %s, %s, %s);",
               (data['course_id'], data['exam_name'], data['num_mcq'], data['num_tf']))
    return jsonify({"status": "success", "message": "Exam generated successfully!"}), 201


# ======================== STUDENT EXAM TAKING ========================
@app.route('/api/student/exams', methods=['GET'])
def get_student_exams():
    """Get available exams for students."""
    rows = query_db("""
        SELECT e.examid, e.examname, c.coursename, e.totalquestions
        FROM exams e JOIN course c ON e.courseid = c.courseid
        ORDER BY e.createddate DESC;
    """)
    return jsonify(rows)

@app.route('/api/student/exam/<int:exam_id>/questions', methods=['GET'])
def get_exam_questions(exam_id):
    """Get exam questions with choices for a student to take."""
    rows = query_db("""
        SELECT eq.orderno, q.questionid, q.questiontext, q.type, q.points,
               c.optionid, c.optiontext, c.optionorder
        FROM examquestion eq
        JOIN questions q ON q.questionid = eq.questionid
        LEFT JOIN choice c ON c.questionid = q.questionid
        WHERE eq.examid = %s
        ORDER BY eq.orderno, c.optionorder;
    """, (exam_id,))
    
    # Group by question
    questions = {}
    for row in rows:
        qid = row['questionid']
        if qid not in questions:
            questions[qid] = {
                'question_id': qid,
                'order': row['orderno'],
                'text': row['questiontext'],
                'type': row['type'],
                'points': row['points'],
                'options': []
            }
        if row['optionid']:
            questions[qid]['options'].append({
                'option_id': row['optionid'],
                'text': row['optiontext'],
                'order': row['optionorder']
            })
    
    return jsonify(list(questions.values()))

@app.route('/api/submit_exam', methods=['POST'])
def submit_exam():
    data = request.get_json()
    answers_json = json.dumps(data['answers'])
    execute_db(
        "CALL SubmitExamAnswers(%s, %s, %s, %s, %s::jsonb);",
        (data['student_id'], data['exam_id'], data['start_time'], data['end_time'], answers_json)
    )
    # Auto-correct
    try:
        # Get the latest student_exam_id
        row = query_db(
            "SELECT studentexamid FROM studentexam WHERE studentid=%s AND examid=%s ORDER BY studentexamid DESC LIMIT 1;",
            (data['student_id'], data['exam_id']), fetchall=False
        )
        if row:
            execute_db("CALL CorrectExam(%s);", (row['studentexamid'],))
    except:
        pass
    return jsonify({"status": "success", "message": "Exam submitted and corrected!"}), 200


# ======================== QUESTIONS CRUD ========================
@app.route('/api/questions', methods=['GET'])
def get_questions():
    course_id = request.args.get('course_id')
    if course_id:
        rows = query_db("""
            SELECT q.questionid, q.courseid, c.coursename, q.questiontext, q.type, q.points
            FROM questions q JOIN course c ON q.courseid = c.courseid
            WHERE q.courseid = %s ORDER BY q.questionid;
        """, (course_id,))
    else:
        rows = query_db("""
            SELECT q.questionid, q.courseid, c.coursename, q.questiontext, q.type, q.points
            FROM questions q JOIN course c ON q.courseid = c.courseid
            ORDER BY q.questionid;
        """)
    return jsonify(rows)

@app.route('/api/questions', methods=['POST'])
def add_question():
    data = request.get_json()
    row = query_db(
        "SELECT * FROM InsertQuestion(%s, %s, %s, %s);",
        (data['course_id'], data['text'], data['type'], data['points']),
        fetchall=False
    )
    # If the procedure uses OUT param, handle differently
    # Fallback: direct insert
    if not row:
        execute_db(
            "INSERT INTO questions (courseid, questiontext, type, points) VALUES (%s, %s, %s, %s);",
            (data['course_id'], data['text'], data['type'], data['points'])
        )
    return jsonify({"status": "success"}), 201

@app.route('/api/questions/<int:q_id>', methods=['DELETE'])
def delete_question(q_id):
    execute_db("CALL DeleteQuestion(%s);", (q_id,))
    return jsonify({"status": "success"})


# ======================== OPTIONS CRUD ========================
@app.route('/api/questions/<int:q_id>/options', methods=['GET'])
def get_options(q_id):
    rows = query_db("SELECT optionid, questionid, optiontext, optionorder FROM choice WHERE questionid=%s ORDER BY optionorder;", (q_id,))
    return jsonify(rows)

@app.route('/api/questions/<int:q_id>/options', methods=['POST'])
def add_option(q_id):
    data = request.get_json()
    execute_db("CALL InsertOption(%s, %s, %s, NULL);", (q_id, data['text'], data['order']))
    return jsonify({"status": "success"}), 201

@app.route('/api/questions/<int:q_id>/model_answer', methods=['POST'])
def set_model_answer(q_id):
    data = request.get_json()
    execute_db("CALL SetModelAnswer(%s, %s);", (q_id, data['correct_option_id']))
    return jsonify({"status": "success"})


# ======================== REPORTS (PDF) ========================
@app.route('/api/reports/students_by_dept/<int:dept_id>')
def report_students_by_dept(dept_id):
    conn = get_db()
    try:
        rows = fetch_cursor_results(conn, "CALL Report_StudentsByDepartment(%s, 'rpt');", (dept_id,))
    finally:
        conn.close()

    pdf = FPDF()
    pdf.add_page()
    pdf.set_font("Arial", 'B', 16)
    pdf.cell(200, 10, txt=f"Students in Department {dept_id}", ln=True, align='C')
    pdf.ln(10)
    pdf.set_font("Arial", size=10)
    for row in rows:
        line = f"ID: {row.get('studentid','')} | {row.get('name','')} | {row.get('email','')} | Track: {row.get('trackname','')}"
        pdf.cell(200, 8, txt=line, ln=True)

    buf = io.BytesIO(pdf.output(dest='S').encode('latin-1'))
    return send_file(buf, as_attachment=True, download_name='students_by_dept.pdf', mimetype='application/pdf')

@app.route('/api/reports/student_grades/<int:student_id>')
def report_student_grades(student_id):
    conn = get_db()
    try:
        rows = fetch_cursor_results(conn, "CALL Report_StudentGrades(%s, 'rpt');", (student_id,))
    finally:
        conn.close()

    pdf = FPDF()
    pdf.add_page()
    pdf.set_font("Arial", 'B', 16)
    pdf.cell(200, 10, txt=f"Grades for Student {student_id}", ln=True, align='C')
    pdf.ln(10)
    pdf.set_font("Arial", size=10)
    for row in rows:
        line = f"{row.get('coursename','')} - {row.get('examname','')} | Grade: {row.get('totalgrade',0)}/{row.get('maxdegree',0)} ({row.get('percentage',0):.1f}%)"
        pdf.cell(200, 8, txt=line, ln=True)

    buf = io.BytesIO(pdf.output(dest='S').encode('latin-1'))
    return send_file(buf, as_attachment=True, download_name='student_grades.pdf', mimetype='application/pdf')

@app.route('/api/reports/instructor_courses/<int:inst_id>')
def report_instructor_courses(inst_id):
    conn = get_db()
    try:
        rows = fetch_cursor_results(conn, "CALL Report_InstructorCourses(%s, 'rpt');", (inst_id,))
    finally:
        conn.close()

    pdf = FPDF()
    pdf.add_page()
    pdf.set_font("Arial", 'B', 16)
    pdf.cell(200, 10, txt=f"Courses for Instructor {inst_id}", ln=True, align='C')
    pdf.ln(10)
    pdf.set_font("Arial", size=10)
    for row in rows:
        line = f"{row.get('coursename','')} | Track: {row.get('trackname','')} | Students: {row.get('studentcount',0)}"
        pdf.cell(200, 8, txt=line, ln=True)

    buf = io.BytesIO(pdf.output(dest='S').encode('latin-1'))
    return send_file(buf, as_attachment=True, download_name='instructor_courses.pdf', mimetype='application/pdf')


# ======================== TRACK-COURSE ASSIGNMENT ========================
@app.route('/api/track_courses', methods=['POST'])
def assign_track_course():
    data = request.get_json()
    execute_db("CALL InsertTrackCourse(%s, %s);", (data['track_id'], data['course_id']))
    return jsonify({"status": "success"}), 201

# ======================== STUDENT-TRACK ASSIGNMENT ========================
@app.route('/api/student_tracks', methods=['POST'])
def assign_student_track():
    data = request.get_json()
    execute_db("CALL AssignStudentToTrack(%s, %s);", (data['student_id'], data['track_id']))
    return jsonify({"status": "success"}), 201

# ======================== INSTRUCTOR-COURSE ASSIGNMENT ========================
@app.route('/api/instructor_courses', methods=['POST'])
def assign_instructor_course():
    data = request.get_json()
    execute_db("CALL AssignInstructorToCourse(%s, %s);", (data['instructor_id'], data['course_id']))
    return jsonify({"status": "success"}), 201


if __name__ == '__main__':
    app.run(debug=True, port=5000)
