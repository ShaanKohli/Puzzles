-- first step is to get the total spend for each product in each category in the year 2020
WITH category_spend as (
SELECT
  category_id,
  product_id,
  SUM(spend) total_spend
FROM product_spend
WHERE DATE_TRUNC('year', transaction_date) = 2020
GROUP BY 1,2)

SELECT
  category_id,
  product_id
FROM (
SELECT
  category_id,
  product_id,
  dense_rank() OVER (PARTITION BY category_id, product_id ORDER BY total_spend DESC) as cat_rank
FROM category_spend) t
WHERE cat_rank <=3
ORDER BY
  category_id,
  product_id,
  cat_rank
