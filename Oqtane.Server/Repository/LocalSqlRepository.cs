using Oqtane.Enums;

namespace Oqtane.Repository
{
    public class LocalSqlRepository : SqlRepository
    {
        public override SqlType GetSqlType() => SqlType.LocalDB;
    }
}
