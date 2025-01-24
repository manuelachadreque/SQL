/*
FIRST_VALUE - Exercises
Exercise 1
Create a query that returns all records - and the following columns - from the HumanResources.Employee table:
a. BusinessEntityID (alias this as “EmployeeID”)
b. JobTitle
c. HireDate
d. VacationHours
To make the effect of subsequent steps clearer, also sort the query output by "JobTitle" and HireDate, both in ascending order.
Now add a derived column called “FirstHireVacationHours” that displays – for a given job title – 
the amount of vacation hours possessed by the first employee hired who has that same job title. 
For example, if 5 employees have the title “Data Guru”, and the one of those 5 with the oldest hire date has 99 vacation hours,
“FirstHireVacationHours” should display “99” for all 5 of those employees’ corresponding records in the query.

*/


select a.BusinessEntityID
		, a.JobTitle
		, a.HireDate
		,a.VacationHours
		,FirstHireVacationHours = FIRST_VALUE(A.VacationHours) OVER(PARTITION BY a.JobTitle ORDER BY a.hireDate)
from
HumanResources.Employee a 
order by a.JobTitle, a.HireDate asc;



/*

Exercise 2
Create a query with the following columns:
a. “ProductID” from the Production.Product table
b. “Name” from the Production.Product table (alias this as “ProductName”)
c. “ListPrice” from the Production.ProductListPriceHistory table
d. “ModifiedDate” from the Production.ProductListPriceHistory

You can join the Production.Product and Production.ProductListPriceHistory tables on "ProductID".
Note that the Production.ProductListPriceHistory table contains a distinct record for every different price a product has been listed at. 
This means that a single product ID may have several records in this table – one for every list price it has had.
Also note that the “ModifiedDate” field in this table displays the effective date of each of these prices. 
So if there are 3 rows in the table for product ID 12345, 
the row with the oldest modified date also contains the first price in the associated product’s history. 
Conversely, the row with the most recent modified date also contains the current price of the product.
To make the effect of subsequent steps clearer, also sort the query output by ProductID and ModifiedDate, both in ascending order.
Now add a derived column called “HighestPrice” that displays – for a given product – the highest price that product has been listed at.
So even if there are 4 records for a given product, this column should only display the all-time highest list price for that product in each of those 4 rows.
Similarly, create another derived column called “LowestCost” that displays the all-time lowest price for a given product.
Finally, create a third derived column called “PriceRange” that reflects, for a given product, the difference between its highest and lowest ever list prices.
*/

select a.ProductID
		, a.Name
		, b.ListPrice
		, b.ModifiedDate
		, HighestPrice = FIRST_VALUE(b.ListPrice) OVER (PARTITION BY a.Name ORDER BY b.ModifiedDate DESC)
		, LowestCost = FIRST_VALUE(b.ListPrice) OVER (PARTITION BY a.Name ORDER BY b.ModifiedDate ASC)
		,  PriceRange = FIRST_VALUE(b.ListPrice) OVER (PARTITION BY a.Name ORDER BY b.ModifiedDate DESC) - 
						FIRST_VALUE(b.ListPrice) OVER (PARTITION BY a.Name ORDER BY b.ModifiedDate ASC)

from Production.Product a 
join Production.ProductListPriceHistory b on a.ProductID=b.ProductID
order by a.ProductID, b.ModifiedDate asc

