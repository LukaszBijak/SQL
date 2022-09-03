SELECT
	CASE WHEN nr_of_sessions = 1 THEN 0 
		 WHEN nr_of_sessions = 2 THEN 1
         WHEN nr_of_sessions = 3 THEN 2
         WHEN nr_of_sessions = 4 THEN 3
         ELSE 'more than 3...'  END AS repeat_sessions,
	COUNT(user_id) AS users
FROM(
SELECT
	user_id,
    COUNT(website_session_id) as nr_of_sessions
FROM website_sessions
WHERE created_at BETWEEN '2014-01-01' AND '2014-11-01'
GROUP BY 1
) AS session_per_user
GROUP BY 1