-- CUSTOMER LIFETIME value

CREATE VIEW customer_lifetime_valuee AS
SELECT
    o.customer_id,
    ROUND(
        SUM(p.price * oi.quantity * (1 - oi.discount / 100)),
        2
    ) AS lifetime_revenue
FROM orders o
JOIN order_items oi
    ON o.order_id = oi.order_id
JOIN products p
    ON p.product_id = oi.product_id
WHERE o.order_status = 'Delivered'
GROUP BY o.customer_id
order by lifetime_revenue ;