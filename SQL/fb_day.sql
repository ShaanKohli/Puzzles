-- 8.22

WITH top_100_topics AS (
  SELECT
    topic_id
  FROM topic_rankings
  WHERE ranking_date = '2021-01-01' AND ranking < =100

)

SELECT
  DISTINCT user_id
FROM  user_topics
WHERE follow_date <= '2021-01-01'

MINUS

SELECT
  u.user_id
FROM user_topics u 
INNER JOIN top_100_topics t ON u.topic_id = t.topic_id

--8.23
-- get active user retention by month

-- month | current_active_users | prior_Active user_topics

-- 1) write a query to get the active users per month

SELECT
  DATE_TRUNC('month', curr_month.timestamp) as 'month',
  COUNT(DISTINCT curr_month.user_id) as retained_users,
  ROUND(COUNT(DISTINCT curr_month.user_id) / 1.0*COUNT(DISTINCT last_month.user_id)*100,2) as perc_retained
FROM user_actions curr_month
LEFT JOIN user_actions last_month ON last_month.user_id = curr_month.user_id AND DATE_TRUNC('month', curr_month.timestamp) -1 = DATE_TRUNC('month', last_month.timestamp)
GROUP BY 1

-- 8.24

-- 1) create a atable with aggregated information about total session_duration 

WITH total_session_duration AS (
  SELECT
    user_id,
    session_type,
    SUM(duration) as total_duration
  FROM sessions
  WHERE DATE(start_time) BETWEEN '2021-01-01' AND '2021-02-01'
  GROUP BY
    user_id,
    session_type
)

-- 2) write a query that ranks users for each type of session_duration

SELECT
  user_id,
  session_type,
  dense_rank() OVER (PARTITION BY user_id, session_type ORDER BY user_id, total_duration DESC) as rank_user_type
FROM total_session_duration
ORDER BY session_type, rank_user_type DESC

-- 8.25

SELECT
  b.age_bucket,
  ROUND(SUM(CASE WHEN type = 'send' THEN time_spent ELSE 0 END)/ SUM(time_spent)*100,2) as time_send_perc,
  ROUND(SUM(CASE WHEN type = 'open' THEN time_spent ELSE 0 END)/ SUM(time_spent)*100,2) as time_open_perc
FROM activities a
INNER JOIN age_breakdown b ON a.user_id = b.user_id 
WHERE type IN ('send','open')
GROUP BY b.age_bucket

-- 8.26

--get the user session that is concurrent with the largest nubmer of other user sessions
SELECT
  s1.session_id,
  COUNT(s2.session_id) as concurrents
FROM sessions s1
INNER JOIN sessions s2 on s2.start_time BETWEEN s1.start_time AND s1.end_time AND s1.session_id != s2.session_id
GROUP BY s1.session_id
ORDER BY concurrents DESC
LIMIT 1

-- 8.27

-- 1) getting a top_rated business

WITH top_rated_business as (
  SELECT
    business_id,
    MIN(review_stars) as min_rating
  FROM reviews
GROUP BY 1
)

SELECT
  COUNT(DISTINCT CASE WHEN min_rating >= 4 THEN business_id ELSE NULL END) as num_top_rated,
  ROUND(COUNT(DISTINCT CASE WHEN min_rating >= 4 THEN business_id ELSE NULL END)/COUNT(DISTINCT business_id)*1.0*100,2) as perc_top_rated 
FROM top_rated_business

-- 8.28

WITH numbered_records AS (
  SELECT
    measurement_id,
    measurement_value,
    measurement_time,
    ROW_NUMBER () OVER (PARTITION BY measurment_id ORDER BY measurement_time) rn  
  FROM measurements
)

SELECT
  SUM(CASE WHEN MOD(rn, 2) = 0  THEN measurment_value ELSE 0 END) as even_measurments,
  SUM(CASE WHEN MOD(rn, 2) != 0  THEN measurment_value ELSE 0 END) as odd_measurments
FROM numbered_records

-- 8.29

-- of the users who joined in the past week, what % purchased at leaast 1 item

SELECT
  ROUND(COUNT(DISTINCt p.user_id)/COUNT(DISTINCT s.user_id)*100.00,2) as perc_purchased
FROM signups s
LEFT JOIN user_purchases p ON s.user_id = p.user_id
WHERE s.signup_date > current_date - 7

--8.30
--get top 10 products most frequently bought together

-- first step is to create purchase info table
WITH purchase_info AS (
SELECT
  user_id,
  product_name,
  transaction_id
FROM transactions
INNER JOIN products ON transactions.product_id = products.product_id)

SELECT
  p1.product_id,
  p2.product_id,
  COUNt(*) cnt
FROM purchase_info p1
INNER JOIN purchase_info p2 ON p1.transaction_id = p2.transaction_id AND p1.product_id < p2.product_id
GROUP BY 1,2
ORDER by cnt DESC
LIMIT 10

--8.31

--get list of users that signup up in the previous month,
-- # reactivated users

SELECT
  DATE_TRUNC('month', curr_month.login_date) as 'month',
  COUNT(DISTINCT curr_month.user_id) as reactivated_users
FROM user_logins as curr_month
WHERE
  NOT EXISTS (
    SELECT
      *
    FROM user_logins last_month
    WHERE DATE_TRUNC('month',last_month.login_date) BETWEEN DATE_TRUNC('month',curr_month.login_date) AND DATE_TRUNC('month',curr_month.login_date) - INTERVAL '1 month'
  )

  -- 8.32

  -- get year over year gorwth rate for the total spend of each products ofr each week 

  -- create total_spend table
with total_spend as (
  SELECT
    DATE_TRUNC('week', trasnsaction_date) as 'week',
    product_id,
    SUM(spend) sum_spend
  FROM
   user_transactions
  GROUP BY
    1,2
)

-- create table with current spend and pst week spend
with complete_table as (
SELECT
  week,
  product_id,
  sum_spend,
  LAG(sum_spend, 1) OVER (PARTITION BY product_id ORDER BY week) as sum_spend_prior
FROM total_spend
ORDER BY week
)

SELECT
  week,
  ROUND(sum_spend/sum_spend_prior*100,2) as perc_growth
FROM complete_table
ORDER BY week

-- 8.33 
--get rolling 7 day earnings

WITH total_earnings as (
  SELECT
    DATE(transaction_date) trans_date,
    SUM(amount) as total_amt
  FROM user_transactions
  GROUP BY 1
)

SELECT
  trans_date,
  SUM(total_amt) OVER (ORDER BY trans_date ASC ROWS BETWEEN 6 preceeding and current row) as 7_day_rolling_sum
FROM total_earnings
ORDER BY trans_date