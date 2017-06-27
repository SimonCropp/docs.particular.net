using System.Data.Common;
using Microsoft.EntityFrameworkCore;

public class ReceiverDataContext :
    DbContext
{
    #region EntityFramework
    public ReceiverDataContext(DbConnection connection)
    {
        this.connection = connection;
    }
    public ReceiverDataContext(string connectionString)
    {
        this.connectionString = connectionString;
    }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
    {
        if (!string.IsNullOrEmpty(connectionString))
        {
            optionsBuilder.UseSqlServer(connectionString);
        }
        else
        {
            optionsBuilder.UseSqlServer(connection);
        }
    }

    DbConnection connection;
    string connectionString;
    #endregion

    public DbSet<Order> Orders { get; set; }
}
