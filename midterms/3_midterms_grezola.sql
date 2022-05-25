--3
select C.StoreName,YEAR(A.OrderDate), count(A.orderID) as 'OrderCount' 
from [order] A
inner join Store C on A.StoreId = C.StoreId
group by C.StoreName, YEAR(A.OrderDate)
order by 1,2 desc;
