SELECT
	YEAR(created_at) AS year,
	WEEK(created_at) AS week,
    MIN(DATE(created_at)) AS week_start,
    MAX(DATE(created_at)) AS week_end,
	COUNT(website_session_id) AS sessions,
    CASE WHEN COUNT(website_session_id) < 2000 THEN 'low' 
		 WHEN COUNT(website_session_id) < 3000 THEN 'mid'
         ELSE 'high' END AS week_status
FROM website_sessions
GROUP BY YEAR(created_at), WEEK(created_at)
HAVING year = '2013'
ORDER BY sessions DESC;

