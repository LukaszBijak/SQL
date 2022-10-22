SELECT
	*,
    MIN(created_at)
FROM website_pageviews
WHERE pageview_url = '/lander-1';


CREATE TEMPORARY TABLE temp_tab
SELECT 
	website_pageviews.pageview_url,
    website_pageviews.website_session_id,
    website_sessions.utm_source,
    website_sessions.utm_campaign,
    COUNT(website_pageviews.website_pageview_id) AS nr_of_pageviews
FROM website_pageviews
INNER JOIN website_sessions 
	ON website_pageviews.website_session_id = website_sessions.website_session_id
WHERE website_pageviews.created_at BETWEEN '2012-06-19' AND '2012-07-28' 
	AND utm_source = 'gsearch'
    AND utm_campaign = 'nonbrand'
GROUP BY website_pageviews.website_session_id;


SELECT 
	pageview_url,
    COUNT(*) AS sessions,
    COUNT(CASE nr_of_pageviews WHEN nr_of_pageviews = 1 THEN 1 END) AS bounced_sessions,
    COUNT(CASE nr_of_pageviews WHEN nr_of_pageviews = 1 THEN 1 END) / COUNT(*) AS bounce_rate
FROM temp_tab
GROUP BY pageview_url;