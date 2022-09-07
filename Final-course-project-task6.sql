
-- outcomes in percentage

SELECT 
	YEAR(website_pageviews.created_at) AS yr,
    MONTH(website_pageviews.created_at) AS mo,
    COUNT(CASE WHEN pageview_url = '/products' THEN 1 ELSE NULL END) / COUNT(website_pageviews.website_session_id) * 100 AS sessions_to_product,
    COUNT(CASE WHEN pageview_url IN 
		('/the-original-mr-fuzzy', '/the-forever-love-bear', '/the-birthday-sugar-panda', '/the-hudson-river-mini-bear') THEN 1 ELSE NULL END) 
        / COUNT(CASE WHEN pageview_url = '/products' THEN 1 ELSE NULL END) *100 AS product_to_next_page_rt,
	COUNT(DISTINCT orders.order_id) / COUNT(CASE WHEN pageview_url = '/products' THEN 1 ELSE NULL END) *100 AS conv_from_prod_to_order
FROM website_pageviews
LEFT JOIN orders ON website_pageviews.website_session_id = orders.website_session_id
GROUP BY 1,2;

SELECT DISTINCT pageview_url FROM website_pageviews;