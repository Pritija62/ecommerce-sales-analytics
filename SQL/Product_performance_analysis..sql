-- PRODUCT PERFORMANCE ANALYSIS

-- the highest_revenue is 1258681.34 and the product category is beleza_saude
SELECT
    p.product_category_name AS product,
	SUM(o.price)AS revenue
FROM order_items  o
JOIN products  p
ON o.product_id = p.product_id
WHERE p.product_category_name IS NOT NULL
GROUP BY 1
ORDER BY revenue DESC
LIMIT 1;

-- cama_mesa_banho have highest number of item sold ie 11115
SELECT 
    p.product_category_name AS product_category,
    COUNT(*) AS items_sold
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
WHERE p.product_category_name IS NOT NULL
GROUP BY p.product_category_name
ORDER BY items_sold DESC
LIMIT 10;


-- product with bb50f2e236e5eea0100680137654686c this id  GENERATES HIGHEST REVENUE IE 63885.00
SELECT 
   product_id AS product,
   SUM(oi.price)AS revenue
FROM order_items AS oi
GROUP BY product
ORDER BY revenue desc
LIMIT 1;


--avg product price by category
SELECT
  p.product_category_name AS product_category,
  AVG(oi.price) AS average_price
FROM order_items AS oi
JOIN products AS p 
   ON oi.product_id = p.product_id
WHERE p.product_category_name IS NOT NULL
GROUP BY product_category;


-- category with highest average value is pcs with avg value 1098.34
SELECT
  p.product_category_name AS product_category,
  AVG(oi.price) AS average_price
FROM order_items AS oi
JOIN products AS p 
   ON oi.product_id = p.product_id
WHERE p.product_category_name IS NOT NULL
GROUP BY product_category
ORDER BY average_price DESC
LIMIT 1;


