/* 
Stored Procedures - Exercise
Exercise


Create a stored procedure called "OrdersAboveThreshold" that pulls in all sales orders with a total due amount above a threshold specified in a parameter called "@Threshold". The value for threshold will be supplied by the caller of the stored procedure.

The proc should have two other parameters: "@StartYear" and "@EndYear" (both INT data types), also specified by the called of the procedure. All order dates returned by the proc should fall between these two years.

Resources for this lecture

*/