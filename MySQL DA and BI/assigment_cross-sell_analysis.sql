 
CREATE TEMPORARY TABLE cart_to_shipp
SELECT 
	website_session_id,
    MAX(CASE WHEN pageview_url = '/cart' THEN 1 ELSE 0 END) as cart_page,
    MAX(CASE WHEN pageview_url = '/shipping' THEN 1 ELSE 0 END) as shipping_page,
    CASE WHEN created_at BETWEEN '2013-08-25' AND '2013-09-25' THEN 'A.Pre_Cross_Sell'
		 WHEN created_at BETWEEN '2013-09-25' AND '2013-10-25' THEN 'B.Post_Cross_Sell' ELSE NULL END AS time_period
FROM website_pageviews
WHERE created_at BETWEEN '2013-08-25' AND '2013-10-25'
	AND pageview_url IN ('/cart', '/shipping')
GROUP BY website_session_id;

SELECT
	time_period,
    SUM(cart_page) AS cart_sessions,
    SUM(shipping_page) AS clickthrougs,
    SUM(shipping_page) / SUM(cart_page) AS cart_ctr,
    AVG(items_purchased) AS product_per_order,
    AVG(price_usd) AS AOV,
    SUM(price_usd) / SUM(cart_page) AS rev_per_cart_session
FROM cart_to_shipp
LEFT JOIN orders ON cart_to_shipp.website_session_id = orders.website_session_id
GROUP BY 1