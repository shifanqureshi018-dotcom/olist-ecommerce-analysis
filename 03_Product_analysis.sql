use olist_ecommerce_project;

-- ==============================
--     PRODUCT ANALYSIS
-- ==============================

-- check top selling product

use olist_ecommerce_project;

SELECT 
    ct.product_category_name_english,
    COUNT(*) AS total_sales
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
JOIN category_translation ct
ON p.product_category_name = ct.product_category_name
GROUP BY ct.product_category_name_english
ORDER BY total_sales DESC
LIMIT 10;


--high revenue category

SELECT 
    ct.product_category_name_english,
    ROUND(SUM(oi.price),2) AS total_revenue
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
JOIN category_translation ct
ON p.product_category_name = ct.product_category_name
GROUP BY ct.product_category_name_english
ORDER BY total_revenue DESC
LIMIT 10;



-- check most expensive products
select 
	product_id ,
	MAX(price) as highest_price
from order_items
group by product_id 
order by highest_price desc
limit 10;


-- AVG PRODUCT PRICE BY CATEGORY
SELECT 
    ct.product_category_name_english,
    ROUND(AVG(oi.price),2) AS avg_price
FROM order_items oi
JOIN products p
ON oi.product_id = p.product_id
JOIN category_translation ct
ON p.product_category_name = ct.product_category_name
GROUP BY ct.product_category_name_english
ORDER BY avg_price DESC
LIMIT 10;



-- CHECK PRODUCTS WITH HIGH FREIGHT COST
select 
	product_id,
	ROUND(AVG(freight_value),2) as high_freight
from order_items
group by product_id 
order by high_freight  desc 
limit 10;


-- CALCULATE CATEGORY WISE PRODUCT COUNT

SELECT 
    ct.product_category_name_english,
    COUNT(*) AS total_products
FROM products p
JOIN category_translation ct
ON p.product_category_name = ct.product_category_name
GROUP BY ct.product_category_name_english
ORDER BY total_products DESC
LIMIT 10;