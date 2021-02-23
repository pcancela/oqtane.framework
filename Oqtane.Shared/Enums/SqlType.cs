using System.ComponentModel;

namespace Oqtane.Enums
{
    public enum SqlType
    {
        LocalDB,
        [Description("SQLServer")]
        MSSQL,
        MySQL
    }
}
