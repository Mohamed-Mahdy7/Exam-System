    function switchRole(role) {
        document.querySelectorAll('.nav-links').forEach(el => el.classList.add('d-none'));
        document.querySelectorAll('.dashboard-view').forEach(el => el.classList.remove('active'));

        document.getElementById(`nav-${role}`).classList.remove('d-none');
        document.getElementById(`view-${role}`).classList.add('active');

        const titles = {
            'admin': 'System Oversight',
            'instructor': 'Course & Exam Administration',
            'student': 'Assessments & Results'
        };
        document.getElementById('headerTitle').innerText = titles[role];
    }