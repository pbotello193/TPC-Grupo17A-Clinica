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
        public List<TurnoDeTrabajo> listarPorMedico(int idMedico, string estado = "activos")
        {
            List<TurnoDeTrabajo> turnosDeTrabajo = new List<TurnoDeTrabajo>();
            try
            {
                string consulta = "SELECT T.Id, T.IdMedico, T.DiaDeLaSemana, T.HoraInicio, T.HoraFin, T.Activo, " +
                          "E.Id AS IdEspecialidad, E.Nombre AS NombreEspecialidad " +
                          "FROM TurnosDeTrabajo T " +
                          "INNER JOIN Especialidades E ON T.IdEspecialidad = E.Id " +
                          "WHERE T.IdMedico = @IdMedico";

                if (estado == "activos")
                {
                    consulta += " AND T.Activo = 1";
                }
                else if (estado == "inactivos")
                {
                    consulta += " AND T.Activo = 0";
                }

                consulta += " ORDER BY T.DiaDeLaSemana ASC, T.HoraInicio ASC";

                datos.setearConsulta(consulta);
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
                    aux.Especialidad = new Especialidad();
                    aux.Especialidad.Id = (int)datos.Lector["IdEspecialidad"];
                    aux.Especialidad.Nombre = (string)datos.Lector["NombreEspecialidad"];
                    
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

        public List<TurnoDeTrabajo> listarPorEspecialidad(int idEspecialidad)
        {
            List<TurnoDeTrabajo> turnos = new List<TurnoDeTrabajo>();
            return turnos;
        }

        public void agregar(TurnoDeTrabajo nuevo)
        {
            try
            {
                nuevo.Validar(); // valido los datos del turno de trabajo antes de intentar insertarlo en la base de datos

                datos.setearConsulta("INSERT INTO TurnosDeTrabajo (IdMedico, IdEspecialidad, DiaDeLaSemana, HoraInicio, HoraFin, Activo) VALUES (@IdMedico,@IdEspecialidad, @DiaDeLaSemana, @HoraInicio, @HoraFin, @Activo)");
                datos.setearParametro("@IdMedico", nuevo.IdMedico);
                datos.setearParametro("@IdEspecialidad", nuevo.Especialidad.Id);
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

                datos.setearConsulta("UPDATE TurnosDeTrabajo SET IdEspecialidad = @IdEspecialidad, DiaDeLaSemana = @DiaDeLaSemana, HoraInicio = @HoraInicio, HoraFin = @HoraFin WHERE Id = @Id");
                datos.setearParametro("@Id", turnoModificar.Id);
                datos.setearParametro("@IdEspecialidad", turnoModificar.Especialidad.Id);
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
                datos.setearConsulta("UPDATE TurnosDeTrabajo SET Activo = 0 WHERE Id = @Id");
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
        public void activar(int id)
        {
            try
            {
                datos.setearConsulta("UPDATE TurnosDeTrabajo SET Activo = 1 WHERE Id = @Id");
                datos.setearParametro("@Id", id);
                datos.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw new Exception("No se pudo activar el turno de trabajo.", ex);
            }
            finally
            {
                datos.cerrarConexion();
            }
        }
    }
}
