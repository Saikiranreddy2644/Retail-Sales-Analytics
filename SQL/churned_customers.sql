-- Churned Customers

CREATE OR REPLACE VIEW churned_customers AS
SELECT
    o.customer_id,
    MAX(o.order_date) AS last_order_date
FROM orders o
WHERE o.order_status = 'Delivered'
GROUP BY o.customer_id
HAVING MAX(o.order_date) < (
    SELECT 
        DATE_SUB(MAX(order_date), INTERVAL 90 DAY)
    FROM orders
    WHERE order_status = 'Delivered'
);
