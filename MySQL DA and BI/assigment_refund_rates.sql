SELECT
	YEAR(order_items.created_at) AS yr,
    MONTH(order_items.created_at) AS mo,
    COUNT(CASE WHEN order_items.product_id = 1 THEN 1 ELSE NULL END) AS p1_orders,
    COUNT(CASE WHEN order_item_refunds.order_item_id > 0 AND order_items.product_id = 1 THEN 1 ELSE NULL END) / COUNT(CASE WHEN order_items.product_id = 1 THEN 1 ELSE NULL END) AS p1_refund_rt,
    COUNT(CASE WHEN order_items.product_id = 2 THEN 1 ELSE NULL END) AS p2_orders,
    COUNT(CASE WHEN order_item_refunds.order_item_id > 0 AND order_items.product_id = 2 THEN 1 ELSE NULL END) / COUNT(CASE WHEN order_items.product_id = 2 THEN 1 ELSE NULL END) AS p2_refund_rt,
    COUNT(CASE WHEN order_items.product_id = 3 THEN 1 ELSE NULL END) AS p3_orders,
    COUNT(CASE WHEN order_item_refunds.order_item_id > 0 AND order_items.product_id = 3 THEN 1 ELSE NULL END) / COUNT(CASE WHEN order_items.product_id = 3 THEN 1 ELSE NULL END) AS p3_refund_rt,
    COUNT(CASE WHEN order_items.product_id = 4 THEN 1 ELSE NULL END) AS p4_orders,
        COUNT(CASE WHEN order_item_refunds.order_item_id > 0 AND order_items.product_id = 4 THEN 1 ELSE NULL END) / COUNT(CASE WHEN order_items.product_id = 4 THEN 1 ELSE NULL END) AS p4_refund_rt
FROM order_items
LEFT JOIN order_item_refunds ON order_items.order_item_id = order_item_refunds.order_item_id
WHERE order_items.created_at < '2014-10-01' 
GROUP BY 1,2