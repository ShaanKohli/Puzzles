-- #1
-- define click through rate as the number of clicks over the number of impressions

SELECT
  app_id,
  COUNT(CASE WHEN event_id = 'click' ELSE NULL END)/COUNT(CASE WHEN event_id = 'impression' ELSE NULL END)
FROM events
WHERE timestamp between '2019-01-01' AND '2019-12-31'
GROUP BY 1


-- #2
SELECT 
  u.city,
  COUNT(DISTINCT order_id) num_orders
FROM trades t
INNER JOIN users u on t.user_id = u.user_id
WHERE t.status = 'complete'
GROUP BY u.city 
ORDER BY num_orders DESC
LIMIT 3;

-- #3
SELECT
  COUNT(CASE WHEN device_type IN ('tablet','phone') THEN user_id ELSE NULL END) as mobile_views,
  COUNT(CASE WHEN device_type = 'laptop' THEN user_id ELSE NULL END) as laptop_views
FROM viewership

-- #4
SELECT
  product_id,
  trans_date,
  SUM(spend) OVER(PARTITION BY product_id ORDER BY trans_date) as roll_sum
FROM total_trans
GROUP BY product_id, trans_date
ORDER BY product_id, trans_date

-- #5
SELECT
  user_id,
  count(product_id) as num_prod
FROM user_transactions
GROUP BY user_id,
HAVING SUM(spend) > 1000
ORDER BY num_prod DESC
LIMIT 10;

-- #6

-- forumla for histogram is to get the the number of tweets per user and then get the number of users per number of tweets
SELECT
  x.num_tweets,
  COUNT(x.user_id) as num_users
FROM
(SELECT 
  user_id,
  COUNT(tweet_id) as num_tweets
FROM tweets
GROUP BY 1) as x
GROUP BY x.num_tweets
ORDER BY num_tweets ASC

-- #7
SELECT
  DISTINCT user_id
(SELECT
  user_id,
  product_id,
  RANK() OVER (PARTITION BY user_id, product_id ORDER BY purchase_time ASC) as rank_purchase
FROM  
  purchases ) t
WHERE rank_purchase = 2

-- #8
SELECT
COUNT(distinct compnay_id)
(SELECT
  company_id
FROM (
SELECT
  company_id,
  ROW_NUMBER() OVER (PARTITION BY company_id, title, description ORDER BY post_date) as rank_posting
FROM job_listings) t
WHERE MAX(rank_posting) > 1) t2
FROM t2

-- #9

SELECT
  user_id,
(SELECT 
  user_id,
  spend,
  ROW_NUMBER() OVER (PARITION BY user_id, transaction_id ORDER BY transaction_date ASC) as transaction_rank
FROM user_transactions) t
WHERE t.spend >= 50 and transaction_rank = 1

-- # 10
WITH base_table as (
SELECT
  user_id,
  DATE(tweet_date) as tweet_date,
  COUNT(tweet_id) as num_tweets
FROM tweets
GROUP BY user_id, tweet_date
ORDER BY 1,2)

SELECT
  user_id,
  tweet_date,
  AVG(num_tweets) OVER (PARTITION BY user_id ORDER BY tweet_date ROWS BETWEEN 6 preceeding and current row ) as rolling_avg
FROM base_table

-- #11
SELECT
  t.user_id,
  t.spend,
  t.transaction_date
(SELECT
  user_id,
  spend,
  transaction_date,
  ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY transaction_date ASC) transaction_rank
FROM transactions ) t
WHERE transaction_rank = 3

-- #12 
SELECT
  t2.category_id,
  t2.product_id,
  t2.total_spend
FROM (
SELECT
  t.category_id,
  t.product_id,
  t.total_spend,
  DENSE_RANK() OVER (PARTITION BY t.category_id, t.product_id ORDER BY t.total_spend DESC) as spend_rank
FROM 
(SELECT
  category_id,
  product_id,
  SUM(spend) total_spend
FROM product_spend
WHERE transaction_date BETWEEN '2020-01-01' AND '2020-12-31'
GROUP BY 1,2) t) t2
WHERE t2.spend_rank <= 3

-- #13

WITH base_table AS (
  SELECT
    *,
    RANK() OVER (PARTITION BY user_id ORDER BY (DATE(transaction_date)) as lastest_transaction_rank
  FROM user_transactions
)

SELECT
  transaction_date,
  COUNT(DISTINCT user_id),
  COUNT(product_id)
FROM base_table
WHERE lastest_transaction_rank = 1
GROUP BY 1 
ORDER BY transaction_date DESC

-- #22

-- create list of top 100 most popular topic for '2021-01-01'
with top_topic as (
SELECT
  topic_id
FROM topic_rankings
WHERE ranking_date = '2021-01-01' and ranking  <= 100)

SELECT
  user_id
FROM user_topics
WHERE follow_date <= '2021-01-01' AND topic_id NOT IN (
  SELECT
  topic_id
  FROM topic_rankings
  WHERE ranking_date = '2021-01-01' and ranking  <= 100)

-- #23

SELECT 
  DATE_TRUNC('month', curr_month.timestamp) as 'month',
  COUNT(distinct curr_month.user_id) as retained_users
FROM user_actions curr_month
WHERE EXSITS (
  SELECT
    *
  FROM user_actions last_month
  WHERE add_month(DATE_TRUNC('month', last_month.timestamp) -1) = DATE_TRUNC('month', curr_month.timestamp)
  )
GROUP BY 1
ORDER BY 1

-- #24
with base_table as (
SELECT
  session_type,
  user_id,
  SUM(duration) as total_duration
FROM sessions
WHERE start_time BETWEEN '2021-01-01' AND '2021-02-01'
GROUP BY 1,2)

SELECT
  user_id,
  session_type,
  RANK() OVER (PARTITION BY user_id, session_type ORDER BY user_id,  total_duration DESC) as user_rank
FROM base_table
ORDER BY session_type, user_rank DESC

-- # 25
SELECT
  b.age_bucket,
  ROUND(SUM(CASE WHEN type = 'send' THEN time_spent ELSE 0 END)/ SUM(time_spent)*100,2)  as time_spent_sending,
  ROUND(SUM(CASE WHEN type = 'open' THEN time_spent ELSE 0 END)/ SUM(time_spent)*100,2)  as time_spent_sending,
FROM activities a
INNER JOIN age_breakdown  b ON a.user_id = b.user_id
GROUP BY b.age_bucket
ORDER BY b.age_bucket

-- #26
SELECT
  s1.seassion_id,
  COUNT(s2.seassion_id) as concurrence
FROM sessions s1
INNER JOIN sessionss2 ON s1.session_id != s2.seassion_id
  AND s2.start_time BETWEEN s1.start_time AND s1.end_time
GROUP BY
  s1.seassion_id
ORDER BY
  concurrence DESC
LIMIT 1

-- # 27

WITH top_rated_businesses as (
  SELECT
    business_id
  FROM reviews
  GROUP BY business_id
  HAVING MIN(review_stars) >= 4)

SELECT
  COUNT(distinct t.business_id) as num_top_rated,
  ROUND(COUNT(distinct t.business_id)/COUNT(distinct s.business_id)::FLOAT *100,2) as perc_top_rated
FROM  reviews r
LEFT JOIN top_rated_businesses t ON t.business_id = r.business_id

)
-- #28
with base_table as (
SELECT
  DATE(measurement_time) as measurement_date
  measurement_value,
  ROW_NUMBER() OVER (PARTITION BY DATE(measurement_time) ORDER BY measurement_time) as rn_day
FROM measurements
GROUP BY 1
ORDER BY 1)

SELECT
  measurement_date,
  SUM(CASE WHEN rn_day % 2 != 0 THEN measurement_value else 0 END) as odd_val,
  SUM(CASE WHEN rn_day % 2 = 0 THEN measurement_value else 0 END) as even_val, 
FROM base_table
GROUP BY 1
ORDER BY 1

-- #29

-- 1) left join user_purchases to signups to keep all users that never made a purchase 
-- 2) apply the filter for users in the past week (involuves using current_date - 7)
-- count the number of users that made one 1 purchase i.e prodict_id is not NULL
-- count total number of users

SELECT
  ROUNd(COUNT(distinct p.user_id)/count(distinct s.user_id)::FLOAT *100,2) as perc_purchased_lastweek
FROM signups s
LEFT JOIN user_purchases p ON s.user_id = p.user_id
WHERE signup_date > current_date -7

-- #30

-- find top 10 products that are purchased together

WITH (
  SELECT
    t.user_id,
    p.product_name,
    t.transaction_id
  FROM transactions t
  INNER JOIN product p on t.product_id = p.product_id
) as purchase_info

SELECT
  p1.product_name as product1,
  p2.product_name as product2,
  COUNt(*)
FROM purchase_info p1
INNER JOIN purchase_info p2 ON p1.transaction_id = p2.transaction_id AND p1.product_id < p2.product_id
GROUP BY 1,2
ORDER BY 3 DESC
LIMIT 10

-- #31

-- 1) create a list of users that were online the previous month
-- 2) left join that list of users to list of users online in the ucrrent month
-- 3) count when this month user is not null and previous month user is null

with (
  SELECT
    DISTINCT user_id
  FROM user_logins
  WHERE month(login_date) = MONTH(getdate()) - 1
) as last_month_user

SELECT
  COUNT(DISTINCT CASE WHEN curr_month.user_id IS NOT NULL AND last_month_user.user_id IS NULL) as reactivated_users
FROM user_logins curr_month 
LEFT JOIN last_month_user ON curr_month.user_id = last_month_user.user_id
WHERE month(curr_month.login_date) = MONTH(getdate())

-- #32
WITH weekly_spend as (
  SELECT
    DATEPART('week', DATE(transaction_date)) as week,
    product_id,
    SUM(spend)
  FROM user_transactions
  GROUP BY week, product_id
)

WITH total_weekly_spend as (
  SELECT
    w.*,
    LAG(total_spend) OVER (PARTITION BY product_id ORDER BY week) as total_prev_spend
  FROm weekly_spend w
)

SELECT
  product_id,
  total_spend,
  total_prev_spend,
  total_spend/total_prev_spend as spend yoy
FROM total_weekly_spend


-- #33
with base_table as (
SELECT
  DATE(transaction_date) as transaction_date,
  SUM(amount) as total_amount
FROM user_transactions
GROUP BY 1)

SELECT
  transaction_date,
  SUM(total_amount) OVER (ORDER BY transaction_date ROWS BETWEEN 6 preceeding and current row) as rolling_earning
from base_table

  `