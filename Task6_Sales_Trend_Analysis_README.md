
# Task 6: Sales Trend Analysis Using Aggregations

## Objective
Analyze monthly revenue and order volume from the `orders` table.

## Dataset
Table: `orders`
- `order_id` (INT) — Unique ID for each order
- `order_date` (DATE) — Date the order was placed
- `product_id` (INT) — ID of the product
- `amount` (NUMERIC) — Revenue amount for the order item

## Steps

### 1. Create the Table
```sql
CREATE TABLE orders (
    order_id INT,
    order_date DATE,
    product_id INT,
    amount NUMERIC(10, 2)
);
```

### 2. Import Data
Use pgAdmin's Import/Export tool or the `COPY` command to load the CSV file into the `orders` table.

### 3. Run the Monthly Sales Trend Query
**Version 1 — Year & Month Columns**
```sql
SELECT
    EXTRACT(YEAR FROM order_date)  AS year,
    EXTRACT(MONTH FROM order_date) AS month,
    SUM(amount)                   AS total_revenue,
    COUNT(DISTINCT order_id)      AS total_orders
FROM orders
WHERE order_date BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY year, month
ORDER BY year, month;
```

**Version 2 — Single Year-Month Column**
```sql
SELECT
    TO_CHAR(DATE_TRUNC('month', order_date), 'YYYY-MM') AS year_month,
    SUM(amount)                                        AS total_revenue,
    COUNT(DISTINCT order_id)                           AS total_orders
FROM orders
WHERE order_date BETWEEN '2024-01-01' AND '2024-12-31'
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY DATE_TRUNC('month', order_date);
```

## Output Example
| year | month | total_revenue | total_orders |
|------|-------|---------------|--------------|
| 2024 | 1     | 3450.50        | 12           |
| 2024 | 2     | 4102.75        | 15           |
| 2024 | 3     | 5020.20        | 18           |

## Notes
- `EXTRACT()` is used to get the year and month from the date.
- `SUM(amount)` calculates the total revenue.
- `COUNT(DISTINCT order_id)` counts unique orders.
- `WHERE` filters data to a specific time period.
- `GROUP BY` groups the data by time periods for aggregation.
- `ORDER BY` sorts the results in chronological order.
