
/*

NOTE TO STUDENTS
The code example in the next section - in which we create a user defined function that calculates the elapsed business days between two dates - needs a slight tweak.



We actually need to subtract 1 from the output of the current calculation, since our elapsed business days should be 0 if our start and end dates are the same, and not 1 as the current logic would return.



The updated logic can be seen below, and is also reflected in the example file.



Big shout out to student Daniel Redgate for catching this!



  ElapsedBusinessDays = (

SELECT

COUNT(*)

FROM AdventureWorks2019.dbo.Calendar B

WHERE B.DateValue BETWEEN A.OrderDate AND A.ShipDate

AND B.WeekendFlag = 0

AND B.HolidayFlag = 0

  ) - 1



  */

