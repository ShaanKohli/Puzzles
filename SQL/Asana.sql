---- CALL THIS the base_table
SELECT 
  account_id,
  plan_tier,
  CASE WHEN plan_tier = 'free' THEN 1 ELSE
    (CASE WHEN plan_tier = 'premium' = 2 ELSE
      (CASE WHEN plan_tier = 'business' = 3 ELSE
        (CASE WHEN plan_tier = 'enterprise' = 4 ELSE NULL END) END) END) END as plan_rank
  min(date) as min_date
FROM customer_plan_history
WHERE date >= current_date -30
GROUP BY 1,2


SELECT
  COUNT(DISTINCT x.account_id)
FROM 
  (
    SELECT 
      t1.account_id, 
      CASE WHEN  t2.plan_rank > t1.plan_rank and t2.min_date - t1._date > 0 THEN 1 ELSE 0 END upgraded_flag
    FROM base_table t1 
    LEFT JOIN base_table t2 ON t1.account_id = t2.account_id
  ) x
  WHERE x.upgraded_flag > 1