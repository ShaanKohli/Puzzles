# Write your MySQL query statement below

SELECT 
    DISTINCT t1.num as ConsecutiveNums
FROM
(SELECT
    id, 
    num,
    LEAD(num,1) OVER (ORDER BY id) next_num,
    LEAD(num,2) OVER (ORDER By id) next_2_num
FROM Logs) t1
 
WHERE (t1.num = t1.next_num) and (t1.next_num = t1.next_2_num)
    
