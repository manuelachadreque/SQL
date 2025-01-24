/*

LEAD and LAG - Exercises
Exercise 1


Create a query with the following columns:

“PurchaseOrderID” from the Purchasing.PurchaseOrderHeader table

“OrderDate” from the Purchasing.PurchaseOrderHeader table

“TotalDue” from the Purchasing.PurchaseOrderHeader table

“Name” from the Purchasing.Vendor table, which can be aliased as “VendorName”*

*Join Purchasing.Vendor to Purchasing.PurchaseOrderHeader on BusinessEntityID = VendorID

Apply the following criteria to the query:

Order must have taken place on or after 2013

TotalDue must be greater than $500
*/


select PurchaseOrderID
		,OrderDate
		,TotalDue
		,V.Name

from Purchasing.PurchaseOrderHeader P 
left join Purchasing.Vendor  V ON p.VendorID=v.BusinessEntityID
where YEAR(OrderDate) >=2013 and TotalDue>500;

/*
Exercise 2


Modify your query from Exercise 1 by adding a derived column called

"PrevOrderFromVendorAmt", that returns the “previous” TotalDue value (relative to the current row) within the group of all orders with the same vendor ID. We are defining “previous” based on order date.
*/


select PurchaseOrderID
		,OrderDate
		,TotalDue
		,V.Name
		,PrevOrderFromVendorAmt = LAG(TotalDue) OVER(PARTITION BY V.Name order by OrderDate asc)
from Purchasing.PurchaseOrderHeader P 
left join Purchasing.Vendor  V ON p.VendorID=v.BusinessEntityID
where YEAR(OrderDate) >=2013 and TotalDue>500;

/*
Exercise 3


Modify your query from Exercise 2 by adding a derived column called

"NextOrderByEmployeeVendor", that returns the “next” vendor name (the “name” field from Purchasing.Vendor) within the group of all orders 
that have the same EmployeeID value in Purchasing.PurchaseOrderHeader. Similar to the last exercise, we are defining “next” based on order date.
*/



select PurchaseOrderID
		,OrderDate
		,TotalDue
		,V.Name
		,PrevOrderFromVendorAmt = LAG(TotalDue) OVER(PARTITION BY V.Name order by OrderDate asc)
		,NextOrderByEmployeeVendor = LEAD(V.Name) OVER (PARTITION BY EmployeeID ORDER BY OrderDate asc)
from Purchasing.PurchaseOrderHeader P 
left join Purchasing.Vendor  V ON P.VendorID=V.BusinessEntityID
where YEAR(P.OrderDate) >=2013 and TotalDue>500;


/*
Exercise 4


Modify your query from Exercise 3 by adding a derived column called "Next2OrderByEmployeeVendor" that returns, 
within the group of all orders that have the same EmployeeID, 
the vendor name offset TWO orders into the “future” relative to the order in the current row.
The code should be very similar to Exercise 3, but with an extra argument passed to the Window Function used.

Resources for this lecture


*/



select PurchaseOrderID
		,OrderDate
		,TotalDue
		,V.Name
		,PrevOrderFromVendorAmt = LAG(TotalDue) OVER(PARTITION BY V.Name order by OrderDate asc)
		,NextOrderByEmployeeVendor = LEAD(V.Name) OVER (PARTITION BY EmployeeID ORDER BY OrderDate asc)
		,Next2OrderByEmployeeVendor = LEAD(V.Name,2) OVER (PARTITION BY EmployeeID ORDER BY OrderDate asc)
from Purchasing.PurchaseOrderHeader P 
left join Purchasing.Vendor  V ON P.VendorID=V.BusinessEntityID
where YEAR(P.OrderDate) >=2013 and TotalDue>500;
