using System;
using Microsoft.EntityFrameworkCore;
using Oqtane.Enums;
using Pomelo.EntityFrameworkCore.MySql.Infrastructure;

namespace Oqtane.Extensions
{
    public static class DbContextOptionsBuilderExtensions
    {
        public static DbContextOptionsBuilder UseConfiguredSqlProvider(this DbContextOptionsBuilder optionsBuilder, SqlType sqlType, string contextType, string databaseEngineVersion, string connectionString)
        {
            switch (sqlType)
            {
                case SqlType.MySQL:
                    return optionsBuilder.UseMySql(connectionString,
                        new MySqlServerVersion(new Version(databaseEngineVersion)), // use MariaDbServerVersion for MariaDB
                        mySqlOptions =>
                        {
                            mySqlOptions.CharSetBehavior(CharSetBehavior.NeverAppend);
                            mySqlOptions.MigrationsAssembly($"Oqtane.Migrations.{contextType}.MySQL");
                        }
                    );
                default:
                    return optionsBuilder.UseSqlServer(
                        connectionString.Replace("|DataDirectory|", AppDomain.CurrentDomain.GetData("DataDirectory")?.ToString()),
                        sqlOptions =>
                        {
                            sqlOptions.MigrationsAssembly($"Oqtane.Migrations.{contextType}.MSSQL");
                        }
                    );
            }
        }     
    }
}
