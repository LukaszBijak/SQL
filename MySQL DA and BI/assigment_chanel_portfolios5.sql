SELECT
	MONTH(created_at) AS month,
	COUNT(CASE WHEN utm_campaign = 'nonbrand'  THEN website_session_id ELSE NULL END) as nonbrand,
    COUNT(CASE WHEN utm_campaign = 'brand'  THEN website_session_id ELSE NULL END) as brand,
    COUNT(CASE WHEN utm_campaign = 'brand'  THEN website_session_id ELSE NULL END) / COUNT(CASE WHEN utm_campaign = 'nonbrand'  THEN website_session_id ELSE NULL END) AS brand_share,
    COUNT(CASE WHEN utm_source IS NULL AND http_referer IS NULL THEN website_session_id ELSE NULL END) AS direct,
    COUNT(CASE WHEN utm_source IS NULL AND http_referer IS NULL THEN website_session_id ELSE NULL END) / COUNT(CASE WHEN utm_campaign = 'nonbrand'  THEN website_session_id ELSE NULL END) AS direct_share,
    COUNT(CASE WHEN utm_source IS NULL AND http_referer IS NOT NULL THEN website_session_id ELSE NULL END) AS organic,
	COUNT(CASE WHEN utm_source IS NULL AND http_referer IS NOT NULL THEN website_session_id ELSE NULL END) / COUNT(CASE WHEN utm_campaign = 'nonbrand'  THEN website_session_id ELSE NULL END) organic_share
FROM website_sessions
WHERE created_at < '2012-12-23'
GROUP BY 1