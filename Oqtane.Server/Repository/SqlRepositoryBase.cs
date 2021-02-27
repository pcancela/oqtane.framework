using System;
using System.Data;
using System.Data.Common;
using System.IO;
using System.Linq;
using System.Reflection;
using Oqtane.Enums;
using Oqtane.Models;

namespace Oqtane.Repository
{
    public abstract class SqlRepositoryBase : ISqlRepository
    {
        public abstract int ExecuteNonQuery(Tenant tenant, string query);

        public abstract DbDataReader ExecuteReader(Tenant tenant, string query);

        public abstract void ExecuteScript(Tenant tenant, string script);

        public abstract SqlType GetSqlType();

        public bool ExecuteScript(Tenant tenant, Assembly assembly, string filename)
        {
            // script must be included as an Embedded Resource within an assembly
            bool success = true;
            string script = "";

            if (assembly != null)
            {
                string name = assembly.GetManifestResourceNames().FirstOrDefault(item => item.EndsWith($"{GetSqlType()}." + filename));
                if (name != null)
                {
                    Stream resourceStream = assembly.GetManifestResourceStream(name);
                    if (resourceStream != null)
                    {
                        using (var reader = new StreamReader(resourceStream))
                        {
                            script = reader.ReadToEnd();
                        }
                    }
                }
            }

            if (!string.IsNullOrEmpty(script))
            {
                try
                {
                    ExecuteScript(tenant, script);
                }
                catch
                {
                    success = false;
                }
            }

            return success;
        }

        protected virtual void PrepareCommand(DbConnection conn, DbCommand cmd, string query)
        {
            if (conn.State != ConnectionState.Open)
            {
                conn.Open();
            }
            cmd.Connection = conn;
            cmd.CommandText = query;
            cmd.CommandType = CommandType.Text;
        }

        protected string FormatConnectionString(string connectionString)
        {
            return connectionString.Replace("|DataDirectory|", AppDomain.CurrentDomain.GetData("DataDirectory").ToString());
        }
    }
}
