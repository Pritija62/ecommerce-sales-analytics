import streamlit as st
import pandas as pd
import matplotlib.pyplot as plt
import plotly.express as px

# Page configuration
st.set_page_config(
    page_title="E-Commerce Sales Analytics Dashboard",
    page_icon=":bar_chart:",
    layout="wide"
)

#Title and description
st.title(" E-Commerce Sales Analytics Dashboard")
st.markdown(
    "A detailed analysis of sales, products and customers behavior."
)

# Load processed data
monthly_sales = pd.read_csv("data/processed/monthly_sales.csv")

category_revenue = pd.read_csv("data/processed/category_revenue.csv")

customer_spending = pd.read_csv("data/processed/customer_spending.csv")

order_frequency = pd.read_csv("data/processed/order_frequency.csv")

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

fig = px.line(
    monthly_sales,
    x="month",
    y="revenue",
    markers=True,
    title="Monthly Revenue"
)

fig.update_layout(
    xaxis_title="Month",
    yaxis_title="Revenue"
)

st.plotly_chart(fig, use_container_width=True)


fig = px.line(
    monthly_sales,
    x="month",
    y="orders",
    markers=True,
    title="Monthly orders"
)

fig.update_layout(
    xaxis_title="Month",
    yaxis_title="Orders"
)

st.plotly_chart(fig, use_container_width=True)


fig = px.line(
    monthly_sales,
    x="month",
    y="aov",
    markers=True,
    title="Monthly Average Order Value"
)

fig.update_layout(
    xaxis_title="Month",
    yaxis_title="Average Order Value"
)

st.plotly_chart(fig, use_container_width=True)



highest_revenue_month = monthly_sales.loc[
    monthly_sales["revenue"].idxmax()
]

lowest_revenue_month = monthly_sales.loc[
    monthly_sales["revenue"].idxmin()
]
col1, col2 = st.columns(2)
with col1:
    st.metric(
        "Highest-Revenue Month",
        str(highest_revenue_month["month"]),
        f"${highest_revenue_month['revenue']:,.2f} revenue | "
        f"{highest_revenue_month['orders']:,.0f} orders"
)

with col2:
    st.metric(
        "Lowest-Revenue Month",
        str(lowest_revenue_month["month"]),
        f"${lowest_revenue_month['revenue']:,.2f} revenue | "
        f"{lowest_revenue_month['orders']:,.0f} orders"
)


#product performance
st.divider()

st.subheader("Product Performance")

st.markdown("### Top Categories by Revenue")
top_categories = category_revenue.head(10).copy()

# Format category names for display
category_display = top_categories.copy()
top_categories["category_display"] = (
    top_categories["product_category_name"]
    .str.replace("_", " ")
    .str.title()
)

fig = px.bar(
    top_categories.sort_values("revenue"),
    x="revenue",
    y="product_category_name",
    orientation="h",
    title="Top 10 Categories by Revenue",
    text_auto=".2s",
    color="revenue",
    color_continuous_scale="magenta"
)

st.plotly_chart(fig, use_container_width=True)




top_volume_categories = category_revenue.sort_values(
    "items_sold",
    ascending=False
).head(10).copy()

fig = px.bar(
    top_volume_categories.sort_values("items_sold"),
    x="items_sold",
    y="product_category_name",
    orientation="h",
    title="Top 10 Categories by Order-Item Volume",
    text_auto=True,
    color="items_sold",
    color_continuous_scale="blues"
)

st.plotly_chart(fig, use_container_width=True)

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





# customer behavior
st.divider()

st.subheader("Customer Behavior")

# Ensure a consistent customer-group order
customer_group_order = [
    "One-time customer",
    "Repeat customer"
]

customer_group_summary["customer_group"] = pd.Categorical(
    customer_group_summary["customer_group"],
    categories=customer_group_order,
    ordered=True
)

customer_group_summary = customer_group_summary.sort_values(
    "customer_group"
)

col1, col2 = st.columns(2)

with col1:
    st.markdown("### Customer Count by Group")

    customer_count_chart = customer_group_summary.set_index(
        "customer_group"
    )[["customer_count"]]

    st.bar_chart(customer_count_chart)

with col2:
    st.markdown("### Product Revenue by Group")

    revenue_chart = customer_group_summary.set_index(
        "customer_group"
    )[["product_revenue"]]

    st.bar_chart(revenue_chart)

st.markdown("### Customer Group Summary")

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



st.markdown("### Order Frequency Distribution")

fig, ax = plt.subplots(figsize=(8, 4))

ax.bar(
    order_frequency["orders"],
    order_frequency["number_of_customers"]
)

ax.set_title("Number of Customers by Order Frequency")
ax.set_xlabel("Number of Orders")
ax.set_ylabel("Number of Customers")

st.pyplot(fig)
plt.close(fig)