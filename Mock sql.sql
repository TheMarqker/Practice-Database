/*1. Create a query to return all orders made by users with the first name of “Marion”
Expected Output:*/
use mock_sba_db;
select o.Order_ID,u.USER_ID, o.Store_ID from orders as o
join users as u on u.USER_ID = o.USER_ID
where u.FIRST_NAME = 'Marion'

/*2. Create a query to select all users that have not made an order
Expected Output:*/
select u.USER_ID, u.LAST_NAME, u.FIRST_NAME, u.CITY 
from users as u 
left join  orders as o  on u.USER_ID  = o.USER_ID 
where o.USER_ID  is null;

/*3. Create a Query to select the names and prices of all items that have been part of 2 or 
more separate orders.
Expected Output:*/
select  i.NAME , count(distinct oi.ITEM_ID) as `uniques`, i.PRICE  
from order_items as oi 
join items as i  on oi.ITEM_ID  = i.ITEM_ID  
group by i.ITEM_ID 
having `uniques`;

/*4. Create a query to return the Order Id, Item name, Item Price, and Quantity from orders 
made at stores in the city “New York”. Order by Order Id in ascending order.
Expected Output:*/
select o.ORDER_ID, i.NAME 'NAME', i.PRICE 'Item Price', oi.QUANTITY 'Quantity' 
from orders as o 
join order_items oi on oi.ORDER_ID=o.ORDER_ID
join items as i on i.ITEM_ID=oi.ITEM_ID 
join stores as s on s.STORE_ID=o.STORE_ID  where s.CITY ="New York"
order by o.ORDER_ID;

/*5. Your boss would like you to create a query that calculates the total revenue generated 
by each item. Revenue for an item can be found as (Item Price * Total Quantity 
Ordered). Please return the first column as ‘ITEM_NAME’ and the second column as 
‘REVENUE’.
Expected Output:*/
select i.NAME as 'Item Name', SUM(oi.QUANTITY * i.PRICE) as 'Revenue' 
from order_items oi 
join items i on i.ITEM_ID = oi.ITEM_ID 
group by i.NAME 
order by `Revenue` desc;


/*6. Create a query with the following output:
a. Column 1 - Store Name
i. The name of each store
b. Column 2 - Order Quantity
i. The number of times an order has been made in this store
c. Column 3 - Sales Figure
i. If the store has been involved in more than 3 orders, mark as ‘High’
ii. If the store has been involved in less than 3 orders but more than 1 order, 
mark as ‘Medium’
iii. If the store has been involved with 1 or less orders, mark as ‘Low’
d. Should be ordered by the Order Quantity in Descending Order*/
select s.Name, COUNT(ORDER_ID) 'ORDER_QUANTITY', 
if(COUNT(ORDER_ID) > 3, 'High', if(COUNT(ORDER_ID) <= 3 and COUNT(ORDER_ID)>1, 'Medium', 'Low')) 'SALES_FIGURE'
from orders o 
join stores s on s.STORE_ID=o.STORE_ID
group by s.STORE_ID
order by COUNT(ORDER_ID) desc;
