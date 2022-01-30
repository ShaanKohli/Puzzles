-- calculate the cummulative spend so far by date for each product over time in chronological order

-- total_trans: order_id | user_id | product_id | spend | trans_date
SELECT
  trans_date,
  product_id,
  SUM(spend) OVER (PARTITION BY product_id ORDER BY trans_date)
FROM total_trans
ORDER BY product_id, trans_date ASC

