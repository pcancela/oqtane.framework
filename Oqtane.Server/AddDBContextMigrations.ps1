Param(
    [Parameter(Mandatory=$false)] $MasterMigrationName,
    [Parameter(Mandatory=$false)] $TenantMigrationName
)

# Master Migrations
if ($MasterMigrationName) {
    dotnet ef migrations add $MasterMigrationName --context MSSQLMasterDBContext --output-dir ../Oqtane.Migrations.Master.MSSQL
    Copy-Item Migrations/MSSQLMasterDBContextModelSnapshot.cs -Destination ../Oqtane.Migrations.Master.MSSQL
    # Fix namespaces
    Get-ChildItem -Path ../Oqtane.Migrations.Master.MSSQL/*.cs | ForEach-Object {
        (Get-Content $_ `
        | ForEach-Object {$_ -replace "namespace Oqtane.Migrations", "namespace Oqtane.Migrations.Master.MSSQL"} `
        | ForEach-Object {$_ -replace "MSSQLMasterDBContext", "MasterDBContext"}) `
        | Set-Content $_ 
    }

    dotnet ef migrations add $MasterMigrationName --context MySQLMasterDBContext --output-dir ../Oqtane.Migrations.Master.MySQL
    Copy-Item Migrations/MySQLMasterDBContextModelSnapshot.cs -Destination ../Oqtane.Migrations.Master.MySQL
    # Fix namespaces
    Get-ChildItem -Path ../Oqtane.Migrations.Master.MySQL/*.cs | ForEach-Object {
        (Get-Content $_ `
        | ForEach-Object {$_ -replace "namespace Oqtane.Migrations", "namespace Oqtane.Migrations.Master.MySQL"} `
        | ForEach-Object {$_ -replace "MySQLMasterDBContext", "MasterDBContext"}) `
        | Set-Content $_ 
    }

    # Build migrations projects in order to update DLLs in Oqtane.Server bin folder
    dotnet build ../Oqtane.Migrations.Master.MSSQL/Oqtane.Migrations.Master.MSSQL.csproj
    dotnet build ../Oqtane.Migrations.Master.MySQL/Oqtane.Migrations.Master.MySQL.csproj
}

# Tenant Migrations
if ($TenantMigrationName) {
    dotnet ef migrations add $TenantMigrationName --context MSSQLTenantDBContext --output-dir ../Oqtane.Migrations.Tenant.MSSQL
    Copy-Item Migrations/MSSQLTenantDBContextModelSnapshot.cs -Destination ../Oqtane.Migrations.Tenant.MSSQL
    # Fix namespaces
    Get-ChildItem -Path ../Oqtane.Migrations.Tenant.MSSQL/*.cs | ForEach-Object {
        (Get-Content $_ `
        | ForEach-Object {$_ -replace "namespace Oqtane.Migrations", "namespace Oqtane.Migrations.Tenant.MSSQL"} `
        | ForEach-Object {$_ -replace "MSSQLTenantDBContext", "TenantDBContext"}) `
        | Set-Content $_ 
    }

    dotnet ef migrations add $TenantMigrationName --context MySQLTenantDBContext --output-dir ../Oqtane.Migrations.Tenant.MySQL
    Copy-Item Migrations/MySQLTenantDBContextModelSnapshot.cs -Destination ../Oqtane.Migrations.Tenant.MySQL
    # Fix namespaces
    Get-ChildItem -Path ../Oqtane.Migrations.Tenant.MySQL/*.cs | ForEach-Object {
        (Get-Content $_ `
        | ForEach-Object {$_ -replace "namespace Oqtane.Migrations", "namespace Oqtane.Migrations.Tenant.MySQL"} `
        | ForEach-Object {$_ -replace "MySQLTenantDBContext", "TenantDBContext"}) `
        | Set-Content $_ 
    }

    # Build migrations projects in order to update DLLs in Oqtane.Server bin folder
    dotnet build ../Oqtane.Migrations.Tenant.MSSQL/Oqtane.Migrations.Tenant.MSSQL.csproj
    dotnet build ../Oqtane.Migrations.Tenant.MySQL/Oqtane.Migrations.Tenant.MySQL.csproj
}

# Delete temporary migrations folder
Remove-Item Migrations -Force -Recurse




