SELECT
    YEAR(website_sessions.created_at) AS year,
    MONTH(website_sessions.created_at) AS month,
    COUNT(website_sessions.website_session_id) AS total_sessions,
    COUNT(orders.order_id) AS placed_orders
FROM website_sessions
LEFT JOIN orders ON website_sessions.website_session_id = orders.website_session_id
WHERE website_sessions.created_at BETWEEN '2012-03-01' AND '2012-11-27' 
	AND website_sessions.utm_source = 'gsearch'
GROUP BY MONTH(website_sessions.created_at)