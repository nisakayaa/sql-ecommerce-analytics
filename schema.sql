-- SQL E-Commerce Analytics (PostgreSQL friendly)
-- Create tables
CREATE TABLE customers (
  customer_id SERIAL PRIMARY KEY,
  full_name   VARCHAR(120) NOT NULL,
  email       VARCHAR(160) UNIQUE NOT NULL,
  created_at  TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products (
  product_id  SERIAL PRIMARY KEY,
  name        VARCHAR(160) NOT NULL,
  category    VARCHAR(80) NOT NULL,
  price       NUMERIC(10,2) NOT NULL CHECK (price >= 0),
  stock       INT NOT NULL CHECK (stock >= 0)
);

CREATE TABLE orders (
  order_id    SERIAL PRIMARY KEY,
  customer_id INT NOT NULL REFERENCES customers(customer_id),
  order_date  DATE NOT NULL DEFAULT CURRENT_DATE,
  status      VARCHAR(20) NOT NULL CHECK (status IN ('created','paid','shipped','cancelled'))
);

CREATE TABLE order_items (
  order_id    INT NOT NULL REFERENCES orders(order_id) ON DELETE CASCADE,
  product_id  INT NOT NULL REFERENCES products(product_id),
  quantity    INT NOT NULL CHECK (quantity > 0),
  unit_price  NUMERIC(10,2) NOT NULL CHECK (unit_price >= 0),
  PRIMARY KEY (order_id, product_id)
);

CREATE INDEX idx_orders_customer ON orders(customer_id);
CREATE INDEX idx_products_category ON products(category);
