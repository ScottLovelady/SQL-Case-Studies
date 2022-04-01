--Scott Lovelady
--10/26/2021


CREATE DATABASE 4_Scott_Lovelady;
USE 4_Scott_Lovelady

--1. Create a query that uses a CASE statement and gets the following columns:
--order_id
--num_items   (number of items in the order)
--num_desks   (number of desks in the order)
SELECT 
order_id,
SUM(quantity) AS num_items,
SUM(
CASE 
	WHEN product_name = 'Desk' THEN quantity
END) AS num_desks
FROM order_line ol 
INNER JOIN product p 
ON ol.product_id = p.product_id
GROUP BY order_id


--2. Create a query that uses a CTE and a Window Function to get the following columns:
--state_province
--last_customer_name    (name of customer that placed an order most recently)

WITH state_customer AS 
(
SELECT state_province
, order_date
, customer_name
, ROW_NUMBER() OVER(PARTITION BY state_province ORDER BY order_date DESC) AS ranking
FROM customer c 
INNER JOIN order_header oh 
ON c.customer_id = oh.customer_id
)
SELECT state_province
, customer_name
FROM state_customer
WHERE ranking = 1

--3. Create the query from #2 using a Temporary Table instead of a CTE. 

DROP TABLE IF EXISTS #tmp_rank_table
SELECT state_province
, order_date
, customer_name
, ROW_NUMBER() OVER(PARTITION BY state_province ORDER BY order_date DESC) AS ranking
INTO #tmp_rank_table
FROM customer c 
INNER JOIN order_header oh 
ON c.customer_id = oh.customer_id;

SELECT state_province
, customer_name
FROM #tmp_rank_table
WHERE ranking = 1;

--4. Create the query from #2 using a View instead of a CTE.  

CREATE VIEW rank_table AS
SELECT state_province
, order_date
, customer_name
, ROW_NUMBER() OVER(PARTITION BY state_province ORDER BY order_date DESC) AS ranking
FROM customer c 
INNER JOIN order_header oh 
ON c.customer_id = oh.customer_id;

SELECT state_province
, customer_name
FROM rank_table
WHERE ranking = 1;


--5. Create a view called SalesPerState that shows state, how many orders have been placed (order_count), and total sales revenue (total_revenue).
CREATE VIEW SalesPerState AS
SELECT state_province
, COUNT(oh.order_id) AS order_count
, SUM(product_price * quantity) AS total_revenue
FROM
order_header oh
INNER JOIN 
	order_line ol ON oh.order_id = ol.order_id
INNER JOIN
	product p ON ol.product_id = p.product_id
INNER JOIN customer c ON oh.customer_id = c.customer_id
GROUP BY state_province


--6. Create a Stored Procedure called UpdateProductPrice, which can be used to update the SalesPrice of a Product.  Stored procedure 
----also adds a row to the ProductPriceHistory table to maintain price history.
------The UpdateProductPrice sproc takes 2 input parameters, @ProductID with a data type of SMALLINT and the second one @ProductPrice 
----------with a data type of DECIMAL(7,2).


CREATE PROCEDURE UpdateProductPrice
	@ProductID		SMALLINT,
	@ProductPrice	DECIMAL(7,2)
AS
BEGIN
	BEGIN TRANSACTION
		UPDATE product
		SET product_price = @ProductPrice
		WHERE product_id = @ProductID;
		INSERT INTO product_price_hist (product_id, price_change_date, product_price)
		VALUES (@ProductID, GETDATE(), @ProductPrice);
	COMMIT TRANSACTION;
END;



EXECUTE UpdateProductPrice
	@ProductID = 101,
	@ProductPrice = 21.00;