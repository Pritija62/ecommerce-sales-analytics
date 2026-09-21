SELECT COUNT(*)
FROM products

SELECT * 
FROM products
LIMIT 10


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


-- average order value = 137.75
SELECT 
   AVG (order_value) AS average_order_value
FROM (
   SELECT 
      order_id,
	  SUM(price) AS order_value
   FROM order_items
   GROUP by order_id
)AS orders_summary;


-- how revenue changed over time
SELECT
    DATE_TRUNC('month',o.order_purchase_timestamp) AS month,
	SUM(oi.price) AS revenue
FROM orders o
join order_items oi
ON o.order_id = oi.order_id
GROUP BY 1
ORDER BY 1;


-- highest revenue generating month 2017-11-01 generating 1010271.37
SELECT
    DATE_TRUNC('month',o.order_purchase_timestamp) AS month,
	SUM(oi.price) AS revenue
FROM orders o
join order_items oi
ON o.order_id = oi.order_id
GROUP BY 1
ORDER BY revenue DESC
LIMIT 5;

-- Distribution of order status
SELECT 
   order_status,
   COUNT(*)As order_count
FROM orders
GROUP BY order_status
ORDER BY order_count DESC;

-- monthly orders alongside monthly revenue
SELECT
    DATE_TRUNC('month',o.order_purchase_timestamp) AS month,
	COUNT(DISTINCT o.order_id) AS order_count,
	SUM(oi.price) AS revenue
FROM orders o
JOIN order_items as oi
ON o.order_id = oi.order_id
GROUP BY 1
ORDER BY 1;





