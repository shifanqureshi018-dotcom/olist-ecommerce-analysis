use olist_ecommerce_project;

-- ==================================
--        SELLER ANALYSIS
-- ==================================


-- COUNT TOTAL SELLERS
select 
	COUNT(*) as total_sellers
from sellers;


-- top sellers by orders
select seller_id,
	count(order_id) as total_orders
from order_items
group by seller_id 
order by total_orders desc 
limit 10;



-- TOP SELLER BY REVENUE
select
	seller_id,
	ROUND(sum(price),2) as total_revenue
from order_items
group by seller_id
order by total_revenue desc 
limit 10;


-- seller state distribution
select
	seller_state,
	count(*) as total_sellers
from sellers
group by seller_state 
order by total_sellers desc
limit 10;


-- average revenue per seller
USE olist_ecommerce_project;

SELECT 
    ROUND(AVG(seller_revenue),2) AS avg_revenue_per_seller
FROM (
    SELECT 
        seller_id,
        SUM(price) AS seller_revenue
    FROM order_items
    GROUP BY seller_id
) t;



-- SELLER WITH HIGHEST FREIGHT COST
select 
	seller_id,
	ROUND(SUM(freight_value),2) as avg_freight
from order_items
group by seller_id 
order by avg_freight desc 
limit 10;


-- SELLER PRODUCT COUNT
SELECT 
    seller_id,
    COUNT(DISTINCT product_id) AS total_products
FROM order_items
GROUP BY seller_id
ORDER BY total_products DESC
LIMIT 10;



-- SELLER DELIVERY PERFORMANCE

SELECT 
    oi.seller_id,
    ROUND(
        AVG(
            DATEDIFF(
                o.order_delivered_customer_date,
                o.order_purchase_timestamp
            )
        ),2
    ) AS avg_delivery_days
FROM order_items oi
JOIN orders o
ON oi.order_id = o.order_id
WHERE o.order_delivered_customer_date IS NOT NULL
GROUP BY oi.seller_id
ORDER BY avg_delivery_days ASC
LIMIT 10;



-- SELLER CENCELLATION IMPACT

SELECT 
    oi.seller_id,
    COUNT(*) AS cancelled_orders
FROM order_items oi
JOIN orders o
ON oi.order_id = o.order_id
WHERE o.order_status = 'canceled'
GROUP BY oi.seller_id
ORDER BY cancelled_orders DESC
LIMIT 10;



