using Microsoft.EntityFrameworkCore;
using Oqtane.Enums;
using Oqtane.Extensions;
using Oqtane.Models;

namespace Oqtane.Repository
{ 
    public class InstallationContext : DbContext
    {
        private readonly SqlType _sqlType;

        private readonly string _databaseEngineVersion;

        private readonly string _connectionString;

        public InstallationContext(SqlType sqlType, string databaseVersion, string connectionString)
        {
            _sqlType = sqlType;
            _connectionString = connectionString;
            _databaseEngineVersion = databaseVersion;
        }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder) => optionsBuilder.UseConfiguredSqlProvider(_sqlType, "Master", _databaseEngineVersion, _connectionString);


        public virtual DbSet<Alias> Alias { get; set; }
        public virtual DbSet<Tenant> Tenant { get; set; }
        public virtual DbSet<ModuleDefinition> ModuleDefinition { get; set; }
        public virtual DbSet<Job> Job { get; set; }
    }
}
