/****** Assignment#1.1 ******/

select CustomerId, count(OrderId) as OrderCount
from [dbo].[Order]
where shippedDate IS NULL
and orderDate between '2017-01-01' and '2018-12-31'
group by CustomerId
having count(OrderId) >= 2;


/****** Assignment#1.2 ******/
--1.2.a
select *
into dbo.Product_20220504
from [dbo].[Product]
where ModelYear <> 2016;

--1.2.b
select productId,
ProductName,
BrandId,
CategoryId,
ModelYear,
ListPrice,
 CASE 
 WHEN brandId in (3,7) THEN ListPrice+(ListPrice*0.2)
 WHEN brandId not in (3,7) THEN ListPrice+(ListPrice*0.1)
 END ListPrice_raised
from dbo.Product_20220504