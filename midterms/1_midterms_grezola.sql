--1
select storeid, storeName from store where storeid not in (select distinct storeid from [order]);
