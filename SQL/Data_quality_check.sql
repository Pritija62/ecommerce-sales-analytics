-- counting all the table records
SELECT 'customers' AS table_name, COUNT(*) AS row_count FROM customers
UNION ALL
SELECT 'orders', COUNT(*) FROM orders
UNION ALL
SELECT 'order_items', COUNT(*) FROM order_items
UNION ALL
SELECT 'products', COUNT(*) FROM products
UNION ALL
SELECT 'sellers', COUNT(*) FROM sellers
UNION ALL
SELECT 'payments', COUNT(*) FROM payments;


--checking for missing_values:
SELECT COUNT(*) AS missing_customer_ids
FROM customers
WHERE customer_id IS NULL
      OR customer_unique_id IS NULl;


SELECT COUNT(*) AS missing_product_ids
FROM products
WHERE product_id IS NULL;


SELECT COUNT(*) AS Product_without_category
FROM products
WHERE product_category_name IS NULL;
	  

SELECT COUNT(*) AS missing_seller_ids
FROM sellers
WHERE seller_id IS NULL;


SELECT COUNT(*) AS missing_order_ids
FROM orders
WHERE order_id IS NULL;


SELECT COUNT(*) AS missing_customer_ids
FROM orders
WHERE customer_id IS NULL;


SELECT COUNT(*) AS missing_order_status
FROM orders
WHERE order_status IS NULL;

SELECT COUNT(*) AS missing_purchase_timestamps
FROM orders
WHERE order_purchase_timestamp IS NULL;


SELECT count(*) 
FROM order_items
WHERE order_id IS NULL
   OR order_item_id IS NULL
   OR product_id IS NULL
   OR seller_id IS NULL
   OR price Is NULL
   OR freight_value IS NULL
   OR shipping_limit_date IS NULL;


SELECT count(*) 
FROM payments
WHERE order_id IS NULL
   OR payment_sequential IS NULL
   OR payment_type IS NULL
   OR payment_value IS NULL;


-- checking for duplicates

SELECT customer_id, COUNT(*)
FROM customers
GROUP BY customer_id
HAVING COUNT(*) > 1;

SELECT product_id, COUNT(*)
FROM products
GROUP BY product_id
HAVING COUNT(*) > 1;

SELECT seller_id, COUNT(*)
FROM sellers
GROUP BY seller_id
HAVING COUNT(*) > 1;

SELECT order_id, COUNT(*)
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

SELECT order_id,order_item_id ,COUNT(*)
FROM order_items
GROUP BY order_id,order_item_id
HAVING COUNT(*) > 1;

SELECT order_id,payment_sequential, COUNT(*)
FROM payments
GROUP BY order_id,payment_sequential
HAVING COUNT(*) > 1;



-- checking foregin key constraints
SELECT COUNT(*) AS orders_without_customer
FROM orders o
LEFT JOIN customers c
    ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;


SELECT COUNT(*) AS order_item_without_order
FROM order_items oi
LEFT JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_id IS NULL;


SELECT COUNT(*) AS order_item_without_product
FROM order_items oi
LEFT JOIN products p
    ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;


SELECT COUNT(*) AS order_item_without_seller
FROM order_items oi
LEFT JOIN sellers s
    ON oi.seller_id = s.seller_id
WHERE s.seller_id IS NULL;


SELECT COUNT(*) AS payments_without_order
FROM payments p
LEFT JOIN orders o
    ON p.order_id = o.order_id
WHERE o.order_id IS NULL;


SELECT COUNT(*)
FROM order_items
WHERE price < 0 OR Freight_value < 0



SELECT COUNT(*)
FROM payments
WHERE payment_value < 0
      OR payment_installments <0;




















