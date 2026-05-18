USE olist_ecommerce_project;


-- ===============================
--        BUSINESS OVERVIEW
-- ================================
#calculate total revenue
select round(SUM(payment_value),2) as total_revenue from payments; 


#count total orders
select count(*) as total_orders from orders;

#calculate average order value
select ROUND(AVG(payment_value),2) as avg_order_value from payments;


#calculate high and most payment method 
select payment_type,
count(*) as total_transactions
from payments
group by payment_type
order by total_transactions desc;


#check order status 
select order_status, count(*) as total_order from orders 
group by order_status 
order by total_order   desc ;




#calculate monthly revenue trend
select 
     YEAR(o.order_purchase_timestamp) as year,
     MONTH(o.order_purchase_timestamp) as month,
     ROUND(SUM(payment_value),2) as revenue
     from orders o
     join payments p
     on o.order_id = p.order_id
     group by year, month
     order by year, month;
     
     
