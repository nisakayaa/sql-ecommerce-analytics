-- Seed sample data
INSERT INTO customers(full_name, email) VALUES
('Ayşe Yılmaz','ayse@example.com'),
('Mehmet Kaya','mehmet@example.com'),
('Zeynep Demir','zeynep@example.com');

INSERT INTO products(name, category, price, stock) VALUES
('Wireless Mouse','Electronics', 399.90, 50),
('Mechanical Keyboard','Electronics', 1499.00, 20),
('Protein Bar Box','Food', 259.50, 200),
('Yoga Mat','Sports', 349.99, 60);

INSERT INTO orders(customer_id, order_date, status) VALUES
(1, '2026-01-10', 'paid'),
(2, '2026-01-12', 'shipped'),
(1, '2026-01-20', 'cancelled');

INSERT INTO order_items(order_id, product_id, quantity, unit_price) VALUES
(1, 1, 1, 399.90),
(1, 3, 2, 259.50),
(2, 2, 1, 1499.00),
(2, 4, 1, 349.99),
(3, 3, 1, 259.50);
