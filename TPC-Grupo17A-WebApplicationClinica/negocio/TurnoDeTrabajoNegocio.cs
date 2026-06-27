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
                datos.setearConsulta("SELECT Id, IdMedico, DiaDeLaSemana, HoraInicio, HoraFin, Activo FROM TurnosDeTrabajo WHERE IdMedico = @IdMedico ORDER BY DiaDeLaSemana ASC, HoraInicio ASC");
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
                    aux.Activo = (bool)datos.Lector["Activo"];
                    turnosDeTrabajo.Add(aux);
                }
                return turnosDeTrabajo;
            }
            catch (Exception ex)
            {
                throw new Exception("No se pudieron cargar los turnos de trabajo del médico seleccionado. Por favor, reintente en unos momentos.", ex);
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
                nuevo.Validar(); // valido los datos del turno de trabajo antes de intentar insertarlo en la base de datos

                datos.setearConsulta("INSERT INTO TurnosDeTrabajo (IdMedico, DiaDeLaSemana, HoraInicio, HoraFin, Activo) VALUES (@IdMedico, @DiaDeLaSemana, @HoraInicio, @HoraFin, @Activo)");
                datos.setearParametro("@IdMedico", nuevo.IdMedico);
                datos.setearParametro("@DiaDeLaSemana", (int)nuevo.DiaDeLaSemana);
                datos.setearParametro("@HoraInicio", nuevo.HoraInicio);
                datos.setearParametro("@HoraFin", nuevo.HoraFin);
                datos.setearParametro("@Activo", nuevo.Activo);
                datos.ejecutarAccion();
            }
            catch (ArgumentException ex)
            {
                throw new Exception("Datos del turno incorrectos: " + ex.Message, ex);
            }
            catch (Exception ex)
            {
                throw new Exception("Ocurrió un error al intentar registrar el nuevo turno de trabajo. Verifique la conexión con el servidor.", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
        public void modificar(TurnoDeTrabajo turnoModificar)
        {
            try
            {
                turnoModificar.Validar(); // valido los datos del turno de trabajo antes de intentar modificarlo en la base de datos

                datos.setearConsulta("UPDATE TurnosDeTrabajo SET DiaDeLaSemana = @DiaDeLaSemana, HoraInicio = @HoraInicio, HoraFin = @HoraFin WHERE Id = @Id");
                datos.setearParametro("@Id", turnoModificar.Id);
                datos.setearParametro("@DiaDeLaSemana", (int)turnoModificar.DiaDeLaSemana);
                datos.setearParametro("@HoraInicio", turnoModificar.HoraInicio);
                datos.setearParametro("@HoraFin", turnoModificar.HoraFin);
                datos.ejecutarAccion();
            }
            catch (ArgumentException ex)
            {
                throw new Exception("No se pudo modificar el turno de trabajo: " + ex.Message, ex);
            }
            catch (Exception ex)
            {
                throw new Exception("Ocurrió un error al intentar guardar los cambios del turno de trabajo. Intente nuevamente.", ex);
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
                datos.setearProcedimiento("SP_EliminarLogicoTurnoDeTrabajo");
                datos.setearParametro("@Id", id);
                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw new Exception("No se pudo eliminar el turno de trabajo. Compruebe que no tenga turnos médicos agendados asociados a este horario.", ex);
            }
            finally
            {
                datos.cerrarConexion();

            }
        }
    }
}
