-- write a query to obtain a histgram of tweets posted per user in 2020
-- the key is to get the number of tweets per user, count(users)

SELECT 
  num_tweets,
  count(user_id) as num_users
FROM (
SELECT 
  user_id,
  COUNT(tweet_id) as num_tweets
FROM tweets
WHERE  tweet_date between '2020-01-01' AND '2020-12-31'
GROUP BY user_id  ) total_tweets
GROUP BY num_tweets
ORDER BY num_tweets ASC