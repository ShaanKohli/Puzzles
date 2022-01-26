-- we want the 1 user session that is overlapping with the most other user session

-- conditions for if (let c = current_session and o = other_session):
-- 1) c.start_time >= o.end_time and s.eend_time <= o.end_time
-- 2) c.start_time >= o.start_time and s.end_time > o.end_time 
-- 3) c.start_time <= 0.start_time and s.end_time 
SELECT
  session_id,
  COUNT(DISTINCT s2.session_id) as concurrence
SELECT
FROM sessions s1
INNER JOIN seassions s2 ON s1.session_id = s2.session_id AND (s2.start_time > s1.start_time) AND (s2.start_time <s1.end_time)
GROUP BY 
  s1.session_id
ORDER BY concurrence DESC
LIMIT 1