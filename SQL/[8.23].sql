-- previous month active users and select from those users how many were active

-- sample: month | retention (as #) |
select
  DATE_TRUNC('month', curr_month.timestamp) as 'month',
  COUNT(DISINCT curr_mont.user_id)
FROM user_actions curr_month
WHERE EXISTS
(select
  *
from user_actions as last_month
WHERE add_months(DATE_TRUNC('month', last_month.timestamp), -1) = DATE_TRUN('month', curr_month,timestamp))
GROUP BY 
  DATE_TRUNC('month', curr_month.timestamp) 
ORDER BY month ASC

