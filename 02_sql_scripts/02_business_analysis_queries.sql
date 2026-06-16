
USE olist_ecommerce;

-- 1.BASIC KPIs

-- Total Orders and Total Revenue
SELECT COUNT(order_id) AS TOTAL_Orders,
SUM(payment_value) AS Total_Revenue 
FROM payments;

-- Monthly Revenue Trend
SELECT 
    YEAR(order_purchase_timestamp) AS Order_Year,
    MONTH(order_purchase_timestamp) AS Order_Month,
    ROUND(SUM(p.payment_value), 2) AS Monthly_Revenue
FROM orders o
JOIN payments p ON o.order_id = p.order_id
WHERE o.order_status = 'delivered'
GROUP BY Order_Year, Order_Month
ORDER BY Order_Year, Order_Month;

-- 2. CUSTOMER & PRODUCT INSIGHTS

-- Top 5 product categories that generates the Highest Revenue
SELECT (product_category_name_english) AS product_categories,
	COUNT(oi.order_id) AS Total_items_sold,
	ROUND(SUM(oi.price),2) AS Total_Sales
FROM order_items oi JOIN products p 
ON oi.product_id = p.product_id
GROUP BY product_categories
ORDER BY Total_Sales DESC
LIMIT 5;

-- Most used payment type and their transaction value
SELECT payment_type AS Payment_Method,
	COUNT(order_id) AS Total_Transactions,
	ROUND(SUM(payment_value), 2) AS Total_Amount_Paid
FROM payments 
GROUP BY Payment_Method
ORDER BY Total_Transactions DESC;

-- 3. Advanced Business Logic & Time Analysis

-- Q5: Which customer states experience the longest delivery times? (Comparing Average Actual vs. Estimated Delivery Days)
SELECT c.customer_state as State,
	ROUND(AVG(DATEDIFF(o.order_delivered_customer_date, o.order_purchase_timestamp)),1) AS Avg_order_delivery_date,
	ROUND(AVG(DATEDIFF(o.order_estimated_delivery_date, o.order_purchase_timestamp)),1) AS Avg_estimated_delivery_date
FROM customers c JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.order_status = 'delivered' AND o.order_status IS NOT NULL
GROUP BY State
ORDER BY Avg_order_delivery_date DESC;

-- Q6: What is the direct impact of late deliveries on customer review scores?
SELECT 
    CASE 
        WHEN o.order_delivered_customer_date <= o.order_estimated_delivery_date THEN 'On Time / Early'
        ELSE 'Late Delivery'
    END AS Delivery_Status,
    COUNT(o.order_id) AS Total_Orders,
    ROUND(AVG(r.review_score), 2) AS Avg_Customer_Rating
FROM orders o
JOIN reviews r ON o.order_id = r.order_id
WHERE o.order_status = 'delivered' 
  AND o.order_delivered_customer_date IS NOT NULL
GROUP BY Delivery_Status;

-- 4. Window Functions & Complex Business Analytics

-- Top 3 Highest-Spending Customers Per State
WITH CustomerSpending AS (
	SELECT 
		c.customer_state AS State,
		c.customer_unique_id AS Customer_ID,
		ROUND(SUM(p.payment_value), 2) AS Total_Spent,
		DENSE_RANK() OVER (PARTITION BY c.customer_state ORDER BY SUM(p.payment_value) DESC) AS spending_rank
	FROM customers c
	JOIN orders o ON c.customer_id = o.customer_id
	JOIN payments p ON o.order_id = p.order_id
	GROUP BY c.customer_state, c.customer_unique_id
)
SELECT State, Customer_ID, Total_Spent, spending_rank
FROM CustomerSpending
WHERE spending_rank <= 3
ORDER BY State, spending_rank;

-- Cumulative (Running Total) Revenue Month-on-Month
WITH MonthlyRevenue AS(
	SELECT 
		YEAR(order_purchase_timestamp) AS order_year,
        MONTH(order_purchase_timestamp) AS order_month,
        ROUND(SUM(payment_value),2) AS monthly_sales
	FROM orders o JOIN payments p 
    ON o.order_id = p.order_id
    WHERE order_status ='delivered'
    GROUP BY order_year, order_month
)
SELECT order_year, order_month, monthly_sales,
ROUND(SUM(monthly_sales) OVER (ORDER BY order_year, order_month), 2) AS cumulative_revenue
FROM MonthlyRevenue
ORDER BY order_year, order_month;


















