--A. Create a table called ‘Ranking’ with two columns – Id (primary key, identity), and Description.
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Ranking](
	[RankingId] [int] IDENTITY(1,1) NOT NULL,
	[Description] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RankingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

--B. Populate table Ranking table
SET IDENTITY_INSERT [dbo].[Ranking] ON 
GO
INSERT [dbo].[Ranking] ([RankingId], [Description]) VALUES (1, N'Inactive')
GO
INSERT [dbo].[Ranking] ([RankingId], [Description]) VALUES (2, N'Bronze')
GO
INSERT [dbo].[Ranking] ([RankingId], [Description]) VALUES (3, N'Silver')
GO
INSERT [dbo].[Ranking] ([RankingId], [Description]) VALUES (4, N'Gold')
GO
INSERT [dbo].[Ranking] ([RankingId], [Description]) VALUES (5, N'Platinum')
GO
SET IDENTITY_INSERT [dbo].[Ranking] OFF
GO

--C. Add a column to Customer table called RankingId and make it a foreign key to Ranking.Id
ALTER TABLE [dbo].[Customer] ADD RankingId int;
GO
ALTER TABLE [dbo].[Customer]  WITH CHECK ADD FOREIGN KEY([RankingId])
REFERENCES [dbo].[Ranking] ([RankingId])
ON UPDATE CASCADE
ON DELETE CASCADE
GO


--D. Create a stored procedure uspRankCustomers that will populate Customer.RankingId

CREATE PROCEDURE uspRankCustomers
AS
BEGIN
SET NOCOUNT ON;

--Using CTE, get the total order amount for customers
WITH CUSTOMER_TOTAL_ORDER_AMOUNT_CTE as (
select A.CustomerId, sum((B.Quantity * B.ListPrice) / (1 + B.Discount)) as Total
from [dbo].[Order] A
left join OrderItem B on A.OrderId = B.OrderId
group by A.CustomerId

)

--Update Customer.RankingId based on CTE.Total
UPDATE A 
SET A.RankingId  = 
CASE 
	WHEN CTE.Total = 0 THEN 1
	WHEN CTE.Total < 1000 THEN 2
	WHEN CTE.Total < 2000 THEN 3
	WHEN CTE.Total < 3000 THEN 4
	WHEN CTE.Total >= 3000 THEN 5
END
FROM Customer A 
INNER JOIN CUSTOMER_TOTAL_ORDER_AMOUNT_CTE CTE on A.CustomerId = CTE.CustomerId
;
END
GO

--E. Create a view vwCustomerOrders that will display

CREATE VIEW vwCustomerOrders AS

WITH CUSTOMER_TOTAL_ORDER_AMOUNT_CTE as (
select A.CustomerId, sum((B.Quantity * B.ListPrice) / (1 + B.Discount)) as Total
from [dbo].[Order] A
left join OrderItem B on A.OrderId = B.OrderId
group by A.CustomerId
)

select A.CustomerId, A.FirstName, A.LastName, CTE.Total, A.RankingId 
FROM Customer A 
INNER JOIN CUSTOMER_TOTAL_ORDER_AMOUNT_CTE CTE on A.CustomerId = CTE.CustomerId;

