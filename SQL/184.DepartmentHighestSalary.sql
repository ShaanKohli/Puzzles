SELECT 
    x.Department,
    x.Employee,
    x.salary
FROM (
SELECT
    e.name as 'Employee',
    e.salary, 
    d.name as 'Department',
    dense_rank() OVER (PARTITION BY e.departmentId ORDER BY e.salary DESC) as salary_rank
FROM Employee as e
INNER JOIN Department as d ON e.departmentId = d.id) x
WHERE salary_rank = 1