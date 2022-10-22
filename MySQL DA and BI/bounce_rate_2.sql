CREATE TEMPORARY TABLE temp_tab
SELECT 
	pageview_url,
    website_session_id,
    COUNT(website_pageview_id) AS nr_of_pageviews
FROM website_pageviews
WHERE created_at < '2014-06-14'
GROUP BY website_session_id;

SELECT * FROM temp_tab;

SELECT 
	pageview_url,
    COUNT(*) AS sessions,
    COUNT(CASE nr_of_pageviews WHEN nr_of_pageviews = 1 THEN 1 END) AS bounced_sessions
FROM temp_tab
GROUP BY pageview_url;