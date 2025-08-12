CREATE TABLE orders (
    order_id    INT,
    order_date  DATE,
    product_id  INT,
    amount      NUMERIC(10,2)
);
SELECT
    EXTRACT(YEAR FROM order_date)  AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    SUM(amount)                   AS total_revenue,
    COUNT(DISTINCT order_id)      AS total_orders
FROM orders
WHERE order_date BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY year, month
ORDER BY year, month;

SELECT
    TO_CHAR(DATE_TRUNC('month', order_date), 'YYYY-MM') AS year_month,
    SUM(amount)                                        AS total_revenue,
    COUNT(DISTINCT order_id)                           AS total_orders
FROM orders
WHERE order_date BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY DATE_TRUNC('month', order_date);



