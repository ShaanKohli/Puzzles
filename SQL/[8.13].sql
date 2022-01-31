-- bucketing by latest transaction_date means i would need to take a max of transaction_date

WITH latest_spend as (
SELECT
  user_id,
  product_id,
  cast(transaction_date as date) as transaction_date,
  RANK() OVER (PARTITION BY user_id ORDER BY cast(transaction_date as date) ) days_rank
FROM user_transactions)


SELECT 
  transaction_date,
  COUNT(user_id) as num_users,
  COUNT(product_id) as num_prod
FROM latest_spend
WHERE days_rank = 1
GROUP BY 1