 SELECT
	hr,
    AVG(CASE WHEN wk_day = 0 THEN sessions ELSE NULL END) AS mon,
	AVG(CASE WHEN wk_day = 1 THEN sessions ELSE NULL END) AS tue,
    AVG(CASE WHEN wk_day = 2 THEN sessions ELSE NULL END) AS wen,
    AVG(CASE WHEN wk_day = 3 THEN sessions ELSE NULL END) AS thu,
    AVG(CASE WHEN wk_day = 4 THEN sessions ELSE NULL END) AS fri,
    AVG(CASE WHEN wk_day = 5 THEN sessions ELSE NULL END) AS sat,
    AVG(CASE WHEN wk_day = 6 THEN sessions ELSE NULL END) AS sun
 FROM (
 SELECT
	DATE(created_at) AS cr_date,
    WEEKDAY(created_at) AS wk_day,
    HOUR(created_at) AS hr,
    COUNT(DISTINCT website_session_id) AS sessions
FROM website_sessions
WHERE created_at BETWEEN '2012-09-15' AND '2012-11-15'
GROUP BY 1,2,3
) AS temp_tab
 GROUP BY 1
 ORDER BY 1;
 
