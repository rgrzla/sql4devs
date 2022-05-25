--2
select A.Productid, B.ProductName,E.BrandName,F.CategoryName, A.Quantity  
from stock A
inner join Store C on A.StoreId = C.StoreId
inner join Product B on A.ProductId = B.ProductId
inner join brand E on B.brandId = E.brandId
inner join category F on B.CategoryId = F.CategoryId
where C.StoreName = 'Baldwin Bikes'
and B.ModelYear in (2017, 2018)
order by 5 desc,2,3,4;