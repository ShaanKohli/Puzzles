-- for each session id there will be some duration that is positive for that type 
-- we will aggregate to capture all sesiion_id for each session type
SELECT 
  x.user_id,
  x.session_type,
  rank() OVER (PARTITION BY x.user_id, x.session_type ORDER BY x.total_duration_time DESC ) as rank_duration
FROM (

(SELECT 
  s.user_id,
  s.session_type,
  SUM(s.duration) as total_session_time
FROM sessions as s
WHERE DATE(start_time) BETWEEN '2021-01-01' AND '2021-02-01')
GROUP BY 1,2
)
ORDER BY 2,3