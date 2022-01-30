-- obtain names of the ten customers who have ordered the highest number of products among  those customers who have spent at least 1000$

-- user_transactions: transaction_id, product_id, user_id, spend_trans_date
SELECT 
  user_id
FROM (
SELECT
  user_id,
  COUNT(product_id) num_products,
  SUM(SPEND) total_spend
FROM user_transactions
GROUP BY 
  user_id)
WHERE total_spend >=1000
ORDER BY num_products DESC
LIMIT 10


SELECT user_id
FROM user_transactions
GROUP BY user_id
HAVING SUM(spend) >= 1000
ORDER BY COUNT(product_id) DESC
LIMIT 10