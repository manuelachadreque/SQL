/*RANK and DENSE_RANK - Exercises
Exercise 1
Using your solution query to Exercise 4 from the ROW_NUMBER exercises as a staring point, add a derived column called
“Category Price Rank With Rank” that uses the RANK function to rank all products by ListPrice – within each category - in descending order. Observe the differences between the “Category Price Rank” and “Category Price Rank With Rank” fields.
*/


select 
	A.Name as [ProductName],
	B.Name as [ProductSubcategory],
	C.Name as [ProductCategory],
	ListPrice,
	AvgPriceByCategory = AVG(listPrice) OVER (PARTITION BY C.NAME),
	AvgPriceByCategoryAndSubcategory = AVG(ListPrice) OVER (PARTITION BY C.NAME, B.NAME),
	ProductVsCategoryDelta =ListPrice - AVG(ListPrice) OVER (PARTITION BY C.NAME),
	[Price Rank] = ROW_NUMBER() OVER(ORDER BY ListPrice DESC),
	[Category Price Rank] = ROW_NUMBER() OVER (PARTITION BY C.NAME ORDER BY ListPrice desc),
	[Top 5 Price In Category]=
	CASE 
		WHEN ROW_NUMBER() OVER (PARTITION BY C.NAME ORDER BY ListPrice desc)<=5 THEN 'Yes'
		ELSE 'No'
	END,
	[Category Price Rank With Rank] = RANK() OVER(PARTITION BY C.NAME ORDER BY ListPrice desc) 
from Production.Product A
join Production.ProductSubcategory B on B.ProductSubcategoryID=A.ProductSubcategoryID
join Production.ProductCategory C on C.ProductCategoryID=B.ProductCategoryID;



/*
Exercise 2
Modify your query from Exercise 2 by adding a derived column called "Category Price Rank With Dense Rank" that that uses the DENSE_RANK function to rank all products by ListPrice – within each category - in descending order. Observe the differences among the “Category Price Rank”, “Category Price Rank With Rank”, and “Category Price Rank With Dense Rank” fields.
*/


select 
	A.Name as [ProductName],
	B.Name as [ProductSubcategory],
	C.Name as [ProductCategory],
	ListPrice,
	AvgPriceByCategory = AVG(listPrice) OVER (PARTITION BY C.NAME),
	AvgPriceByCategoryAndSubcategory = AVG(ListPrice) OVER (PARTITION BY C.NAME, B.NAME),
	ProductVsCategoryDelta =ListPrice - AVG(ListPrice) OVER (PARTITION BY C.NAME),
	[Price Rank] = ROW_NUMBER() OVER(ORDER BY ListPrice DESC),
	[Category Price Rank] = ROW_NUMBER() OVER (PARTITION BY C.NAME ORDER BY ListPrice desc),
	[Top 5 Price In Category]=
	CASE 
		WHEN ROW_NUMBER() OVER (PARTITION BY C.NAME ORDER BY ListPrice desc)<=5 THEN 'Yes'
		ELSE 'No'
	END,
	[Category Price Rank With Rank] = RANK() OVER(PARTITION BY C.NAME ORDER BY ListPrice desc),
	[Category Price Rank With Dense Rank] = DENSE_RANK () OVER(PARTITION BY C.NAME ORDER BY ListPrice desc)
from Production.Product A
join Production.ProductSubcategory B on B.ProductSubcategoryID=A.ProductSubcategoryID
join Production.ProductCategory C on C.ProductCategoryID=B.ProductCategoryID;


/*
Exercise 3
Examine the code you wrote to define the “Top 5 Price In Category” field back in the ROW_NUMBER exercises. Now that you understand the differences among ROW_NUMBER, RANK, and DENSE_RANK, consider which of these functions would be most appropriate to return a true top 5 products by price, assuming we want to see the top 5 distinct prices AND we want “ties” (by price) to all share the same rank.
Resources for this lecture
*/


select 
	A.Name as [ProductName],
	B.Name as [ProductSubcategory],
	C.Name as [ProductCategory],
	ListPrice,
	AvgPriceByCategory = AVG(listPrice) OVER (PARTITION BY C.NAME),
	AvgPriceByCategoryAndSubcategory = AVG(ListPrice) OVER (PARTITION BY C.NAME, B.NAME),
	ProductVsCategoryDelta =ListPrice - AVG(ListPrice) OVER (PARTITION BY C.NAME),
	[Price Rank] = ROW_NUMBER() OVER(ORDER BY ListPrice DESC),
	[Category Price Rank] = ROW_NUMBER() OVER (PARTITION BY C.NAME ORDER BY ListPrice desc),
	[Top 5 Price In Category]=
	CASE 
		WHEN DENSE_RANK() OVER (PARTITION BY C.NAME ORDER BY ListPrice desc)<=5 THEN 'Yes'
		ELSE 'No'
	END,
	[Category Price Rank With Rank] = RANK() OVER(PARTITION BY C.NAME ORDER BY ListPrice desc),
	[Category Price Rank With Dense Rank] = DENSE_RANK () OVER(PARTITION BY C.NAME ORDER BY ListPrice desc)
from Production.Product A
join Production.ProductSubcategory B on B.ProductSubcategoryID=A.ProductSubcategoryID
join Production.ProductCategory C on C.ProductCategoryID=B.ProductCategoryID;
