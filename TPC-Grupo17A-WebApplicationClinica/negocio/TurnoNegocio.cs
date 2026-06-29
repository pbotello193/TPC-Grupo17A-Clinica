using dominio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace negocio
{
    public class TurnoNegocio
    {
        private AccesoDatos datos = new AccesoDatos();

        public void agregar(Turno nuevo)
        {
            // Validar que el turno no esté vencido (Fecha y hora de inicio deben ser a futuro)
            DateTime fechaTurnoCompleta = nuevo.Fecha.Date + nuevo.HoraInicio;
            if (fechaTurnoCompleta <= DateTime.Now)
            {
                throw new Exception("No se puede registrar un turno para una fecha u hora que ya ha pasado.");
            }

            // Validar que el médico no tenga otro turno el mismo día a la misma hora
            if (!validarDisponibilidadMedico(nuevo.Medico.Id, nuevo.Fecha, nuevo.HoraInicio))
            {
                throw new Exception("El médico seleccionado ya tiene un turno asignado para ese día y horario.");
            }

            // Validar que el paciente no tenga otro turno el mismo día a la misma hora
            if (!validarDisponibilidadPaciente(nuevo.Paciente.Id, nuevo.Fecha, nuevo.HoraInicio))
            {
                throw new Exception("El paciente ya tiene un turno agendado para ese día y horario.");
            }

            // Si pasa las validaciones, procedemos al insert
            AccesoDatos datosInsercion = new AccesoDatos();
            try
            {
                string consulta = "INSERT INTO Turnos (Fecha, HoraInicio, HoraFin, Observaciones, IdPaciente, IdMedico, IdEspecialidad, Estado) " +
                                  "OUTPUT INSERTED.ID " +
                                  "VALUES (@Fecha, @HoraInicio, @HoraFin, @Observaciones, @IdPaciente, @IdMedico, @IdEspecialidad, @Estado)";

                datosInsercion.setearConsulta(consulta);
                datosInsercion.setearParametro("@Fecha", nuevo.Fecha);
                datosInsercion.setearParametro("@HoraInicio", nuevo.HoraInicio);
                datosInsercion.setearParametro("@HoraFin", nuevo.HoraFin);
                datosInsercion.setearParametro("@Observaciones", nuevo.Observaciones ?? "");
                datosInsercion.setearParametro("@IdPaciente", nuevo.Paciente.Id);
                datosInsercion.setearParametro("@IdMedico", nuevo.Medico.Id);
                datosInsercion.setearParametro("@IdEspecialidad", nuevo.Especialidad.Id);
                datosInsercion.setearParametro("@Estado", nuevo.Estado ?? "Pendiente");

                // El método ejecutarAccionScalar nos devuelve el ID generado por IDENTITY
                nuevo.Id = datosInsercion.ejecutarAccionScalar();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datosInsercion.cerrarConexion();
            }
        }

        public bool validarDisponibilidadMedico(int idMedico, DateTime fecha, TimeSpan horaInicio)
        {
            AccesoDatos datosAux = new AccesoDatos();
            try
            {
                // Solo contamos turnos que no estén cancelados
                string consulta = "SELECT COUNT(*) FROM Turnos WHERE IdMedico = @IdMedico AND Fecha = @Fecha AND HoraInicio = @HoraInicio AND Estado <> 'Cancelado'";
                datosAux.setearConsulta(consulta);
                datosAux.setearParametro("@IdMedico", idMedico);
                datosAux.setearParametro("@Fecha", fecha);
                datosAux.setearParametro("@HoraInicio", horaInicio);

                return datosAux.ejecutarAccionScalar() == 0;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datosAux.cerrarConexion();
            }
        }

        public bool validarDisponibilidadPaciente(int idPaciente, DateTime fecha, TimeSpan horaInicio)
        {
            AccesoDatos datosAux = new AccesoDatos();
            try
            {
                // Solo contamos turnos que no estén cancelados
                string consulta = "SELECT COUNT(*) FROM Turnos WHERE IdPaciente = @IdPaciente AND Fecha = @Fecha AND HoraInicio = @HoraInicio AND Estado <> 'Cancelado'";
                datosAux.setearConsulta(consulta);
                datosAux.setearParametro("@IdPaciente", idPaciente);
                datosAux.setearParametro("@Fecha", fecha);
                datosAux.setearParametro("@HoraInicio", horaInicio);

                return datosAux.ejecutarAccionScalar() == 0;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datosAux.cerrarConexion();
            }
        }
    }
}
