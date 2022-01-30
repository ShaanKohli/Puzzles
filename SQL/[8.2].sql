-- get top three cities that had most # of completed orders
-- what does completed orders mean?


SELECT 
  u.city,
  COUNT(DISTINCT t.order_id) as complete_orders
FROM trades t
INNER JOIN users u on t.user_id = u.user_id 
WHERE t.status = 'completed'
GROUP BY u.city
ORDER BY complete_orders DESC
LIMIT 3;