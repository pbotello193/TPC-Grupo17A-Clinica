using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace dominio
{
    public enum TipoUsuario //Enum sirve para identificar el tipo de usuario sin usar numeros sueltos en el codigo
    {
        Administrador = 1,
        Recepcionista = 2,
        Medico = 3
    }

    public class Usuario
    {
        public int Id { get; set; }
        public string User { get; set; }
        public string Pass { get; set; }
        public TipoUsuario TipoUsuario { get; set; }
        public string PaginaInicio { get; set; }
        public int? IdMedico { get; set; } //? -> puede ser null porque no todos los usuarios son medicos
        public string NombreMostrar { get; set; }
        public string Rol { get; set; }
        public string Nombre { get; set; }
        public string Apellido { get; set; }
        public string DNI { get; set; }
        public string Telefono { get; set; }
        public string Email { get; set; }
        public bool Activo { get; set; }
    }
}
