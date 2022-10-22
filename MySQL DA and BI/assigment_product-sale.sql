SELECT 
	YEAR(created_at) AS yr,
    MONTH(created_at) AS mo,
    COUNT(order_id) AS nr_of_orders,
    SUM(price_usd) AS total_revenue,
    SUM(price_usd-cogs_usd) AS total_margin
FROM orders
WHERE created_at < '2013-01-04'
GROUP BY 1,2
