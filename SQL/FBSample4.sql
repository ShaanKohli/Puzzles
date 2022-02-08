-- tables 1 t1: date| userid

-- table 2 t2: date| user_id | search_id

-- Over the last 7 days how many users had 10 or more searches.
SELECT  
  DISTINCT x.user_id
FROM (
SELECT
  t1.user_id,
  COUNT(t2.search_id) OVER (PARTITION BY t1.user_id ORDER BY t1.date ASC ROWS BETWEEN 6 preceecing AND current row) as roll_count
FROM t1
INNER join t2 ON t1.date = t2.date AND t1.user_id = t2.user_id ) x
WHERE roll_count >= 10

