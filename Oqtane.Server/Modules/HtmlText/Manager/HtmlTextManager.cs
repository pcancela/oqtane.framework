using System.Collections.Generic;
using System.Linq;
using System.Net;
using Oqtane.Enums;
using Oqtane.Extensions;
using Oqtane.Infrastructure;
using Oqtane.Models;
using Oqtane.Modules.HtmlText.Models;
using Oqtane.Modules.HtmlText.Repository;
using Oqtane.Repository;

namespace Oqtane.Modules.HtmlText.Manager
{
    public class HtmlTextManager : IInstallable, IPortable
    {
        private IHtmlTextRepository _htmlTexts;
        private IEnumerable<ISqlRepository> _sqlRepositories;

        public HtmlTextManager(IHtmlTextRepository htmltexts, IEnumerable<ISqlRepository> sqlRepositories)
        {
            _htmlTexts = htmltexts;
            _sqlRepositories = sqlRepositories;
        }

        public bool Install(Tenant tenant, string version)
        {
            var sqlType = tenant.DBSqlType.ToEnum<SqlType>();
            var sql = _sqlRepositories.FirstOrDefault(r => r.GetSqlType() == sqlType);
            return sql.ExecuteScript(tenant, GetType().Assembly, "HtmlText." + version + ".sql");
        }

        public bool Uninstall(Tenant tenant)
        {
            var sqlType = tenant.DBSqlType.ToEnum<SqlType>();
            var sql = _sqlRepositories.FirstOrDefault(r => r.GetSqlType() == sqlType);
            return sql.ExecuteScript(tenant, GetType().Assembly, "HtmlText.Uninstall.sql");
        }

        public string ExportModule(Module module)
        {
            string content = "";
            HtmlTextInfo htmltext = _htmlTexts.GetHtmlText(module.ModuleId);
            if (htmltext != null)
            {
                content = WebUtility.HtmlEncode(htmltext.Content);
            }
            return content;
        }

        public void ImportModule(Module module, string content, string version)
        {
            content = WebUtility.HtmlDecode(content);
            HtmlTextInfo htmltext = _htmlTexts.GetHtmlText(module.ModuleId);
            if (htmltext != null)
            {
                htmltext.Content = content;
                _htmlTexts.UpdateHtmlText(htmltext);
            }
            else
            {
                htmltext = new HtmlTextInfo();
                htmltext.ModuleId = module.ModuleId;
                htmltext.Content = content;
                _htmlTexts.AddHtmlText(htmltext);
            }
        }
    }
}
