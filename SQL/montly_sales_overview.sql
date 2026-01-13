   -- Monthly Sales Overview

CREATE OR REPLACE VIEW monthly_sales_overview AS
SELECT
    DATE_FORMAT(o.order_date, '%Y-%m-01') AS month_start,
    DATE_FORMAT(o.order_date, '%Y-%m')    AS year_monthh,
    SUM(p.price * oi.quantity * (1 - oi.discount/100)) AS revenue,
    COUNT(DISTINCT o.order_id) AS total_orders
FROM orders o
JOIN order_items oi 
    ON o.order_id = oi.order_id
JOIN products p 
    ON p.product_id = oi.product_id
WHERE o.order_status = 'Delivered'
GROUP BY
    month_start,
    year_monthh;