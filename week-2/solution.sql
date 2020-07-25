--...........................HOMEWORK(SQL week 2)...........................................................................

--select customer name and address who live in United States
select name, address
from customers c 
where country = 'United States';

--retrive all the customers ordered by ascending name
select *
from customers 
order by name asc;

--retrive all the products which costs more than 100
select * 
from products p 
where unit_price > 100;

--retrive all the products whose name contains the word 'socks'
select *
from products p 
where product_name like '%socks%';

--retrive five most expensive products
select *
from products p 
order by unit_price desc 
limit 5;

--Retrieve all the products with their corresponding suppliers. 
--The result should only contain the columns `product_name`, `unit_price` and `supplier_name`

select products.product_name, products.unit_price, suppliers.supplier_name 
from products
join suppliers on products.supplier_id = suppliers.id;

--retrive all the product sold by suppliers based in the united kingdom 
select p.product_name, s.supplier_name 
from products p
join suppliers s on s.id = p.supplier_id 
where s.country = 'United Kingdom';

--retrive all the orders from the customer id 1 

select p2.product_name, oi.quantity
from products p2
join order_items oi on p2.id = oi.product_id
join orders o on o.id = oi.order_id
where o.customer_id = 1;

--retrive all orders from customer name 'Hope CrossBy'
select c2.name, oi.quantity
from customers c2
join orders o on c2.id = o.customer_id
join order_items oi on o.id = oi.order_id
where c2.name = 'Hope Crosby';

--retrive all the products in the order 'ORD006'. the result should only contain
-- the columns 'producnt name', 'unit price', 'quantity'

select p2.product_name, p2.unit_price, oi.quantity 
from products p2
join order_items oi on p2.id = oi.product_id
join orders o2 on oi.order_id = o2.id
where o2.order_reference = 'ORD006';

--retrive all their products with their supplier for all orders of all customers. The result should only contain 
--the collumns 'name' (from customers), 'order_reference', 'order_date', 'product_name', 'supplier_name', 'quantity'.

  select c.name, o.order_reference, o.order_date, p.product_name , s.supplier_name , oi.quantity 
  from customers c 
  join orders o on c.id = o.customer_id 
  join order_items oi on oi.order_id = o.id 
  join products p on p.id = oi.product_id 
  join suppliers s on p.supplier_id = s.id;
 
--retrive all the name of the customers who bought a product from a supplier from china 
select c.name 
from customers c
join orders o on c.id = o.customer_id 
join order_items oi on oi.order_id = o.id 
join products p on p.id = oi.product_id 
join suppliers s on s.id = p.supplier_id
where s.country = 'China';




