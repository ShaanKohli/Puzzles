-- first step is to order people transactions and get their first one, after that we can check if those transactions are over 50$

SELECT 
  DISTINCT user_id
FROM (
SELECT
  user_id,
  row_number() OVER (PARTITION BY user_id, transaction_id ORDER BY transaction_date ASC) as transaction_rank
  total_spend
FROM (
SELECT
  transaction_id,
  transaction_date,
  user_id,
  SUM(spend) total_spend
FROM user_transactions
GROUP BY 1,2,3) t1) t2
WHERE transaction_rank = 1 and total_spend >= 50



SELECT 
  DISTINCT t.user_id
FROM
(SELECT 
  user_id,
  spend,
  row_number() over (PARITION BY user_id ORDER BY transaction_date ASC) as transaction_rank
FROM user_transactions
GROUP BY 1) t
WHERE transaction_rank = 1 and t.spend >= 50