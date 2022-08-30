 SELECT
	MONTH(website_sessions.created_at) AS month,
    COUNT(website_sessions.website_session_id) AS sessions,
    COUNT(orders.order_id) AS orders
 FROM website_sessions
 LEFT JOIN orders ON website_sessions.website_session_id = orders.website_session_id
 WHERE website_sessions.created_at BETWEEN '2012-01-01' AND '2012-12-31'
 GROUP BY 1;
 

   SELECT
	DATE(MIN(website_sessions.created_at)) AS week_start,
    COUNT(website_sessions.website_session_id) AS sessions,
    COUNT(orders.order_id) AS orders
 FROM website_sessions
 LEFT JOIN orders ON website_sessions.website_session_id = orders.website_session_id
 WHERE website_sessions.created_at BETWEEN '2012-01-01' AND '2012-12-31'
 GROUP BY WEEK(website_sessions.created_at);