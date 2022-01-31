-- calculate the 7 day rolling day average of tweets by each user for every date

-- get total number of tweets
SELECT
  user_id,
  tweet_date,
  AVG(num_tweets) OVER (PARTITION BY user_id ORDER BY user_id, tweet_date ROWS BETWEEN 6 preceeding and current row) as rolling_avg
FROM (
SELECT 
  user_id,
  CAST(tweet_date as DATE) as tweet_date,
  COUNt(distinct tweet_id) as num_tweets
FROM tweets
GROUP BY 1,2)  t1