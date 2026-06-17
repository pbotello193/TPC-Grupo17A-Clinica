using dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace negocio
{
    public class TurnoDeTrabajoNegocio
    {
        private AccesoDatos datos = new AccesoDatos();
        public List<TurnoDeTrabajo> listarPorMedico(int idMedico)
        {
            List<TurnoDeTrabajo> turnosDeTrabajo = new List<TurnoDeTrabajo>();
            try
            {
                datos.setearConsulta("SELECT Id, IdMedico, DiaDeLaSemana, HoraInicio, HoraFin FROM TurnosDeTrabajo WHERE IdMedico = @IdMedico ORDER BY DiaDeLaSemana ASC, HoraInicio ASC");
                datos.setearParametro("@IdMedico", idMedico);
                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    TurnoDeTrabajo aux = new TurnoDeTrabajo();
                    aux.Id = (int)datos.Lector["Id"];
                    aux.IdMedico = (int)datos.Lector["IdMedico"];
                    aux.DiaDeLaSemana = (DayOfWeek)(int)datos.Lector["DiaDeLaSemana"];
                    aux.HoraInicio = (TimeSpan)datos.Lector["HoraInicio"];
                    aux.HoraFin = (TimeSpan)datos.Lector["HoraFin"];
                    turnosDeTrabajo.Add(aux);
                }
                return turnosDeTrabajo;
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
        public void agregar(TurnoDeTrabajo nuevo)
        {
            try
            {
                datos.setearConsulta("INSERT INTO TurnosDeTrabajo (IdMedico, DiaDeLaSemana, HoraInicio, HoraFin) VALUES (@IdMedico, @DiaDeLaSemana, @HoraInicio, @HoraFin)");
                datos.setearParametro("@IdMedico", nuevo.IdMedico);
                datos.setearParametro("@DiaDeLaSemana", (int)nuevo.DiaDeLaSemana);
                datos.setearParametro("@HoraInicio", nuevo.HoraInicio);
                datos.setearParametro("@HoraFin", nuevo.HoraFin);
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
        public void modificar(TurnoDeTrabajo t)
        {
            try
            {
                datos.setearConsulta("UPDATE TurnosDeTrabajo SET DiaDeLaSemana = @DiaDeLaSemana, HoraInicio = @HoraInicio, HoraFin = @HoraFin WHERE Id = @Id");
                datos.setearParametro("@Id", t.Id);
                datos.setearParametro("@DiaDeLaSemana", (int)t.DiaDeLaSemana);
                datos.setearParametro("@HoraInicio", t.HoraInicio);
                datos.setearParametro("@HoraFin", t.HoraFin);
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
        public void eliminar(int id)
        {
            try
            {
                datos.setearConsulta("DELETE FROM TurnosDeTrabajo WHERE Id = @Id");
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
