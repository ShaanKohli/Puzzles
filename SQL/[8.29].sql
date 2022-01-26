-- of the users who joined in the past week write a query to obtain the % of users that also purchased at least one item?

-- sign ups: user_id | signup_date
-- user_purchases: user_id | product_id | purchase_amount | purchase_date

-- step 1 get all users who joined in the last week
-- step 2 get users where people purchases last week

SELECT
    ROUND(COUNT(DISTINCT CASE WHEN s.purchase_amount > 0 THEN s.user_id ELSE NULL END)/COUNT(DISTINCT s.user_id)::FLOAT *100,2)
FROM signups s
LEFT JOIN user_purchases u ON s.user_id = u.user_purchases
WHERE CAST(s.signup_date as DATE) >= current_date() -7 