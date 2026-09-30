# E-Commerce Sales Analytics

## Project Objective

Analyze Olist e-commerce data using SQL, Python, Pandas, and visualizations to understand sales performance, product categories, and customer behavior.

The project will answer three focused business questions and communicate the findings through a simple Streamlit dashboard.

## Metric Assumptions

- Product revenue is the sum of `order_items.price`; freight is excluded.
- Sales metrics use orders with matching order-item records.
- Customers are counted using `customer_unique_id`.
- Order-item volume means the number of order-item rows, not guaranteed physical units.


## Core Business Questions

### 1. How did product revenue and order volume change over time?

**Why we are asking:**  
To understand overall marketplace performance and identify stronger or weaker periods.

**Main metrics:**

- Monthly product revenue
- Monthly distinct order count
- Average order value for interpretation

**Main tables:**

- `orders`
- `order_items`

**Expected output:**

- Monthly revenue trend
- Monthly order-volume trend
- Summary of the highest- and lowest-performing periods

### 2. Which product categories contributed most to product revenue and order-item volume?

**Why we are asking:**  
To identify the categories that are the main drivers of marketplace sales.

**Main metrics:**

- Product revenue by category
- Order-item volume by category
- Revenue share by category, where useful

**Main tables:**

- `products`
- `order_items`

**Expected output:**

- Ranked category table
- Revenue comparison chart
- Comparison of high-revenue and high-volume categories

### 3. How important are repeat customers to the business?

**Why we are asking:**  
To understand customer purchasing behavior and whether repeat customers contribute meaningful value.

**Main metrics:**

- One-time customer count
- Repeat customer count
- One-time customer product revenue
- Repeat customer product revenue
- Customer-count and revenue contribution for each group

**Main tables:**

- `customers`
- `orders`
- `order_items`

**Expected output:**

- One-time versus repeat customer comparison
- Customer-count chart
- Product-revenue contribution chart

## Optional / Future Analysis

These topics are valid but are outside the first version of the project:

- Seller performance and seller concentration
- Payment-method usage
- Geographic analysis
- Delivery performance
- Individual top customers
- Product-level rankings

## Analysis Approach

For each core question:

1. Identify the required data and metrics.
2. Calculate and validate the results.
3. Create a clear visualization.
4. Explain the observation, business meaning, and limitations.

The findings will support the Python analysis, visualizations, and Streamlit dashboard.
