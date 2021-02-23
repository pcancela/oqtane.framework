using System;
using System.Collections.Generic;
using System.Data.Common;
using System.Linq;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Oqtane.Enums;
using Oqtane.Extensions;
using Oqtane.Infrastructure;
using Oqtane.Models;
using Oqtane.Repository;
using Oqtane.Shared;

namespace Oqtane.Controllers
{
    [Route(ControllerRoutes.Default)]
    public class SqlController : Controller
    {
        private readonly ITenantRepository _tenants;
        private readonly IEnumerable<ISqlRepository> _sqlRepositories;
        private readonly ILogManager _logger;

        public SqlController(ITenantRepository tenants, IEnumerable<ISqlRepository> sqlRepositories, ILogManager logger)
        {
            _tenants = tenants;
            _sqlRepositories = sqlRepositories;
            _logger = logger;
        }

        // POST: api/<controller>
        [HttpPost]
        [Authorize(Roles = RoleNames.Host)]
        public SqlQuery Post([FromBody] SqlQuery sqlquery)
        {
            var results = new List<Dictionary<string, string>>();
            Dictionary<string, string> row;
            Tenant tenant = _tenants.GetTenant(sqlquery.TenantId);
            var sqlType = tenant.DBSqlType.ToEnum<SqlType>();
            var splitType = sqlType == SqlType.LocalDB || sqlType == SqlType.MSSQL ? "GO" : ";";
            try
            {
                foreach (string query in sqlquery.Query.Split(splitType, StringSplitOptions.RemoveEmptyEntries))
                {
                    DbDataReader dr = _sqlRepositories.FirstOrDefault(r => r.GetSqlType() == sqlType).ExecuteReader(tenant, query);
                    _logger.Log(LogLevel.Information, this, LogFunction.Other, "Sql Query {Query} Executed on Tenant {TenantId}", query, sqlquery.TenantId);
                    while (dr.Read())
                    {
                        row = new Dictionary<string, string>();
                        for (var field = 0; field < dr.FieldCount; field++)
                        {
                            row[dr.GetName(field)] = dr.IsDBNull(field) ? "" : dr.GetValue(field).ToString();
                        }
                        results.Add(row);
                    }
                }
            }
            catch (Exception ex)
            {
                _logger.Log(LogLevel.Error, this, LogFunction.Other, "Sql Query {Query} Executed on Tenant {TenantId} Results In An Error {Error}", sqlquery.Query, sqlquery.TenantId, ex.Message);
            }
            sqlquery.Results = results;
            return sqlquery;
        }

    }
}
