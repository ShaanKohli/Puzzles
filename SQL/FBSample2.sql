-- Sample Rows: searches
-- date | search_id | user_id | age_group | search_query
-- --------------------------------------------------------------------
-- '2020-01-01' | 101 | 9991 | '<30' | 'justin bieber'
-- '2020-01-01' | 102 | 9991 | '<30' | 'menlo park'
-- '2020-01-01' | 103 | 5555 | '30-50' | 'john'
-- '2020-01-01' | 104 | 1234 | '50+' | 'funny cats'


-- Sample Rows: search_results
-- date | search_id | result_id | result_type | clicked
-- --------------------------------------------------------------------
-- '2020-01-01' | 101 | 1001 | 'page' | TRUE
-- '2020-01-01' | 101 | 1002 | 'event' | FALSE
-- '2020-01-01' | 101 | 1003 | 'event' | FALSE
-- '2020-01-01' | 101 | 1004 | 'group' | FALSE

-- Over the last 7 days, how many users made more than 10 searches?
SELECT
  DISTINCT x.user_id
FROM (
SELECT
  user_id,
  count(distinct search_id) as num_searches
FROM 
  searches
WHERE date  > current_date - 7
GROUP BY user_id
HAVING COUNT(DISTINCT search_id) > 10) as x