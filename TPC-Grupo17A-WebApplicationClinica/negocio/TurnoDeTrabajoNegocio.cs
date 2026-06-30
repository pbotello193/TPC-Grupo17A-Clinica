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
            //creo uno local porque me genera conflicto al consumirlo desde turnos usando foreach
            AccesoDatos datosLista = new AccesoDatos(); 
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

                datosLista.setearConsulta(consulta);
                datosLista.setearParametro("@IdMedico", idMedico);
                datosLista.ejecutarLectura();
                while (datosLista.Lector.Read())
                {
                    TurnoDeTrabajo aux = new TurnoDeTrabajo();

                    aux.Id = (int)datosLista.Lector["Id"];
                    aux.IdMedico = (int)datosLista.Lector["IdMedico"];
                    aux.DiaDeLaSemana = (DayOfWeek)(int)datosLista.Lector["DiaDeLaSemana"];
                    aux.HoraInicio = (TimeSpan)datosLista.Lector["HoraInicio"];
                    aux.HoraFin = (TimeSpan)datosLista.Lector["HoraFin"];
                    aux.Activo = (bool)datosLista.Lector["Activo"];
                    aux.Especialidad = new Especialidad();
                    aux.Especialidad.Id = (int)datosLista.Lector["IdEspecialidad"];
                    aux.Especialidad.Nombre = (string)datosLista.Lector["NombreEspecialidad"];
                    
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

                // valido que no se superponga con otro turno activo del mismo medico
                if (verificarSuperposicion(nuevo))
                {
                    throw new ArgumentException("El médico ya tiene asignado un turno de trabajo activo que se superpone con este rango horario.");
                }

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

                // valido que no se superponga con otro turno activo del mismo medico
                if (verificarSuperposicion(turnoModificar))
                {
                    throw new ArgumentException("El médico ya tiene asignado un turno de trabajo activo que se superpone con este rango horario.");
                }

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

                // antes de activar el turno validamos que no se superponga con otro activo
                TurnoDeTrabajo turno = obtenerPorId(id);
                if (turno != null)
                {
                    turno.Activo = true; // le pongo true para que pueda verificar con el otro activo porque la otra funcion solo compara activos
                    if (verificarSuperposicion(turno))
                    {
                        throw new ArgumentException("No se puede activar este turno de trabajo porque se superpone con otro turno activo del mismo médico.");
                    }
                }

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

        public bool verificarSuperposicion(TurnoDeTrabajo nuevo)
        {
            List<TurnoDeTrabajo> turnosExistentes = listarPorMedico(nuevo.IdMedico, "activos");
            foreach (var turno in turnosExistentes)
            {
                // se omite el turno que estamos modificando
                if (turno.Id == nuevo.Id)
                    continue;
                // primero vemos si coincide con el dia
                if (turno.DiaDeLaSemana == nuevo.DiaDeLaSemana)
                {
                    if (nuevo.HoraInicio < turno.HoraFin && nuevo.HoraFin > turno.HoraInicio)
                    {
                        return true; // si las dos condiciones son true hay conflicto de horarios
                    }
                }
            }
            return false; // no hay superposición
        }
        private TurnoDeTrabajo obtenerPorId(int id)
        {
            AccesoDatos datosAux = new AccesoDatos();
            try
            {
                datosAux.setearConsulta("SELECT T.Id, T.IdMedico, T.DiaDeLaSemana, T.HoraInicio, T.HoraFin, T.Activo, " +
                                       "E.Id AS IdEspecialidad, E.Nombre AS NombreEspecialidad " +
                                       "FROM TurnosDeTrabajo T " +
                                       "INNER JOIN Especialidades E ON T.IdEspecialidad = E.Id " +
                                       "WHERE T.Id = @Id");
                datosAux.setearParametro("@Id", id);
                datosAux.ejecutarLectura();
                if (datosAux.Lector.Read())
                {
                    TurnoDeTrabajo aux = new TurnoDeTrabajo();
                    aux.Id = (int)datosAux.Lector["Id"];
                    aux.IdMedico = (int)datosAux.Lector["IdMedico"];
                    aux.DiaDeLaSemana = (DayOfWeek)(int)datosAux.Lector["DiaDeLaSemana"];
                    aux.HoraInicio = (TimeSpan)datosAux.Lector["HoraInicio"];
                    aux.HoraFin = (TimeSpan)datosAux.Lector["HoraFin"];
                    aux.Activo = (bool)datosAux.Lector["Activo"];
                    aux.Especialidad = new Especialidad();
                    aux.Especialidad.Id = (int)datosAux.Lector["IdEspecialidad"];
                    aux.Especialidad.Nombre = (string)datosAux.Lector["NombreEspecialidad"];
                    return aux;
                }
                return null;
            }
            finally
            {
                datosAux.cerrarConexion();
            }
        }

    }
}
