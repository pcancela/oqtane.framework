using DbUp.Builder;
using Oqtane.Enums;

namespace Oqtane.Extensions
{
    public static class UpgradeEngineBuilderExtensions
    {
        public static UpgradeEngineBuilder ConfiguredSqlDatabase(this SupportedDatabases supportedDatabases, SqlType sqlType, string connectionString)
        {
            switch (sqlType)
            {
                case SqlType.MySQL:
                    return supportedDatabases.MySqlDatabase(connectionString);
                default:
                    return supportedDatabases.SqlDatabase(connectionString);
            }
        }
    }
}
