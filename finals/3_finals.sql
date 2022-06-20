BEGIN
	BEGIN
		UPDATE dbo.Product_20220504
		SET ListPrice = (ListPrice * 1.2)
		WHERE CategoryId in (SELECT c.CategoryId FROM dbo.Category c 
			WHERE c.CategoryName in ('Children Bicycles','Cyclocross Bicycles','Road Bikes'));
	END;

	BEGIN
		UPDATE dbo.Product_20220504
		SET ListPrice = (ListPrice * 1.7)
		WHERE CategoryId in (SELECT c.CategoryId FROM dbo.Category c 
			WHERE c.CategoryName in ('Comfort Bicycles','Cruisers Bicycles','Electric Bikes'));
	END;

	BEGIN
		UPDATE dbo.Product_20220504
		SET ListPrice = (ListPrice * 1.4)
		WHERE CategoryId = (SELECT c.CategoryId FROM dbo.Category c 
			WHERE c.CategoryName ='Mountain Bikes');
	END;
END;