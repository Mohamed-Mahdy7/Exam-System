# app.py
from flask import Flask, render_template, request, jsonify, send_file
import psycopg2
from psycopg2.extras import Json
from fpdf import FPDF
import io

app = Flask(__name__)

# --- Authentication Logic ---
@app.route('/login', methods=['POST'])
def login():
    data = request.get_json()
    email = data.get('email', '').lower()
    
    # Mocking roles based on email input for testing
    if 'admin' in email:
        role = 'admin'
    elif 'instructor' in email:
        role = 'instructor'
    else:
        role = 'student'
        
    return jsonify({"role": role, "redirect": f"/{role}_dashboard"})

# --- Page Routes ---
@app.route('/')
def landing():
    return render_template('index.html')

@app.route('/admin_dashboard')
def admin_dashboard():
    return render_template('admin.html')

@app.route('/instructor_dashboard')
def instructor_dashboard():
    return render_template('instructor.html')

@app.route('/student_dashboard')
def student_dashboard():
    # Sending a mock exam ID to the template
    return render_template('student_exam.html', student_exam_id=101)

# --- API: Submit Exam (Student) ---
@app.route('/api/submit_exam', methods=['POST'])
def submit_exam():
    data = request.get_json()
    # In a real app, you connect to the DB here and call SubmitExamAnswers
    print("Received Answers:", data)
    return jsonify({"status": "success", "message": "Exam submitted successfully!", "redirect_url": "/"}), 200

# --- API: Download PDF Report (Instructor/Admin) ---
@app.route('/api/reports/students_by_dept/<int:dept_id>')
def download_dept_report(dept_id):
    # Mock Database Data
    data = [
        ("1", "Ali Ahmed", "ali@iti.edu", "Alexandria", "Software Development"),
        ("2", "Sara Hassan", "sara@iti.edu", "Cairo", "Data Science")
    ]

    # PDF Generation
    pdf = FPDF()
    pdf.add_page()
    pdf.set_font("Arial", 'B', 16)
    pdf.cell(200, 10, txt=f"ITI Students in Department {dept_id}", ln=True, align='C')
    pdf.ln(10)
    
    pdf.set_font("Arial", size=12)
    for row in data:
        row_text = f"ID: {row[0]} | Name: {row[1]} | Branch: {row[3]} | Track: {row[4]}"
        pdf.cell(200, 10, txt=row_text, ln=True)
    
    pdf_output = io.BytesIO(pdf.output(dest='S').encode('latin-1'))
    return send_file(pdf_output, as_attachment=True, download_name='dept_report.pdf', mimetype='application/pdf')

if __name__ == '__main__':
    app.run(debug=True, port=5000)