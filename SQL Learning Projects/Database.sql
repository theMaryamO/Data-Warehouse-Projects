-----------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------
--VIEWS
-----------------------------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------------------------------------------------------------------------------------------

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [TerritoryID]
      ,[Name]
      ,[CountryRegionCode]
      ,[Group]
      ,[SalesYTD]
      ,[SalesLastYear]
      ,[CostYTD]
      ,[CostLastYear]
      ,[rowguid]
      ,[ModifiedDate]
  FROM [AdventureWorks2019].[Sales].[SalesTerritory]

  --CREATE VIEW FOR US
  create view salesUSView
  as 
  select * from AdventureWorks2019.Sales.SalesTerritory
  where CountryRegionCode Like 'US'
  select * from salesUSView
