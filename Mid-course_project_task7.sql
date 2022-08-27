CREATE TEMPORARY TABLE orders_compl
SELECT
	website_pageviews.website_session_id,
    website_pageviews.pageview_url,
    COUNT(orders.order_id) AS completed_orders
FROM  website_pageviews
LEFT JOIN orders ON website_pageviews.website_session_id = orders.website_session_id
WHERE orders.created_at BETWEEN '2012-06-19' AND '2012-07-28'
 	AND website_pageviews.pageview_url  IN ('/home', '/lander-1')
GROUP BY pageview_url;

SELECT
	website_pageviews.pageview_url,
    COUNT(website_pageviews.website_session_id) AS sessions,
    orders_compl.completed_orders AS orders,
    orders_compl.completed_orders / COUNT(website_pageviews.website_session_id) AS lander_to_order_ratio
FROM  website_pageviews
LEFT JOIN orders_compl ON orders_compl.pageview_url = website_pageviews.pageview_url
WHERE website_pageviews.created_at BETWEEN '2012-06-19' AND '2012-07-28'
 	AND website_pageviews.pageview_url  IN ('/home', '/lander-1')
GROUP BY website_pageviews.pageview_url;