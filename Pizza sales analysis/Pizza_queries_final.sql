USE [Pizza DB];

SELECT
    *
FROM
    pizza_sales;

-- 1. Total Revenue:
SELECT
    SUM(total_price) AS Total_Revenue
FROM
    pizza_sales;

-- 2. Average Order Value
SELECT
    SUM(total_price) / count(DISTINCT order_id) as Average_revenue_per_order
from
    pizza_sales;

-- 3. Total Pizzas Sold
SELECT
    SUM(quantity) AS Total_Pizza_Sold
FROM
    pizza_sales;

-- 4. Total Orders
SELECT
    COUNT(DISTINCT order_id) AS Total_Orders
FROM
    pizza_sales;

-- 5. Average Pizzas Per Order
SELECT
    CAST(
        CAST(SUM(quantity) AS DECIMAL(10, 2)) / CAST(COUNT(DISTINCT order_id) AS DECIMAL(10, 2)) AS DECIMAL(10, 2)
    ) AS Pizza_per_Order
FROM
    pizza_sales;

-- 6. Daily Trend for Total Orders
SELECT
    DATENAME(DW, order_date) AS order_day,
    COUNT(DISTINCT order_id) AS Total_orders
from
    pizza_sales
GROUP BY
    DATENAME(DW, order_date);

-- 7. Monthly Trend for Orders
SELECT
    DATENAME(MONTH, order_date) AS Month_Name,
    COUNT(DISTINCT order_id) AS Total_orders
from
    pizza_sales
GROUP BY
    DATENAME(MONTH, order_date);

-- 8. % of Sales by Pizza Category
SELECT
    pizza_category,
    ROUND(SUM(total_price), 2) AS Total_Sales,
    ROUND(
        SUM(total_price) * 100 /(
            SELECT
                SUM(total_price)
            FROM
                pizza_sales
        ),
        2
    ) AS PCT_Total_Sales
from
    pizza_sales
GROUP BY
    pizza_category;

-- 9. % of Sales by Pizza Size
SELECT
    pizza_size,
    CAST(SUM(total_price) AS DECIMAL(10, 2)) as total_revenue,
    CAST(
        SUM(total_price) * 100 / (
            SELECT
                SUM(total_price)
            from
                pizza_sales
        ) AS DECIMAL(10, 2)
    ) AS PCT
FROM
    pizza_sales
GROUP BY
    pizza_size
ORDER BY
    pizza_size 
    
-- 10. Total Pizzas Sold by Pizza Category
SELECT
    pizza_category,
    SUM(quantity) as Total_Quantity_Sold
FROM
    pizza_sales
WHERE
    MONTH(order_date) = 2
GROUP BY
    pizza_category
ORDER BY
    Total_Quantity_Sold DESC 
    
-- 11. Bottom 5 Pizzas by Revenue
SELECT
    TOP 5 pizza_name,
    CAST(SUM(total_price) AS DECIMAL(10, 2)) AS Total_revenue
FROM
    pizza_sales
GROUP BY
    pizza_name
ORDER BY
    Total_revenue DESC;

-- 12. Top 5 Pizzas by Quantity
SELECT
    TOP 5 pizza_name,
    SUM(quantity) AS Total_quantity
FROM
    pizza_sales
GROUP BY
    pizza_name
ORDER BY
    Total_quantity DESC;

-- Top 5 Pizzas by Total Orders
SELECT
    TOP 5 pizza_name,
    COUNT(DISTINCT order_id) AS Total_orders
FROM
    pizza_sales
GROUP BY
    pizza_name
ORDER BY
    Total_orders DESC;