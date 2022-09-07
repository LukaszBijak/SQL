SELECT 
	YEAR(created_at) AS yr,
    MONTH(created_at) AS mo,
    SUM(CASE WHEN product_id = 1 THEN price_usd ELSE NULL END) AS product1_revenue,
    SUM(CASE WHEN product_id = 1 THEN price_usd-cogs_usd ELSE NULL END) AS product1_margin,
    SUM(CASE WHEN product_id = 2 THEN price_usd ELSE NULL END) AS product2_revenue,
    SUM(CASE WHEN product_id = 2 THEN price_usd-cogs_usd ELSE NULL END) AS product2_margin,
    SUM(CASE WHEN product_id = 3 THEN price_usd ELSE NULL END) AS product3_revenue,
    SUM(CASE WHEN product_id = 3 THEN price_usd-cogs_usd ELSE NULL END) AS product3_margin,
    SUM(CASE WHEN product_id = 4 THEN price_usd ELSE NULL END) AS product4_revenue,
    SUM(CASE WHEN product_id = 4 THEN price_usd-cogs_usd ELSE NULL END) AS product4_margin,
    SUM(price_usd) AS total_revenue,
    SUM(cogs_usd) AS total_margin
FROM order_items
GROUP BY 1,2