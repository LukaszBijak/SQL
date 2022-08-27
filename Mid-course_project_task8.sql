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
-- drop table orders_compl;
SELECT
	website_pageviews.pageview_url AS billing_page,
    COUNT(website_pageviews.website_session_id) AS sessions,
    orders_compl.completed_orders AS orders,
    SUM(orders.price_usd) / COUNT(website_pageviews.website_session_id) AS revenue_per_billing_page
FROM  website_pageviews
LEFT JOIN orders_compl ON orders_compl.pageview_url = website_pageviews.pageview_url
LEFT JOIN orders ON website_pageviews.website_session_id = orders.website_session_id
WHERE website_pageviews.created_at BETWEEN '2012-09-10' AND '2012-11-10'
 	AND website_pageviews.pageview_url  IN ('/billing', '/billing-2')
GROUP BY website_pageviews.pageview_url;