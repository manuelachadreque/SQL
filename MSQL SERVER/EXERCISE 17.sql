USE [AdventureWorks2022];

/*
Exercise 1


Write a query that outputs all records from the Purchasing.PurchaseOrderHeader table. Include the following columns from the table:

PurchaseOrderID

VendorID

OrderDate

TotalDue

Add a derived column called NonRejectedItems which returns, for each purchase order ID in the query output, the number of line items from the Purchasing.PurchaseOrderDetail table which did not have any rejections (i.e., RejectedQty = 0). Use a correlated subquery to do this.
*/



/*
UPDATE - Exercise
Exercise


Using the code in the "Update - Exercise Starter Code.sql" file in the resources for this section (which is the same as the example presented in the video), update the value in the "OrderSubcategory" field as follows:

The value in the field should consist of the following string values concatenated together in this order:

The value in the "OrderCategory" field

A space

A hyphen

Another space

The value in the "OrderAmtBucket" field



The values in the field should look like the following:




Resources for this lecture
*/



