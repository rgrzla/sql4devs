with CTE as (

select S.staffid, S.FirstName +' '+ S.LastName as FullName, CAST(S.FirstName +' '+ S.LastName as varchar(255)) as EmployeeHeirarrchy
from staff S
WHERE S.ManagerId is null

UNION ALL

select S.staffid, S.FirstName +' '+ S.LastName as FullName, EmployeeHeirarchy = CAST (C.EmployeeHeirarrchy+','+  S.FirstName +' '+ S.LastName as varchar(255))
from staff S
INNER JOIN CTE C
ON S.managerid = C.staffid

)
select * from CTE order by 1;