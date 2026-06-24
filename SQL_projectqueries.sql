/*
E-Commerce Sales Analytics Project

Author: Urvesh Dabhi

Tools Used:
- SQL
- MySQL Workbench

Dataset:
Superstore Dataset
*/

USE superstore;

-- BASIC AGGREGATIONS

-- Q1 Total Sales 
SELECT SUM(Sales) AS total_sales FROM orders;

-- Q2 Total Profit 
SELECT SUM(Profit) as profit FROM orders; 

-- Q3 Total Sales by category
SELECT category, SUM(Sales) AS total_sales FROM orders
GROUP BY category 
ORDER BY total_sales DESC;

-- Q4 Total Profit by category
SELECT category, SUM(Profit) AS total_profit FROM orders
GROUP BY category 
ORDER BY total_profit DESC;

-- Q5 Sales by region 
SELECT region,SUM(Sales) AS total_sales from orders 
GROUP BY region 
ORDER BY total_sales DESC;

-- Q6 Profit by region 
SELECT region,SUM(Profit) AS total_profit from orders 
GROUP BY region 
ORDER BY total_profit DESC;

-- Q7 Profit by sub-category 
SELECT `Sub-Category`,SUM(Profit) AS total_profit from orders 
GROUP BY `Sub-Category`
ORDER BY total_profit DESC;

-- Q8 Top 10 products by sales 
SELECT `Product Name`, SUM(Sales) AS total_sales FROM orders
GROUP BY `Product Name`
ORDER BY total_sales DESC
limit 10;

-- Q9 Top 10 products by profit
SELECT `Product Name`, SUM(Profit) AS profit FROM orders
GROUP BY `Product Name`
ORDER BY profit DESC
limit 10;

-- Q10 Profit by customer segment
SELECT Segment,SUM(Profit) AS profit from orders 
GROUP BY Segment
ORDER BY profit DESC;

-- SHIPPING ANALYSIS
-- Q11 Most used ship mode 
SELECT `Ship Mode`,COUNT(*) AS total_orders
FROM orders
GROUP BY `Ship Mode`
ORDER BY total_orders DESC;

-- CUSTOMER ANALYSIS
-- Q12 Top 10 customer by sales 
SELECT `Customer Name`,SUM(Sales) AS total_sales
FROM orders
GROUP BY `Customer Name`
ORDER BY total_sales DESC
LIMIT 10;

-- TREND ANALYSIS
-- Q13 Monthly sales trend
SELECT YEAR(`Order Date`) AS order_year,
       MONTH(`Order Date`) AS order_month,
       SUM(Sales) AS total_sales
FROM orders
GROUP BY YEAR(`Order Date`),
         MONTH(`Order Date`)
ORDER BY order_year,
         order_month;

-- RETURN ANALYSIS
-- Q14 percentage of orders returned 
SELECT 
    ROUND(
        (
            COUNT(DISTINCT `Order ID`) * 100.0
        ) /
        (
            SELECT COUNT(DISTINCT `Order ID`)
            FROM orders
        ),
        2
    ) AS return_percentage
FROM returns_data;

-- Q15 Catgory associated with highest percentage of returned orders
SELECT
    o.Category,
    COUNT(DISTINCT r.`Order ID`) AS returned_orders,
    COUNT(DISTINCT o.`Order ID`) AS total_orders,
    ROUND(
        COUNT(DISTINCT r.`Order ID`) * 100.0 /
        COUNT(DISTINCT o.`Order ID`),
        2
    ) AS return_rate
FROM orders o
LEFT JOIN returns_data r
    ON o.`Order ID` = r.`Order ID`
GROUP BY o.Category
ORDER BY return_rate DESC;
-- limitation 
-- Return analysis was performed at the order level because the Returns dataset identifies returned orders but does not specify which products within an order were returned.
-- Therefore, category-wise return rates should be interpreted as indicative rather than exact.

-- Q16 Return rate by region 
 SELECT
    o.region,
    COUNT(DISTINCT r.`Order ID`) AS returned_orders,
    COUNT(DISTINCT o.`Order ID`) AS total_orders,
    ROUND(
        COUNT(DISTINCT r.`Order ID`) * 100.0 /
        COUNT(DISTINCT o.`Order ID`),
        2
    ) AS return_rate
FROM orders o
LEFT JOIN returns_data r
    ON o.`Order ID` = r.`Order ID`
GROUP BY o.region
ORDER BY return_rate DESC;








