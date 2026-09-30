# Sales Analytics Insights

This document summarizes the findings for the three core business questions. The analysis uses PostgreSQL views for joins, filtering, grouping, and metric calculations. Pandas and the Streamlit dashboard consume the resulting analytical datasets.


## 1. How did product revenue and order volume change over time?

### Observation

Revenue and order volume were strongest during the main observation period, with **November 2017** standing out as the best-performing month. It generated **$1,010,271.37** in product revenue from **7,451 distinct orders**, with a monthly average order value of **$135.59**.

### Business implication

November 2017 was a strong period for both sales value and order activity. Revenue and order volume should be reviewed together because a month can generate higher revenue through either more orders, higher order values, or both.

### Limitation

The first and last observed months are incomplete or contain very few orders: September 2016 has 3 orders and September 2018 has 1 order. They should not be treated as normal full-month comparisons. The dataset does not explain the causes of the November 2017 peak.

## 2. Which product categories contributed most to product revenue and order-item volume?

### Observation

`beleza_saude` was the highest-revenue category, generating **$1,258,681.34**, or **9.38%** of category revenue. `cama_mesa_banho` had the highest order-item volume, with **11,115 order-item rows** and **$1,036,988.68** in revenue.

### Business implication

The category with the highest revenue was different from the category with the highest order-item volume. Category performance should therefore be evaluated using both value and volume rather than a single ranking.

### Limitation

Order-item volume counts rows, not confirmed physical quantities. Products with missing category labels are excluded from the category analysis. Category revenue and order-item volume also do not measure profitability, returns, or customer satisfaction.

## 3. How important are repeat customers to the business?

### Observation

One-time customers represented **92,507 customers**, or **96.95%** of purchasing customers, and contributed **$12,828,351.84**, or **94.38%** of product revenue.

Repeat customers represented **2,913 customers**, or **3.05%** of purchasing customers, and contributed **$763,291.86**, or **5.62%** of product revenue.

The dashboard also includes customer counts by group, product revenue by group, customer and revenue shares, and order-frequency distribution.

### Business implication

Most identified purchasing customers made only one analyzed purchase, so repeat customers currently represent a small share of the customer base. Their contribution is also smaller in absolute revenue, although repeat behavior remains important for retention and future customer-value initiatives.

The results suggest that customer retention and re-engagement could be important areas for further investigation. However, these results alone do not establish why customers did not return or whether repeat customers are more profitable.

### Limitation

Repeat status is based on more than one analyzed distinct order within the available observation period. It does not measure customer lifetime duration, acquisition cost, profitability, or the reasons for non-return. Because the analysis joins customers, orders, and order items, it focuses on customers with orders that have matching order-item records.

