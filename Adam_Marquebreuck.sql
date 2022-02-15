use banking;
/* 1. For each product, show the product name "Product" and the product type name "Type". */
select name as 'Product', product_type_cd as 'Type' from product;

/* 2. For each branch, list the branch name and city, plus the last name and title of each employee who works in that branch. */
select branch.name as 'Name', branch.city as 'City', employee.last_name as 'LastName', employee.title as 'Title' from branch
join employee on assigned_branch_id;  


/*3. Show a list of each unique employee title.*/
select UNIQUE title as 'Title' from employee;

 /* 4. Show the last name and title of each employee, along with the last name and title of that employee's boss. */
select e.LAST_NAME as 'Employee Name', e.TITLE 'Employee Title', b.LAST_NAME as 'BossName', b.TITLE as 'BossTitle'
from employee e
left join employee as b  on b.EMP_ID = e.SUPERIOR_EMP_ID;

 /* 5. For each account, show the name of the account's product, the available balance, and the customer's last name. */
select p.NAME  as 'Product Name', a.AVAIL_BALANCE as 'Available Balance', i.LAST_NAME as 'Customer LAST Name' 
from account a 
join product p on a.PRODUCT_CD = p.PRODUCT_CD 
join individual i on a.CUST_ID  = i.CUST_ID ;

 /* 6. List all account transaction details for individual customers whose last name starts with 'T'. */
select at2.*, a.AVAIL_BALANCE as 'Balance', i.LAST_NAME as 'Last Name' 
from account a 
join acc_transaction at2 on a.ACCOUNT_ID = at2.ACCOUNT_ID 
join individual i on a.CUST_ID = i.CUST_ID 
where i.LAST_NAME like 'T%';