-- ATHLETICORE SPORTS ACADEMY BUSINESS LOGIC & ANALYTICS QUERIES

-- 1. Get student names and e-mail information
SELECT student_name, mail 
FROM student;

-- 2. Find students born before 2005
SELECT student_name, birth 
FROM student 
WHERE birth < '2005.01.01';

-- 3. Count the number of students by their gender
SELECT gender, COUNT(*) AS total 
FROM student 
GROUP BY gender;

-- 4. Get the names and birth dates of the 5 youngest students
SELECT student_name, birth 
FROM student 
ORDER BY birth DESC 
LIMIT 5;

-- 5. Calculate the total sum of all payment amounts
SELECT SUM(amount) AS total_income 
FROM payment;

-- 6. Retrieve programs scheduled to begin after the current date
SELECT program_name, start_date 
FROM program 
WHERE start_date > CURDATE();

-- 7. List programs that last more than 30 days
SELECT program_name, DATEDIFF(end_date, start_date) AS duration_days 
FROM program 
WHERE DATEDIFF(end_date, start_date) > 30;

-- 8. Count how many students were born in each unique year
SELECT YEAR(birth) AS birth_year, COUNT(*) AS student_count 
FROM student 
GROUP BY birth_year;

-- 9. Retrieve a list of program names and their assigned coaches
SELECT p.program_name, c.coach_name 
FROM program p 
INNER JOIN coach c ON p.coach_id = c.coach_id;

-- 10. Calculate the number of students enrolled in each program
SELECT pr.program_name, COUNT(e.enrollment_id) AS num_students 
FROM program pr 
LEFT JOIN enrollment e ON pr.program_id = e.program_id 
GROUP BY pr.program_name;

-- 11. Find students who have addresses in Kırıkkale
SELECT s.student_name, sa.address 
FROM student s 
LEFT JOIN student_address sa ON s.student_id = sa.student_id 
WHERE sa.address LIKE '%Kırıkkale';

-- 12. Get the names of students and their enrollment dates for completed enrollments
SELECT s.student_name, e.enrollment_date 
FROM enrollment e 
INNER JOIN student s ON e.student_id = s.student_id 
WHERE e.status = "Completed";

-- 13. Identify the top 5 highest-paying students across all enrollments
SELECT s.student_name, SUM(p.amount) AS total_paid 
FROM payment p 
INNER JOIN enrollment e ON p.enrollment_id = e.enrollment_id 
INNER JOIN student s ON e.student_id = s.student_id 
GROUP BY s.student_name 
ORDER BY total_paid DESC 
LIMIT 5;

-- 14. Calculate the total revenue generated per sport
SELECT sp.sport_name, SUM(p.amount) AS total_income 
FROM sport sp 
JOIN program pr ON sp.sport_id = pr.sport_id 
JOIN enrollment e ON pr.program_id = e.program_id 
JOIN payment p ON e.enrollment_id = p.enrollment_id 
GROUP BY sp.sport_name;

-- 15. Generate a comprehensive student-program-sport relationship report
SELECT s.student_name, pr.program_name, sp.sport_name 
FROM enrollment e 
INNER JOIN student s ON e.student_id = s.student_id 
INNER JOIN program pr ON e.program_id = pr.program_id 
INNER JOIN sport sp ON pr.sport_id = sp.sport_id;