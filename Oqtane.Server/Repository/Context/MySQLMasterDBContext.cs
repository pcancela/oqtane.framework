using System;
using Microsoft.EntityFrameworkCore;
using Pomelo.EntityFrameworkCore.MySql.Infrastructure;

namespace Oqtane.Repository
{
    // Context for MySQL ef migrations 
    public class MySQLMasterDBContext : MasterDBContext
    {
        public MySQLMasterDBContext() : base(null) { }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.UseMySql("Server=Oqtane;Port=3306;User Id=Oqtane;Password=Oqtane;Database=Oqtane;", new MySqlServerVersion(new Version(0, 0, 0)), mySqlOptions =>
            {
                mySqlOptions.CharSetBehavior(CharSetBehavior.NeverAppend);
            });
        }
    }
}
