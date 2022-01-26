-- Query: Find the number and % of businesses that are top rated

-- top rated business  = business with 4 or 5 stars

-- reviews: | business_id | user_id | review_text | review_stars | review_date |



SELECT
  COUNT(CASE WHEN min_reviews >= 4 THEN business_id ELSE NULL END)/ COUNT(*) ::FLOAT *100 as % 
FROM 
(SELECT 
SELECT
  business_id,
  MIN(review_stars) as min_reviews
FROM reviews
GROUP BY business_id)

