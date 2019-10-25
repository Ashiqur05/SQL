-- ###################################### Query 1 #####################################################
use pricehub;
select * FROM line_item limit 10;
select * from products limit 10;

select  product_quantity as line_quantity,
date as line_date,unit_price as line_price,
name_en as name,
price as product_price,
products.sku as product_sku
from line_item 
inner join products 
on products.sku=line_item.sku;

-- ###################################### Query 2 #####################################################
select  product_quantity as line_quantity,
date as line_date,
unit_price as line_price,
name_en as name,
price as product_price,
products.sku as product_sku,
price - unit_price as  price_difference
from line_item 
inner join products 
on products.sku=line_item.sku;

-- ###################################### Query 3 #####################################################
select  manual_categories,round(avg(price - unit_price),2) as  price_difference
from line_item 
inner join products 
on products.sku=line_item.sku
group by manual_categories;

-- ###################################### Query 4 #####################################################
select  brand,round(avg(price - unit_price),2) as  price_difference
from line_item 
inner join products 
on products.sku=line_item.sku
group by brand;

-- ###################################### Query 5 #####################################################
select  brand,round(avg(price - unit_price),2) as  avg_price_difference
from line_item 
inner join products 
on products.sku=line_item.sku
group by brand having avg_price_difference > 50000
order by avg_price_difference desc;

-- ###################################### Query 6 #####################################################
select * FROM orders limit 10;
select * from line_item  limit 10;
select * from products  limit 10;

select  products.sku,created_date,state,total_paid,orders.id_order
from line_item 
join products on line_item.sku = products.sku
join orders on line_item.id_order = orders.id_order;
       
-- ###################################### Query 7 #####################################################
select  products.sku,created_date,state,total_paid,orders.id_order,brand, manual_categories
from line_item 
join products on line_item.sku = products.sku
join orders on line_item.id_order = orders.id_order;
       
   ###################################### Query 8 #####################################################     
select manual_categories, count(orders.id_order) as number_of_orders, state
from line_item join products
on line_item.sku = products.sku join orders
on line_item.id_order = orders.id_order
group by manual_categories, state having state = "cancelled"
order by number_of_orders desc
limit 10 ;

select brand, count(orders.id_order) as number_of_orders, state -- is it count from only others table?
from line_item join products
on line_item.sku = products.sku join orders
on line_item.id_order = orders.id_order
group by brand, state having state = "cancelled"
order by number_of_orders desc
limit 10 ;


########################################### Query 8 ######################################################
select manual_categories,brand,count(orders.id_order),state
from line_item 
join products on line_item.sku = products.sku
join orders on line_item.id_order = orders.id_order
group by manual_categories,brand,state having state = "cancelled"
order by number_of_orders desc
limit 10 ;
########################################################################################################


