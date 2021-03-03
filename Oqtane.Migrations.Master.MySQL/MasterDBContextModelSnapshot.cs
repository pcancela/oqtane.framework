// <auto-generated />
using System;
using Microsoft.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore.Infrastructure;
using Microsoft.EntityFrameworkCore.Storage.ValueConversion;
using Oqtane.Repository;

namespace Oqtane.Migrations.Master.MySQL
{
    [DbContext(typeof(MasterDBContext))]
    partial class MasterDBContextModelSnapshot : ModelSnapshot
    {
        protected override void BuildModel(ModelBuilder modelBuilder)
        {
#pragma warning disable 612, 618
            modelBuilder
                .HasAnnotation("Relational:MaxIdentifierLength", 64)
                .HasAnnotation("ProductVersion", "5.0.0");

            modelBuilder.Entity("Oqtane.Models.Alias", b =>
                {
                    b.Property<int>("AliasId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    b.Property<string>("CreatedBy")
                        .HasColumnType("longtext");

                    b.Property<DateTime>("CreatedOn")
                        .HasColumnType("datetime");

                    b.Property<string>("ModifiedBy")
                        .HasColumnType("longtext");

                    b.Property<DateTime>("ModifiedOn")
                        .HasColumnType("datetime");

                    b.Property<string>("Name")
                        .HasColumnType("longtext");

                    b.Property<int>("SiteId")
                        .HasColumnType("int");

                    b.Property<int>("TenantId")
                        .HasColumnType("int");

                    b.HasKey("AliasId");

                    b.ToTable("Alias");
                });

            modelBuilder.Entity("Oqtane.Models.Job", b =>
                {
                    b.Property<int>("JobId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    b.Property<string>("CreatedBy")
                        .HasColumnType("longtext");

                    b.Property<DateTime>("CreatedOn")
                        .HasColumnType("datetime");

                    b.Property<DateTime?>("EndDate")
                        .HasColumnType("datetime");

                    b.Property<string>("Frequency")
                        .HasColumnType("longtext");

                    b.Property<int>("Interval")
                        .HasColumnType("int");

                    b.Property<bool>("IsEnabled")
                        .HasColumnType("tinyint(1)");

                    b.Property<bool>("IsExecuting")
                        .HasColumnType("tinyint(1)");

                    b.Property<bool>("IsStarted")
                        .HasColumnType("tinyint(1)");

                    b.Property<string>("JobType")
                        .HasColumnType("longtext");

                    b.Property<string>("ModifiedBy")
                        .HasColumnType("longtext");

                    b.Property<DateTime>("ModifiedOn")
                        .HasColumnType("datetime");

                    b.Property<string>("Name")
                        .HasColumnType("longtext");

                    b.Property<DateTime?>("NextExecution")
                        .HasColumnType("datetime");

                    b.Property<int>("RetentionHistory")
                        .HasColumnType("int");

                    b.Property<DateTime?>("StartDate")
                        .HasColumnType("datetime");

                    b.HasKey("JobId");

                    b.ToTable("Job");
                });

            modelBuilder.Entity("Oqtane.Models.JobLog", b =>
                {
                    b.Property<int>("JobLogId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    b.Property<DateTime?>("FinishDate")
                        .HasColumnType("datetime");

                    b.Property<int>("JobId")
                        .HasColumnType("int");

                    b.Property<string>("Notes")
                        .HasColumnType("longtext");

                    b.Property<DateTime>("StartDate")
                        .HasColumnType("datetime");

                    b.Property<bool?>("Succeeded")
                        .HasColumnType("tinyint(1)");

                    b.HasKey("JobLogId");

                    b.HasIndex("JobId");

                    b.ToTable("JobLog");
                });

            modelBuilder.Entity("Oqtane.Models.ModuleDefinition", b =>
                {
                    b.Property<int>("ModuleDefinitionId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    b.Property<string>("Categories")
                        .HasColumnType("longtext");

                    b.Property<string>("CreatedBy")
                        .HasColumnType("longtext");

                    b.Property<DateTime>("CreatedOn")
                        .HasColumnType("datetime");

                    b.Property<string>("Description")
                        .HasColumnType("longtext");

                    b.Property<string>("ModifiedBy")
                        .HasColumnType("longtext");

                    b.Property<DateTime>("ModifiedOn")
                        .HasColumnType("datetime");

                    b.Property<string>("ModuleDefinitionName")
                        .HasColumnType("longtext");

                    b.Property<string>("Name")
                        .HasColumnType("longtext");

                    b.Property<string>("Version")
                        .HasColumnType("longtext");

                    b.HasKey("ModuleDefinitionId");

                    b.ToTable("ModuleDefinition");
                });

            modelBuilder.Entity("Oqtane.Models.Tenant", b =>
                {
                    b.Property<int>("TenantId")
                        .ValueGeneratedOnAdd()
                        .HasColumnType("int");

                    b.Property<string>("CreatedBy")
                        .HasColumnType("longtext");

                    b.Property<DateTime>("CreatedOn")
                        .HasColumnType("datetime");

                    b.Property<string>("DBConnectionString")
                        .HasColumnType("longtext");

                    b.Property<string>("DBEngineVersion")
                        .HasColumnType("longtext");

                    b.Property<string>("DBSqlType")
                        .HasColumnType("longtext");

                    b.Property<string>("ModifiedBy")
                        .HasColumnType("longtext");

                    b.Property<DateTime>("ModifiedOn")
                        .HasColumnType("datetime");

                    b.Property<string>("Name")
                        .HasColumnType("longtext");

                    b.Property<string>("Version")
                        .HasColumnType("longtext");

                    b.HasKey("TenantId");

                    b.ToTable("Tenant");
                });

            modelBuilder.Entity("Oqtane.Models.JobLog", b =>
                {
                    b.HasOne("Oqtane.Models.Job", "Job")
                        .WithMany()
                        .HasForeignKey("JobId")
                        .OnDelete(DeleteBehavior.Cascade)
                        .IsRequired();

                    b.Navigation("Job");
                });
#pragma warning restore 612, 618
        }
    }
}
