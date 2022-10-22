CREATE TEMPORARY TABLE conv_fun
SELECT 
	website_session_id,
    created_at,
    SUM(CASE WHEN pageview_url = '/products' THEN 1 ELSE 0 END) AS to_product,
    SUM(CASE WHEN pageview_url = '/the-original-mr-fuzzy' THEN 1 ELSE 0 END) AS to_mrfuzzy,
    SUM(CASE WHEN pageview_url = '/the-forever-love-bear' THEN 1 ELSE 0 END) AS to_lovebear
FROM website_pageviews
WHERE created_at BETWEEN '2012-10-06' AND '2013-04-06'
GROUP BY website_session_id;


SELECT
    CASE WHEN created_at BETWEEN '2012-10-06' AND '2013-01-06' THEN 'A.Pre_Product_2'
		 WHEN created_at BETWEEN '2013-01-06' AND '2013-04-06' THEN 'B.Post_Product_2' ELSE NULL END AS time_period,
	COUNT(website_session_id) AS sessions,
    COUNT(CASE WHEN to_product =  1 THEN website_session_id ELSE NULL END) AS to_product,
    COUNT(CASE WHEN to_product =  1 THEN website_session_id ELSE NULL END) / COUNT(website_session_id) AS session_ratio,
    COUNT(CASE WHEN to_mrfuzzy =  1 THEN website_session_id ELSE NULL END) AS to_mrfuzzy,
    COUNT(CASE WHEN to_mrfuzzy =  1 THEN website_session_id ELSE NULL END) / COUNT(CASE WHEN to_product =  1 THEN website_session_id ELSE NULL END) AS mrfuzzy_ratio,
    COUNT(CASE WHEN to_lovebear =  1 THEN website_session_id ELSE NULL END) AS to_lovebear,
    COUNT(CASE WHEN to_lovebear =  1 THEN website_session_id ELSE NULL END) / COUNT(CASE WHEN to_product =  1 THEN website_session_id ELSE NULL END) lovebear_ratio
FROM conv_fun
GROUP BY 1;