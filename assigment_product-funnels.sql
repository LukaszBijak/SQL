CREATE TEMPORARY TABLE session_w_products
SELECT
	website_session_id,
    website_pageview_id,
    pageview_url AS product_page_seen
FROM website_pageviews
WHERE created_at < '2013-04-10'
	AND created_at > '2013-01-06'
	AND pageview_url IN ('/the-original-mr-fuzzy', '/the-forever-love-bear');

CREATE TEMPORARY TABLE funnel_tab
SELECT 
	session_w_products.website_session_id AS sessions,
    session_w_products.product_page_seen AS product_page,
    CASE WHEN pageview_url = '/cart' THEN 1 ELSE 0 END as cart_page,
    CASE WHEN pageview_url = '/shipping' THEN 1 ELSE 0 END as shipping_page,
    CASE WHEN pageview_url = '/billing-2' THEN 1 ELSE 0 END as billing_page,
    CASE WHEN pageview_url = '/thank-you-for-your-order' THEN 1 ELSE 0 END as thankyou_page
FROM session_w_products
LEFT JOIN website_pageviews
	ON website_pageviews.website_session_id = session_w_products.website_session_id
    AND website_pageviews.website_pageview_id > session_w_products.website_pageview_id
ORDER BY
	session_w_products.website_session_id,
    website_pageviews.created_at; 
 
-- solution:
 
SELECT
	product_page,
    COUNT(sessions),
    SUM(to_cart),
    SUM(to_shipping),
    SUM(to_billing),
    SUM(to_thankyou)
FROM(
SELECT
	product_page,
    sessions,
    SUM(cart_page) AS to_cart,
    SUM(shipping_page) AS to_shipping,
    SUM(billing_page) AS to_billing,
    SUM(thankyou_page) AS to_thankyou    
FROM funnel_tab
GROUP BY 1,2
) AS tmp
GROUP BY 1;    


-- click rate:
  
SELECT
	product_page,
    SUM(to_cart) / sessions AS session_to_cart,
    SUM(to_shipping) / SUM(to_cart) AS cart_to_shipping,
    SUM(to_billing) / SUM(to_shipping) AS shipping_to_billing,
    SUM(to_thankyou) / SUM(to_billing) AS billing_to_thankyou 
FROM(
SELECT
	product_page,
    sessions,
    SUM(cart_page) AS to_cart,
    SUM(shipping_page) AS to_shipping,
    SUM(billing_page) AS to_billing,
    SUM(thankyou_page) AS to_thankyou    
FROM funnel_tab
GROUP BY 1,2
) AS tmp
GROUP BY 1;    

