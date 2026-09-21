# E-Commerce Sales Analytics

## Project overview

This project analyzes the Olist e-commerce dataset to understand marketplace sales performance, product categories, seller concentration, customer purchasing behavior, and payment-method usage.

The project combines SQL, Python, Pandas, Matplotlib, and Streamlit. It is designed as a beginner-friendly portfolio project focused on answering clear business questions rather than adding unrelated metrics.

## Business questions

1. How did product revenue and order volume change over time?
2. Which product categories contributed most to product revenue and order-item volume?
3. How concentrated is marketplace performance among sellers?
4. How important are repeat customers to the business?
5. Which payment methods are most commonly used?

## Tools

- PostgreSQL and SQL
- Python
- Pandas
- Matplotlib
- Streamlit
- Jupyter Notebook

## Project structure

```text
sales_analysis project/
├── Dashboard/
│   └── app.py
├── Notebooks/
│   ├── DataQualityCheck.ipynb
│   └── ecommerce_analysis.ipynb
├── SQL/
│   ├── sales_analysis.sql
│   ├── Product_performance_analysis..sql
│   ├── seller_performance_analysis.sql
│   ├── customer_behaviour_analysis.sql
│   └── payment_behaviour_analysis.sql
├── data/
│   ├── raw/
│   └── processed/
├── Business_questions.md
├── Insights.md
└── README.md
```

## Methodology

1. Loaded the source tables into PostgreSQL and inspected their structure.
2. Documented table grain and relationships.
3. Performed basic quality checks for duplicates, missing values, broken relationships, and date anomalies.
4. Defined consistent business metrics.
5. Used Pandas to prepare summary datasets for the five questions.
6. Created exploratory charts and concise insight narratives.
7. Exported processed summary CSV files.
8. Built and tested a Streamlit dashboard using the processed outputs.


## Data model

The project uses these main source tables:

| Table | Grain | Main use |
|---|---|---|
| `orders` | One row per order | Order status and purchase dates |
| `order_items` | One row per order-item line | Product revenue, category volume, and seller performance |
| `products` | One row per product | Product category information |
| `customers` | Customer/order relationship records | Customer identification and repeat-purchase analysis |
| `sellers` | One row per seller | Seller-level analysis |
| `payments` | One row per payment record | Payment-method usage and payment values |

Orders are connected to order items through `order_id`. Order items connect to products through `product_id` and to sellers through `seller_id`. Customer behavior uses `customer_unique_id` so repeat purchasing is measured at the customer level rather than only at the order-record level.

Because one order can contain multiple item lines and multiple payment records, order counts use distinct `order_id`, while payment usage is kept at payment-record grain to avoid unintended row multiplication.

## Metric definitions

- **Product revenue:** `SUM(order_items.price)`. Freight is excluded.
- **Analyzed orders:** Distinct orders with matching order-item records.
- **Customers:** Counted using `customer_unique_id`, rather than the order-level `customer_id`.
- **Order-item volume:** Number of order-item rows. This is not guaranteed to represent physical unit quantities.
- **Average order value:** Product revenue divided by analyzed distinct orders.
- **Seller concentration:** Top-10 seller product revenue divided by total seller product revenue.
- **Repeat customer:** A customer with more than one analyzed distinct order.
- **Payment usage:** Payment records grouped by payment type. Payment-record counts are not distinct order counts.

## Main findings

- November 2017 was the strongest month, with **$1,010,271.37** in product revenue and **7,451 orders**.
- `beleza_saude` led category revenue with **$1,258,681.34**, while `cama_mesa_banho` led order-item volume with **11,115 order-item rows**.
- The top 10 sellers generated **13.15%** of seller-attributed product revenue.
- One-time customers represented **96.95%** of purchasing customers and **94.38%** of product revenue. Repeat customers represented **3.05%** of customers and **5.62%** of revenue.
- Credit card was the most commonly recorded payment method at **73.92%** of payment records, followed by boleto at **19.04%**.

More detailed observations, implications, and limitations are available in [Insights.md](./Insights.md).

## Processed outputs

The notebook exports these files to `data/processed/`:

- `monthly_sales.csv`
- `category_revenue.csv`
- `seller_performance.csv`
- `customer_spending.csv`
- `order_frequency.csv`
- `payment_usage.csv`
- `customer_group_summary.csv`

## Running the dashboard

From the project root, install the required Python packages in your environment and run:

```bash
streamlit run Dashboard/app.py
```

The dashboard expects the processed CSV files to be present in `data/processed/`. It displays KPI cards and sections for sales performance, product categories, seller concentration, customer behavior, and payment methods.

## Limitations

- The first and last observed months have very few orders and should not be treated as normal full-month comparisons.
- The data does not explain the causes behind monthly peaks or customer repeat behavior.
- Order-item volume is based on rows, not guaranteed physical unit quantities.
- Products without category labels are excluded from category analysis.
- The seller analysis focuses on the top-10 revenue share and does not measure seller profitability or operational quality.
- Payment shares are based on payment records, not necessarily distinct orders or customers.
- The repeat-customer analysis does not measure customer lifetime duration, profitability, acquisition cost, or reasons for non-return.
- Geographic analysis, delivery performance, individual customer rankings, and product-level rankings are outside the first version of this project.

