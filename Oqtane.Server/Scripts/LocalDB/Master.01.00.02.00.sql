/*  

Version 1.0.2.0 Master migration script

*/

ALTER TABLE [dbo].[Tenant] ADD
	[DBEngineVersion] [nvarchar](50) NULL
GO

ALTER TABLE [dbo].[Tenant] ADD
	[DBSqlType] [nvarchar](50) NULL
GO

UPDATE [dbo].[Tenant] SET [DBSqlType] = 'LocalDB' WHERE DBConnectionString LIKE '%AttachDbFilename%' 
GO

UPDATE [dbo].[Tenant] SET [DBSqlType] = 'SQLServer' WHERE DBSqlType IS NULL 
GO

ALTER TABLE [dbo].[Tenant] ALTER COLUMN
	[DBSqlType] [nvarchar](50) NOT NULL
GO

UPDATE [dbo].[SchemaVersions] SET ScriptName = 'Oqtane.Scripts.MSSQL.Master.00.09.00.00.sql' WHERE ScriptName = 'Oqtane.Scripts.Master.00.09.00.00.sql'
GO

UPDATE [dbo].[SchemaVersions] SET ScriptName = 'Oqtane.Scripts.MSSQL.Master.01.00.01.00.sql' WHERE ScriptName = 'Oqtane.Scripts.Master.01.00.01.00.sql'
GO