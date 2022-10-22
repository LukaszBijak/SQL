CREATE TEMPORARY TABLE second_session
SELECT 
	user_id,
    MIN(created_at) AS second_session_date
FROM website_sessions
WHERE created_at BETWEEN '2014-01-01' AND '2014-11-01'
AND is_repeat_session = 1
GROUP BY 1;

SELECT
    AVG(DATEDIFF(second_session_date,created_at)) AS avg_days_first_to_second,
    MIN(DATEDIFF(second_session_date,created_at)) AS min_days_first_to_second,
    MAX(DATEDIFF(second_session_date,created_at)) AS max_days_first_to_second
FROM website_sessions
LEFT JOIN second_session on website_sessions.user_id = second_session.user_id
WHERE created_at BETWEEN '2014-01-01' AND '2014-11-01'
 	AND is_repeat_session = 0;