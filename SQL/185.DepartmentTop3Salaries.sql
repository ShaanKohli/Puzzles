SELECT 
    x.Department,
    x.Employee,
    x.Salary
FROM (
SELECT
    e.name as 'Employee',
    e.salary,
    d.name as 'Department',
    dense_rank() OVER (PARTITION BY e.departmentId ORDER BY e.salary DESC) as salary_rank
FROM Employee e
INNER JOIN Department d on e.departmentId = d.id) as x
WHERE x.salary_rank <= 3