USE 2_Scott_Lovelady;

--List IDs of products that have been ordered.
select distinct ol.product_id
from order_line ol
order by ol.product_id asc;

--List IDs of customers that have placed orders after October 27, 2019.
select distinct customer_id
from order_header
where order_date > '2019-10-27'
order by customer_id asc;

--List all customer names for customers who are from Salt Lake City and whose first name starts with the letter ‘J’.
select customer_name
from customer
where city = 'Salt Lake City'
and
customer_name like 'J%';

--List the product name, product price and product price after 10% discount.
select 
product_name, 
product_price, 
(product_price * 0.9) AS discounted_price
from product;

--List the number of products with a price higher than $100
select distinct
count(product_id)
from product
where product_price > 100;

--List name and price for all products that have been purchased on order 1001.
select
product_name, product_price
from product
where product_id in 
(
	select product_id
	from order_line 
	where order_id = 1001
);

--List the order id and the total quantity of items for each order.
select
order_id,
sum(quantity) as tot_quantity
from order_line
group by order_id
order by tot_quantity desc

--List the order id, date and total dollar amount for the top 10 orders by dollar amount.
select * from (
select
top 10
oh.order_id,
order_date,
sum(quantity * product_price) as total_amount
from order_header oh
inner join
	order_line ol 
	on 
	ol.order_id = oh.order_id
inner join 
	product p
	on
	p.product_id = ol.product_id
group by
oh.order_id, order_date
order by total_amount desc
) as myTable
order by order_date asc, total_amount desc

--List the order id, date and total dollar amount for each order that has at least 4 items.
select
oh.order_id,
order_date,
sum(quantity * product_price) as total_amount
from order_header oh
inner join
	order_line ol 
	on 
	ol.order_id = oh.order_id
inner join 
	product p
	on
	p.product_id = ol.product_id
where exists (
	select order_id, sum(quantity) from order_line group by order_id having sum(quantity) >= 4 )
group by oh.order_id, order_date
order by order_date asc, total_amount desc


/*
Select all rows from the customer table, but add a column called is_vip_customer where 1 
		indicates customers who have placed at least 10 orders and 0 indicates customers who 
		have places 9 or less orders 
*/
select distinct
	cu.customer_id,
	customer_name,
	address_line_1,
	city,
	state_province,
	postal_code,
	case
		when count_customer_id >= 10 then 1
		else 0
	end as is_vip_customer
from customer cu
inner join
	(
	select distinct 
		customer_id, 
		count(customer_id) as count_customer_id
	from order_header 
	group by customer_id
	) as co
on cu.customer_id = co.customer_id
order by is_vip_customer desc, state_province asc, city asc;


/*
Remove the customer “Pavia Vanyutin” from the database.
*/
delete ol
from 
customer c 
inner join 
	order_header oh 
	on c.customer_id = oh.customer_id
inner join
	order_line ol
	on ol.order_id = oh.order_id
where customer_name = 'Pavia Vanyutin';

delete oh
from 
customer c 
inner join 
	order_header oh 
	on c.customer_id = oh.customer_id
where customer_name = 'Pavia Vanyutin';

delete c
from 
customer c 
where customer_name = 'Pavia Vanyutin';


/*
Remove the customer “Rania Kyne” from the database
*/
delete ol
from 
customer c 
inner join 
	order_header oh 
	on c.customer_id = oh.customer_id
inner join
	order_line ol
	on ol.order_id = oh.order_id
where customer_name = 'Rania Kyne';

delete oh
from 
customer c 
inner join 
	order_header oh 
	on c.customer_id = oh.customer_id
where customer_name = 'Rania Kyne';

delete c
from 
customer c 
where customer_name = 'Rania Kyne';


/*
Delete the customer “Allistir Rickett” from the Customer table.
*/
delete ol
from 
customer c 
inner join 
	order_header oh 
	on c.customer_id = oh.customer_id
inner join
	order_line ol
	on ol.order_id = oh.order_id
where customer_name = 'Allistir Rickett';

delete oh
from 
customer c 
inner join 
	order_header oh 
	on c.customer_id = oh.customer_id
where customer_name = 'Allistir Rickett';

delete c
from 
customer c 
where customer_name = 'Allistir Rickett';

