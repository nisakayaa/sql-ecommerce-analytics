-- Example analytics queries

-- 1) Total revenue (paid + shipped)
SELECT SUM(oi.quantity * oi.unit_price) AS revenue
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.status IN ('paid','shipped');

-- 2) Spending per customer
SELECT c.full_name, SUM(oi.quantity * oi.unit_price) AS spent
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.status IN ('paid','shipped')
GROUP BY c.full_name
ORDER BY spent DESC;

-- 3) Units sold per category
SELECT p.category, SUM(oi.quantity) AS units_sold
FROM order_items oi
JOIN orders o ON o.order_id = oi.order_id
JOIN products p ON p.product_id = oi.product_id
WHERE o.status IN ('paid','shipped')
GROUP BY p.category
ORDER BY units_sold DESC;

-- 4) Best-selling product
SELECT p.name, SUM(oi.quantity) AS units_sold
FROM order_items oi
JOIN orders o ON o.order_id = oi.order_id
JOIN products p ON p.product_id = oi.product_id
WHERE o.status IN ('paid','shipped')
GROUP BY p.name
ORDER BY units_sold DESC
LIMIT 1;

-- 5) Orders in last 30 days
SELECT COUNT(*) AS orders_last_30d
FROM orders
WHERE order_date >= CURRENT_DATE - INTERVAL '30 day';

-- 6) Low stock items (<= 25)
SELECT name, stock
FROM products
WHERE stock <= 25
ORDER BY stock ASC;

-- 7) Cancelled value (gross)
SELECT SUM(oi.quantity * oi.unit_price) AS cancelled_value
FROM orders o
JOIN order_items oi ON oi.order_id = o.order_id
WHERE o.status = 'cancelled';

-- 8) First order date per customer (if any)
SELECT c.full_name, MIN(o.order_date) AS first_order
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.full_name;

-- 9) Average order value (AOV)
SELECT AVG(order_total) AS avg_order_value
FROM (
  SELECT o.order_id, SUM(oi.quantity * oi.unit_price) AS order_total
  FROM orders o
  JOIN order_items oi ON oi.order_id = o.order_id
  WHERE o.status IN ('paid','shipped')
  GROUP BY o.order_id
) t;

-- 10) Customer with most orders
SELECT c.full_name, COUNT(*) AS order_count
FROM customers c
JOIN orders o ON o.customer_id = c.customer_id
GROUP BY c.full_name
ORDER BY order_count DESC
LIMIT 1;-- E-commerce analytics project

CREATE TABLE customers (
    id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE orders (
    id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total DECIMAL(10,2)
);

SELECT customers.name, orders.total
FROM customers
JOIN orders ON customers.id = orders.customer_id;

