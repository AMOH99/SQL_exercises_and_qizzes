-- Retrieve all customers who live in cities starting with 'S' 

select *
from customers
where city like 's%';

-- List all orders where the required date is later than the shipment date

select order_id, customer_id, required_date, shipped_date,
      datediff(shipped_date, required_date) as shipmentdays
from orders
where datediff(shipped_date, required_date) > '0';

-- Show the number of products in each category per brand

select brand_name, category_name, count(product_name) as products
from brands inner join products
on brands.brand_id = products.brand_id
inner join categories
on products.category_id = categories.category_id
group by brand_name, category_name;

-- Retrieve all products with a model year not equal to 2016 
 
select product_name, model_year
from products
where model_year != '2016';

-- List all customers who have purchased a product from the 'Mountain Bikes' category 

select distinct(concat(first_name, ' ', last_name)) as name,
       category_name
from customers join orders
on customers.customer_id = orders.customer_id
join order_items on orders.order_id = order_items.order_id
join products on products.product_id = order_items.product_id
join categories on categories.category_id = products.category_id
where category_name like '%mountain bikes%';

-- Find the total revenue from orders shipped before the required date 

select sum(quantity * list_price) as total_revenue
from orders join order_items
on orders.order_id = order_items.order_id
where datediff(shipped_date, required_date) > '0';

-- Retrieve revenue made by each staff

select staffs.staff_id,
      sum(quantity * list_price) as revenue
from orders join order_items
on orders.order_id = order_items.order_id
join staffs 
on orders.staff_id = staffs.staff_id
group by staffs.staff_id
order by staffs.staff_id asc;

-- Find all products with list price greater than the average list price 

select avg(list_price)
from products;

select product_id, product_name, list_price
from products
where list_price > 1520.60
order by list_price;

-- Show the number of orders placed in each month of 2017

select month, count(order_id)
from(
select order_id, order_date,
      extract(month from order_date) as month
from orders
where order_date = 2017) as month_cte
group by month;

-- Retrieve all customers who do not have an email address

select *
from customers
where email = null
  or email = '';
 