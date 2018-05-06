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
CREATE TABLE [dbo].[OrderInformation]( 
    [OrderID] [int] NOT NULL, 
    [CustomerID] [int] NOT NULL 
    ) 
INSERT INTO [dbo].[OrderInformation] ([OrderID], [CustomerID]) VALUES (123, 1) 
INSERT INTO [dbo].[OrderInformation] ([OrderID], [CustomerID]) VALUES (149, 2) 
INSERT INTO [dbo].[OrderInformation] ([OrderID], [CustomerID]) VALUES (857, 2) 
INSERT INTO [dbo].[OrderInformation] ([OrderID], [CustomerID]) VALUES (321, 1) 
INSERT INTO [dbo].[OrderInformation] ([OrderID], [CustomerID]) VALUES (564, 8) 

5. Create CustomerInformation table in jackeqtest1:
CREATE TABLE [dbo].[CustomerInformation]( 
    [CustomerID] [int] NOT NULL, 
    [CustomerName] [varchar](50) NULL, 
    [Company] [varchar](50) NULL 
    CONSTRAINT [CustID] PRIMARY KEY CLUSTERED ([CustomerID] ASC) 
) 
INSERT INTO [dbo].[CustomerInformation] ([CustomerID], [CustomerName], [Company]) VALUES (1, 'Jack', 'ABC') 
INSERT INTO [dbo].[CustomerInformation] ([CustomerID], [CustomerName], [Company]) VALUES (2, 'Steve', 'XYZ') 
INSERT INTO [dbo].[CustomerInformation] ([CustomerID], [CustomerName], [Company]) 


