-- |age bucket | time_spent_sending as % | timtime spent opening snaps 

SELECT 
  x.age_bucket,
  ROUND(x.send_time/x.total_time::FLOAT *100 ,2) as send_time_perc,
  ROUND(x.open_time/x.total_time::FLOAT *100 ,2) as open_time_perc
FROM 
(SELECT 
  age_breakdown.age_bucket,
  SUM(CASE WHEN activities.type = 'send' THEN activities.duration ELSE 0 END) send_time,
  SUM(CASE WHEN activities.type = 'open' THEN actitivities.duration ELSE 0 END) open_time,
  SUM(duration) as total_time
FROM activities 
INNER JOIN age_breakdown ON activities.user_id = age_breakdown.user_id
WHERE activities.type IN ('send','open')
GROUP BY 1) as x

