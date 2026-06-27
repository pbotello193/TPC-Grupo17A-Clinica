using dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Security.Policy;
using System.Text;
using System.Threading.Tasks;
using static System.Collections.Specialized.BitVector32;

namespace negocio
{
    public class EspecialidadNegocio
    {
        AccesoDatos datos = new AccesoDatos();

        public List<Especialidad> listarEspecialidades()
        {
            List<Especialidad> especialidades = new List<Especialidad>();
            try
            {
                datos.setearConsulta("select Id, Nombre, Descripcion from Especialidades");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Especialidad aux = new Especialidad();
                    aux.Id = (int)datos.Lector["Id"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Descripcion = (string)datos.Lector["Descripcion"];

                    especialidades.Add(aux);
                }
                return especialidades;
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
        public void agregar(Especialidad nuevo)
        {
            try
            {
                datos.setearConsulta("INSERT INTO Especialidades(Nombre, Descripcion) VALUES(@Nombre, @Descripcion)");
                datos.setearParametro("@Nombre", nuevo.Nombre);
                datos.setearParametro("@Descripcion", nuevo.Descripcion);

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

        public void modificar(Especialidad modificar)
        {
            try
            {
                datos.setearConsulta("UPDATE Especialidades set Nombre = @Nombre, Descripcion = @Descripcion where Id=@Id");
                datos.setearParametro("@Id", modificar.Id);
                datos.setearParametro("@Nombre", modificar.Nombre);
                datos.setearParametro("@Descripcion", modificar.Descripcion);

                datos.ejecutarAccion();

            }
            catch (Exception ex)
            {
                throw ex;

            }
            finally { datos.cerrarConexion(); }
        }

        public List<Especialidad> listarPorMedico(int idMedico)
        {
            List<Especialidad> listaFiltrada = new List<Especialidad>();
            AccesoDatos datosLista = new AccesoDatos();

            try
            {
                string consulta = "SELECT E.Id, E.Nombre, E.Descripcion FROM Especialidades E INNER JOIN MedicoEspecialidad ME ON E.Id = ME.IdEspecialidad WHERE ME.IdMedico = @IdMedico";

                datosLista.setearConsulta(consulta);
                datosLista.setearParametro("@IdMedico", idMedico);
                datosLista.ejecutarLectura();

                while (datosLista.Lector.Read())
                {
                    Especialidad aux = new Especialidad();
                    aux.Id = (int)datosLista.Lector["Id"];
                    aux.Nombre = (string)datosLista.Lector["Nombre"];

                    if (!(datosLista.Lector["Descripcion"] is DBNull))
                        aux.Descripcion = (string)datosLista.Lector["Descripcion"];

                    listaFiltrada.Add(aux);
                }

                return listaFiltrada;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datosLista.cerrarConexion();
            }
        }


        public void resetearEspecialidades(int idMedico)
        {
            //Para borrar las especialidades asociadas a un medico antes de actualizarlas
            AccesoDatos datosLocal = new AccesoDatos();
            try
            {
                datosLocal.setearConsulta("DELETE FROM MedicoEspecialidad WHERE IdMedico = @IdMedico");
                datosLocal.setearParametro("@IdMedico", idMedico);

                datosLocal.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datosLocal.cerrarConexion();
            }
        }

        public void asignarEspecialidad(int idMedico, int idEspecialidad)
        {
            //Para guardar las especialidades de un medico
            AccesoDatos datosLocal = new AccesoDatos();
            try
            {
                datosLocal.setearConsulta("INSERT INTO MedicoEspecialidad (IdMedico, IdEspecialidad) VALUES (@IdMedico, @IdEspecialidad)");
                datosLocal.setearParametro("@IdMedico", idMedico);
                datosLocal.setearParametro("@IdEspecialidad", idEspecialidad);

                datosLocal.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datosLocal.cerrarConexion();
            }
        }

        public bool existeEspecialidad(string nombre, int idEspecialidad = 0)
        {
            AccesoDatos datos = new AccesoDatos();
            try
            {
                //verifica si no hay otra esp. con el mismo nombre (exceptuar el id de la actual si es modificacion)
                datos.setearConsulta("SELECT COUNT(*) FROM Especialidades WHERE Nombre = @Nombre AND Id <> @Id");
                datos.setearParametro("@Nombre", nombre);
                datos.setearParametro("@Id", idEspecialidad);
                datos.ejecutarLectura();

                if (datos.Lector.Read())
                {
                    int cantidad = Convert.ToInt32(datos.Lector[0]);
                    return cantidad > 0;
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
    }
}

