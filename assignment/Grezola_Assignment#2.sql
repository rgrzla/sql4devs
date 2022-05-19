Assignment #2:

1.)
Display the total number of items sold per PRODUCT from orders in the database with the following requirements:​
Only count orders from TX state​
Total items sold per product should be greater than 10​
Sort by total units sold from highest to lowest​
Return columns should include: ProductName, TotalQuantity
_____________________________________________________________________
with ORDER_CUSTOMER_TX_CTE as
(
select A.orderId, A.customerId, B.Email, B.state
from [Order] A
left join [Customer] B on a.customerId = b.customerId
where b.state='TX'
)
select A.ProductId, B.ProductName, sum(A.Quantity) as 'Total Quantity'
from [OrderItem] A
left join [Product] B on A.ProductId = B.ProductId
right join ORDER_CUSTOMER_TX_CTE C on A.OrderId = C.OrderId
group by A.ProductId,B.ProductName
having sum(A.Quantity) > 10
order by 3 desc;
_____________________________________________________________________

2.)
Display the total number of items sold per CATEGORY from orders in the database with the following requirements:​
For categories with "Bikes" on the name, make it Bicycle instead (ex. "Road Bikes" will be "Road Bicycles" instead)​
Sort by total units sold from highest to lowest​
Return columns should include: CategoryName, TotalQuantity
_____________________________________________________________________
with CATEGORY_CTE as
(
select CategoryId, REPLACE(CategoryName,'Bikes','Bicycles') as CategoryName from Category
)
select C.CategoryId, C.CategoryName, sum(A.Quantity) as 'Total Quantity'
from [OrderItem] A
left join [Product] B on A.ProductId = B.ProductId
left join CATEGORY_CTE C on B.CategoryId = C.CategoryId
group by C.CategoryId, C.CategoryName
order by 3 desc;
_____________________________________________________________________

3.)
Merge the results of items #1 and #2:
Sort by total units sold from highest to lowest​
_____________________________________________________________________
with ORDER_CUSTOMER_TX_CTE as
(
select A.orderId, A.customerId, B.Email, B.state
from [Order] A
left join [Customer] B on a.customerId = b.customerId
where b.state='TX'
),
CATEGORY_CTE as
(
select CategoryId, REPLACE(CategoryName,'Bikes','Bicycles') as CategoryName 
from Category
)
select A.ProductId as 'ID', B.ProductName as 'Name', sum(A.Quantity) as 'Total Quantity'
from [OrderItem] A
left join [Product] B on A.ProductId = B.ProductId
right join ORDER_CUSTOMER_TX_CTE C on A.OrderId = C.OrderId
group by A.ProductId,B.ProductName
having sum(A.Quantity) > 10

UNION ALL

select C.CategoryId as 'ID', C.CategoryName as 'Name', sum(A.Quantity) as 'Total Quantity'
from [OrderItem] A
left join [Product] B on A.ProductId = B.ProductId
left join CATEGORY_CTE C on B.CategoryId = C.CategoryId
group by C.CategoryId, C.CategoryName

order by 3 desc;
_____________________________________________________________________


4.)
For all orders in the database, retrieve the top selling product per month year with the following requirements:
Return columns should include: OrderYear, OrderMonth, ProductName, TotalQuantity
Sort the result by Year and Month in ascending order
In cases where there are more than 1 top-selling product in a month, we should display ALL products in TOP 1 position
_____________________________________________________________________
with ORDER_DATE_CTE as (
select year(orderDate) as 'OrderYear',
DATENAME(month, orderDate) as 'OrderMonth',
month(orderDate) as 'MonthNumber',
OrderId
from [Order])

select * FROM (
	select B.OrderYear, B.OrderMonth,C.ProductName, 
sum(A.Quantity) as 'TotalQuantity',B.MonthNumber,
	rank() OVER ( 
			PARTITION BY B.OrderYear, B.OrderMonth, B.MonthNumber 
ORDER BY sum(A.Quantity) desc 
	) TopSellingProductRank
	from OrderItem A
	left join ORDER_DATE_CTE B ON A.OrderId = B.OrderId
	left join Product C ON A.ProductId = C.ProductId
	group by B.OrderYear, B.OrderMonth, C.ProductName, B.MonthNumber
) T
where T.TopSellingProductRank =1
order by 1,5
________________________________________________________________________
