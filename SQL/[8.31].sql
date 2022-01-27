-- write a query to obtain the number of reactivated users

-- user_logins: user_id | login_date

-- we first need to find the users that were active in the previous month

SELECT 
  MONTH(current_month.login_date) as curr_month
  COUNT(*)
FROM user_logins as current_month
WHERE NOT EXISTS (
SELECT
  DISTINCT user_id
FROM user_logins as last_month
WHERE MONTH(last_month.login_date) BETWEEN MONTH(current_month.login_date) AND MONTH(current_month.login_date) - INTERVAL 1 MONTH)
