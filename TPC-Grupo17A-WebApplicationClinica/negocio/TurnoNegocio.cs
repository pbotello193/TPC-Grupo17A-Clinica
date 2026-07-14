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
                string consulta = "SELECT T.Id, T.Fecha, T.HoraInicio, T.HoraFin, T.Observaciones, T.Diagnostico, T.Estado, " +
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
                    aux.Diagnostico = datos.Lector["Diagnostico"] == DBNull.Value ? "" : (string)datos.Lector["Diagnostico"];
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

        public List<Turno> listarPorMedico(int idMedico)
        {
            List<Turno> lista = listar();
            return lista.FindAll(x => x.Medico.Id == idMedico);
        }

        public void agregar(Turno nuevo, Usuario usuarioAsignacion) //nuevo parametro apra guardar quien asigno el turno
        {
            nuevo.Estado = "Asignado"; // seteamos el estado inicial del turno como "Asignado"

            //Con esto se setea automaticamente la duracion de una hora a partir de HoraInicio
            nuevo.HoraFin = nuevo.HoraInicio.Add(new TimeSpan(1, 0, 0));

            // Valida que no sea anterior a la fecha actual
            DateTime fechaTurnoCompleta = nuevo.Fecha.Date + nuevo.HoraInicio;
            if (fechaTurnoCompleta <= DateTime.Now)
            {
                throw new Exception("No se puede registrar un turno para una fecha u hora que ya ha pasado");
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
            //guardamos la info de hora y usuario que lo creo
            nuevo.UsuarioAsignacion = usuarioAsignacion;
            nuevo.FechaAsignacion = DateTime.Now;

            // Si pasa las validaciones, procedemos al insert
            AccesoDatos datosInsercion = new AccesoDatos();
            try
            {
                string consulta = "INSERT INTO Turnos (Fecha, HoraInicio, HoraFin, Observaciones, IdPaciente, IdMedico, IdEspecialidad, Estado, FechaAsignacion, IdUsuarioAsignacion) " +
                                  "OUTPUT INSERTED.ID " +
                                  "VALUES (@Fecha, @HoraInicio, @HoraFin, @Observaciones, @IdPaciente, @IdMedico, @IdEspecialidad, @Estado, @FechaAsignacion, @IdUsuarioAsignacion)";

                datosInsercion.setearConsulta(consulta);
                datosInsercion.setearParametro("@Fecha", nuevo.Fecha);
                datosInsercion.setearParametro("@HoraInicio", nuevo.HoraInicio);
                datosInsercion.setearParametro("@HoraFin", nuevo.HoraFin);
                datosInsercion.setearParametro("@Observaciones", nuevo.Observaciones ?? "");
                datosInsercion.setearParametro("@IdPaciente", nuevo.Paciente.Id);
                datosInsercion.setearParametro("@IdMedico", nuevo.Medico.Id);
                datosInsercion.setearParametro("@IdEspecialidad", nuevo.Especialidad.Id);
                datosInsercion.setearParametro("@Estado", nuevo.Estado);
                datosInsercion.setearParametro("@FechaAsignacion", nuevo.FechaAsignacion);
                datosInsercion.setearParametro("@IdUsuarioAsignacion", nuevo.UsuarioAsignacion.Id);

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
                string consulta = "SELECT COUNT(*) FROM Turnos WHERE IdMedico = @IdMedico AND Fecha = @Fecha AND HoraInicio = @HoraInicio AND Estado NOT IN ('Cancelado', 'Reprogramado')";
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
                string consulta = "SELECT COUNT(*) FROM Turnos WHERE IdPaciente = @IdPaciente AND Fecha = @Fecha AND HoraInicio = @HoraInicio AND Estado NOT IN ('Cancelado', 'Reprogramado')";
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

        public void cambiarEstado(int id, string estado, string diagnostico = null)
        {
            AccesoDatos datosUpdate = new AccesoDatos();
            try
            {
                // se construye la consulta
                string consulta = "UPDATE Turnos SET Estado = @Estado";
                if (diagnostico != null)
                {
                    consulta += ", Diagnostico = @Diagnostico";
                }
                consulta += " WHERE Id = @Id";

                // seteamos la consulta (esto limpia parámetros previos en AccesoDatos)
                datosUpdate.setearConsulta(consulta);

                // agregamos los parámetros después de haber seteado la consulta
                datosUpdate.setearParametro("@Estado", estado);
                datosUpdate.setearParametro("@Id", id);
                if (diagnostico != null)
                {
                    datosUpdate.setearParametro("@Diagnostico", diagnostico);
                }
                datosUpdate.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datosUpdate.cerrarConexion();
            }
        }
        public void reprogramarTurno(int idTurno, DateTime nuevaFecha, TimeSpan nuevaHoraInicio, string observaciones)
        {
            //de nuevo para asegurar que guarde el turno de una hora
            TimeSpan nuevaHoraFin = nuevaHoraInicio.Add(new TimeSpan(1, 0, 0));

            AccesoDatos datosUpdate = new AccesoDatos();
            try
            {
                string consulta = "UPDATE Turnos SET Fecha = @Fecha, HoraInicio = @HoraInicio, HoraFin = @HoraFin, Observaciones = @Observaciones, Estado = 'Reprogramado' WHERE Id = @Id";

                datosUpdate.setearConsulta(consulta);
                datosUpdate.setearParametro("@Fecha", nuevaFecha);
                datosUpdate.setearParametro("@HoraInicio", nuevaHoraInicio);
                datosUpdate.setearParametro("@HoraFin", nuevaHoraFin);
                datosUpdate.setearParametro("@Observaciones", observaciones ?? "");
                datosUpdate.setearParametro("@Id", idTurno);

                datosUpdate.ejecutarAccion();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                datosUpdate.cerrarConexion();
            }
        }
        public List<Turno> listarPorPaciente(int idPaciente)
        {
            List<Turno> lista = new List<Turno>();
            AccesoDatos datos = new AccesoDatos();
            try
            {
                datos.setearProcedimiento("SP_ListarTurnosPorPaciente");
                datos.setearParametro("@IdPaciente", idPaciente);
                datos.ejecutarLectura();
                while (datos.Lector.Read())
                {
                    Turno aux = new Turno();
                    aux.Id = (int)datos.Lector["Id"];
                    aux.Fecha = (DateTime)datos.Lector["Fecha"];
                    aux.HoraInicio = (TimeSpan)datos.Lector["HoraInicio"];
                    aux.HoraFin = (TimeSpan)datos.Lector["HoraFin"];
                    aux.Observaciones = datos.Lector["Observaciones"] == DBNull.Value ? "" : (string)datos.Lector["Observaciones"];
                    aux.Diagnostico = datos.Lector["Diagnostico"] == DBNull.Value ? "" : (string)datos.Lector["Diagnostico"];
                    aux.Estado = (string)datos.Lector["Estado"];
                    aux.FechaAsignacion = (DateTime)datos.Lector["FechaAsignacion"];

                    aux.Paciente = new Paciente
                    {
                        Id = (int)datos.Lector["IdPaciente"],
                        Nombre = (string)datos.Lector["NombrePaciente"],
                        Apellido = (string)datos.Lector["ApellidoPaciente"],
                        Dni = (string)datos.Lector["DniPaciente"],
                        Telefono = (string)datos.Lector["TelefonoPaciente"],
                        Email = (string)datos.Lector["EmailPaciente"]
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

                    //este check es porque como antes no se guardaba esto ahora trae null y rompen
                    if (datos.Lector["IdUsuarioAsignacion"] != DBNull.Value)
                    {
                        aux.UsuarioAsignacion = new Usuario
                        {
                            Id = (int)datos.Lector["IdUsuarioAsignacion"],
                            User = (string)datos.Lector["NombreUsuarioAsignacion"]
                        };
                    }

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
        public List<Turno> listarAgendaMedico(int idMedico)
        {
            List<Turno> lista = new List<Turno>();
            AccesoDatos datosLocal = new AccesoDatos();

            try
            {
                string consulta = "SELECT T.Id, T.Fecha, T.HoraInicio, T.HoraFin, T.Observaciones, T.Estado, P.Id AS IdPaciente, P.Nombre AS NombrePaciente, P.Apellido AS ApellidoPaciente, " +
                                    "E.Id AS IdEspecialidad, E.Nombre AS Especialidad FROM Turnos T INNER JOIN Pacientes P ON P.Id = T.IdPaciente INNER JOIN Especialidades E ON E.Id = T.IdEspecialidad " +
                                    "WHERE T.IdMedico = @IdMedico AND T.Estado IN ('Asignado', 'Reprogramado') ORDER BY T.Fecha, T.HoraInicio";

                datosLocal.setearConsulta(consulta);
                datosLocal.setearParametro("@IdMedico", idMedico);
                datosLocal.ejecutarLectura();

                while (datosLocal.Lector.Read())
                {
                    Turno aux = new Turno();

                    aux.Id = (int)datosLocal.Lector["Id"];
                    aux.Fecha = (DateTime)datosLocal.Lector["Fecha"];
                    aux.HoraInicio = (TimeSpan)datosLocal.Lector["HoraInicio"];
                    aux.HoraFin = (TimeSpan)datosLocal.Lector["HoraFin"];
                    aux.Observaciones = datosLocal.Lector["Observaciones"].ToString();
                    aux.Estado = datosLocal.Lector["Estado"].ToString();

                    aux.Paciente = new Paciente();
                    aux.Paciente.Id = (int)datosLocal.Lector["IdPaciente"];
                    aux.Paciente.Nombre = datosLocal.Lector["NombrePaciente"].ToString();
                    aux.Paciente.Apellido = datosLocal.Lector["ApellidoPaciente"].ToString();

                    aux.Especialidad = new Especialidad();
                    aux.Especialidad.Id = (int)datosLocal.Lector["IdEspecialidad"];
                    aux.Especialidad.Nombre = datosLocal.Lector["Especialidad"].ToString();

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
                datosLocal.cerrarConexion();
            }
        }
    }
}
