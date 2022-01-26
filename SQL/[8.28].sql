-- Get sum of odd numbered and even numbered measurements by date

-- measurements: |measurement_id|measurement_value| measurement_time

SELECT
  DATE(measurement_time),
  SUM(CASE WHEN measurement_value % 2 = 0 THEN measurement_value ELSE NULL END) as even_measure,
  SUM(CASE WHEN measurement_value % 2 != 0 THEN measurement_value ELSE NULL END) as odd_measure
FROM measurements
GROUP BY 
  DATE(measurement_time)


-- need to label which measurement are odd and even
SELECT 
  date_measurement,
  SUM(CASE WHEN row_measure % 2 = 0 then measurement_value else null end) as even_measure,
  SUM(CASE WHEN row_measure % 2 != 0 then measurement_value else null end) as odd_measure,
FROM (
SELECT
  CAST(measurement_time as DATE ) as date_measurement,
  measurement_value,
  ROW_NUMBER() OVER (PARTITION BY date_measurement ORDER BY date_measurement) as row_measure
  ORDER BY date_measurement)
GROUP BY 
  date_measurement
