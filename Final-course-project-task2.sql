SELECT 
	YEAR(website_sessions.created_at) AS yr,
    QUARTER(website_sessions.created_at) AS qr,
    COUNT(DISTINCT orders.order_id) / COUNT(DISTINCT website_sessions.website_session_id) * 100 AS session_to_order_prct,
    ROUND(SUM(orders.price_usd) / COUNT(DISTINCT orders.order_id),2) AS revenue_per_order,
    ROUND(SUM(orders.price_usd) / COUNT(DISTINCT website_sessions.website_session_id),2) AS revenue_per_session
FROM website_sessions
LEFT JOIN orders ON website_sessions.website_session_id = orders.website_session_id
WHERE website_sessions.created_at < '2015-01-01'
GROUP BY 1,2

