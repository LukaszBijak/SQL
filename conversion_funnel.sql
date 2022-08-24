CREATE TEMPORARY TABLE session_level_made_it_flags
SELECT
	website_session_id,
    MAX(product_page) AS product_made_it,
    MAX(mrfuzzy_page) AS mrfuzzy_made_it,
    MAX(cart_page) AS cart_made_it
FROM(
SELECT
	website_sessions.website_session_id,
    website_pageviews.pageview_url,
    website_sessions.created_at AS pageview_created_at,
    CASE WHEN pageview_url ='/products' THEN 1 ELSE 0 END AS product_page,
    CASE WHEN pageview_url ='/the-original-mr-fuzzy' THEN 1 ELSE 0 END AS mrfuzzy_page,
    CASE WHEN pageview_url ='/cart' THEN 1 ELSE 0 END AS cart_page    
FROM website_sessions
LEFT JOIN website_pageviews ON website_sessions.website_session_id = website_pageviews.website_session_id
WHERE website_sessions.created_at BETWEEN '2014-01-01' AND '2014-02-01'
	AND website_pageviews.pageview_url IN ('/lander-2','/products','/the-original-mr-fuzzy','/cart')
ORDER BY 
	website_sessions.website_session_id,
    website_pageviews.created_at
) AS pageview_level 
GROUP BY
	website_session_id;

SELECT
	COUNT(DISTINCT website_session_id) AS sessions,
    COUNT(CASE WHEN product_made_it = 1 THEN 1 ELSE NULL END) AS to_products,
    COUNT(DISTINCT CASE WHEN mrfuzzy_made_it = 1 THEN website_session_id ELSE NULL END) AS to_mrfuzzzy,
    COUNT(DISTINCT CASE WHEN cart_made_it = 1 THEN website_session_id ELSE NULL END) AS to_cart
FROM session_level_made_it_flags;

SELECT
 COUNT(*) AS sessions,
 SUM(product_made_it) / COUNT(*) AS click_to_products,
 SUM(mrfuzzy_made_it) / COUNT(*) AS click_to_mrfuzzzy,
 SUM(cart_made_it) / COUNT(*) AS click_to_cart
FROM session_level_made_it_flags;