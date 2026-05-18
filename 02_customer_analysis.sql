use olist_ecommerce_project;


-- =================================
--    CUSTOMER ANALYSIS
-- =================================
       

#check unique customer
select count(distinct customer_unique_id) as unique_customer from customers;


#check repeat customer
USE olist_ecommerce_project;

SELECT 
    c.customer_unique_id,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o
ON c.customer_id = o.customer_id
GROUP BY c.customer_unique_id
HAVING COUNT(o.order_id) > 1
ORDER BY total_orders DESC;



#check top customer cities
select customer_city, COUNT(*) as total_customer
from customers
group by customer_city 
order by total_customer desc
limit 10;



#check high customer state
select customer_state, 
	COUNT(*) as total_customer
from customers
group by customer_state 
order by total_customer desc;



#customer growth trend 
select 
	YEAR(first_order_date) as year,
	MONTH(first_order_date) as month,
	COUNT(*) as new_customer
from (
	select 
		customer_id,
		min(order_purchase_timestamp) as first_order_date
		from orders
		group by customer_id 
) t
group by year(first_order_date),
MONTH(first_order_date)
order by year, month;



#check high valueable customer
select o.customer_id,
ROUND(sum(p.payment_value),2) as total_spend 
from orders o
join payments p
on o.order_id = p.order_id
group by customer_id
order by total_spend desc
limit 10;



#check average delivery time 
select 
	ROUND(
		AVG(
			DATEDIFF(order_delivered_customer_date, order_purchase_timestamp
			)
	),2
) as avg_delivery_date
from orders
where order_delivered_customer_date is not null;




#check delayed orders

SELECT 
    COUNT(*) AS delayed_orders
FROM orders
WHERE order_delivered_customer_date >
      order_estimated_delivery_date;
