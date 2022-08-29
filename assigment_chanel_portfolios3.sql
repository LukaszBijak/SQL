SELECT
	utm_source,
 	COUNT(DISTINCT website_sessions.website_session_id) AS total_sessions,
    COUNT(DISTINCT CASE WHEN device_type = 'mobile' THEN website_sessions.website_session_id ELSE NULL END) AS mobile_sessions,
    COUNT(DISTINCT CASE WHEN device_type = 'mobile' AND order_id > 0  THEN  order_id ELSE NULL END) / COUNT(DISTINCT CASE WHEN device_type = 'mobile' THEN website_sessions.website_session_id ELSE NULL END) AS mobile_to_orders,
    COUNT(DISTINCT CASE WHEN device_type = 'desktop' THEN website_sessions.website_session_id ELSE NULL END) AS desktop_sessions,
    COUNT(DISTINCT CASE WHEN device_type = 'desktop' AND order_id > 0  THEN  order_id ELSE NULL END) /COUNT(DISTINCT CASE WHEN device_type = 'desktop' THEN website_sessions.website_session_id ELSE NULL END)  AS desktop_to_orders

FROM website_sessions
LEFT JOIN orders ON website_sessions.website_session_id = orders.website_session_id
WHERE  website_sessions.created_at BETWEEN '2012-08-22' AND '2012-09-18'
	AND utm_campaign = 'nonbrand'
GROUP BY 1