create procedure createnewbrandandmoveproducts_sp(
@new_brand_name as varchar(255),
@old_brand_id as integer)

as
begin
	begin try  
        begin transaction;
		--create new brand
		insert into brand (brandname) values(@new_brand_name);
		
		--get the created brand id and assign to variable
		declare @new_brand_id  int
		select @new_brand_id  = brandid from dbo.brand where brandname = @new_brand_name

		--update the brand id to new value
		update  product set brandid = @new_brand_id where brandid = @old_brand_id

		--delete old brand
		delete from brand where brandid = @old_brand_id
		
		commit transaction;   
	end try  

    begin catch
        begin
            rollback transaction;  
        end
    end catch
end