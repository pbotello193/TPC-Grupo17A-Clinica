using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using dominio;

namespace negocio
{
    public static class Seguridad
    {
        public static bool SesionActiva(object user)
        {
            Usuario usuario = user != null ? (Usuario)user : null;
            return usuario != null && usuario.Id != 0;
        }

        //metodos auxiliares para preguntar si el usuario pertenece a ese tipo
        public static bool EsAdmin(object user)
        {
            Usuario usuario = user != null ? (Usuario)user : null;
            return usuario != null && usuario.TipoUsuario == TipoUsuario.Administrador;
        }

        public static bool EsRecepcionista(object user)
        {
            Usuario usuario = user != null ? (Usuario)user : null;
            return usuario != null && usuario.TipoUsuario == TipoUsuario.Recepcionista;
        }

        public static bool EsMedico(object user)
        {
            Usuario usuario = user != null ? (Usuario)user : null;
            return usuario != null && usuario.TipoUsuario == TipoUsuario.Medico;
        }
    }
}
