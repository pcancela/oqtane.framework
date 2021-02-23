using System;
using Microsoft.EntityFrameworkCore;
using Oqtane.Enums;
using Pomelo.EntityFrameworkCore.MySql.Infrastructure;

namespace Oqtane.Extensions
{
    public static class DbContextOptionsBuilderExtensions
    {
        public static DbContextOptionsBuilder UseConfiguredSqlProvider(this DbContextOptionsBuilder optionsBuilder, SqlType sqlType, string databaseEngineVersion, string connectionString)
        {
            switch (sqlType)
            {
                case SqlType.MySQL:
                    return optionsBuilder.UseMySql(connectionString, new MySqlServerVersion(new Version(databaseEngineVersion)), // use MariaDbServerVersion for MariaDB
                            mySqlOptions => mySqlOptions
                                .CharSetBehavior(CharSetBehavior.NeverAppend));
                default:
                    return optionsBuilder.UseSqlServer(connectionString
                            .Replace("|DataDirectory|", AppDomain.CurrentDomain.GetData("DataDirectory")?.ToString())
                    );
            }
        }     
    }
}
