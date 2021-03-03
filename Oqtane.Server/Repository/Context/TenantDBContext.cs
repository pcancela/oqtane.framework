using Microsoft.AspNetCore.Http;
using Microsoft.EntityFrameworkCore;
using Oqtane.Enums;
using Oqtane.Extensions;
using Oqtane.Models;

namespace Oqtane.Repository
{
    public class TenantDBContext : DBContextBase
    {
        public virtual DbSet<Site> Site { get; set; }
        public virtual DbSet<Page> Page { get; set; }
        public virtual DbSet<PageModule> PageModule { get; set; }
        public virtual DbSet<Module> Module { get; set; }
        public virtual DbSet<User> User { get; set; }
        public virtual DbSet<Profile> Profile { get; set; }
        public virtual DbSet<Role> Role { get; set; }
        public virtual DbSet<UserRole> UserRole { get; set; }
        public virtual DbSet<Permission> Permission { get; set; }
        public virtual DbSet<Setting> Setting { get; set; }
        public virtual DbSet<Log> Log { get; set; }
        public virtual DbSet<Notification> Notification { get; set; }
        public virtual DbSet<Folder> Folder { get; set; }
        public virtual DbSet<File> File { get; set; }

        public virtual DbSet<Language> Language { get; set; }
        public virtual DbSet<HtmlText> HtmlText { get; set; }

        public string InstallerSqlType { get; set; }
        public string InstallerDatabaseEngineVersion { get; set; }
        public string InstallerConnectionString { get; set; }

        public TenantDBContext(ITenantResolver tenantResolver, IHttpContextAccessor accessor) : base(tenantResolver, accessor)
        {
            // DBContextBase handles multi-tenant database connections
        }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (TenantResolver?.GetTenant() == null)
            {
                //var sqlType = SqlType.MSSQL;//InstallerSqlType.ToEnum<SqlType>();
                //var databaseEngineVersion = "";//InstallerDatabaseEngineVersion;
                //var connectionString = "Data Source=PPC09;Initial Catalog=Oqtane-202103031301;Integrated Security=SSPI;";//InstallerConnectionString;
                var sqlType = InstallerSqlType.ToEnum<SqlType>();
                var databaseEngineVersion = InstallerDatabaseEngineVersion;
                var connectionString = InstallerConnectionString;
                optionsBuilder.UseConfiguredSqlProvider(sqlType, "Tenant", databaseEngineVersion, connectionString);
            }
            else
            {
                base.OnConfiguring(optionsBuilder);
            }
        }
    }
}
