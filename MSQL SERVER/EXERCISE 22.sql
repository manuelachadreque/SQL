/*
Views - Exercises
Exercise 1


Create a view named vw_Top10MonthOverMonth in your AdventureWorks database, based on the query below. Assign the view to the Sales schema.

HINT: You will need to make a slight tweak to the query code before it can be successfully converted to a view.



 WITH Sales AS
(
SELECT
OrderDate
,OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1)
,TotalDue
,OrderRank = ROW_NUMBER() OVER(PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue DESC)
FROM AdventureWorks2019.Sales.SalesOrderHeader
)
 
,Top10Sales AS
(
SELECT
OrderMonth,
Top10Total = SUM(TotalDue)
FROM Sales
WHERE OrderRank <= 10
GROUP BY OrderMonth
)
 
 
SELECT
A.OrderMonth,
A.Top10Total,
PrevTop10Total = B.Top10Total
 
FROM Top10Sales A
LEFT JOIN Top10Sales B
ON A.OrderMonth = DATEADD(MONTH,1,B.OrderMonth)
 
ORDER BY 1
*/


/*
Exercise 2


Try converting the below query to a view.



What happens? Why? (You may need to do a little Google-ing/Bing-ing to find out.)



SELECT
OrderDate
,OrderMonth = DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1)
,TotalDue
,OrderRank = ROW_NUMBER() OVER(PARTITION BY DATEFROMPARTS(YEAR(OrderDate),MONTH(OrderDate),1) ORDER BY TotalDue DESC)
 
INTO #Sales
 
FROM AdventureWorks2019.Sales.SalesOrderHeader
 
 
SELECT
OrderMonth,
Top10Total = SUM(TotalDue)
 
INTO #Top10Sales
 
FROM #Sales
 
WHERE OrderRank <= 10
 
GROUP BY OrderMonth
 
 
 
SELECT
A.OrderMonth,
A.Top10Total,
PrevTop10Total = B.Top10Total
 
FROM #Top10Sales A
LEFT JOIN #Top10Sales B
ON A.OrderMonth = DATEADD(MONTH,1,B.OrderMonth)

*/