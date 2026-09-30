CREATE OR REPLACE VIEW category_performance AS
WITH category_totals AS (
    SELECT
        p.product_category_name,
        SUM(oi.price) AS revenue,
        COUNT(*) AS items_sold,
        AVG(oi.price) AS average_item_price
    FROM order_items AS oi
    JOIN products AS p
        ON oi.product_id = p.product_id
    WHERE p.product_category_name IS NOT NULL
    GROUP BY p.product_category_name
)
SELECT
    product_category_name,
    revenue,
    items_sold,
    average_item_price,
    revenue * 100.0 / SUM(revenue) OVER () AS revenue_share
FROM category_totals;


-- Business-question queries

-- All categories ranked by revenue
SELECT *
FROM category_performance
ORDER BY revenue DESC;


-- Top 10 categories by revenue
SELECT *
FROM category_performance
ORDER BY revenue DESC
LIMIT 10;



-- top 10 Category with highest order-item volume
SELECT *
FROM category_performance
ORDER BY items_sold DESC
LIMIT 10;


-- Category with highest average item price
SELECT *
FROM category_performance
ORDER BY average_item_price DESC
LIMIT 1;
