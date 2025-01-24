USE [AdventureWorks2022]

--PARTITION BY - Exercises

/*Exercise 1
Create a query with the following columns:

“Name” from the Production.Product table, which can be alised as “ProductName”

“ListPrice” from the Production.Product table

“Name” from the Production. ProductSubcategory table, which can be alised as “ProductSubcategory”*

“Name” from the Production.ProductCategory table, which can be alised as “ProductCategory”**


*Join Production.ProductSubcategory to Production.Product on “ProductSubcategoryID”

**Join Production.ProductCategory to ProductSubcategory on “ProductCategoryID”

All the tables can be inner joined, and you do not need to apply any criteria.

*/


select 
	A.Name as [ProductName],
	B.Name as [ProductSubcategory],
	C.Name as [ProductCategory],
	ListPrice
from Production.Product A
join Production.ProductSubcategory B on B.ProductSubcategoryID=A.ProductSubcategoryID
join Production.ProductCategory C on C.ProductCategoryID=B.ProductCategoryID;

select * from Production.ProductSubcategory;
select * from Production.Product;
select * from Production.ProductCategory;


/*



Exercise 2

Enhance your query from Exercise 1 by adding a derived column called

"AvgPriceByCategory " that returns the average ListPrice for the product category in each given row.

*/

select 
	A.Name as [ProductName],
	B.Name as [ProductSubcategory],
	C.Name as [ProductCategory],
	ListPrice,
	AvgPriceByCategory = AVG(listPrice) OVER (PARTITION BY C.NAME)
from Production.Product A
join Production.ProductSubcategory B on B.ProductSubcategoryID=A.ProductSubcategoryID
join Production.ProductCategory C on C.ProductCategoryID=B.ProductCategoryID;




/*



Exercise 3


Enhance your query from Exercise 2 by adding a derived column called

"AvgPriceByCategoryAndSubcategory" that returns the average ListPrice for the product category AND subcategory in each given row.
*/


select 
	A.Name as [ProductName],
	B.Name as [ProductSubcategory],
	C.Name as [ProductCategory],
	ListPrice,
	AvgPriceByCategory = AVG(listPrice) OVER (PARTITION BY C.NAME),
	AvgPriceByCategoryAndSubcategory = AVG(ListPrice) OVER (PARTITION BY C.NAME, B.NAME)
from Production.Product A
join Production.ProductSubcategory B on B.ProductSubcategoryID=A.ProductSubcategoryID
join Production.ProductCategory C on C.ProductCategoryID=B.ProductCategoryID;


/*


Exercise 4:


Enhance your query from Exercise 3 by adding a derived column called

"ProductVsCategoryDelta" that returns the result of the following calculation:
A product's list price, MINUS the average ListPrice for that product’s category.
*/

select 
	A.Name as [ProductName],
	B.Name as [ProductSubcategory],
	C.Name as [ProductCategory],
	ListPrice,
	AvgPriceByCategory = AVG(listPrice) OVER (PARTITION BY C.NAME),
	AvgPriceByCategoryAndSubcategory = AVG(ListPrice) OVER (PARTITION BY C.NAME, B.NAME),
	ProductVsCategoryDelta =ListPrice - AVG(ListPrice) OVER (PARTITION BY C.NAME)
from Production.Product A
join Production.ProductSubcategory B on B.ProductSubcategoryID=A.ProductSubcategoryID
join Production.ProductCategory C on C.ProductCategoryID=B.ProductCategoryID;