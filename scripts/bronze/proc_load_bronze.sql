/*Load data from csv file into table created before*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME
	BEGIN TRY
	PRINT '=================================================';
	PRINT 'Loading Bronze Layer (step include clear table and reload table from excel)';
	PRINT '=================================================';
	PRINT '------CRM Table------';
	PRINT '>> Table 1: cust_info';
		SET @start_time = GETDATE();
		TRUNCATE TABLE bronze.crm_cust_info; --remove all row, keep the table structure

		BULK INSERT bronze.crm_cust_info
		FROM 'C:\Users\P2610\Desktop\Work File\Other\SQL Learning\Course Document\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',', 
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '--- Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' Second.';

		SELECT COUNT(*) FROM bronze.crm_cust_info; 

	PRINT '>> Table 2: prd_info'
		TRUNCATE TABLE bronze.crm_prd_info;
		BULK INSERT bronze.crm_prd_info
		FROM 'C:\Users\P2610\Desktop\Work File\Other\SQL Learning\Course Document\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		)

		SELECT COUNT(*) FROM bronze.crm_prd_info; 

	PRINT '>> Table 3: sales_details'
		TRUNCATE TABLE bronze.crm_sales_details;
		BULK INSERT bronze.crm_sales_details
		FROM 'C:\Users\P2610\Desktop\Work File\Other\SQL Learning\Course Document\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		)

		SELECT COUNT(*) FROM bronze.crm_sales_details; 

	PRINT '------ERP Table------';
	PRINT '>> Table 1: CUST_AZ12';
		TRUNCATE TABLE bronze.erp_CUST_AZ12;
		BULK INSERT bronze.erp_CUST_AZ12
		FROM 'C:\Users\P2610\Desktop\Work File\Other\SQL Learning\Course Document\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		)

		SELECT COUNT(*) FROM bronze.erp_CUST_AZ12;

	PRINT '>> Table 2: LOC_A101';
		TRUNCATE TABLE bronze.erp_LOC_A101;
		BULK INSERT bronze.erp_LOC_A101
		FROM 'C:\Users\P2610\Desktop\Work File\Other\SQL Learning\Course Document\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		)

		SELECT COUNT(*) FROM bronze.erp_LOC_A101;

	PRINT '>> Table 3: PX_CAT_G1V2';
		TRUNCATE TABLE bronze.erp_PX_CAT_G1V2;
		BULK INSERT bronze.erp_PX_CAT_G1V2
		FROM 'C:\Users\P2610\Desktop\Work File\Other\SQL Learning\Course Document\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		)

		SELECT COUNT(*) FROM bronze.erp_PX_CAT_G1V2;
	END TRY

	BEGIN CATCH
		PRINT 'ERROR occured during loading bronze layer.';
		PRINT 'ERROR Num:' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'ERROR State:' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT 'ERROR Msg::' + ERROR_MESSAGE();
	END CATCH
END

/* to run those above, use line below */
--EXEC bronze.load_bronze
