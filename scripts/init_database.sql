/*1. Create database 'DataWarehouse'*/
--1.1 Go to master
USE master;
GO

--Drop and recreate  the DataWarehouse--
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse;
END;
GO

--1.2 Create new database
CREATE DATABASE DataWarehouse;
GO

--1.3 Switch to DataWarehouse
USE DataWarehouse;
GO

/*2. Create schema for DataWarehouse*/
--2.1 Create new schema
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO
