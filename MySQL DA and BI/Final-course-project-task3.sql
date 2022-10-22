SELECT 
	YEAR(website_sessions.created_at) AS yr,
    QUARTER(website_sessions.created_at) AS qr,
    COUNT(CASE WHEN utm_source = 'gsearch' AND utm_campaign = 'nonbrand' THEN 1 ELSE NULL END) AS 'Gsearch nonbrand',
    COUNT(CASE WHEN utm_source = 'bsearch' AND utm_campaign = 'nonbrand' THEN 1 ELSE NULL END) AS 'Bsearch nonbrand',
    COUNT(CASE WHEN utm_campaign = 'brand' THEN 1 ELSE NULL END) AS 'brand',
    COUNT(CASE WHEN utm_source IS NULL AND http_referer IN ('https://www.gsearch.com','https://www.bsearch.com') THEN 1 ELSE NULL END) AS 'organic_search',
    COUNT(CASE WHEN utm_source IS NULL AND http_referer IS NULL THEN 1 ELSE NULL END) AS 'direct_type_in'     
FROM website_sessions
LEFT JOIN orders ON website_sessions.website_session_id = orders.website_session_id
WHERE website_sessions.created_at < '2015-01-01'
	AND order_id > 0
GROUP BY 1,2


