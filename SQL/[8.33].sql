-- write query to obtain the accounts rolling 7-day earning 

-- user_transactions: transaction_id | user_id | amount | transaction_date

-- get the sum of accounts per day

WITH (
  SELECT 
    transaction_date,
    SUM(amount) daily_earning
  FROM user_transactions
  GROUP BY 1
) as daily_earnings


SELECT 
  transaction_date,
  SUM(daily_earning) OVER (ORDER BY transaction_date, transaction_date BETWEEN 7 preceeding and current row) as rolling_average
FROM daily_earnings
GROUP BY 1
ORDER BY 1


-- another way

SELECT
  d1.transaction_date,
  SUM(d1.daily_earning) as weekly_rolling_total
FROM daily_earning d1
INNER JOIN daily_earnings d2 ON d1.transaction_date > DATEADD('DAY',-7,d2.transaction_date) AND d1.transaction_date <= d2.transaction_date
GROUP BY 
  d1.transaction_date
ORDER BY d1.transaction_date ASC
