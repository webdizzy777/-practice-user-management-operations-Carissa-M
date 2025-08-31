-- Task 1: Create the customers and order tables
drop table if exists orders;
drop table if exists customers;

create table customers (
 id int primary key auto_increment,
 first_name varchar(50),
 last_name varchar(50)
);

create table orders (
 id int primary key,
 customer_id int null,
 order_date date,
 total_amount decimal(10, 2),
 foreign key (customer_id) references customers(id)
);

insert into customers (id, first_name, last_name) values
(1, 'John', 'Doe'),
(2, 'Jane', 'Smith'),
(3, 'Alice', 'Smith'),
(4, 'Bob', 'Brown');

insert into orders (id, customer_id, order_date, total_amount) values
(1, 1, '2023-01-01', 100.00),
(2, 1, '2023-02-01', 150.00),
(3, 2, '2023-01-01', 200.00),
(4, 3, '2023-04-01', 250.00),
(5, 3, '2023-04-01', 300.00),
(6, NULL, '2023-04-01', 100.00);

-- Task 2: find the total amount spent for each customer by grouping them
SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id;

-- Task 3: Find the total amount spent by each customer on specific days
SELECT customer_id, order_date, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id, order_date;

-- Task 4: Only include orders that are greater than $200 when we find the total amount spent for each customer:
SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
WHERE total_amount >= 200
GROUP BY customer_id;

-- Task 5: Only include customers who have spent more than $200 in total when we add the total amount spent per customer
SELECT customer_id, SUM(total_amount) AS total_spent
FROM orders
GROUP BY customer_id
HAVING SUM(total_amount) >= 200;

-- Task 6: Include the customer's information when pulling the order details
SELECT orders.id, customers.first_name, customers.last_name, orders.order_date, orders.total_amount
FROM orders
INNER JOIN customers ON orders.customer_id = customers.id;

-- Task 7: Add the customer's information when we gather the order details, but also include orders from guests:
SELECT orders.id, customers.first_name, customers.last_name, orders.order_date, orders.total_amount
FROM orders
LEFT JOIN customers ON orders.customer_id = customers.id;

-- Task 8: Find all orders where the total amount is greater than the average of all orders
SELECT id, order_date, total_amount
FROM orders
WHERE total_amount >= (SELECT AVG(total_amount) FROM orders); 

-- Task 9: Find all orders placed by a Smith
SELECT id, order_date, total_amount, customer_id
FROM orders
WHERE customer_id IN (SELECT id FROM customers WHERE last_name = 'Smith');

-- Task 10: Find the date of all orders
SELECT order_date
FROM (SELECT id, order_date, total_amount FROM orders) AS order_summary;