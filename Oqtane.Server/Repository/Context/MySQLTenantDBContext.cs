using System;
using Microsoft.EntityFrameworkCore;
using Pomelo.EntityFrameworkCore.MySql.Infrastructure;

namespace Oqtane.Repository
{
    // Context for MSSQL ef migrations 
    public class MySQLTenantDBContext : TenantDBContext
    {
        public MySQLTenantDBContext() : base(null, null) { }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            // YOUR DEV ENVIRONMENT CONNECTION STRING!
            optionsBuilder.UseMySql("Server=192.168.1.110;Port=3306;User Id=root;Password=06memyself&i10;Database=Oqtane-migrations;", new MySqlServerVersion(new Version(5, 1, 73)), mySqlOptions =>
            {
                mySqlOptions.CharSetBehavior(CharSetBehavior.NeverAppend);
            });
        }
    }
}
