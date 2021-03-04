using Microsoft.EntityFrameworkCore;

namespace Oqtane.Repository
{
    // Context for MSSQL ef migrations 
    public class MSSQLTenantDBContext : TenantDBContext
    {
        public MSSQLTenantDBContext() : base(null, null) { }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            // YOUR DEV ENVIRONMENT CONNECTION STRING!
            optionsBuilder.UseSqlServer("Data Source=PPC09;Initial Catalog=Oqtane-migrations;Integrated Security=SSPI;");
        }
    }
}
