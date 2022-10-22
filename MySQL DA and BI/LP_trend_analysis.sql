CREATE TEMPORARY TABLE temp_tab
SELECT 
	website_pageviews.pageview_url,
    website_pageviews.website_session_id,
	WEEK(website_pageviews.created_at) AS week,
    MIN(DATE(website_pageviews.created_at)) AS week_start_datee,
    COUNT(website_pageviews.website_pageview_id) AS nr_of_pageviews
FROM website_pageviews
INNER JOIN website_sessions 
	ON website_pageviews.website_session_id = website_sessions.website_session_id
WHERE website_pageviews.created_at BETWEEN '2012-06-01' AND '2012-08-31' 
	AND utm_source = 'gsearch'
    AND utm_campaign = 'nonbrand'
GROUP BY website_pageviews.website_session_id;
drop table temp_tab;

SELECT 
    week_start_datee,
--    COUNT(*) AS total_sessions,
--    COUNT(CASE WHEN nr_of_pageviews = 1 THEN 1 END) AS bounced_sessions,
    COUNT(CASE WHEN nr_of_pageviews = 1 THEN 1 END) / COUNT(*) AS bounce_rate,
    COUNT(CASE WHEN pageview_url = '/home' THEN 1 END) AS home_sessions,
    COUNT(CASE WHEN pageview_url = '/lander-1' THEN 1 END) AS lander_sessions
FROM temp_tab
WHERE pageview_url IN ('/home', '/lander-1')
GROUP BY week;