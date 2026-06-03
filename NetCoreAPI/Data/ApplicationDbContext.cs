using Microsoft.EntityFrameworkCore;
using NetCoreAPI.Models;

namespace NetCoreAPI.Data
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
            : base(options)
        {
        }

        // Esta propiedad le dice a Entity Framework que cree una tabla llamada "Usuarios" basada en el modelo anterior
        public DbSet<Usuario> Usuarios { get; set; }
    }
}