SELECT 
	utm_source, 
	utm_campaign,
    http_referer,
    COUNT(website_session_id) AS sessions
FROM mavenfuzzyfactory.website_sessions
WHERE created_at < '2012-04-12'
GROUP BY utm_source, utm_campaign, http_referer;
