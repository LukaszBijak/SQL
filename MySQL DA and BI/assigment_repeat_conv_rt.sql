SELECT 
	is_repeat_session,
	COUNT(website_sessions.website_session_id) AS sessions,
    COUNT(order_id) /COUNT(website_sessions.website_session_id) AS conv_rate,
    SUM(price_usd) / COUNT(website_sessions.website_session_id) as rev_per_session
FROM website_sessions
LEFT JOIN orders ON website_sessions.website_session_id = orders.website_session_id
WHERE website_sessions.created_at BETWEEN '2014-01-01' AND '2014-11-08'
GROUP BY 1