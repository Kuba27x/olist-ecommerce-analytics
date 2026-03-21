CREATE OR REPLACE VIEW vw_master_sales AS
SELECT
	o.order_id,
    c.customer_unique_id,
    c.customer_city,
    c.customer_state,
    DATE(o.order_purchase_timestamp) AS purchase_date,
    oi.product_id,
    oi.price AS product_price,
    oi.freight_value AS delivery_cost,
    COALESCE(t.product_category_name_english, p.product_category_name, 'Unknown') AS product_category
FROM orders o 
JOIN customers c
	ON o.customer_id = c.customer_id
JOIN order_items oi
	ON o.order_id = oi.order_id
LEFT JOIN products p 
	ON oi.product_id = p.product_id
LEFT JOIN product_category_name_translation t
	ON p.product_category_name = t.product_category_name
WHERE o.order_status = 'delivered';