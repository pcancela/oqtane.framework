using System.Data.Common;
using System.Reflection;
using Oqtane.Enums;
using Oqtane.Models;

namespace Oqtane.Repository
{
    public interface ISqlRepository
    {
        void ExecuteScript(Tenant tenant, string script);
        bool ExecuteScript(Tenant tenant, Assembly assembly, string filename);
        int ExecuteNonQuery(Tenant tenant, string query);
        DbDataReader ExecuteReader(Tenant tenant, string query);
        SqlType GetSqlType();
    }
}
