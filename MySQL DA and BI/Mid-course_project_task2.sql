SELECT
    MONTH(website_sessions.created_at) AS month,
    COUNT(CASE WHEN website_sessions.utm_campaign = 'nonbrand' THEN website_sessions.website_session_id END) AS nonbrand_sessions,
    COUNT(CASE WHEN website_sessions.utm_campaign = 'nonbrand' THEN orders.order_id END) AS nonbrand_orders,
    COUNT(CASE WHEN website_sessions.utm_campaign = 'nonbrand' THEN orders.order_id END) / COUNT(CASE WHEN website_sessions.utm_campaign = 'nonbrand' THEN website_sessions.website_session_id END) AS nonbrand_ratio,
    COUNT(CASE WHEN website_sessions.utm_campaign = 'brand' THEN website_sessions.website_session_id END) AS brand_sessions,
    COUNT(CASE WHEN website_sessions.utm_campaign = 'brand' THEN order_id END) AS brand_orders,
    COUNT(CASE WHEN website_sessions.utm_campaign = 'brand' THEN order_id END) / COUNT(CASE WHEN website_sessions.utm_campaign = 'brand' THEN website_sessions.website_session_id END) AS brand_ratio
--     ROUND((COUNT(orders.order_id) /  COUNT(website_sessions.website_session_id)),4)*100 AS conversion_in_percent
FROM website_sessions
LEFT JOIN orders ON website_sessions.website_session_id = orders.website_session_id
WHERE website_sessions.created_at BETWEEN '2012-03-01' AND '2012-11-27' 
	AND website_sessions.utm_source = 'gsearch'
GROUP BY MONTH(website_sessions.created_at);
