USE olist_ecommerce;

SET SQL_SAFE_UPDATES = 0;

-- 1. TO change all IDs, types, cities and states data type from text to VARCHAR

-- customers table
ALTER TABLE customers 
MODIFY COLUMN customer_id VARCHAR(50),
MODIFY COLUMN customer_unique_id VARCHAR(50),
MODIFY COLUMN customer_city VARCHAR(100),
MODIFY COLUMN customer_state VARCHAR(10);

-- order_items table
ALTER TABLE order_items
MODIFY COLUMN order_id VARCHAR(50),
MODIFY COLUMN product_id VARCHAR(50),
MODIFY COLUMN seller_id VARCHAR(50);

-- orders table
ALTER TABLE orders
MODIFY COLUMN order_id VARCHAR(50),
MODIFY COLUMN customer_id VARCHAR(50),
MODIFY COLUMN order_status VARCHAR(20);

-- payments table
ALTER TABLE payments
MODIFY COLUMN order_id VARCHAR(50),
MODIFY COLUMN payment_type VARCHAR(20);

-- products table
ALTER TABLE products
MODIFY COLUMN product_id VARCHAR(50),
MODIFY COLUMN product_category_name VARCHAR(100);

-- sellers table
ALTER TABLE sellers
MODIFY COLUMN seller_id VARCHAR(50),
MODIFY COLUMN seller_city VARCHAR(100),
MODIFY COLUMN seller_state VARCHAR(10);

-- 2. Zip code prefix data type change from text to VARCHAR

ALTER TABLE customers
MODIFY COLUMN customer_zip_code_prefix VARCHAR(15);

ALTER TABLE sellers
MODIFY COLUMN seller_zip_code_prefix VARCHAR(15);

-- 3. Using UPDATE queries to replace blank strings in date columns with NULL values in orders, reviews and order_items tables

UPDATE orders
SET order_purchase_timestamp = IF(order_purchase_timestamp = '', NULL, order_purchase_timestamp),
    order_approved_at = IF(order_approved_at = '', NULL, order_approved_at),
	order_delivered_carrier_date = IF(order_delivered_carrier_date = '', NULL, order_delivered_carrier_date),
	order_delivered_customer_date = IF(order_delivered_customer_date = '', NULL, order_delivered_customer_date),
    order_estimated_delivery_date = IF(order_estimated_delivery_date = '', NULL, order_estimated_delivery_date);
    
UPDATE order_items
SET shipping_limit_date = IF(shipping_limit_date = '', NULL, shipping_limit_date);  

UPDATE reviews
SET review_creation_date = IF(review_creation_date = '', NULL, review_creation_date),
    review_answer_timestamp = IF(review_answer_timestamp = '', NULL, review_answer_timestamp);

-- 4. Changing date columns data type from text to DATETIME

-- order_items table
ALTER TABLE order_items
MODIFY COLUMN shipping_limit_date DATETIME;

-- order table
ALTER TABLE orders
MODIFY COLUMN order_purchase_timestamp DATETIME,
MODIFY COLUMN order_approved_at DATETIME,
MODIFY COLUMN order_delivered_carrier_date DATETIME,
MODIFY COLUMN order_delivered_customer_date DATETIME,
MODIFY COLUMN order_estimated_delivery_date DATETIME;

-- reviews table
ALTER TABLE reviews 
MODIFY COLUMN review_creation_date DATETIME,
MODIFY COLUMN review_answer_timestamp DATETIME;

-- 5. To change double/float columns data type to decimal(10,2)

-- order_items table
ALTER TABLE order_items
MODIFY COLUMN price DECIMAL(10, 2),
MODIFY COLUMN freight_value DECIMAL(10, 2);

-- payments table 
ALTER TABLE payments
MODIFY COLUMN payment_value DECIMAL(10, 2);

-- 6. TO ADD ENGLISH PRODUCT CATEGORY NEW COLUMN (Data Transformation) 

ALTER TABLE products 
ADD COLUMN product_category_name_english VARCHAR(100);

ALTER TABLE translation
RENAME COLUMN `ï»¿product_category_name` TO product_category_name;

ALTER TABLE translation
MODIFY COLUMN product_category_name VARCHAR(100),
MODIFY COLUMN product_category_name_english VARCHAR(100);

UPDATE products p
JOIN translation t ON p.product_category_name = t.product_category_name
SET p.product_category_name_english = t.product_category_name_english;




































   