CREATE TEMPORARY TABLE prim_prod
SELECT 
 	order_id,
    CASE WHEN is_primary_item = 1 THEN product_id ELSE NULL END AS primary_product_id
FROM order_items;

SELECT 
 	primary_product_id,
    COUNT(DISTINCT order_items.order_id) AS total_orders,
 	COUNT(CASE WHEN is_primary_item = 0 AND product_id = 1 THEN 1 ELSE NULL END) AS xsold_p1,
    COUNT(CASE WHEN is_primary_item = 0 AND product_id = 2 THEN 1 ELSE NULL END) AS xsold_p2,
    COUNT(CASE WHEN is_primary_item = 0 AND product_id = 3 THEN 1 ELSE NULL END) AS xsold_p3,
    COUNT(CASE WHEN is_primary_item = 0 AND product_id = 4 THEN 1 ELSE NULL END) AS xsold_p4,
    COUNT(CASE WHEN is_primary_item = 0 AND product_id = 1 THEN 1 ELSE NULL END) / COUNT(DISTINCT order_items.order_id)*100 AS p1_xsell_prct,
    COUNT(CASE WHEN is_primary_item = 0 AND product_id = 2 THEN 1 ELSE NULL END) / COUNT(DISTINCT order_items.order_id)*100 AS p2_xsell_prct,
    COUNT(CASE WHEN is_primary_item = 0 AND product_id = 3 THEN 1 ELSE NULL END) / COUNT(DISTINCT order_items.order_id)*100 AS p3_xsell_prct,
    COUNT(CASE WHEN is_primary_item = 0 AND product_id = 4 THEN 1 ELSE NULL END) / COUNT(DISTINCT order_items.order_id)*100 AS p4_xsell_prct
FROM order_items
LEFT JOIN prim_prod ON order_items.order_id = prim_prod.order_id
WHERE created_at > '2014-12-05'
	AND primary_product_id IN ('1','2','3','4')
GROUP BY 1
ORDER BY 1

