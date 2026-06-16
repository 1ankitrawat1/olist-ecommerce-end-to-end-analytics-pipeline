## Dashboard Preview

### Executive Overview

![Executive Overview](04_screenshots/01_executive_overview.jpg)

### Logistics and Experience

![Logistics and Experience](04_screenshots/02_logistics_experience.jpg)

# Olist E-Commerce End-to-End Analytics Pipeline

## Project Overview

This is an end-to-end analytics pipeline for Olist e-commerce data. It combines raw CSV data, SQL data cleaning, business analysis, database optimization, and Power BI reporting into a complete business intelligence workflow.

The final Power BI report includes:

- Executive Overview
- Logistics and Experience

## Business Problem

E-commerce leaders need to monitor sales performance, product categories, payment behavior, delivery performance, and customer experience. This project answers:

- How is revenue trending over time?
- Which product categories drive revenue?
- Which payment methods are most common?
- Which states face longer delivery times?
- How do late deliveries affect review scores?
- Which customers spend the most in each state?
- What operational factors affect satisfaction?

## Dataset

Main datasets:

- Customers: 99,441 rows
- Geolocation: 1,000,163 rows
- Orders: 99,441 rows
- Order Items: 112,650 rows
- Order Payments: 103,886 rows
- Order Reviews: 99,224 rows
- Products: 32,951 rows
- Sellers: 3,095 rows
- Product Category Translation: 71 rows

Total analysis scope: 1.5M+ rows.

## Tools Used

- SQL
- MySQL
- Power BI
- Power Query
- DAX

## Project Workflow

1. Collected raw Olist e-commerce datasets.
2. Loaded the data into MySQL.
3. Cleaned and transformed columns using SQL.
4. Converted date columns into proper datetime format.
5. Converted payment, price, and freight columns into decimal format.
6. Added English product category names using the translation table.
7. Wrote SQL queries for sales, payment, delivery, and review analysis.
8. Created indexes, views, and stored procedure for analysis and reporting.
9. Built Power BI dashboard pages for executive and logistics analysis.

## SQL Analysis Covered

- Total orders and payment value
- Monthly revenue trend
- Top product categories
- Payment method distribution
- Delivery time by state
- Late delivery impact on review score
- Top customers by state using DENSE_RANK
- Cumulative revenue using window functions

## Power BI Dashboard Pages

### Executive Overview

- Revenue trend
- Product category performance
- Payment type distribution
- Year slicer
- KPI cards

### Logistics and Experience

- Delivery status
- Customer state analysis
- Delivery experience
- Review impact
- Logistics performance

## Repository Structure

```text
olist-ecommerce-end-to-end-analytics-pipeline/
|-- README.md
|-- 01_raw_data/
|-- 02_sql_scripts/
|   |-- 01_data_cleaning_and_setup.sql
|   |-- 02_business_analysis_queries.sql
|   |-- 03_database_optimization_and_automation.sql
|-- 03_powerbi/
|   |-- dashboard.pbix
|-- 04_screenshots/
|   |-- 01_executive_overview.png
|   |-- 02_logistics_experience.png
|-- 05_docs/
    |-- data_dictionary.md
```

## GitHub Upload Notes

- Include dashboard screenshots.
- Do not upload database passwords.
- If raw data is too large, upload sample data and mention the source link.

## Skills Demonstrated

- SQL Data Cleaning
- MySQL
- Joins and Aggregations
- CTEs
- Window Functions
- Views
- Indexes
- Stored Procedures
- Power BI Dashboarding
- Power Query
- DAX
- E-commerce Analytics
- Business Intelligence Reporting

## Future Improvements

- Add customer segmentation.
- Add seller performance analysis.
- Add delivery delay prediction.
- Publish dashboard to Power BI Service.

