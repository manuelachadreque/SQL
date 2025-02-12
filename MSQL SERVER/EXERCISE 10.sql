--Correlated Subqueries - Exercises

/*

Exercise 1
Write a query that outputs all records from the Purchasing.PurchaseOrderHeader table. Include the following columns from the table:

PurchaseOrderID
VendorID
OrderDate
TotalDue

Add a derived column called NonRejectedItems which returns, for each purchase order ID in the query output, 
the number of line items from the Purchasing.PurchaseOrderDetail table which did not have any rejections (i.e., RejectedQty = 0). Use a correlated subquery to do this.


*/

select 
 A.PurchaseOrderID
,VendorID
,OrderDate
,TotalDue
,[NonRejectedItems]=
					(SELECT COUNT( *) 
						FROM Purchasing.PurchaseOrderDetail B
						WHERE A.PurchaseOrderID = B.PurchaseOrderID 
							AND RejectedQty=0 
						) 
from Purchasing.PurchaseOrderHeader A


/*
Exercise 2


Modify your query to include a second derived field called MostExpensiveItem.

This field should return, for each purchase order ID, the UnitPrice of the most expensive item for that order in the Purchasing.PurchaseOrderDetail table.

Use a correlated subquery to do this as well.



Hint: Think of the most appropriate aggregate function to use in the correlated subquery for this scenario.

*/


select 
 A.PurchaseOrderID
,VendorID
,OrderDate
,TotalDue
,[NonRejectedItems]=
					(SELECT COUNT( *) 
						FROM Purchasing.PurchaseOrderDetail B
						WHERE A.PurchaseOrderID = B.PurchaseOrderID 
							AND RejectedQty=0 
						) 
,MostExpensiveItem =(
					SELECT MAX(B.UnitPrice ) 
					FROM Purchasing.PurchaseOrderDetail B
					WHERE A.PurchaseOrderID = B.PurchaseOrderID 
					)
from Purchasing.PurchaseOrderHeader A


