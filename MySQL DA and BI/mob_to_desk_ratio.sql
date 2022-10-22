SELECT 
	MIN(DATE(website_sessions.created_at)) AS week_start_date,
    COUNT(CASE WHEN website_sessions.device_type = 'mobile' 
		THEN website_sessions.website_session_id 
        ELSE NULL END) AS mob_sessions,
    COUNT(CASE WHEN website_sessions.device_type = 'desktop' 
		THEN website_sessions.website_session_id 
        ELSE NULL END) AS desk_sessions,
	COUNT(CASE WHEN website_sessions.device_type = 'desktop' 
		THEN website_sessions.website_session_id 
        ELSE NULL END) / COUNT(CASE WHEN website_sessions.device_type = 'mobile' 
		THEN website_sessions.website_session_id 
        ELSE NULL END) AS ratio
FROM website_sessions
LEFT JOIN orders 
	ON orders.website_session_id = website_sessions.website_session_id
WHERE website_sessions.created_at BETWEEN '2012-04-15' AND '2012-06-09'
	AND utm_source = 'gsearch'
    AND utm_campaign = 'nonbrand'
GROUP BY WEEK(website_sessions.created_at);

select * from website_sessions



