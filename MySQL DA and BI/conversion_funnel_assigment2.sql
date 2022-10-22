SELECT 
	*,
    MIN(created_at)
FROM website_pageviews
WHERE pageview_url = '/billing-2' ;

CREATE TEMPORARY TABLE orders_compl
SELECT
	website_pageviews.website_session_id,
    website_pageviews.pageview_url,
    COUNT(orders.order_id) AS completed_orders
FROM  website_pageviews
LEFT JOIN orders ON website_pageviews.website_session_id = orders.website_session_id
WHERE orders.created_at BETWEEN '2012-09-10' AND '2012-11-10'
 	AND website_pageviews.pageview_url  IN ('/billing', '/billing-2')
GROUP BY pageview_url;

SELECT
	website_pageviews.pageview_url,
    COUNT(website_pageviews.website_session_id) AS sessions,
    orders_compl.completed_orders AS orders,
    orders_compl.completed_orders / COUNT(website_pageviews.website_session_id) AS billing_to_order_rt
FROM  website_pageviews
LEFT JOIN orders_compl ON orders_compl.pageview_url = website_pageviews.pageview_url
WHERE website_pageviews.created_at BETWEEN '2012-09-10' AND '2012-11-10'
 	AND website_pageviews.pageview_url  IN ('/billing', '/billing-2')
GROUP BY website_pageviews.pageview_url;