--  compare viewership between mobile and laptop where mobile = tablet + phone

SELECT
  SUM(CASE WHEN device_type = 'laptop' THEN 1 ELSE 0 END) views_laptop,
  SUM(CASE WHEN device_type IN ('phone','tablet') THEN 1 ELSE 0 END) views_mobile
FROM viewership
