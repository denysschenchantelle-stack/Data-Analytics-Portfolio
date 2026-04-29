-- Query 1: Total revenue per province (quantity × unit_price)

SELECT province, sum(quantity * unit_price) AS Total_Revenue
FROM sales
group by province
;

-- Query 2: Total revenue per category

SELECT category, sum(quantity * unit_price) AS Total_Revenue
FROM sales
group by category
;

-- Query 3: Count of sales per store

SELECT store_name, count(sale_date) AS Total_sales
FROM sales
group by store_name
;

-- Query 4: Top 3 products by revenue

SELECT product_name, sum(quantity * unit_price) AS Total_Revenue
FROM sales
group by product_name
order by Total_Revenue DESC
;

-- Query 5: Monthly revenue trend

SELECT month(sale_date) as Month, sum(quantity * unit_price) AS Total_Revenue
FROM sales
group by month(sale_date)
order by month(sale_date)
;

-- Query 6: Revenue by payment method

SELECT payment_method, sum(quantity * unit_price) AS Total_Revenue
FROM sales
group by payment_method
;

-- Query 7: Rank stores by revenue using a window function

SELECT store_name, Total_Revenue,
RANK() OVER(ORDER BY Total_Revenue DESC) AS revenue_rank
FROM (
    SELECT store_name, SUM(quantity * unit_price) AS Total_Revenue
    FROM sales
    GROUP BY store_name
) AS store_summary
;
