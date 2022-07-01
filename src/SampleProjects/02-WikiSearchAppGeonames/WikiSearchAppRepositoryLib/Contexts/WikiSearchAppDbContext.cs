using CSD.WikiSearchApp.Data.Repositories.Entities;
using Microsoft.EntityFrameworkCore;

#nullable disable

namespace CSD.WikiSearchApp.Data.Repositories.Contexts
{
    public partial class WikiSearchAppDbContext : DbContext
    {
        public WikiSearchAppDbContext()
        {
        }

        public WikiSearchAppDbContext(DbContextOptions<WikiSearchAppDbContext> options)
            : base(options)
        {
        }

        public virtual DbSet<Geoname> Geonames { get; set; }
        public virtual DbSet<WikiSearch> WikiSearches { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            if (optionsBuilder.IsConfigured)
                return;

            //optionsBuilder.UseSqlServer("Server = aws-mssql.cct1ehgoywdp.us-east-2.rds.amazonaws.com; Database = DCJSWPA21_WikiSearchAppDb; User Id = admin; Password = csystem1993;");
            optionsBuilder.UseSqlServer("Server=.;Database=DCJSWPA21_WikiSearchAppDb;Trusted_Connection=True;");            
        }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            modelBuilder.HasAnnotation("Relational:Collation", "SQL_Latin1_General_CP1_CI_AS");

            modelBuilder.Entity<Geoname>(entity =>
            {
                entity.ToTable("Geoname");

                entity.Property(e => e.CountryCode)
                    .HasMaxLength(250)
                    .IsUnicode(false);

                entity.Property(e => e.Feature)
                    .HasMaxLength(500)
                    .IsUnicode(false);

                entity.Property(e => e.Lang)
                    .HasMaxLength(32)
                    .IsUnicode(false);

                entity.Property(e => e.Summary).IsUnicode(false);

                entity.Property(e => e.ThumbnailImg).IsUnicode(false);

                entity.Property(e => e.Title)
                    .HasMaxLength(100)
                    .IsUnicode(false);

                entity.Property(e => e.WikipediaUrl).IsUnicode(false);

                entity.HasOne(d => d.WikiSearch)
                    .WithMany(p => p.Geonames)
                    .HasForeignKey(d => d.WikiSearchId)
                    .HasConstraintName("FK__Geoname__WikiSea__3A81B327");                
            });

            modelBuilder.Entity<WikiSearch>(entity =>
            {
                entity.ToTable("WikiSearch");

                entity.HasIndex(e => e.Q, "UQ__WikiSear__3BD019BF83D6E2A9")
                    .IsUnique();

                entity.Property(e => e.Q)
                    .IsRequired()
                    .HasMaxLength(250)
                    .IsUnicode(false);

                entity.Property(e => e.SearchTime)
                    .HasColumnType("datetime")
                    .HasDefaultValueSql("(sysdatetime())");
            });

            OnModelCreatingPartial(modelBuilder);
        }

        partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
    }
}
