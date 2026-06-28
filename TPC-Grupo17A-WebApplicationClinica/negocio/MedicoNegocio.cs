using dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using static System.Collections.Specialized.BitVector32;

namespace negocio
{
    public class MedicoNegocio
    {
        List<Medico> medicos = new List<Medico>();
        AccesoDatos datos = new AccesoDatos();

        public List<Medico> listarMedicosActivos()
        {
            try
            {
                string consulta = "select id, apellido, nombre, matricula, telefono, email, activo from Medicos WHERE Activo = 1 ORDER BY Apellido ASC";
                datos.setearConsulta(consulta);
                datos.ejecutarLectura();
                EspecialidadNegocio especialidadNegocio = new EspecialidadNegocio();

                while (datos.Lector.Read())
                {
                    Medico aux = new Medico();
                    aux.Id = (int)datos.Lector["Id"];
                    aux.Apellido = (string)datos.Lector["Apellido"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Matricula = (string)datos.Lector["Matricula"];
                    aux.Telefono = (string)datos.Lector["Telefono"];
                    aux.Email = (string)datos.Lector["Email"];
                    aux.Activo = (bool)datos.Lector["Activo"];

                    aux.Especialidades = especialidadNegocio.listarPorMedico(aux.Id);

                    medicos.Add(aux);
                }

                return medicos;
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
        public List<Medico> listarMedicosInactivos()
        {
            try
            {
                string consulta = "select id, apellido, nombre, matricula, telefono, email, activo from Medicos WHERE Activo = 0 ORDER BY Apellido ASC";
                datos.setearConsulta(consulta);
                datos.ejecutarLectura();
                EspecialidadNegocio especialidadNegocio = new EspecialidadNegocio();

                while (datos.Lector.Read())
                {
                    Medico aux = new Medico();
                    aux.Id = (int)datos.Lector["Id"];
                    aux.Apellido = (string)datos.Lector["Apellido"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Matricula = (string)datos.Lector["Matricula"];
                    aux.Telefono = (string)datos.Lector["Telefono"];
                    aux.Email = (string)datos.Lector["Email"];
                    aux.Activo = (bool)datos.Lector["Activo"];

                    aux.Especialidades = especialidadNegocio.listarPorMedico(aux.Id);

                    medicos.Add(aux);
                }

                return medicos;
            }
            catch (Exception ex)
            {

                throw;
            }

        }
        public List<Medico> listarMedicosCompleto()
        {
            try
            {
                string consulta = "select id, apellido, nombre, matricula, telefono, email, activo from Medicos ORDER BY Activo DESC, Apellido ASC";
                datos.setearConsulta(consulta);
                datos.ejecutarLectura();
                EspecialidadNegocio especialidadNegocio = new EspecialidadNegocio();

                while (datos.Lector.Read())
                {
                    Medico aux = new Medico();
                    aux.Id = (int)datos.Lector["Id"];
                    aux.Apellido = (string)datos.Lector["Apellido"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Matricula = (string)datos.Lector["Matricula"];
                    aux.Telefono = (string)datos.Lector["Telefono"];
                    aux.Email = (string)datos.Lector["Email"];
                    aux.Activo = (bool)datos.Lector["Activo"];
                    aux.Especialidades = especialidadNegocio.listarPorMedico(aux.Id);

                    medicos.Add(aux);
                }

                return medicos;
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
        public bool validarMatricula(string matricula, int id = 0) //el = 0 es para que si no manda id usa ese valor(en caso de agregar)
        {
            // Método para verificar si ya existe una matrícula (exceptuando el id en caso de modificación)
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearConsulta("SELECT COUNT(*) FROM Medicos WHERE Matricula = @Matricula AND Id <> @Id");
                datos.setearParametro("@Matricula", matricula);
                datos.setearParametro("@Id", id);
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
        public int agregar(Medico nuevo)
        {
            try
            {
                
                datos.setearConsulta("INSERT INTO Medicos(Nombre, Apellido, Matricula, Telefono, Email) OUTPUT INSERTED.ID VALUES(@Nombre, @Apellido, @Matricula, @Telefono, @Email)");
                datos.setearParametro("@Nombre", nuevo.Nombre);
                datos.setearParametro("@Apellido", nuevo.Apellido);
                datos.setearParametro("@Matricula", nuevo.Matricula);
                if (validarMatricula(nuevo.Matricula, nuevo.Id))
                    throw new Exception("Ya existe un médico con esa matrícula.");
                datos.setearParametro("@Telefono", nuevo.Telefono);
                datos.setearParametro("@Email", nuevo.Email);

                return datos.ejecutarAccionScalar(); //Prueba a ver si devuelve el id

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

        public void modificar(Medico modificar)
        {
            try
            {
                datos.setearConsulta("UPDATE Medicos set Nombre = @Nombre, Apellido = @Apellido, Matricula = @Matricula, Telefono = @Telefono, Email = @Email, Activo = @Activo where Id=@Id");
                datos.setearParametro("@Id", modificar.Id);
                datos.setearParametro("@Nombre", modificar.Nombre);
                datos.setearParametro("@Apellido", modificar.Apellido);
                datos.setearParametro("@Matricula", modificar.Matricula);
                if (validarMatricula(modificar.Matricula, modificar.Id))
                    throw new InvalidOperationException("Ya existe un médico con esa matrícula.");
                datos.setearParametro("@Telefono", modificar.Telefono);
                datos.setearParametro("@Email", modificar.Email);
                datos.setearParametro("@Activo", modificar.Activo);

                datos.ejecutarAccion();

            }
            catch (Exception ex)
            {
                throw ex;

            }
            finally { datos.cerrarConexion(); }
        }
        public void eliminarLogico(int id)
        {
            try
            {
                datos.setearConsulta("UPDATE Medicos SET Activo = 0 WHERE Id = @Id");
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
        


    }


}

