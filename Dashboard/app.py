import streamlit as st
import pandas as pd

# Page configuration
st.set_page_config(
    page_title="E-Commerce Sales Analytics Dashboard",
    page_icon=":bar_chart:",
    layout="wide"
)

#Title and description
st.title(" E-Commerce Sales Analytics Dashboard")
st.markdown(
    "A detailed analysis of sales, products, customers, sellers, and payment behavior."
)

# Load processed data
monthly_sales = pd.read_csv("data/processed/monthly_sales.csv")

category_revenue = pd.read_csv("data/processed/category_revenue.csv")

seller_performance = pd.read_csv("data/processed/seller_performance.csv")

customer_spending = pd.read_csv("data/processed/customer_spending.csv")

order_frequency = pd.read_csv("data/processed/order_frequency.csv")

payment_usage = pd.read_csv("data/processed/payment_usage.csv")

customer_group_summary = pd.read_csv(
    "data/processed/customer_group_summary.csv"
)



# KPI calculations
total_orders = monthly_sales["orders"].sum()
total_revenue = monthly_sales["revenue"].sum()
total_customers = customer_spending["customer_unique_id"].nunique()
average_order_value = total_revenue / total_orders

# KPI cards
col1, col2, col3, col4 = st.columns(4)

with col1:
    st.metric("Total Orders", f"{total_orders:,.0f}")

with col2:
    st.metric("Product Revenue", f"${total_revenue:,.2f}")

with col3:
    st.metric("Average Order Value", f"${average_order_value:,.2f}")

with col4:
    st.metric("Unique Customers", f"{total_customers:,.0f}")




st.divider()

st.subheader("Sales Performance")

col1, col2 = st.columns(2)

with col1:
    st.markdown("### Monthly Revenue")

    st.line_chart(
        monthly_sales.set_index("month")["revenue"]
    )

with col2:
    st.markdown("### Monthly Orders")

    st.line_chart(
        monthly_sales.set_index("month")["orders"]
    )

st.markdown("### Monthly Average Order Value")

st.line_chart(
    monthly_sales.set_index("month")["aov"]
)

highest_revenue_month = monthly_sales.loc[
    monthly_sales["revenue"].idxmax()
]

st.metric(
    "Highest-Revenue Month",
    str(highest_revenue_month["month"]),
    f"${highest_revenue_month['revenue']:,.2f} revenue | "
    f"{highest_revenue_month['orders']:,.0f} orders"
)


#product performance
st.divider()

st.subheader("Product Performance")

top_categories = category_revenue.head(10).copy()

# Format category names for display
category_display = top_categories.copy()
category_display["product_category_name"] = (
    category_display["product_category_name"]
    .str.replace("_", " ")
    .str.title()
)
st.bar_chart(
    category_display.set_index("product_category_name")["revenue"]
)

st.markdown("### Top Categories by Order-Item Volume")

top_volume_categories = category_revenue.sort_values(
    "items_sold",
    ascending=False
).head(10).copy()

volume_category_display = top_volume_categories.copy()
volume_category_display["product_category_name"] = (
    volume_category_display["product_category_name"]
    .str.replace("_", " ")
    .str.title()
)

st.bar_chart(
    volume_category_display.set_index("product_category_name")["items_sold"]
)

st.markdown("### Category Revenue Share")

st.dataframe(
    category_display[
        ["product_category_name", "revenue", "items_sold", "revenue_share"]
    ].rename(
        columns={
            "product_category_name": "Category",
            "revenue": "Revenue",
            "items_sold": "Order-item volume",
            "revenue_share": "Revenue share (%)"
        }
    ),
    hide_index=True
)


# seller performance
st.divider()

st.subheader("Seller Performance")

top_sellers = seller_performance.head(10).copy()

st.bar_chart(
    top_sellers.set_index("seller_id")["revenue"]
)

total_seller_revenue = seller_performance["revenue"].sum()
top_10_seller_revenue = top_sellers["revenue"].sum()
top_10_seller_revenue_share = (
    top_10_seller_revenue / total_seller_revenue * 100
)

seller_col1, seller_col2, seller_col3 = st.columns(3)

with seller_col1:
    st.metric(
        "Total Seller Product Revenue",
        f"${total_seller_revenue:,.2f}"
    )

with seller_col2:
    st.metric(
        "Top 10 Seller Revenue",
        f"${top_10_seller_revenue:,.2f}"
    )

with seller_col3:
    st.metric(
        "Top 10 Revenue Share",
        f"{top_10_seller_revenue_share:.2f}%"
    )

# customer behavior
st.divider()

st.subheader("Customer Behavior")

st.bar_chart(
    order_frequency.set_index("orders")["number_of_customers"]
)

st.markdown("### One-Time vs Repeat Customers")

customer_group_display = customer_group_summary.rename(
    columns={
        "customer_group": "Customer group",
        "customer_count": "Customer count",
        "product_revenue": "Product revenue",
        "customer_share": "Customer share (%)",
        "revenue_share": "Revenue share (%)"
    }
)

st.dataframe(
    customer_group_display,
    hide_index=True
)

st.bar_chart(
    customer_group_summary.set_index("customer_group")[
        ["customer_share", "revenue_share"]
    ]
)



# payment behaviour
st.divider()

st.subheader("Payment Behavior")

st.bar_chart(
    payment_usage.set_index("payment_type")["payment_counts"]
)

st.markdown("### Payment Share and Average Payment Value")

payment_display = payment_usage.rename(
    columns={
        "payment_type": "Payment method",
        "payment_counts": "Payment records",
        "total_value": "Total value",
        "payment_share": "Payment share (%)",
        "average_payment_value": "Average payment value"
    }
)

st.dataframe(
    payment_display,
    hide_index=True
)