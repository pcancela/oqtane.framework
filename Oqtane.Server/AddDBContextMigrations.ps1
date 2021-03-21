Param(
    [Parameter(Mandatory = $false)] $MasterMigrationName,
    [Parameter(Mandatory = $false)] $TenantMigrationName
)

function Normalize-ProdNamespaces {
    param($folder, $type, $namespaceRegEx, $namespace, $mockContext, $dbContext)
    # Fix namespaces
    Get-ChildItem -Path "Migrations$folder/*$type*.cs" | ForEach-Object {
        (Get-Content $_ `
            | ForEach-Object { $_ -replace $namespaceRegEx, "namespace Oqtane.Migrations.$namespace" } `
            | ForEach-Object { $_ -replace $mockContext, $dbContext }) `
        | Set-Content $_ 
    }
}

try {

    # Master Migrations
    if ($MasterMigrationName) {

        # Migrate MSSQL
        $mssqlMigrationName = "MSSQLMaster$MasterMigrationName"
        dotnet ef migrations add $mssqlMigrationName --context MSSQLMasterDBContext
        
        # Migrate MySQL
        $mysqlMigrationName = "MySQLMaster$MasterMigrationName"
        dotnet ef migrations add $mysqlMigrationName --context MySQLMasterDBContext
       
        #Normalize Migrations
        Normalize-ProdNamespaces -folder "" -type "MSSQLMaster" -namespaceRegEx "namespace Oqtane.Migrations$" -namespace "Master.MSSQL" -mockContext "MSSQLMasterDBContext" -dbContext "MasterDBContext"
        Normalize-ProdNamespaces -folder "/MySQLMasterDB" -type "MySQLMaster" -namespaceRegEx "namespace Oqtane.Migrations.MySQLMasterDB$" -namespace "Master.MySQL" -mockContext "MySQLMasterDBContext" -dbContext "MasterDBContext"
    }

    # Tenant Migrations
    if ($TenantMigrationName) {
        
        # Migrate MSSQL
        $mssqlMigrationName = "MSSQLTenant$TenantMigrationName"
        dotnet ef migrations add $mssqlMigrationName --context MSSQLTenantDBContext  

        # Migrate MySQL
        $mysqlMigrationName = "MySQLTenant$TenantMigrationName"
        dotnet ef migrations add $mysqlMigrationName --context MySQLTenantDBContext
        
        #Normalize Migrations
        Normalize-ProdNamespaces -folder "" -type "MSSQLTenant" -namespaceRegEx "namespace Oqtane.Migrations$" -namespace "Tenant.MSSQL" -mockContext "MSSQLTenantDBContext" -dbContext "TenantDBContext"
        Normalize-ProdNamespaces -folder "/MySQLTenantDB" -type "MySQLTenant" -namespaceRegEx "namespace Oqtane.Migrations.MySQLTenantDB$" -namespace "Tenant.MySQL" -mockContext "MySQLTenantDBContext" -dbContext "TenantDBContext"
    }
}
catch {
    Write-Warning $_.Exception
    Write-Output "A critical error occurred: $_.Exception"
}
finally { 
    Write-Output "Finalising job!"
} 