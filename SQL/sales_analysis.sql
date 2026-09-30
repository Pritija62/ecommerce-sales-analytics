
-- there are 73 products_category in the catalog
SELECT COUNT(DISTINCT product_category_name) 
FROM products

--total orders
SELECT 
     COUNT(DISTINCT order_id) as total_orders
FROM orders
--99441 orders were placed

-- revenue  = 13591643.70
SELECT
    SUM (price) as total_revenue
FROM order_items;


-- Distribution of order status
SELECT 
   order_status,
   COUNT(*)As order_count
FROM orders
GROUP BY order_status
ORDER BY order_count DESC;


CREATE OR REPLACE VIEW monthly_sales AS
SELECT
    DATE_TRUNC('month', o.order_purchase_timestamp) AS month,
    COUNT(DISTINCT o.order_id) AS orders,
    SUM(oi.price) AS revenue,
    AVG(oi.price) AS avg_item_price,
    SUM(oi.price) / COUNT(DISTINCT o.order_id) AS aov
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
GROUP BY 1
ORDER BY 1;



