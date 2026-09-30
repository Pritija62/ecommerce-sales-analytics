# E-Commerce Sales Analytics

[Live Streamlit dashboard](https://ecommerce-sales-analytics-lvyccu8s56fly44lkktjv2.streamlit.app/)

This project analyzes the Olist e-commerce dataset with PostgreSQL, SQL, Python, Pandas, and interactive visualizations. The analysis is organized around three business questions and is presented through a Streamlit dashboard.

## Business questions

### 1. How did product revenue and order volume change over time?

The project analyzes:

- Monthly product revenue
- Monthly distinct order count
- Monthly average order value
- Highest- and lowest-revenue months

The dashboard presents revenue, order-volume, and average-order-value trends.

### 2. Which product categories contributed most to product revenue and order-item volume?

The project analyzes:

- Product revenue by category
- Order-item volume by category
- Revenue share by category
- Average item price by category

The dashboard presents ranked category visualizations and a category summary table.

### 3. How important are repeat customers to the business?

The project analyzes:

- One-time customer count
- Repeat customer count
- Product revenue by customer group
- Customer share by group
- Revenue share by group
- Customer order-frequency distribution

The dashboard presents customer-group comparisons, revenue comparisons, a summary table, and order-frequency distribution.

## Metric definitions

- **Product revenue:** `SUM(order_items.price)`. Freight is excluded.
- **Analyzed orders:** Distinct orders with matching order-item records.
- **Customers:** Counted using `customer_unique_id`, rather than the order-level `customer_id`.
- **Order-item volume:** Number of order-item rows. This is not guaranteed to represent physical unit quantities.
- **Average order value:** Product revenue divided by analyzed distinct orders.
- **Repeat customer:** A customer with more than one analyzed distinct order.
- **Category analysis:** Products without a category label are excluded.

## Main findings

- November 2017 was the strongest month, with **$1,010,271.37** in product revenue and **7,451 orders**.
- `beleza_saude` led category revenue with **$1,258,681.34**, while `cama_mesa_banho` led order-item volume with **11,115 order-item rows**.
- One-time customers represented **96.95%** of purchasing customers and **94.38%** of product revenue.
- Repeat customers represented **3.05%** of purchasing customers and **5.62%** of product revenue.

More detailed observations and limitations are available in [Insights.md](./Insights.md).

## Data model

| Table | Grain | Main use |
|---|---|---|
| `orders` | One row per order | Purchase dates, order counts, and order status |
| `order_items` | One row per order-item line | Product revenue and order-item volume |
| `products` | One row per product | Product category information |
| `customers` | Customer/order relationship records | Customer identification and repeat-purchase analysis |

Orders connect to order items through `order_id`. Order items connect to products through `product_id`. Customer behavior uses `customer_unique_id` so repeat purchasing is measured at the customer level.

## Methodology

1. Load the source CSV data into PostgreSQL.
2. Check data quality, including missing values, duplicates, foreign-key relationships, and invalid numeric values.
3. Define the project metrics and table relationships.
4. Perform joins, filtering, grouping, and metric calculations in SQL.
5. Expose reusable analytical results through SQL views such as:
   - `monthly_sales`
   - `category_performance`
   - `customer_spending`
   - `customer_group_summary`
   - `order_frequency`
6. Load the small aggregated results into Pandas.
7. Create notebook analysis and visualizations.
8. Export processed result files for the dashboard.
9. Present the results in Streamlit using Plotly, Matplotlib, and Streamlit components.

The database performs the main analytical transformations. Pandas is used for consuming result sets, presentation, visualization, and export rather than loading all source tables into memory.

## Project structure

```text
sales_analysis_project/
├── Dashboard/
│   └── app.py
├── Notebooks/
│   └── ecommerce_analysis.ipynb
├── SQL/
│   ├── create_table.sql
│   ├── Data_quality_check.sql
│   ├── Product_performance_analysis..sql
│   ├── customer_behaviour_analysis.sql
│   └── sales_analysis.sql
├── data/
│   └── processed/
├── Business_questions.md
├── Insights.md
├── requirements.txt
└── README.md
```

## Processed dashboard outputs

The notebook exports the following aggregated or analytical result files to `data/processed/`:

- `monthly_sales.csv`
- `category_revenue.csv`
- `customer_spending.csv`
- `customer_group_summary.csv`
- `order_frequency.csv`

The dashboard reads these files to display:

- Executive KPIs
- Monthly revenue, orders, and average-order-value trends
- Highest- and lowest-revenue months
- Top categories by revenue
- Top categories by order-item volume
- Category revenue-share table
- Customer counts by group
- Product revenue by customer group
- Customer-group summary
- Order-frequency distribution

## Requirements

- Python 3
- PostgreSQL
- A PostgreSQL database containing the project tables and analytical views

Python dependencies are listed in [requirements.txt](./requirements.txt).

## Setup and usage

### 1. Install Python dependencies

From the project root:

```bash
pip install -r requirements.txt
```

### 2. Prepare the database

1. Create the PostgreSQL database.
2. Create the source tables using `SQL/create_table.sql`.
3. Load the raw Olist CSV data into the tables.
4. Run the SQL analysis and view definitions in `SQL/`.
5. Run the data-quality checks before generating dashboard outputs.

The database connection string is configured in the notebook. Do not commit credentials or passwords to the repository.

### 3. Generate processed outputs

Open and run [Notebooks/ecommerce_analysis.ipynb](./Notebooks/ecommerce_analysis.ipynb) from the project environment. The notebook queries the analytical SQL results and writes the processed CSV files to `data/processed/`.

### 4. Run the dashboard

From the project root:

```bash
streamlit run Dashboard/app.py
```

The dashboard expects the processed CSV files to already exist in `data/processed/`.

## Dashboard technology

- **Streamlit:** Dashboard layout, KPI cards, tables, and application hosting
- **Plotly:** Interactive time-series and category charts
- **Matplotlib:** Static order-frequency visualization
- **Pandas:** Loading and preparing aggregated result files
- **PostgreSQL and SQL:** Data storage and analytical transformations

## Limitations
- The data does not explain the causes behind monthly peaks or customer repeat behavior.
- Order-item volume is based on rows, not guaranteed physical units.
- Products without category labels are excluded from category analysis.
- Repeat status is based on the available observation period and does not measure customer lifetime duration.
- The repeat-customer analysis does not measure profitability, acquisition cost, or reasons for non-return.

