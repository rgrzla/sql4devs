create procedure getListofProducts_sp(
@product_name as varchar(255),
@brand_id as integer,
@catogery_id as integer,
@model_year as integer,
@page_number as integer=1,
@page_size as integer=10
)

as
begin

SET NOCOUNT ON

select A.ProductId,
	A.ProductName,
	A.BrandId,
	B.BrandName,
	A.CategoryId,
	C.CategoryName,
	A.ModelYear,
	A.ListPrice
from product A
left join brand B on A.BrandId = B.BrandId
left join category C on A.CategoryId = C.CategoryId
where (@product_name IS NULL OR A.ProductName = @product_name)
	and (@brand_id IS NULL OR A.BrandId = @brand_id)
	and (@catogery_id IS NULL OR A.CategoryId = @catogery_id)
	and (@model_year IS NULL OR A.ModelYear = @model_year)
order by 7, 8 desc, 2
OFFSET (@page_number-1)*@page_size ROWS
FETCH NEXT @page_size ROWS ONLY

end;