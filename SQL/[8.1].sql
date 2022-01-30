-- get clickrate through rate for each app in 2019

-- events: app_id | event_id | timestamp

SELECT
  app_id,
  COUNT(CASE WHEN event_id = 'click' THEN event_id ELSE NULL END)/ COUNT(CASE WHEN event_id = 'Impression' THEN event_id ELSE NULL END) as CTR
FROM events
WHERE YEAR(datetime) = 2019
GROUP BY app_id