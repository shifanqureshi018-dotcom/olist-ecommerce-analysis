# 🛒 Olist E-Commerce Sales Analysis
> End-to-end data analysis project using SQL for data extraction & Power BI for interactive visualization.

![SQL](https://img.shields.io/badge/SQL-MySQL-blue) ![Power BI](https://img.shields.io/badge/PowerBI-Dashboard-yellow) ![Dataset](https://img.shields.io/badge/Dataset-100K%2B_Orders-green) ![Status](https://img.shields.io/badge/Status-Completed-brightgreen)

---

## 📌 Project Overview

Analyzed the **Brazilian E-Commerce dataset by Olist** — covering 100K+ orders, 99K customers, 3K+ sellers across 27 Brazilian states from 2016 to 2018.

The goal was to extract actionable business insights across 4 domains: Sales Performance, Customer Behavior, Product Analysis, and Delivery Operations.

---

## 🗂️ Repository Structure

```
olist-ecommerce-analysis/
├── sql/
│   ├── tables_import.sql          # Schema creation & table setup
│   ├── business_overview.sql      # Revenue, orders, payment KPIs
│   ├── 02_customer_analysis.sql   # Customer behavior & geography
│   ├── 03_Product_analysis.sql    # Product & category performance
│   ├── 04_seller_analysis.sql     # Seller performance & delivery
│   └── 05_review_analysis.sql     # Review scores & satisfaction
├── powerbi/
│   ├── olist_dashboard.pbix
│   └── olist_dashboard.pdf
├── assets/
│   ├── executive_overview.png
│   ├── customer_analysis.png
│   ├── product_analysis.png
│   └── delivery_operations.png
└── README.md
```

---

## 📊 Dataset

**Source:** [Brazilian E-Commerce Public Dataset by Olist](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

| Table | Description |
|-------|-------------|
| `orders` | 99K orders with status & timestamps |
| `customers` | Customer location & unique IDs |
| `order_items` | Product, seller, price per order |
| `payments` | Payment type & value |
| `products` | Product dimensions & category |
| `sellers` | Seller location data |
| `reviews` | Customer review scores & comments |
| `category_translation` | Portuguese → English category names |
| `geolocation` | ZIP code lat/lng mapping |

---

## 🔍 Business Questions Answered

1. What is the total revenue and monthly revenue trend?
2. Which states and cities drive maximum customers & orders?
3. Which product categories generate highest revenue?
4. What is the relationship between delivery delays and review scores?
5. Which sellers have the best and worst delivery performance?
6. What payment methods do customers prefer?
7. How has delivery performance improved over time?

---

## 🛠️ SQL Work

### Data Cleaning & Setup
Created 9 tables with proper data types. Handled `reviews` table schema issue — rebuilt with `LONGTEXT` for comment fields and `TEXT` for timestamp columns to avoid import errors.

### Key Queries

**Monthly Revenue Trend**
```sql
SELECT 
    YEAR(o.order_purchase_timestamp) AS year,
    MONTH(o.order_purchase_timestamp) AS month,
    ROUND(SUM(payment_value), 2) AS revenue
FROM orders o
JOIN payments p ON o.order_id = p.order_id
GROUP BY year, month
ORDER BY year, month;
```

**Delivery Delay vs Review Score** *(Advanced)*
```sql
SELECT 
    r.review_score,
    ROUND(AVG(DATEDIFF(
        order_delivered_customer_date,
        order_estimated_delivery_date
    )), 2) AS avg_delay_days
FROM reviews r
JOIN orders o ON r.order_id = o.order_id
WHERE o.order_delivered_customer_date IS NOT NULL
GROUP BY r.review_score
ORDER BY r.review_score DESC;
```

**Repeat Customers**
```sql
SELECT 
    c.customer_unique_id,
    COUNT(o.order_id) AS total_orders
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
GROUP BY c.customer_unique_id
HAVING COUNT(o.order_id) > 1
ORDER BY total_orders DESC;
```

---

## 📈 Power BI Dashboard

4-page interactive dashboard with cross-page slicers, DAX measures, and drill-through navigation.

| Page | Focus |
|------|-------|
| Executive Overview | Revenue KPIs, payment methods, order status |
| Customer Analysis | Growth trend, top states/cities, distribution |
| Product Analysis | Category revenue, freight cost, price analysis |
| Delivery & Operations | Delivery days, late deliveries, seller performance |

### Dashboard Screenshots

**Executive Overview**
![Executive Overview](<img width="1321" height="716" alt="Screenshot 2026-05-18 165724" src="https://github.com/user-attachments/assets/da86db9c-9116-42fc-998d-ba67177a21fd" />
)

**Customer Analysis**
![Customer Analysis](<img width="1282" height="720" alt="Screenshot 2026-05-18 165745" src="https://github.com/user-attachments/assets/ffd094c1-5311-44bc-90ba-4c9660973de1" />
)

**Product Analysis**
![Product Analysis](<img width="1280" height="721" alt="Screenshot 2026-05-18 165812" src="https://github.com/user-attachments/assets/b3628a02-e624-4a8d-8534-845c0a691b18" />
)

**Delivery & Operations**
![Delivery & Operations](<img width="1285" height="722" alt="Screenshot 2026-05-18 170004" src="https://github.com/user-attachments/assets/fd8efbbb-fbbc-4301-bbea-1d7837ac0009" />
)

---

## 🔑 Key Findings

- **₹13.6M total revenue** generated across 99K orders in 2017–2018
- **SP state dominates** — 38% of total revenue and 42K of 99K customers
- **Credit card = 73.9%** of all payments — EMI culture is strong in Brazil
- **Delivery improved significantly** — avg delivery days dropped from ~50 days (early 2017) to ~8 days (mid 2018)
- **8K late deliveries** concentrated in SP and RJ — highest volume states
- **Review score 4.1/5** overall — but orders with delays average score of 2.5 vs 4.3 for on-time orders
- **Avg orders per customer = 1.00** — near-zero retention, major opportunity for loyalty programs

---

## 💡 Recommendations

| Problem | Recommendation |
|---------|---------------|
| Low repeat purchase rate | Launch loyalty/rewards program |
| Late deliveries in SP & RJ | Add regional fulfillment centers |
| Low review scores on delayed orders | Improve delivery ETA communication |
| Untapped states (MG, RS) | Targeted marketing campaigns |

---

## 🧰 Skills Demonstrated

`MySQL` · `Multi-table JOINs` · `Subqueries` · `Aggregations` · `Window Functions` · `Data Cleaning` · `Power BI` · `DAX Measures` · `Data Modeling` · `KPI Design` · `Cross-page Filtering` · `Business Intelligence` · `Data Storytelling`

---

## 👤 Author

**[SHIFWAN]**
[LinkedIn]() · [GitHub](#) · [Portfolio](#)
