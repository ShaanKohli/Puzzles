-- An attendance log for every student in a school district attendance_events : 
-- date | student_id | attendance

-- A summary table with demographics for each student in the district all_ students : 
-- student_id | school_id | grade_level | date_of_birth | hometown

-- 1) What percent of students attend school on their birthday?

SELECT COUNT(DISTINCT student_id)::FLOAT / (SELECT
  COUNT(DISTINCT student_id)
FROM attendance_logs
INNER JOIN demographics ON attendance_logs.date = demographics.date_of_birth)

FROM attendance_logs

SELECT 
  (COUNT(DISTINCT student_id)::FLOAT / COUNT (CASE WHEN a.date  = d.date_of_birth THEN DISTINCT student_id ELSE NULL END)) *100
FROM attendance_logs a
INNER JOIN demographics d ON a.student_id = d.student_id
WHERE a.attendance = 1


-- 2) Which grade level had the largest drop in attendance between yesterday and today?
SELECT x.grade_level, y.today_attendance - x.yesterday_attendance as diff_att
(SELECT 
  d.grade_level,
  COUNT(DISTINCT CASE WHEN attendance = 1 THEN t1.student_id ELSE NULL END)::FLOAT/COUNT(DISTINCT student_id)*100 as yesterday_attendance 
FROM attendance_logs t1
INNER JOIN demographics d ON t1.student_id  = d.student_id
WHERE date = current_date - 1
group by 1,2) x
INNER JOIN (
SELECT 
  d.grade_level,
  COUNT(DISTINCT CASE WHEN attendance = 1 THEN t1.student_id ELSE NULL END)::FLOAT/COUNT(DISTINCT student_id)*100 as today_attendance 
FROM attendance_logs t1
INNER JOIN demographics d ON t1.student_id  = d.student_id
WHERE date = current_date
group by 1,2) ON  x.grade_level = y.grade_level
ORDER BY diff_att DESC
LIMIT 1

-- Better way to answer 2 
SELECT
  x.grade_level,
  x.today_attendance - x.yesterday_attendance as DIFF_ATT
FROM (
  SELECT 
    a.date,
    s.grade_level,
    COUNT(DISTINCT a.student_id) today_attendance,
    LAG(today_attendance,1) OVER (PARTITION BY grade_level ORDER BY Date )))  as yesterday_attendance
  FROM attendance a 
  INNER JOIN students s ON a.student_id = s.student_id
  WHERE a.attendance = 1
  GROUP BY 1,2
  ORDER BY date) x
WHERE x.date = current_date
ORDER BY DIFF_ATT
LIMIT 1