USE olist_ecommerce;

-- Creating a View for BI Tools (Hides complex joins for the reporting layer)
CREATE VIEW vw_product_performance_summary AS
SELECT 
    p.product_category_name_english AS Product_Category,
    COUNT(oi.order_id) AS Total_Orders_Sold,
    ROUND(SUM(oi.price), 2) AS Total_Revenue,
    ROUND(AVG(oi.freight_value), 2) AS Avg_Freight_Cost
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_category_name_english;


-- Creating Indexes on Foreign Key columns to speed up JOIN operations
CREATE INDEX idx_orders_customer_id ON orders(customer_id);
CREATE INDEX idx_orders_order_id ON orders(order_id);
CREATE INDEX idx_order_items_product_id ON order_items(product_id);


DELIMITER //

CREATE PROCEDURE GetMonthlyRevenueStatus(IN input_year INT, IN input_month INT)
BEGIN
    SELECT 
        YEAR(o.order_purchase_timestamp) AS Order_Year,
        MONTH(o.order_purchase_timestamp) AS Order_Month,
        ROUND(SUM(p.payment_value), 2) AS Total_Sales,
        COUNT(o.order_id) AS Total_Orders
    FROM orders o
    JOIN payments p ON o.order_id = p.order_id
    WHERE YEAR(o.order_purchase_timestamp) = input_year 
      AND MONTH(o.order_purchase_timestamp) = input_month
      AND o.order_status = 'delivered'
    GROUP BY YEAR(o.order_purchase_timestamp), MONTH(o.order_purchase_timestamp);
END //

DELIMITER ;

