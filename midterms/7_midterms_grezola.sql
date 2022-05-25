select *
from (select year(b.orderdate) [Year], 
       	datename(month, b.orderdate) [month], 
       	sum(a.listprice) [list price]
      	from [orderitem] a
	inner join [order] b on a.orderid = b.orderid
      	group by year(b.orderdate), 
      	datename(month, b.orderdate)
) as montlyorderdata

pivot( sum([list price])   
    for month in (
	[January],[February],[March],
	[April],[May],[June],[July],[August],
	[September],[October],[November],[December])
) as mnamepivot;