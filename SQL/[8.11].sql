-- get third transaction for every user
SELECT
  user_id,
  spend,
  trasaction_date
FROM (
SELECT
  *,
  row_number() OVER (PARTITION by user_id ORDER BY trasaction_date ASC) as trans_rank
FROM transactions) t1
WHERE trans_rank = 3