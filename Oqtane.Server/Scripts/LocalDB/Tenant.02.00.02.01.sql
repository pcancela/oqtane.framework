/*  

Version 2.0.2.1 Tenant migration script

*/

UPDATE [dbo].[SchemaVersions] SET ScriptName = 'Oqtane.Scripts.LocalDB.Tenant.00.09.00.00.sql' WHERE ScriptName = 'Oqtane.Scripts.Tenant.00.09.00.00.sql'
GO
UPDATE [dbo].[SchemaVersions] SET ScriptName = 'Oqtane.Scripts.LocalDB.Tenant.00.09.01.00.sql' WHERE ScriptName = 'Oqtane.Scripts.Tenant.00.09.01.00.sql'
GO
UPDATE [dbo].[SchemaVersions] SET ScriptName = 'Oqtane.Scripts.LocalDB.Tenant.00.09.02.00.sql' WHERE ScriptName = 'Oqtane.Scripts.Tenant.00.09.02.00.sql'
GO
UPDATE [dbo].[SchemaVersions] SET ScriptName = 'Oqtane.Scripts.LocalDB.Tenant.01.00.01.00.sql' WHERE ScriptName = 'Oqtane.Scripts.Tenant.01.00.01.00.sql'
GO