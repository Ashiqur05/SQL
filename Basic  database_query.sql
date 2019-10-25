use pricehub ;
 ###########################################line_items#########################################################
-- Select the entire line_item table
SELECT * fROM line_item;

-- Select only the first 10 rows from the line_item table
SELECT * FROM line_item limit 10;

-- Select only the columns sku, unit_price and date from the line_item table (and only the first 10 rows)
SELECT sku,unit_price,"date" FROM line_item limit 10;
  
-- Count the total number of rows of the line_item table
SELECT count(*) FROM line_item;
  
-- Count the total number of unique "sku" from the line_item table
SELECT DISTINCT sku FROM line_item;
  
-- Generate a list with the average price of each sku
SELECT sku,AVG(unit_price)  FROM line_item group by sku;
  
--  now name the column of the previous query with the average price "avg_price", and sort the list that you by that column (bigger to smaller price)
SELECT sku,AVG(unit_price) as avg_price FROM line_item group by sku ORDER BY avg_price DESC;
  
-- Which products were bought in largest quantities?
SELECT id,max(product_quantity) as max_quantity FROM line_item group by id order by max_quantity desc;
 
-- select the 100 lines with the biggest "product quantity"
SELECT id,max(product_quantity) as max_quantity FROM line_item group by id order by max_quantity desc limit 100;
  
-- select their stock keeping unit" and product quantity
SELECT sku,max(product_quantity) as max_quantity FROM line_item group by sku order by max_quantity desc limit 100;
  
###############################################orders#########################################################
SELECT * from orders limit 10;
-- How many orders were placed in total?
SELECT * from orders order by total_paid DESC;
SELECT count(*) as number_of_order FROM orders;

-- Make a count of orders by their state
SELECT count(id_order)as order_state,state  FROM orders group by state;

-- Count the number of orders of your previous select query (i.e. How many orders were placed in January of 2017?)
SELECT count(id_order) as number_of_order FROM orders WHERE created_date like "%2017-01-%";

-- How many orders were cancelled on January 4th 2017?
SELECT count(state) from orders where created_date like "2017-04-%" and state = "Cancelled"; 
SELECT id_order,state from orders where created_date like "2017-04-%" and state = "Cancelled";

-- How many orders have been placed each month of the year?
SELECT extract(month from created_date) as monthly,count(id_order) as num_of_order FROM orders group by monthly;

-- What is the total amount paid in all the orders?
SELECT sum(total_paid) from orders;

-- What is the average amount paid per order?
SELECT id_order,avg(total_paid) as avg_paid from orders group by id_order ORDER BY avg_paid DESC;

-- Give a result to the previous question with only 2 decimals
SELECT id_order,truncate(avg(total_paid) ,2) as avg_two_deci from orders group by id_order ORDER BY avg(total_paid) DESC;

-- What is the date of the newest order? And the oldest?
SELECT id_order,created_date from orders order by id_order asc;
SELECT id_order,created_date from orders order by id_order desc;

-- What is the day with the highest amount of completed orders (and how many completed orders were placed that day)?
SELECT created_date,state,count(id_order) as counts from orders where state='Completed'group by created_date order by counts desc;
-- What is the day with the highest amount paid (and how much was paid that day)?
SELECT date(created_date),max(total_paid) as total_amount from orders group by created_date order by total_amount desc;


 ##############################################products##########################################################

SELECT * from products limit 10;
-- How many products are there?
SELECT count(*) as number_of_products FROM products;

-- How many brands?
SELECT  count(distinct brand) as brand from products;

-- How many categories?
SELECT  count(distinct manual_categories) as categories from products;

-- How many products per brand & products per category?
SELECT brand,count(productid) as count from products group by brand order by count desc;
SELECT manual_categories,count(productid) as count from products group by manual_categories order by count desc;

-- What's the average price per brand and the average price per category?
SELECT brand,truncate(avg(price),2)as avg_price from products group by brand order by avg_price desc;
SELECT manual_categories,truncate(avg(price),2)as avg_price from products group by manual_categories order by avg_price desc;

-- What's the name and description of the most expensive product per brand and per category
select name_en, short_desc_en, products.manual_categories, price
from (select manual_categories, max(price) as most_expensive 
from products group by manual_categories) as store
inner join products 
on products.price = store.most_expensive
order by store.most_expensive desc;