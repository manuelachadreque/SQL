
/*Create a query with the following columns:

FirstName and LastName, from the Person.Person table**

JobTitle, from the HumanResources.Employee table**

Rate, from the HumanResources.EmployeePayHistory table**

A derived column called "AverageRate" that returns the average of all values in the "Rate" column, in each row
*/
USE [AdventureWorks2022]
GO

SELECT [PersonType]
      ,[NameStyle]
      ,[Title]
      ,[FirstName]
      ,[MiddleName]
      ,[LastName]
	  , [AverageRate]=AVG(RATE) OVER()
	  ,Rate
  FROM [Person].[Person] P
  left join [HumanResources].[Employee] E on P.BusinessEntityID=E.BusinessEntityID
  left Join HumanResources.EmployeePayHistory H on P.BusinessEntityID=H.BusinessEntityID

/*Exercise 2


Enhance your query from Exercise 1 by adding a derived column called

"MaximumRate" that returns the largest of all values in the "Rate" column, in each row.

*/

SELECT [PersonType]
      ,[NameStyle]
      ,[Title]
      ,[FirstName]
      ,[MiddleName]
      ,[LastName]
	  , [AverageRate]=AVG(RATE) OVER()
	  ,[MaximumRate] =MAX(RATE) OVER()
	  ,Rate
  FROM [Person].[Person] P
  left join [HumanResources].[Employee] E on P.BusinessEntityID=E.BusinessEntityID
  left Join HumanResources.EmployeePayHistory H on P.BusinessEntityID=H.BusinessEntityID



  /*Enhance your query from Exercise 2 by adding a derived column called
"DiffFromAvgRate" that returns the result of the following calculation:
An employees's pay rate, MINUS the average of all values in the "Rate" column.

*/


SELECT [PersonType]
      ,[NameStyle]
      ,[Title]
      ,[FirstName]
      ,[MiddleName]
      ,[LastName]
	  , [AverageRate]=AVG(RATE) OVER()
	  ,[MaximumRate] =MAX(RATE) OVER()
	  ,[DiffFromAvgRate] = RATE -AVG(RATE) OVER ()
	  ,Rate
  FROM [Person].[Person] P
  left join [HumanResources].[Employee] E on P.BusinessEntityID=E.BusinessEntityID
  left Join HumanResources.EmployeePayHistory H on P.BusinessEntityID=H.BusinessEntityID


  /*

  Exercise 4
Enhance your query from Exercise 3 by adding a derived column called
"PercentofMaxRate" that returns the result of the following calculation:
An employees's pay rate, DIVIDED BY the maximum of all values in the "Rate" column, times 100.
*/
SELECT [PersonType]
      ,[NameStyle]
      ,[Title]
      ,[FirstName]
      ,[MiddleName]
      ,[LastName]
	  , [AverageRate]=AVG(RATE) OVER()
	  ,[MaximumRate] =MAX(RATE) OVER()
	  ,[DiffFromAvgRate] = RATE -AVG(RATE) OVER ()
	  ,[PercentofMaxRate] = RATE/MAX(RATE) OVER()
	  ,Rate
  FROM [Person].[Person] P
  left join [HumanResources].[Employee] E on P.BusinessEntityID=E.BusinessEntityID
  left Join HumanResources.EmployeePayHistory H on P.BusinessEntityID=H.BusinessEntityID
