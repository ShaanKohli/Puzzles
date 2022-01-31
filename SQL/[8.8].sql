-- job_listings: job_id | company_id | title | description | post_date
SELECT
  COUNT(DISTINCT t.company_id)
FROM (
SELECT
  company_id,
  title,
  description,
  row_number() OVER (PARTITION BY company_id, title, description ORDER BY post_date) as job_post_num
FROM job_listings) t
GROUP BY company_id
HAVING max(job_post_num) > 2
WHERE MAX(job_pust_num) > 2