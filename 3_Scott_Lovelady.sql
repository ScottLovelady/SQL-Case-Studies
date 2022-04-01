--Scott Lovelady
--10/5/2021

CREATE DATABASE 3_Scott_Lovelady
USE 3_Scott_Lovelady

---1. List the ID, name, and price for all products with a price greater than the average product price.
SELECT
product_id,
product_name,
product_price
FROM 
product
WHERE product_price > (SELECT AVG(product_price) FROM product)


--2. For each product, list its ID and total quantity ordered. 
SELECT p.product_id, sum(quantity) AS total_quantity
FROM product p
INNER JOIN order_line ol on p.product_id = ol.product_id
GROUP BY p.product_id
ORDER BY product_ID ASC


--3. For each product, list its ID and total quantity ordered.
SELECT p.product_id, sum(quantity) AS total_quantity
FROM product p
INNER JOIN order_line ol on p.product_id = ol.product_id
GROUP BY p.product_id
ORDER BY total_quantity DESC

--4. For each product, list its ID, name and total quantity ordered. 
SELECT p.product_id, product_name, sum(quantity) AS total_quantity
FROM product p
INNER JOIN order_line ol on p.product_id = ol.product_id
GROUP BY p.product_id, product_name
ORDER BY product_name ASC

--5. List the name for all customers, who have placed 20 or more orders. Each customer name appears exactly once. 
SELECT DISTINCT customer_name
FROM customer c
INNER JOIN order_header oh on c.customer_id = oh.customer_id
GROUP BY customer_name
HAVING (COUNT(oh.customer_id) >= 20)
ORDER BY customer_name ASC


--6. Implement previous query using a subquery and IN adding the requirement that the customers’ orders have been placed after January 1st, 2019.
SELECT DISTINCT customer_name
FROM customer c
INNER JOIN order_header oh on c.customer_id = oh.customer_id
WHERE oh.customer_id IN 
	(
	SELECT customer_id
	FROM order_header
	WHERE order_date > '01/01/2019'
	GROUP BY customer_id
	HAVING count(customer_id) > 20
	)

--7. For each city, list the number of customers from that city, who have placed 5 or more orders. 
SELECT city, count(customer_id)
FROM 
(
SELECT oh.customer_id, city
FROM order_header AS oh
INNER JOIN customer c on oh.customer_id = c.customer_id
GROUP BY oh.customer_id, city
HAVING COUNT(oh.customer_id) >= 5
--ORDER by city asc
) AS subq
GROUP BY city
ORDER BY city ASC

--8. Implement the previous using a subquery and IN.
SELECT city, count(customer_id)
FROM 
(
SELECT oh.customer_id, city
FROM order_header AS oh
INNER JOIN customer c on oh.customer_id = c.customer_id
GROUP BY oh.customer_id, city
HAVING COUNT(oh.customer_id) >= 5
--ORDER by city asc
) AS subq
WHERE city in (SELECT city FROM customer)
GROUP BY city
ORDER BY city ASC

--9. List the ID for all products, which have NOT been ordered since October 28, 2019. 

SELECT product_id
FROM order_line oh

EXCEPT

SELECT product_id
FROM order_header oh
INNER JOIN order_line ol ON oh.order_id = ol.order_id
WHERE order_date >= '2019-10-28'
ORDER BY product_id

--10. List the ID for all Arizona customers who have placed one or more orders since October 28, 2019. 
SELECT customer_id
FROM customer
WHERE state_province = 'AZ'

INTERSECT

SELECT c.customer_id
FROM customer c
INNER JOIN order_header oh on c.customer_id = oh.customer_id
WHERE order_date >= '2019-10-28'
ORDER BY customer_id ASC

--11. Implement the previous query using a subquery and IN.
SELECT customer_id
FROM customer
WHERE customer_id in (
		SELECT c.customer_id
		FROM customer c
		INNER JOIN order_header oh on c.customer_id = oh.customer_id
		WHERE order_date >= '2019-10-28'
		AND
		state_province = 'AZ'
		)
ORDER BY customer_id ASC

	

--12. List the IDs for all California customers along with all customers (regardless where they are from) who have placed one or 
--more order(s) since October 28, 2019. 

SELECT customer_id
FROM customer
WHERE state_province = 'CA'

UNION

SELECT c.customer_id
FROM customer c
INNER JOIN order_header oh on c.customer_id = oh.customer_id
WHERE order_date >= '2019-10-28'
ORDER BY customer_id ASC

--13. List the ID, name and total quantity ordered for all products with total quantity ordered greater than 10.
SELECT p.product_id, product_name, SUM(quantity)
FROM product p
INNER JOIN order_line ol on p.product_id = ol.product_id
GROUP BY p.product_id, product_name
HAVING SUM(quantity) > 10


--14. List the ID, name and total quantity ordered for all products with total quantity ordered greater than 4 and were placed by Utah customers.

SELECT p.product_id, product_name, SUM(quantity)
FROM product p
INNER JOIN order_line ol on p.product_id = ol.product_id
WHERE order_id IN 
	(
	SELECT order_id
	FROM order_header oh
	INNER JOIN customer c on c.customer_id = oh.customer_id
	WHERE state_province = 'UT'
	)
GROUP BY p.product_id, product_name
HAVING SUM(quantity) > 4