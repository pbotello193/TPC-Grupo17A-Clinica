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

        public List<Turno> listar()
        {
            List<Turno> lista = new List<Turno>();
            try
            {
                string consulta = "SELECT T.Id, T.Fecha, T.HoraInicio, T.HoraFin, T.Observaciones, T.Estado, " +
                                  "P.Id AS IdPaciente, P.Nombre AS NombrePaciente, P.Apellido AS ApellidoPaciente, P.Email AS EmailPaciente, P.DNI AS DniPaciente, P.Telefono AS TelefonoPaciente, " +
                                  "M.Id AS IdMedico, M.Nombre AS NombreMedico, M.Apellido AS ApellidoMedico, M.Matricula AS MatriculaMedico, M.Telefono AS TelefonoMedico, M.Email AS EmailMedico, " +
                                  "E.Id AS IdEspecialidad, E.Nombre AS NombreEspecialidad " +
                                  "FROM Turnos T " +
                                  "INNER JOIN Pacientes P ON T.IdPaciente = P.Id " +
                                  "INNER JOIN Medicos M ON T.IdMedico = M.Id " +
                                  "INNER JOIN Especialidades E ON T.IdEspecialidad = E.Id " +
                                  "ORDER BY T.Fecha DESC, T.HoraInicio DESC";
                datos.setearConsulta(consulta);
                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    Turno aux = new Turno();
                    aux.Id = (int)datos.Lector["Id"];
                    aux.Fecha = (DateTime)datos.Lector["Fecha"];
                    aux.HoraInicio = (TimeSpan)datos.Lector["HoraInicio"];
                    aux.HoraFin = (TimeSpan)datos.Lector["HoraFin"];
                    aux.Observaciones = (string)datos.Lector["Observaciones"];
                    aux.Estado = (string)datos.Lector["Estado"];
                    aux.Paciente = new Paciente
                    {
                        Id = (int)datos.Lector["IdPaciente"],
                        Nombre = (string)datos.Lector["NombrePaciente"],
                        Apellido = (string)datos.Lector["ApellidoPaciente"],
                        Email = (string)datos.Lector["EmailPaciente"],
                        Dni = (string)datos.Lector["DniPaciente"],
                        Telefono = (string)datos.Lector["TelefonoPaciente"]
                    };
                    aux.Medico = new Medico
                    {
                        Id = (int)datos.Lector["IdMedico"],
                        Nombre = (string)datos.Lector["NombreMedico"],
                        Apellido = (string)datos.Lector["ApellidoMedico"],
                        Matricula = (string)datos.Lector["MatriculaMedico"],
                        Telefono = (string)datos.Lector["TelefonoMedico"],
                        Email = (string)datos.Lector["EmailMedico"]
                    };
                    aux.Especialidad = new Especialidad
                    {
                        Id = (int)datos.Lector["IdEspecialidad"],
                        Nombre = (string)datos.Lector["NombreEspecialidad"]
                    };
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
