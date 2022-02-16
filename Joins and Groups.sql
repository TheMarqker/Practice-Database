/*1. Write a query to display each customer’s name (as “Customer Name”) alongside the name of the employee 
who is responsible for that customer’s orders. The employee name should be in a single “Sales Rep” column 
formatted as “lastName, firstName”. The output should be sorted alphabetically by customer name.*/
use classicmodels;
SELECT 
		c.customerName as 'Customer Name',
Concat
		(e.lastName, ', ', e.firstName) as 'Sales Rep'
from 
		customers c
join 
		employees e on c.salesRepEmployeeNumber = e.employeeNumber 
order by 
		c.customerName asc;

/*2. Determine which products are most popular with our customers. 
For each product, list the total quantity ordered along with the total sale generated 
(total quantity ordered * priceEach) for that product. The column headers should be “Product Name”, 
“Total # Ordered” and “Total Sale”. List the products by Total Sale descending.*/
select 	
		p.productName as 'Product Name',
		sum(o.quantityOrdered) as 'Total # Ordered',
		sum(o.quantityOrdered * o.priceEach) as 'Total Sale'
from 
		products as p
join 
		orderdetails as o on p.productCode = o.productCode  
group by 
		p.productName  
order by 
		`Total Sale` desc;
 

/*3. Write a query which lists order status and the # of orders with that status. 
Column headers should be “Order Status” and “# Orders”. Sort alphabetically by status.*/
select 	
		distinct status as 'Order Status', count(*) as '# Orders'
from 
		 orders 
group by 
		 status 
order by status asc;
 

/*4. Write a query to list, for each product line, the total # of products sold from that product line. 
The first column should be “Product Line” and the second should be “# Sold”. Order by the second column descending.*/
select 
		productLine as 'Product Line',
		sum(quantityOrdered) as '# Sold'
from 
		(select p.productCode, p.productName, o.quantityOrdered, p.productLine from products p
		right join orderdetails o on p.productCode = o.productCode) as x 
group by 
		productLine
order by 2 desc;

/*5. For each employee who represents customers, output the total # of orders that employee’s customers have placed 
alongside the total sale amount of those orders. The employee name should be output as a single column named 
“Sales Rep” formatted as “lastName, firstName”. The second column should be titled “# Orders” and the third should be 
“Total Sales”. Sort the output by Total Sales descending. Only (and all) employees with the job title ‘Sales Rep’ 
should be included in the output, and if the employee made no sales the Total Sales should display as “0.00”.*/
 select 
 		concat(e.lastName, ", ", e.firstName) as "Sales Rep",
		sum(d.quantityOrdered) as "# Orders", 
 if	
 		(sum(d.quantityOrdered) is null, 0.00, sum(d.quantityOrdered * d.priceEach)) as "Total Sales"
 from employees as e
 LEFT JOIN customers as c on e.employeeNumber = c.salesRepEmployeeNumber
 LEFT JOIN orders as o on c.customerNumber = o.customerNumber
 LEFT JOIN orderdetails as d on o.orderNumber = d.orderNumber
 WHERE e.jobTitle = "Sales Rep"
 group by e.employeeNumber
 order by sum(d.quantityOrdered * d.priceEach) desc;

/*6. Your product team is requesting data to help them create a bar-chart of monthly sales since the company’s inception. 
Write a query to output the month (January, February, etc.), 4-digit year, and total sales for that month. 
The first column should be labeled ‘Month’, the second ‘Year’, and the third should be ‘Payments Received’. 
Values in the third column should be formatted as numbers with two decimals – for example: 694,292.68.*/
select 
		date_format(p.paymentDate, '%M') as 'Month',
		date_format(p.paymentDate, '%Y') as 'Year',
		format(sum(p.amount), 2) as 'Payments Recieved'
from 
		payments p 
group by 
		`Year`, cast(date_format(p.paymentDate, '%c') as integer);


