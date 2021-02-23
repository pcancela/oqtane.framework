using System;
using System.Data;
using System.Data.Common;
using MySql.Data.MySqlClient;
using Oqtane.Enums;
using Oqtane.Models;

namespace Oqtane.Repository
{
    public class MySQLRepository : SqlRepositoryBase
    {
        public override SqlType GetSqlType() => SqlType.MySQL;

        public override int ExecuteNonQuery(Tenant tenant, string query)
        {
            MySqlConnection conn = new MySqlConnection(FormatConnectionString(tenant.DBConnectionString));
            MySqlCommand cmd = conn.CreateCommand();
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
            MySqlConnection conn = new MySqlConnection(FormatConnectionString(tenant.DBConnectionString));
            MySqlCommand cmd = conn.CreateCommand();
            PrepareCommand(conn, cmd, query);
            var dr = cmd.ExecuteReader(CommandBehavior.CloseConnection);
            return dr;
        }

        public override void ExecuteScript(Tenant tenant, string script)
        {
            // execute script in curent tenant
            foreach (string query in script.Split(";", StringSplitOptions.RemoveEmptyEntries))
            {
                ExecuteNonQuery(tenant, $"{query};");
            }
        }
    }
}
