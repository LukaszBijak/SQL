SELECT
	time_period,
    SUM(ordered) / COUNT(website_session_id) AS conv_rate,
    AVG(price_usd) AS aov,
    SUM(items_purchased) / SUM(ordered) AS product_per_order,
    SUM(price_usd)/ COUNT(website_session_id) AS revenue_per_session
    
FROM(
SELECT 
	website_pageviews.website_session_id,
    CASE WHEN orders.order_id > 0 THEN 1 ELSE 0 END AS ordered,
    price_usd,
    items_purchased,
    CASE WHEN website_pageviews.created_at BETWEEN '2013-11-12' AND '2013-12-12' THEN 'A.Pre_Birthday_Bear'
		 WHEN website_pageviews.created_at BETWEEN '2013-12-12' AND '2014-01-12' THEN 'B.Post_Birthday_Bear' ELSE NULL END AS time_period
FROM website_pageviews
LEFT JOIN orders ON website_pageviews.website_session_id = orders.website_session_id
WHERE website_pageviews.created_at BETWEEN '2013-11-12' AND '2014-01-12'
GROUP BY 1
) as tmp
GROUP BY 1;