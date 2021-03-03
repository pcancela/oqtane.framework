using System;
using System.Data;
using System.Data.Common;
using Microsoft.Data.SqlClient;
using Oqtane.Enums;
using Oqtane.Models;

namespace Oqtane.Repository
{
    public class SqlRepository : SqlRepositoryBase
    {
        public override SqlType GetSqlType() => SqlType.MSSQL;

        public override int ExecuteNonQuery(Tenant tenant, string query)
        {
            SqlConnection conn = new SqlConnection(FormatConnectionString(tenant.DBConnectionString));
            SqlCommand cmd = conn.CreateCommand();
            using (conn)
            {
                PrepareCommand(conn, cmd, query);
                int val = -1;
                try
                {
                    val = cmd.ExecuteNonQuery();
                }
                catch
                {
                    // an error occurred executing the query
                }
                return val;
            }
        }

        public override DbDataReader ExecuteReader(Tenant tenant, string query)
        {
            SqlConnection conn = new SqlConnection(FormatConnectionString(tenant.DBConnectionString));
            SqlCommand cmd = conn.CreateCommand();
            PrepareCommand(conn, cmd, query);
            var dr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
            return dr;
        }

        public override void ExecuteScript(Tenant tenant, string script)
        {
            // execute script in curent tenant
            foreach (string query in script.Split("GO", StringSplitOptions.RemoveEmptyEntries))
            {
                ExecuteNonQuery(tenant, query);
            }
        }
    }
}
