SELECT 
	utm_source,
	COUNT(DISTINCT website_session_id) AS total_sessions,
    COUNT(DISTINCT CASE WHEN device_type = 'mobile' THEN website_session_id ELSE NULL END) AS mobile_sessions,
    COUNT(DISTINCT CASE WHEN device_type = 'mobile' THEN website_session_id ELSE NULL END) / COUNT(website_session_id) AS mobile_ratio,
    COUNT(DISTINCT CASE WHEN device_type = 'desktop' THEN website_session_id ELSE NULL END) AS desktop_sessions,
    COUNT(DISTINCT CASE WHEN device_type = 'desktop' THEN website_session_id ELSE NULL END) / COUNT(website_session_id) AS desktop_ratio
FROM website_sessions
WHERE created_at BETWEEN '2012-08-22' AND '2012-11-30'
	AND utm_campaign = 'nonbrand'
GROUP BY 1
