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
