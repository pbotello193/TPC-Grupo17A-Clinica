using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using dominio;

namespace negocio
{
    public class UsuarioNegocio
    {
        public bool Loguear(Usuario usuario)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT U.Id, U.TipoUser, U.IdMedico, R.PaginaInicio, ISNULL(M.Nombre + ' ' + M.Apellido, U.Usuario) AS NombreMostrar FROM Usuarios U INNER JOIN Roles R ON R.Id = U.TipoUser LEFT JOIN Medicos M ON M.Id = U.IdMedico WHERE U.Usuario = @user AND U.Pass = @pass AND U.Activo = 1");
                datos.setearParametro("@user", usuario.User);
                datos.setearParametro("@pass", usuario.Pass);

                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    usuario.Id = (int)datos.Lector["Id"];
                    usuario.TipoUsuario = (TipoUsuario)(int)datos.Lector["TipoUser"];
                    usuario.PaginaInicio = (string)datos.Lector["PaginaInicio"];
                    usuario.IdMedico = datos.Lector["IdMedico"] == DBNull.Value ? (int?)null : (int)datos.Lector["IdMedico"];
                    usuario.NombreMostrar = (string)datos.Lector["NombreMostrar"];
                    
                    return true;
                }

                return false;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public bool existeUsuario(string nombreUsuario)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT COUNT(*) FROM Usuarios WHERE Usuario = @Usuario");
                datos.setearParametro("@Usuario", nombreUsuario);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                    return Convert.ToInt32(datos.Lector[0]) > 0;

                return false;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }

        public void agregarUsuarioMedico(Usuario usuario)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("INSERT INTO Usuarios (Usuario, Pass, TipoUser, IdMedico, Activo) VALUES (@Usuario, @Pass, @TipoUser, @IdMedico, 1)");
                datos.setearParametro("@Usuario", usuario.User);
                datos.setearParametro("@Pass", usuario.Pass);
                datos.setearParametro("@TipoUser", (int)TipoUsuario.Medico);
                datos.setearParametro("@IdMedico", usuario.IdMedico);

                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }

}
