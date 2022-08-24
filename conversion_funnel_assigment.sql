
CREATE TEMPORARY TABLE page_flags
SELECT
	website_sessions.website_session_id,
    website_pageviews.pageview_url,
    website_sessions.created_at AS pageview_created_at,
    CASE WHEN pageview_url ='/products' THEN 1 ELSE 0 END AS product_page,
    CASE WHEN pageview_url ='/the-original-mr-fuzzy' THEN 1 ELSE 0 END AS mrfuzzy_page,
    CASE WHEN pageview_url ='/cart' THEN 1 ELSE 0 END AS cart_page,    
    CASE WHEN pageview_url ='/shipping' THEN 1 ELSE 0 END AS shipping_page,
    CASE WHEN pageview_url ='/billing' THEN 1 ELSE 0 END AS billing_page,
    CASE WHEN pageview_url ='/thank-you-for-your-order' THEN 1 ELSE 0 END AS thank_you_page  
FROM website_sessions
LEFT JOIN website_pageviews ON website_sessions.website_session_id = website_pageviews.website_session_id
WHERE website_sessions.created_at BETWEEN '2012-08-05' AND '2012-09-05'
 	AND website_pageviews.pageview_url  IN ('/lander-1', '/products', '/the-original-mr-fuzzy', '/cart', '/shipping', '/billing', '/thank-you-for-your-order')
    AND website_sessions.utm_source = 'gsearch';

-- drop TABLE page_flags;

SELECT
	COUNT(website_session_id) AS sessions,
    SUM(to_product) AS to_products,
    SUM(to_product) / COUNT(website_session_id) AS landing_page_ratio,
    SUM(to_mrfuzzy) AS to_mrfuzzy,
    SUM(to_mrfuzzy) / SUM(to_product) AS mrfuzzy_ratio,
    SUM(to_cart) AS to_cart,
    SUM(to_cart) / SUM(to_mrfuzzy) AS cart_ratio,
    SUM(to_shipping) AS to_shipping,
    SUM(to_shipping) / SUM(to_cart) AS shipping_ratio,
    SUM(to_billing) AS to_billing,
    SUM(to_billing) / SUM(to_shipping) AS billing_ratio,
    SUM(to_thanyou) AS to_thankyou,
    SUM(to_thanyou) / SUM(to_billing) AS thanks_ratio
FROM(
SELECT
	website_session_id,
    MAX(product_page) AS to_product,
    MAX(mrfuzzy_page) AS to_mrfuzzy,
    MAX(cart_page) AS to_cart,
    MAX(shipping_page) AS to_shipping,
    MAX(billing_page) AS to_billing,
    MAX(thank_you_page) AS to_thanyou
FROM page_flags
GROUP BY website_session_id
) AS page_flags_group;
