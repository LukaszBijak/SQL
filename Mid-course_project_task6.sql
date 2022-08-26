SELECT 
	website_pageviews.pageview_url,
    COUNT(website_pageviews.website_session_id) AS sessions,
    SUM(CASE WHEN order_id IS NULL THEN 0 ELSE 1 END) AS ordered,
    SUM(CASE WHEN order_id IS NULL THEN 0 ELSE 1 END) / COUNT(website_pageviews.website_session_id) AS conv_rate
FROM website_pageviews
LEFT JOIN website_sessions 
	ON website_pageviews.website_session_id = website_sessions.website_session_id
LEFT JOIN orders
	ON website_pageviews.website_session_id = orders.website_session_id
WHERE website_pageviews.created_at BETWEEN '2012-06-19' AND '2012-07-28' 
	AND utm_source = 'gsearch'
    AND utm_campaign = 'nonbrand'
    AND website_pageviews.pageview_url IN ('/home','/lander-1')
GROUP BY pageview_url;
-- Conversion rate grows from 0.0318 to 0.0406 = 0.0088

-- when the test ended? (last using of /home as landing page):
SELECT
	MAX(website_pageviews.website_session_id)
FROM website_pageviews
LEFT JOIN website_sessions ON website_pageviews.website_session_id = website_sessions.website_session_id
WHERE website_pageviews.pageview_url = '/home'
	AND website_pageviews.created_at < '2012-11-27'
	AND website_sessions.utm_source = 'gsearch'
    AND website_sessions.utm_campaign = 'nonbrand';
-- Last /home as landing page was used at 17145 website_session


-- check nr of orders since last using /home 
SELECT 
    COUNT(website_sessions.website_session_id) AS nr_of_orders_from_new_LP
FROM website_sessions
WHERE website_sessions.created_at < '2012-11-27' 
	AND website_sessions.website_session_id > 17145
	AND website_sessions.utm_source = 'gsearch'
    AND website_sessions.utm_campaign = 'nonbrand';
-- 22972 orders with new landing page

SELECT
	AVG(price_usd) AS avarage_order_value,
	ROUND(22972 * 0.0088) AS orders_increased,
    ROUND(22972 * 0.0088 * AVG(price_usd)) AS revenue_increased_usd
FROM orders
LEFT JOIN website_sessions ON orders.website_session_id = website_sessions.website_session_id
WHERE orders.created_at < '2012-11-27' 
	AND orders.website_session_id > 17145
	AND website_sessions.utm_source = 'gsearch'
    AND website_sessions.utm_campaign = 'nonbrand';
 
