use olist_ecommerce_project;


-- ========================================
--    REVIEWS & SATISFACTION ANALYSIS
-- ========================================


-- AVERAGE REVIEW SCORE (COUNT OVERALL RATINGS)
select
	ROUND(AVG(review_score),2) as avg_review_score
	from reviews;


-- REVIEW SCORE DISTRIBUTION
select
	review_score,
	count(*) as total_reviews
	from reviews
	group by review_score 
	order by total_reviews desc;


-- ORDERS WITH LOW RATINGS
select 
	review_id,
	order_id,
	review_score
from reviews
where review_score <=2
order by review_score ;


-- Delivery Delay vs Review Score
select 
	r.review_score,
	ROUND(
		avg(
			datediff(
			order_delivered_customer_date,
			order_estimated_delivery_date
			)
		),2
	)
		as avg_delay_days
	from reviews r
	join orders o
	on r.order_id = o.order_id
	where o.order_delivered_customer_date is not null 
	group by r.review_score
	order by r.review_score desc;



-- TOP RATED SELLERS
SELECT 
    oi.seller_id,
    ROUND(AVG(r.review_score),2) AS avg_rating,
    COUNT(*) AS total_reviews
FROM reviews r
JOIN orders o
ON r.order_id = o.order_id
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY oi.seller_id
HAVING total_reviews > 20
ORDER BY avg_rating DESC
LIMIT 10;



-- Worst Rated Sellers
SELECT 
    oi.seller_id,
    ROUND(AVG(r.review_score),2) AS avg_rating,
    COUNT(*) AS total_reviews
FROM reviews r
JOIN orders o
ON r.order_id = o.order_id
JOIN order_items oi
ON o.order_id = oi.order_id
GROUP BY oi.seller_id
HAVING total_reviews > 20
ORDER BY avg_rating ASC
LIMIT 10;



-- Review Comments Availability
SELECT 
    COUNT(*) AS reviews_with_comments
FROM reviews
WHERE review_comment_message IS NOT NULL;



-- Rating by Payment Type
SELECT 
    p.payment_type,
    ROUND(AVG(r.review_score),2) AS avg_rating
FROM reviews r
JOIN payments p
ON r.order_id = p.order_id
GROUP BY p.payment_type
ORDER BY avg_rating DESC;




-- Monthly Review Trend
SELECT 
    YEAR(review_creation_date) AS year,
    MONTH(review_creation_date) AS month,
    ROUND(AVG(review_score),2) AS avg_rating
FROM reviews
GROUP BY year, month
ORDER BY year, month;