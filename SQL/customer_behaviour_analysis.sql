
-- =====================================================
-- 1. Customer-level spending and order summary
-- =====================================================

CREATE OR REPLACE VIEW customer_spending AS
SELECT
    c.customer_unique_id,
    COUNT(DISTINCT o.order_id) AS orders,
    SUM(oi.price) AS total_spending,
    CASE
        WHEN COUNT(DISTINCT o.order_id) = 1
            THEN 'One-time customer'
        ELSE 'Repeat customer'
    END AS customer_group
FROM customers AS c
JOIN orders AS o
    ON c.customer_id = o.customer_id
JOIN order_items AS oi
    ON o.order_id = oi.order_id
GROUP BY
    c.customer_unique_id;


-- =====================================================
-- 2. One-time versus repeat customer summary
-- =====================================================

CREATE OR REPLACE VIEW customer_group_summary AS
SELECT
    customer_group,
    COUNT(*) AS customer_count,
    SUM(total_spending) AS product_revenue,
    COUNT(*) * 100.0
        / SUM(COUNT(*)) OVER () AS customer_share,
    SUM(total_spending) * 100.0
        / SUM(SUM(total_spending)) OVER () AS revenue_share
FROM customer_spending
GROUP BY customer_group;


-- =====================================================
-- 3. Main business-question result
-- =====================================================

SELECT
    customer_group,
    customer_count,
    product_revenue,
    customer_share,
    revenue_share
FROM customer_group_summary
ORDER BY
    CASE customer_group
        WHEN 'One-time customer' THEN 1
        WHEN 'Repeat customer' THEN 2
    END;