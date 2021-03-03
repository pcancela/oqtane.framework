using Microsoft.EntityFrameworkCore;

namespace Oqtane.Repository
{
    // Context for MSSQL ef migrations 
    public class MSSQLTenantDBContext : TenantDBContext
    {
        public MSSQLTenantDBContext() : base(null, null) { }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseSqlServer("Data Source=Oqtane;Initial Catalog=Oqtane;Integrated Security=SSPI;");
        }
    }
}
