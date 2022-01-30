-- purchases: purchase_id | user_id | product_id | quantity | price | purchase_time 

-- questions: write a query to obtain the number of people who puchased at least one or more of the same product on multiple days

-- asumptions: that there are no empty purchase_id 

-- Steps: 1) filter on purchased one or more products (which is already satisfied)
SELECT
  COUNT(DISTINCT user_id)
FROM (
SELECT 
  user_id,
  product_id,
  rank() OVER (PARTITION BY user_id, product_id ORDER BY CAST(purchase_time as DATE) as purchase_number
FROM purchases) t
WHERE t.purchase_number = 2