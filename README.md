RetailPulse SA — Retail Sales Analysis
Project Overview
South African retailers operate across diverse provinces and store formats, making it critical to understand where revenue is being generated, which product categories drive the most value, and how sales fluctuate over time.
This project analyses retail sales data across three major South African stores — Sandton City, V&A Waterfront, and Gateway — to uncover performance trends and surface actionable business insights using MySQL, Excel, and Power BI.

Business Questions Answered

Which province and store generates the most revenue?
What product categories contribute most to total sales?
How does revenue trend month-over-month?
Which products are the top performers by revenue?
What payment methods do customers prefer?
How do stores rank against each other in revenue performance?


Tools Used
ToolPurposeMySQLData storage, querying, and analysisExcelData cleaning and preparationPower BIInteractive dashboard and visualisation

Dataset
Simulated South African retail sales data including:

Sales transactions across 3 stores (Sandton City, V&A Waterfront, Gateway)
Product categories: Electronics, Clothing, Appliances
Fields: store_name, province, product_name, category, quantity, unit_price, sale_date, payment_method


SQL Analysis
Seven queries were written to extract key business insights:
1. Total Revenue by Province
Aggregated revenue per province to identify the highest-performing regions.
2. Revenue by Product Category
Compared Electronics, Clothing, and Appliances to understand category contribution.
3. Sales Count by Store
Counted total transactions per store to measure sales activity volume.
4. Top 3 Products by Revenue
Ranked products by total revenue to identify star performers.
5. Monthly Revenue Trend
Tracked revenue month-by-month to identify seasonal patterns and peaks.
6. Revenue by Payment Method
Broke down revenue by payment type to understand customer preferences.
7. Store Revenue Ranking (Window Function)
Used a RANK() window function to rank stores by total revenue — demonstrating advanced SQL capability.
sqlSELECT store_name, Total_Revenue,
RANK() OVER(ORDER BY Total_Revenue DESC) AS revenue_rank
FROM (
    SELECT store_name, SUM(quantity * unit_price) AS Total_Revenue
    FROM sales
    GROUP BY store_name
) AS store_summary;

Power BI Dashboard
The dashboard presents three key visuals on a single page:

KPI Card — Total revenue across all stores: R432K
Bar Chart — Revenue by product category (Electronics led at R150K)
Bar Chart — Revenue by store (Sandton City topped at R221K, followed by V&A Waterfront at R143K)
Line Chart — Monthly revenue trend (January–July), showing a peak in March and a recovery trend from May

![RetailPulse Dashboard](RetailPulse_Main_Dashboard.png.png)

Key Insights

Sandton City is the top-performing store, generating over 3× the revenue of Gateway
Electronics is the strongest product category, slightly ahead of Clothing
Revenue peaked in March before dipping in April — worth investigating for seasonal or stock-related causes
The recovery trend from May through July suggests improving momentum heading into Q3


Project Structure
RetailPulse-SA/
│
├── retailpulse_db.sql              # Database schema and seed data
├── retailpulse_queries.sql         # All 7 analytical SQL queries
├── RetailPulse_SA_Project.xlsx     # Cleaned data in Excel
├── RetailPulse_Main_Dashboard.png  # Power BI dashboard screenshot
└── README.md                       # Project documentation

About
This project was built as part of a self-directed data analytics portfolio, demonstrating skills in relational database querying, spreadsheet data preparation, and business intelligence dashboarding.
Author: Chantelle Denyssche
Skills demonstrated: MySQL · Excel · Power BI · Data Analysis · Window Functions · Business Insight Communication
