# Data Dictionary - Olist E-Commerce Analytics

## Overview

This data dictionary explains the main tables used in the Olist E-Commerce Analytics project. The project uses customer, order, payment, review, product, seller, category translation, and geolocation data.

The purpose of this file is to document the table structure, important columns, relationships, and data transformations used in the project.

---

## Tables Included

- `customers`
- `orders`
- `order_items`
- `payments`
- `reviews`
- `products`
- `sellers`
- `geolocation`
- `translation`

---

## Table Relationships

- `customers.customer_id` connects with `orders.customer_id`
- `orders.order_id` connects with `order_items.order_id`
- `orders.order_id` connects with `payments.order_id`
- `orders.order_id` connects with `reviews.order_id`
- `order_items.product_id` connects with `products.product_id`
- `order_items.seller_id` connects with `sellers.seller_id`
- `products.product_category_name` connects with `translation.product_category_name`

---

## customers

Contains customer identification and customer location details.

| Column Name | Description |
|---|---|
| `customer_id` | Unique customer ID used for each order record |
| `customer_unique_id` | Unique customer identifier used to identify the same customer across multiple orders |
| `customer_zip_code_prefix` | Customer ZIP code prefix |
| `customer_city` | Customer city |
| `customer_state` | Customer state code |

---

## orders

Contains order status and order timeline details.

| Column Name | Description |
|---|---|
| `order_id` | Unique order ID |
| `customer_id` | Customer ID linked to the customers table |
| `order_status` | Status of the order, such as delivered, shipped, canceled, or unavailable |
| `order_purchase_timestamp` | Date and time when the order was placed |
| `order_approved_at` | Date and time when the order was approved |
| `order_delivered_carrier_date` | Date and time when the order was handed over to the carrier |
| `order_delivered_customer_date` | Date and time when the order was delivered to the customer |
| `order_estimated_delivery_date` | Estimated delivery date promised to the customer |

---

## order_items

Contains product-level details for each order.

| Column Name | Description |
|---|---|
| `order_id` | Order ID linked to the orders table |
| `order_item_id` | Item number within an order |
| `product_id` | Product ID linked to the products table |
| `seller_id` | Seller ID linked to the sellers table |
| `shipping_limit_date` | Last date for the seller to ship the product |
| `price` | Selling price of the product |
| `freight_value` | Freight or shipping charge for the product |

---

## payments

Contains payment information for each order.

| Column Name | Description |
|---|---|
| `order_id` | Order ID linked to the orders table |
| `payment_sequential` | Payment sequence number, useful when an order has multiple payment records |
| `payment_type` | Payment method used by the customer |
| `payment_installments` | Number of installments selected by the customer |
| `payment_value` | Payment amount for that payment record |

---

## reviews

Contains customer review and feedback information.

| Column Name | Description |
|---|---|
| `review_id` | Unique review ID |
| `order_id` | Order ID linked to the orders table |
| `review_score` | Customer rating score from 1 to 5 |
| `review_comment_title` | Short title of the customer review |
| `review_comment_message` | Full customer review message |
| `review_creation_date` | Date when the review was created |
| `review_answer_timestamp` | Date and time when the review was answered |

---

## products

Contains product details and product category information.

| Column Name | Description |
|---|---|
| `product_id` | Unique product ID |
| `product_category_name` | Product category name in the original language |
| `product_name_lenght` | Length of the product name |
| `product_description_lenght` | Length of the product description |
| `product_photos_qty` | Number of product photos |
| `product_weight_g` | Product weight in grams |
| `product_length_cm` | Product length in centimeters |
| `product_height_cm` | Product height in centimeters |
| `product_width_cm` | Product width in centimeters |

Note: The dataset uses the column spelling `lenght`, so the same spelling is kept in this documentation.

---

## sellers

Contains seller identification and seller location details.

| Column Name | Description |
|---|---|
| `seller_id` | Unique seller ID |
| `seller_zip_code_prefix` | Seller ZIP code prefix |
| `seller_city` | Seller city |
| `seller_state` | Seller state code |

---

## geolocation

Contains latitude, longitude, city, and state information based on ZIP code prefix.

| Column Name | Description |
|---|---|
| `geolocation_zip_code_prefix` | ZIP code prefix |
| `geolocation_lat` | Latitude |
| `geolocation_lng` | Longitude |
| `geolocation_city` | City name |
| `geolocation_state` | State code |

---

## translation

Contains mapping between original product category names and English product category names.

| Column Name | Description |
|---|---|
| `product_category_name` | Product category name in the original language |
| `product_category_name_english` | Product category name translated into English |

---

## Derived or Transformed Fields

These fields were created or cleaned during SQL transformation.

| Field Name | Table | Description |
|---|---|---|
| `product_category_name_english` | `products` | Added by joining `products.product_category_name` with `translation.product_category_name` |
| Cleaned date columns | `orders`, `order_items`, `reviews` | Blank date values were replaced with `NULL` and converted to `DATETIME` |
| Cleaned ID columns | Multiple tables | ID fields were converted to `VARCHAR` for cleaner joins |
| Cleaned amount columns | `order_items`, `payments` | Price, freight, and payment values were converted to decimal format |

---

## SQL Analysis Performed

The following analysis was performed using SQL queries:

- Checked total orders and total payment value.
- Analyzed monthly revenue trend.
- Found top product categories by sales.
- Compared payment methods by transaction count and payment value.
- Analyzed average delivery time by customer state.
- Compared late delivery with customer review score.
- Ranked top customers by spending within each state.
- Calculated cumulative monthly revenue trend.

---

## Data Cleaning Notes

- Blank values in date fields were replaced with `NULL`.
- Date columns were converted from text to `DATETIME`.
- Price, freight, and payment columns were converted to decimal values.
- Customer, order, product, seller, and location IDs were converted to `VARCHAR`.
- English product category names were added using the translation table.
- Indexes were created on frequently joined columns to improve query performance.

---

## Notes for Users

- Some orders can have multiple payment records.
- Some orders can contain multiple products.
- Product category names are originally available in Portuguese and were translated using the translation table.
- Geolocation data is based on ZIP code prefix and may contain multiple records for the same prefix.
- Review data is linked at the order level using `order_id`.