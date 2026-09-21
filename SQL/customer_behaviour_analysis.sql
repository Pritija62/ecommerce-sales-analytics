--  Unique customers in the customers table
SELECT
  COUNT(DISTINCT customer_unique_id)
FROM customers

-- customers who made multiple purchases : there are 2913
WITH analyzed_customer_orders AS (
    SELECT
        c.customer_unique_id,
        COUNT(DISTINCT o.order_id) AS number_of_orders
    FROM customers AS c
    JOIN orders AS o
        ON c.customer_id = o.customer_id
    JOIN order_items AS oi
        ON o.order_id = oi.order_id
    GROUP BY c.customer_unique_id
)
SELECT COUNT(*) AS repeat_customers
FROM analyzed_customer_orders
WHERE number_of_orders > 1;


-- Average spending per customers
SELECT AVG(total_spending) AS average_customer_spending
FROM (
    SELECT
        c.customer_unique_id,
        SUM(oi.price) AS total_spending
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    GROUP BY c.customer_unique_id
) AS customer_spending;


-- additional sql EDA:

-- Highest Spending Customers 
SELECT
   c.customer_unique_id,
   sum(oi.price) as price
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
join order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_unique_id
ORDER BY price desc
limit 5;
 

 -- state with most customers 
SELECT
   customer_state AS states,
   count(distinct customer_unique_id) AS no_of_customers 
FROM customers
GROUP BY customer_state
ORDER BY no_of_customers desc
LIMIT 1;


-- state generating highest revenue
SELECT
   c.customer_state AS states,
   SUM(oi.price) AS revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
join order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_state
ORDER BY revenue DESC
limit 5;  

 
 

