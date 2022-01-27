-- obtain year-on-year growth rate for the total spend of each product

-- user_transactions: transaction_id | product_id | user_id | spend | transaction_date

-- first step compute the weekly spend as CTE 

WITH (
  SELECT 
    DATE_TRUNC('week', transaction_date) as 'week',
    product_id,
    SUM(spend) total_spend
  FROM user_transactions
  GROUP BY 1,2
  ORDER BY 1
) as weekly_spend

-- second step get total weekly spend from previous week as CTE
WITH (
SELECT 
  ws.week,
  ws.product_id,
  ws.total_spend,
  LAG(ws.total_spend, 52) OVER(PARTITION ws.product_id ORDER BY ws.week) as prev_total_spend
FROM weekly_spend ws 
GROUP By 1,2) as total_weekly_spend

-- compute the final YoY for everyweek 

SELECT
  week,
  product_id,
  (total_spend/ prev_total_spend) *100  as yoy_weekly_change
FROM total_weekly_spend 

