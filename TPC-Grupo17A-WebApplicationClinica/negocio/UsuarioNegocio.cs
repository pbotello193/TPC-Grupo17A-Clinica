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
                datos.setearConsulta("SELECT U.Id, U.TipoUser, U.IdMedico, R.PaginaInicio, COALESCE(M.Nombre + ', ' + M.Apellido, U.Nombre + ', ' + U.Apellido, U.Usuario) AS NombreMostrar FROM Usuarios U INNER JOIN Roles R ON R.Id = U.TipoUser LEFT JOIN Medicos M ON M.Id = U.IdMedico WHERE U.Usuario = @user AND U.Pass = @pass AND U.Activo = 1");
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

        public bool existeUsuario(string nombreUsuario, int idExcluir = 0)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT COUNT(*) FROM Usuarios WHERE Usuario = @Usuario AND Id <> @IdExcluir");
                datos.setearParametro("@Usuario", nombreUsuario);
                datos.setearParametro("@IdExcluir", idExcluir);
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

        public bool existeDniPersonalAdministrativo(string dni, int idExcluir = 0)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT COUNT(*) FROM Usuarios WHERE DNI = @DNI AND TipoUser IN (1, 2) AND Id <> @IdExcluir");
                datos.setearParametro("@DNI", dni);
                datos.setearParametro("@IdExcluir", idExcluir);
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

        public void modificarPersonalAdministrativo(Usuario usuario)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("UPDATE Usuarios SET Usuario = @Usuario, Pass = @Pass, TipoUser = @TipoUser, Nombre = @Nombre, Apellido = @Apellido, DNI = @DNI, Telefono = @Telefono, Email = @Email WHERE Id = @Id AND TipoUser IN (1, 2)");
                datos.setearParametro("@Id", usuario.Id);
                datos.setearParametro("@Usuario", usuario.User);
                datos.setearParametro("@Pass", usuario.Pass);
                datos.setearParametro("@TipoUser", (int)usuario.TipoUsuario);
                datos.setearParametro("@Nombre", usuario.Nombre);
                datos.setearParametro("@Apellido", usuario.Apellido);
                datos.setearParametro("@DNI", usuario.DNI);
                datos.setearParametro("@Telefono", usuario.Telefono);
                datos.setearParametro("@Email", usuario.Email);

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

        public void agregarPersonalAdministrativo(Usuario usuario)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("INSERT INTO Usuarios (Usuario, Pass, TipoUser, IdMedico, Nombre, Apellido, DNI, Telefono, Email, Activo) VALUES (@Usuario, @Pass, @TipoUser, NULL, @Nombre, @Apellido, @DNI, @Telefono, @Email, 1)");
                datos.setearParametro("@Usuario", usuario.User);
                datos.setearParametro("@Pass", usuario.Pass);
                datos.setearParametro("@TipoUser", (int)usuario.TipoUsuario);
                datos.setearParametro("@Nombre", usuario.Nombre);
                datos.setearParametro("@Apellido", usuario.Apellido);
                datos.setearParametro("@DNI", usuario.DNI);
                datos.setearParametro("@Telefono", usuario.Telefono);
                datos.setearParametro("@Email", usuario.Email);

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

        public Usuario obtenerPersonalAdministrativoPorId(int id)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT U.Id, U.Usuario, U.Pass, U.TipoUser, R.Nombre AS Rol, U.Nombre, U.Apellido, U.DNI, U.Telefono, U.Email, U.Activo FROM Usuarios U INNER JOIN Roles R ON R.Id = U.TipoUser WHERE U.Id = @Id AND U.TipoUser IN (1, 2)");
                datos.setearParametro("@Id", id);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    Usuario aux = new Usuario();
                    aux.Id = (int)datos.Lector["Id"];
                    aux.User = (string)datos.Lector["Usuario"];
                    aux.Pass = (string)datos.Lector["Pass"];
                    aux.TipoUsuario = (TipoUsuario)(int)datos.Lector["TipoUser"];
                    aux.Rol = (string)datos.Lector["Rol"];
                    aux.Nombre = datos.Lector["Nombre"] == DBNull.Value ? "" : (string)datos.Lector["Nombre"];
                    aux.Apellido = datos.Lector["Apellido"] == DBNull.Value ? "" : (string)datos.Lector["Apellido"];
                    aux.DNI = datos.Lector["DNI"] == DBNull.Value ? "" : (string)datos.Lector["DNI"];
                    aux.Telefono = datos.Lector["Telefono"] == DBNull.Value ? "" : (string)datos.Lector["Telefono"];
                    aux.Email = datos.Lector["Email"] == DBNull.Value ? "" : (string)datos.Lector["Email"];
                    aux.Activo = (bool)datos.Lector["Activo"];

                    return aux;
                }

                return null;
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

        public void cambiarEstadoPersonalAdministrativo(int id)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("UPDATE Usuarios SET Activo = CASE WHEN Activo = 1 THEN 0 ELSE 1 END WHERE Id = @Id AND TipoUser IN (1, 2)");
                datos.setearParametro("@Id", id);
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

        public List<Usuario> listarPersonalAdministrativo()
        {
            List<Usuario> lista = new List<Usuario>();
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("SELECT U.Id, U.Usuario, U.TipoUser, R.Nombre AS Rol, U.Nombre, U.Apellido, U.DNI, U.Telefono, U.Email, U.Activo FROM Usuarios U INNER JOIN Roles R ON R.Id = U.TipoUser WHERE U.TipoUser IN (1, 2) ORDER BY U.Apellido, U.Nombre");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Usuario aux = new Usuario();
                    aux.Id = (int)datos.Lector["Id"];
                    aux.User = (string)datos.Lector["Usuario"];
                    aux.TipoUsuario = (TipoUsuario)(int)datos.Lector["TipoUser"];
                    aux.Rol = (string)datos.Lector["Rol"];
                    aux.Nombre = datos.Lector["Nombre"] == DBNull.Value ? "" : (string)datos.Lector["Nombre"];
                    aux.Apellido = datos.Lector["Apellido"] == DBNull.Value ? "" : (string)datos.Lector["Apellido"];
                    aux.DNI = datos.Lector["DNI"] == DBNull.Value ? "" : (string)datos.Lector["DNI"];
                    aux.Telefono = datos.Lector["Telefono"] == DBNull.Value ? "" : (string)datos.Lector["Telefono"];
                    aux.Email = datos.Lector["Email"] == DBNull.Value ? "" : (string)datos.Lector["Email"];
                    aux.Activo = (bool)datos.Lector["Activo"];

                    lista.Add(aux);
                }

                return lista;
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
        public bool cambiarPassword(int idUsuario, string passwordActual, string passwordNueva)
        {
            AccesoDatos datos = new AccesoDatos();

            try
            {
                datos.setearConsulta("UPDATE Usuarios SET Pass = @PasswordNueva WHERE Id = @Id AND Pass = @PasswordActual AND Activo = 1; SELECT @@ROWCOUNT;");
                datos.setearParametro("@Id", idUsuario);
                datos.setearParametro("@PasswordActual", passwordActual);
                datos.setearParametro("@PasswordNueva", passwordNueva);

                return datos.ejecutarAccionScalar() > 0;
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