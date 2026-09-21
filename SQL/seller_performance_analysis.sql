-- SELLER PERFORMANCE ANALYSIS

-- there are 3095 sellers
SELECT 
COUNT(DISTINCT seller_id )
FROM sellers

-- seller generating most revenue = 4869f7a5dfa277a7dca6462dcf3b52b2
SELECT 
   seller_id,
   sum(price) as revenue
FROM Order_items
GROUP BY seller_id
ORDER BY revenue DESC
LIMIT 1;


-- 6560211a19b47992c3666cc44a7e94c0 sells the most item ie 2033
SELECT
  seller_id,
  count(order_item_id) as order_items
FROM order_items
GROUP BY seller_id
ORDER BY order_items desc
LIMIT 1;


SELECT
  seller_id,
  count(DISTINCT order_id) as order_items
FROM order_items
GROUP BY seller_id
ORDER BY order_items desc
LIMIT 1;



WITH seller_revenue AS (
    SELECT
        s.seller_state,
        s.seller_id,
        SUM(oi.price) AS revenue
    FROM sellers s
    JOIN order_items oi
        ON s.seller_id = oi.seller_id
    GROUP BY
        s.seller_state,
        s.seller_id
),
ranked_sellers AS (
    SELECT
        seller_state,
        seller_id,
        revenue,
        ROW_NUMBER() OVER (
            PARTITION BY seller_state
            ORDER BY revenue DESC
        ) AS rank
    FROM seller_revenue
)
SELECT
    seller_state,
    seller_id,
    revenue
FROM ranked_sellers
WHERE rank = 1
ORDER BY seller_state;


