SELECT 
	utm_source,
    COUNT(website_session_id)
FROM website_sessions
WHERE website_sessions.created_at BETWEEN '2012-03-01' AND '2012-11-27'
GROUP BY utm_source;

SELECT
    MONTH(website_sessions.created_at) AS month,
	COUNT(website_sessions.website_session_id) AS total_sessions,
    COUNT(CASE WHEN website_sessions.utm_source = 'gsearch' THEN website_sessions.website_session_id END) AS gsearch_sessions,
	COUNT(CASE WHEN website_sessions.utm_source = 'bsearch' THEN website_sessions.website_session_id END) AS bsearch_sessions,
    COUNT(CASE WHEN website_sessions.utm_source IS NULL THEN website_sessions.website_session_id END) AS non_search_sessions
FROM website_sessions
LEFT JOIN orders ON website_sessions.website_session_id = orders.website_session_id
WHERE website_sessions.created_at BETWEEN '2012-03-01' AND '2012-11-27' 
GROUP BY MONTH(website_sessions.created_at);

