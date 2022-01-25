-- filter '2021-01-01' i.e follow_date

-- did not follow any topic in top 100

-- sample output: | users |
WITH top_topics AS (
  SELECT 
    *
  FROM
    topic_rankings
  WHERE 
    ranking_date = '2021-01-01'
    and topic_rank < 100
)

SELECT 
  DISTINCT user_id
FROM user_topics
WHERE follow_date <= '2021-01-01'

MINUS

SELECT
  u.user_id
FROM user_topics u
INNER JOIN top_topics t ON u.topic_id = t.topic_id