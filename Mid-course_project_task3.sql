SELECT
    MONTH(website_sessions.created_at) AS month,
    COUNT(CASE WHEN website_sessions.device_type = 'mobile' THEN website_sessions.website_session_id END) AS mobile_sessions,
    COUNT(CASE WHEN website_sessions.device_type = 'mobile' THEN orders.order_id END) AS mobile_orders,
    COUNT(CASE WHEN website_sessions.device_type = 'desktop' THEN website_sessions.website_session_id END) AS desktop_sessions,
    COUNT(CASE WHEN website_sessions.device_type = 'desktop' THEN order_id END) AS desktop_orders
FROM website_sessions
LEFT JOIN orders ON website_sessions.website_session_id = orders.website_session_id
WHERE website_sessions.created_at BETWEEN '2012-03-01' AND '2012-11-27' 
	AND website_sessions.utm_source = 'gsearch'
    AND website_sessions.utm_campaign = 'nonbrand'
GROUP BY MONTH(website_sessions.created_at);

SELECT DISTINCT(device_type) FROM  website_sessions;