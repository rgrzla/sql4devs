--4
with PRODUCT_PER_BRAND_CTE as (
select B.BrandName, A.productid, A.productName, A.ListPrice,
	rank() OVER ( 
			PARTITION BY B.BrandName
ORDER BY A.ListPrice desc
	) listPriceRank
from product A
inner join Brand B on A.BrandId = B.BrandId
) 
select  BrandName, productid, productName, ListPrice 
from PRODUCT_PER_BRAND_CTE
where listPriceRank <= 5
order by 4 desc, 3 ;
