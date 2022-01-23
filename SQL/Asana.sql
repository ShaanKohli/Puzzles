-- # customer_plan_history

-- # date                  VARCHAR,
-- # account_id        BIGINT,
-- # plan_tier           [‘enterprise’, ‘business’,  'premium', 'free'],
-- # revenue            DOUBLE,
-- # paid_seats       INT


-- date       | account_id | plan_tier | revenue | paid_seats
-- 2020-01-01 | 123        | 'free'    | 0       | 0
-- 2020-01-02 | 123        | 'free'    | 0       | 0
-- 2020-01-03 | 123        | 'business'| 400     | 15
-- 2020-01-01 | 456        | 'premium' | 60      | 5
-- 2020-01-02 | 456        | 'premium' | 60      | 5
-- 2020-01-03 | 456        | 'premium' | 60      | 5

-- How many accounts upgraded to a higher plan tier in the last month?


SELECT
  COUNT(DISTINCT x.account_id)
  
FROM 
  (
    SELECT 
      t1.account_id, 
      CASE WHEN  t2.plan_tier > t1.plan_tier and t2.date - t1.date < 0 THEN 1 ELSE 0 END upgraded_flag
    FROM customer_plan_history t1 
    LEFT JOIN customer_plan_history t2 ON t1.account_id = t2.account_id
  ) x
  WHERE x.upgraded_flag > 1