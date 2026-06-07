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

        public List<Medico> listarMedicos()
        {
            try
            {
                datos.setearConsulta("select id, nombre, apellido, matricula, telefono, email from Medicos");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Medico aux = new Medico();
                    aux.Id = (int)datos.Lector["Id"];
                    aux.Nombre = (string)datos.Lector["Nombre"];
                    aux.Apellido = (string)datos.Lector["Apellido"];
                    aux.Matricula = (string)datos.Lector["Matricula"];
                    aux.Telefono = (string)datos.Lector["Telefono"];
                    aux.Email = (string)datos.Lector["Email"];

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
        public void agregar(Medico nuevo)
        {
            try
            {
                datos.setearConsulta("INSERT INTO Medicos(Nombre, Apellido, Matricula, Telefono, Email) VALUES(@Nombre, @Apellido, @Matricula, @Telefono, @Email)");
                datos.setearParametro("@Nombre", nuevo.Nombre);
                datos.setearParametro("@Apellido", nuevo.Apellido);
                datos.setearParametro("@Matricula", nuevo.Matricula);
                datos.setearParametro("@Telefono", nuevo.Telefono);
                datos.setearParametro("@Email", nuevo.Email);

                datos.ejecutarLectura();

            }
            catch (Exception ex)
            {
                throw new ApplicationException("Error al agregar el artículo.", ex);
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
                datos.setearConsulta("UPDATE Medicos set Nombre = @Nombre, Apellido = @Apellido, Matricula = @Matricula, Telefono = @Telefono, Email = @Email where Id=@Id");
                datos.setearParametro("@Id", modificar.Id);
                datos.setearParametro("@Nombre", modificar.Nombre);
                datos.setearParametro("@Apellido", modificar.Apellido);
                datos.setearParametro("@Matricula", modificar.Matricula);
                datos.setearParametro("@Telefono", modificar.Telefono);
                datos.setearParametro("@Email", modificar.Email);

                datos.ejecutarAccion();
                datos.cerrarConexion();

            }
            catch (Exception ex)
            {
                throw ex;

            }
            finally { datos.cerrarConexion(); }
        }
    }


}

