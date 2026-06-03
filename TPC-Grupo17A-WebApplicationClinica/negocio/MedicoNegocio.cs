using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using dominio;

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
                datos.setearConsulta("select nombre, apellido, matricula, telefono, email from Medicos");
                datos.ejecutarLectura();

                while (datos.Lector.Read())
                {
                    Medico aux = new Medico();
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
    }
}
