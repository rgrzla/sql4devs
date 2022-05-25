DECLARE @productid int ,
		@brandname varchar(max),
		@productname varchar(max),
		@listprice numeric(10,2);

DECLARE PRODUCT_PER_BRAND_CURSOR CURSOR FOR
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

OPEN PRODUCT_PER_BRAND_CURSOR

FETCH NEXT FROM PRODUCT_PER_BRAND_CURSOR
INTO @brandname, @productid, @productname,@listprice


WHILE @@FETCH_STATUS = 0
BEGIN
    print CAST(@brandname as varchar(20)) +' '+
	CAST(@productid as varchar(10)) +' '+
	CAST(@productname as varchar(10)) +' '+
	CAST(@listprice as varchar(10))


    FETCH NEXT FROM PRODUCT_PER_BRAND_CURSOR
INTO @brandname, @productid, @productname,@listprice

END
CLOSE PRODUCT_PER_BRAND_CURSOR;
DEALLOCATE PRODUCT_PER_BRAND_CURSOR;