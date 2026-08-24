# SQL E-Commerce Analytics

A small PostgreSQL schema for an online store, plus ten analytics queries against it. Four tables, foreign keys, check constraints and two indexes. I wrote it to practise schema design and joins without a Python layer in the way, so everything here is plain SQL.

## The schema

`customers`, `products`, `orders` and `order_items`, with `order_items` keyed on `(order_id, product_id)` so a product can't appear twice in the same order. Money is `NUMERIC(10,2)`, not float. `orders.status` is constrained to `created`, `paid`, `shipped` or `cancelled`, and every revenue query filters on it, because counting cancelled orders as revenue is the mistake I was trying to avoid making.

Two indexes: `orders(customer_id)` for the customer joins and `products(category)` for the category grouping.

## The queries

`queries.sql` has ten, working up from a single aggregate to a subquery. Revenue and spend per customer, units and best seller, orders in the last 30 days, low stock, the value sitting in cancelled orders, first order date per customer with a `LEFT JOIN` so customers who never ordered still appear, average order value from a grouped subquery, and the customer with the most orders.

Against the seed data the totals come out at 2,767.89 revenue, 1,383.94 average order value, and 259.50 stuck in the cancelled order. Zeynep Demir shows up in the first-order query with a null date, which is the point of using a `LEFT JOIN` there.

## Running it

```bash
psql -d ecommerce_demo -f schema.sql
psql -d ecommerce_demo -f seed.sql
psql -d ecommerce_demo -f queries.sql
```

Or open the three files in pgAdmin and run them in that order. Any Postgres will do; the only non-portable piece is `INTERVAL '30 day'` in query 5.

The seed dates are fixed in January 2026, so query 5 returns zero unless you edit them. Query 5 is the one query here whose answer depends on when you run it.

## What it isn't

Twelve rows of seed data. It's enough to check that the joins and the status filter behave, not enough to say anything about a business. Window functions are the obvious next thing to add, running totals and rank per category.
