Param(
    [Parameter(Mandatory = $false)] $MasterMigrationName,
    [Parameter(Mandatory = $false)] $TenantMigrationName
)

function Normalize-DevNamespaces {
    param($type, $dbContext, $mockContext)
    # Fix namespaces
    Get-ChildItem -Path "Migrations/*$type*.cs" | ForEach-Object {
        (Get-Content $_ `
            | ForEach-Object { $_ -replace "\($dbContext", "($mockContext" }) `
        | Set-Content $_ 
    }
}

function Normalize-ProdNamespaces {
    param($type, $namespace, $mockContext, $dbContext)
    # Fix namespaces
    Get-ChildItem -Path "../Oqtane.Migrations.$namespace/*$type*.cs" | ForEach-Object {
        (Get-Content $_ `
            | ForEach-Object { $_ -replace "namespace Oqtane.Migrations$", "namespace Oqtane.Migrations.$namespace" } `
            | ForEach-Object { $_ -replace $mockContext, $dbContext }) `
        | Set-Content $_ 
    }
}
function Copy-Files {
    param($originPath, $regex, $destinationPath)

    Get-ChildItem -Path $originPath | Where-Object { 
        if($_.FullName.Contains($regex)) {
            Copy-Item $_.FullName -Destination $destinationPath
        }
    }
}

try {

    # Master Migrations
    if ($MasterMigrationName) {

        # Migrate MSSQL
        $mssqlMigrationName = "MSSQLMaster$MasterMigrationName"
        dotnet ef migrations add $mssqlMigrationName --context MSSQLMasterDBContext --output-dir ../Oqtane.Migrations.Master.MSSQL
        Start-Sleep -s 2
        # Prepare migrations for production - MSSQL
        Copy-Item "Migrations/MSSQLMasterDBContextModelSnapshot.cs" -Destination "../Oqtane.Migrations.Master.MSSQL/MSSQLMasterDBContextModelSnapshot.cs"
        Normalize-ProdNamespaces -namespace "Master.MSSQL" -mockContext "MSSQLMasterDBContext" -dbContext "MasterDBContext"
        # Prepare migrations for development - MSSQL
        Copy-Files -originPath "../Oqtane.Migrations.Master.MSSQL/" -regex $mssqlMigrationName -destinationPath Migrations
        Normalize-DevNamespaces -type "MSSQLMaster" -dbContext "MasterDBContext" -mockContext "MSSQLMasterDBContext" 

        # Migrate MySQL
        $mysqlMigrationName = "MySQLMaster$MasterMigrationName"
        dotnet ef migrations add $mysqlMigrationName --context MySQLMasterDBContext --output-dir ../Oqtane.Migrations.Master.MySQL
        Start-Sleep -s 2
        # Prepare migrations for production - MySQL
        Copy-Item "Migrations/MySQLMasterDBContextModelSnapshot.cs" -Destination "../Oqtane.Migrations.Master.MySQL/MySQLMasterDBContextModelSnapshot.cs"
        Normalize-ProdNamespaces -namespace "Master.MySQL" -mockContext "MySQLMasterDBContext" -dbContext "MasterDBContext"
        # Prepare migrations for development - MySQL
        Copy-Files -originPath "../Oqtane.Migrations.Master.MySQL/" -regex $mysqlMigrationName -destinationPath Migrations
        Normalize-DevNamespaces -type "MySQLMaster" -dbContext "MasterDBContext" -mockContext "MySQLMasterDBContext" 

        # Build migrations projects in order to update DLLs in Oqtane.Server bin folder
        dotnet build ../Oqtane.Migrations.Master.MSSQL/Oqtane.Migrations.Master.MSSQL.csproj
        dotnet build ../Oqtane.Migrations.Master.MySQL/Oqtane.Migrations.Master.MySQL.csproj
    }

    # Tenant Migrations
    if ($TenantMigrationName) {
        
        # Migrate MSSQL
        $mssqlMigrationName = "MSSQLTenant$TenantMigrationName"
        dotnet ef migrations add $mssqlMigrationName --context MSSQLTenantDBContext --output-dir ../Oqtane.Migrations.Tenant.MSSQL   
        Start-Sleep -s 2
        # Prepare migrations for production - MSSQL
        Copy-Item "Migrations/MSSQLTenantDBContextModelSnapshot.cs" -Destination "../Oqtane.Migrations.Tenant.MSSQL/MSSQLTenantDBContextModelSnapshot.cs"
        Normalize-ProdNamespaces -namespace "Tenant.MSSQL" -mockContext "MSSQLTenantDBContext" -dbContext "TenantDBContext"      
        # Prepare migrations for development - MSSQL
        Copy-Files -originPath "../Oqtane.Migrations.Tenant.MSSQL/" -regex $mssqlMigrationName -destinationPath Migrations
        Normalize-DevNamespaces -type "MSSQLTenant" -dbContext "TenantDBContext" -mockContext "MSSQLTenantDBContext"  

        # Migrate MySQL
        $mysqlMigrationName = "MySQLTenant$TenantMigrationName"
        dotnet ef migrations add $mysqlMigrationName --context MySQLTenantDBContext --output-dir ../Oqtane.Migrations.Tenant.MySQL
        Start-Sleep -s 2
        # Prepare migrations for production - MySQL
        Copy-Item "Migrations/MySQLTenantDBContextModelSnapshot.cs" -Destination "../Oqtane.Migrations.Tenant.MySQL/MySQLTenantDBContextModelSnapshot.cs"
        Normalize-ProdNamespaces -namespace "Tenant.MySQL" -mockContext "MySQLTenantDBContext" -dbContext "TenantDBContext"
        # Prepare migrations for development - MySQL
        Copy-Files -originPath "../Oqtane.Migrations.Tenant.MySQL/" -regex $mysqlMigrationName -destinationPath Migrations
        Normalize-DevNamespaces -type "MySQLTenant" -dbContext "TenantDBContext" -mockContext "MySQLTenantDBContext" 

        # Build migrations projects in order to update DLLs in Oqtane.Server bin folder
        dotnet build ../Oqtane.Migrations.Tenant.MSSQL/Oqtane.Migrations.Tenant.MSSQL.csproj
        dotnet build ../Oqtane.Migrations.Tenant.MySQL/Oqtane.Migrations.Tenant.MySQL.csproj
    }
}
catch {
    Write-Warning $_.Exception
    Write-Output "A critical error occurred: $_.Exception"
}
finally { 
    Write-Output "Finalising job!"
} 