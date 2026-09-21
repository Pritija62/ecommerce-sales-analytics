# Sales Analytics Insights

This document summarizes the findings for the five approved business questions. Product revenue means the sum of `order_items.price`, excluding freight. Sales metrics use orders with matching order-item records.

## 1. How did product revenue and order volume change over time?

### Observation

Revenue and order volume increased across the main observation period. November 2017 was the strongest month, with product revenue of **$1,010,271.37** and **7,451 orders**. The monthly AOV for that month was **$135.59**.

### Business implication

The results show substantially stronger sales activity during the main observation period, with November 2017 standing out as the strongest month by both product revenue and order volume.

### Limitation

The first and last months have very few orders: September 2016 has 3 orders and September 2018 has 1 order. They should not be treated as normal full-month comparisons. The data does not explain why November 2017 was the strongest month.

## 2. Which product categories contributed most to product revenue and order-item volume?

### Observation

`beleza_saude` was the highest-revenue category, generating **$1,258,681.34**, or **9.38%** of category revenue. `cama_mesa_banho` had the highest order-item volume, with **11,115 order-item rows** and **$1,036,988.68** in revenue.

### Business implication

Revenue leadership and volume leadership were different. This means category performance should be evaluated using both revenue and order-item volume rather than relying on only one measure.

### Limitation

Order-item volume counts order-item rows and is not guaranteed to represent physical unit quantities. Products with missing category labels are excluded from the category analysis.

## 3. How concentrated is marketplace performance among sellers?

### Observation

Total seller-attributed product revenue was **$13,591,643.70**. The top 10 sellers generated **$1,787,241.74**, equal to **13.15%** of seller product revenue.

### Business implication

The top 10 sellers generated a minority of total seller product revenue, so the results indicate that most revenue came from sellers outside the top 10.

### Limitation

This is a top-10 concentration measure only. It does not describe the full distribution of seller revenue, seller profitability, seller retention, or operational quality.

## 4. How important are repeat customers to the business?

### Observation

One-time customers represented **92,507 customers**, or **96.95%** of purchasing customers, and contributed **$12,828,351.84**, or **94.38%** of product revenue. Repeat customers represented **2,913 customers**, or **3.05%** of customers, and contributed **$763,291.86**, or **5.62%** of product revenue.

### Business implication

Most identified purchasing customers were one-time customers, and they also contributed most of the product revenue in this dataset. Repeat customers were a small customer group with a smaller share of total product revenue.

### Limitation

Repeat status is based on more than one analyzed distinct order. The analysis does not measure customer lifetime duration, profitability, acquisition cost, or why customers did not return.

## 5. Which payment methods are most commonly used?

### Observation

Credit card was the most commonly recorded payment method, with **76,795 payment records**, or **73.92%** of all payment records. Boleto was second, with **19,784 records**, or **19.04%**. Credit card also had the highest average payment-record value among the main payment methods, at **$163.32**.

### Business implication

The payment results show that credit card is the dominant recorded payment method, while boleto remains an important secondary method based on its usage share.

### Limitation

Payment share is based on payment records, not necessarily distinct orders or customers. The data does not establish why customers selected each payment method or whether any method is more profitable. The `not_defined` category contains only 3 records.
