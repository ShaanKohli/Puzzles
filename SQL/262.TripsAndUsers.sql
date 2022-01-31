SELECT
    request_at as Day,
    ROUND(COUNT(DISTINCT CASE WHEN status IN ('cancelled_by_driver', 'cancelled_by_client') THEN t.id ELSE NULL END)/COUNT(DISTINCT t.id),2)  as 'Cancellation Rate'
FROM Trips t
INNER JOIN users drivers ON drivers.users_id = t.driver_id AND drivers.banned = 'No'
INNER JOIN users clients ON clients.users_id = t.client_id AND clients.banned = 'No'
WHERE request_at BETWEEN '2013-10-01' AND '2013-10-03'
GROUP BY request_at