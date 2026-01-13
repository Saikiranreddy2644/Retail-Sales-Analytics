 -- Product Performance
   
CREATE OR REPLACE VIEW product_performance AS
SELECT
    DATE_FORMAT(o.order_date, '%Y-%m-01') AS month_start,
    p.category,
    p.sub_category,
    SUM(p.price * oi.quantity * (1 - oi.discount/100)) AS revenue,
    SUM((p.price * (1 - oi.discount/100) - p.cost) * oi.quantity) AS profit
FROM orders o
JOIN order_items oi 
    ON o.order_id = oi.order_id
JOIN products p 
    ON p.product_id = oi.product_id
WHERE o.order_status = 'Delivered'
GROUP BY
    month_start,
    p.category,
    p.sub_category;