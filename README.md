
# Elastic-Query-Cross-Azure-SQL-DBs-4-Power-BI
Today Power BI can only connect to one Azure SQL DB for direct query. To enable it to directly query more than one Azure SQL DBs, we may use Azure SQL DB's elastic query technique.

Two main refereces are:

https://docs.microsoft.com/en-us/azure/sql-database/sql-database-elastic-query-getting-started-vertical

https://blogs.endjin.com/2017/01/creating-a-powerbi-report-with-directquery-and-multiple-sql-database-sources-using-elastic-query/

The steps are the following:

1. Create Azure SQL DB jackeqtest with logic server jackeqtestsrv.

2. Once the DB and server created, create anohter DB, jackeqtest1 on the same server.

3. Connect the DB server with SSMS 

4. Create OrderInformation table in jackeqtest:
USE [jackeqtest]
GO

CREATE TABLE [dbo].[OrderInformation]( 
    [OrderID] [int] NOT NULL, 
    [CustomerID] [int] NOT NULL 
    ) ;
INSERT INTO [dbo].[OrderInformation] ([OrderID], [CustomerID]) VALUES (123, 1) ;
INSERT INTO [dbo].[OrderInformation] ([OrderID], [CustomerID]) VALUES (149, 2) ;
INSERT INTO [dbo].[OrderInformation] ([OrderID], [CustomerID]) VALUES (857, 2) ;
INSERT INTO [dbo].[OrderInformation] ([OrderID], [CustomerID]) VALUES (321, 1) ;
INSERT INTO [dbo].[OrderInformation] ([OrderID], [CustomerID]) VALUES (564, 8) ;
GO

5. Create CustomerInformation table in jackeqtest1:
USE [jackeqtest1]
GO

CREATE TABLE [dbo].[CustomerInformation]( 
    [CustomerID] [int] NOT NULL, 
    [CustomerName] [varchar](50) NULL, 
    [Company] [varchar](50) NULL 
    CONSTRAINT [CustID] PRIMARY KEY CLUSTERED ([CustomerID] ASC) ;
) 
INSERT INTO [dbo].[CustomerInformation] ([CustomerID], [CustomerName], [Company]) VALUES (1, 'Jack', 'ABC') ;
INSERT INTO [dbo].[CustomerInformation] ([CustomerID], [CustomerName], [Company]) VALUES (2, 'Steve', 'XYZ') ;
INSERT INTO [dbo].[CustomerInformation] ([CustomerID], [CustomerName], [Company]) ;
GO

6. Create Masterkey, external resource and then external table in DB jackeqtest:
use [jackeqtest]
go

CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Password12345!'; 
 CREATE DATABASE SCOPED CREDENTIAL ElasticDBQueryCred 
 WITH IDENTITY = 'jack', 
 SECRET = 'Password12345!';
 go

 CREATE EXTERNAL DATA SOURCE MyElasticDBQueryDataSrc WITH 
    (TYPE = RDBMS, 
    LOCATION = 'jackeqtestsrv.database.windows.net', 
    DATABASE_NAME = 'jackeqtest1', 
    CREDENTIAL = ElasticDBQueryCred, 
) ;

go

CREATE EXTERNAL TABLE [dbo].[CustomerInformation] 
( [CustomerID] [int] NOT NULL, 
  [CustomerName] [varchar](50) NOT NULL, 
  [Company] [varchar](50) NOT NULL) 
WITH 
( DATA_SOURCE = MyElasticDBQueryDataSrc) ;
go

7. Run query to see the results form inner join:
USE [jackeqtest]
GO

SELECT OrderInformation.CustomerID, OrderInformation.OrderId, CustomerInformation.CustomerName, CustomerInformation.Company 
FROM OrderInformation 
INNER JOIN CustomerInformation 
ON CustomerInformation.CustomerID = OrderInformation.CustomerID;
go

8. Now we can start the Power BI Desktop

9. Connect to the Azure SQL DB server jackeqtestsrv

10. Select these two tables and specify DIRECT QUERY

11. Create a Relationship based on CustomerID

12. Create visualizations in Power BI

13. Save all your work to a pbix file and publish it to PowerBi.com

14. Log into your PowerBI.com account and reenter the connection info for jackeqtestsrv

15. YOu by now should see the report and you can pin the report in live to a Dashboard.

16. Finally you should see the dashboard like tha attached PNG image.
