-- Find the 10 products that are most frequently bought together 

--transactions:transaction_id | product_id | user_id | quantity|transaction_time
-- products: product_id | product_name | price |

-- we will need to perform a self join at some point so we will create a CTE with the relavant columns required

with (
  SELECT 
    user_id,
    product_id,
    product_name,
    transaction_id
  FROM transactions t
  INNER JOIN products p ON t.product_id = p.product_id
) AS purchase_info

SELECT
  p1.product_name as prod1,
  p2.product_name as prod2,
  COUNT(*) as 'count'
FROM purchase_info p1
INNER JOIN purchase_info p2 ON p1.transaction_id = p2.transaction_id AND p1.product_id < p2.product_id
GROUP BY 
  1,2
ORDER BY 
  3 DESC
LIMIT 10

