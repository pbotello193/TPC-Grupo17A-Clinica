using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using negocio;
using dominio;

namespace WebApplicationClinica
{
    public partial class WebForm_Turno : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                cargarEspecialidades();
                cargarPacientesActivos();

                if (Request.QueryString["idTurno"] != null)
                {
                    int idTurno = int.Parse(Request.QueryString["idTurno"]);
                    Session["IdTurno"] = idTurno; // Guardamos en Session para el paso final
                    cargarTurnoReprogramar(idTurno);
                }
                else
                {
                    //limpieza para que no aparezca desde la ultima busqueda o id de una reprogramacion
                    Session["DiasDisponiblesEspecialidad"] = null;
                    Session["AgendasEspecialidadCache"] = null;
                    Session["MedicosEspecialidadCache"] = null;
                    Session["listaHorariosDisponibles"] = null;
                    Session.Remove("IdTurno"); //por si quedo un id en session y molesta
                }
            }
        }

        private void cargarEspecialidades()
        {
            EspecialidadNegocio negocio = new EspecialidadNegocio();

            ddlEspecialidad.DataSource = negocio.listarTodasEspecialidades();
            ddlEspecialidad.DataTextField = "Nombre";
            ddlEspecialidad.DataValueField = "Id";
            ddlEspecialidad.DataBind();

            ListItem opcionInicial = new ListItem("Seleccione una especialidad", "0");
            opcionInicial.Attributes.Add("disabled", "disabled");
            opcionInicial.Attributes.Add("style", "display:none");
            ddlEspecialidad.Items.Insert(0, opcionInicial);
            ddlEspecialidad.SelectedIndex = 0;
        }

        private void cargarPacientesActivos()
        {
            PacienteNegocio negocio = new PacienteNegocio();
            Session["listaPacientesTurnos"] = negocio.listarPacientes();
        }

        //buscar pacientes por DNI, nombre o apellido
        protected void txtBuscarPaciente_TextChanged(object sender, EventArgs e)
        {
            List<Paciente> lista = (List<Paciente>)Session["listaPacientesTurnos"];
            string filtro = txtBuscarPaciente.Text.Trim().ToUpper();

            hfIdPaciente.Value = string.Empty;
            lblPacienteSeleccionado.Visible = false;

            if (string.IsNullOrEmpty(filtro))
            {
                dgvPacientesEncontrados.Visible = false;
                return;
            }

            List<Paciente> listaFiltrada = lista.FindAll(x =>
                x.Apellido.ToUpper().Contains(filtro) ||
                x.Nombre.ToUpper().Contains(filtro) ||
                x.Dni.Contains(filtro)
            );

            dgvPacientesEncontrados.DataSource = listaFiltrada;
            dgvPacientesEncontrados.DataBind();
            dgvPacientesEncontrados.Visible = true;
        }

        //guardar el paciente seleccionado y ocultar la lista
        protected void dgvPacientesEncontrados_SelectedIndexChanged(object sender, EventArgs e)
        {
            List<Paciente> lista = (List<Paciente>)Session["listaPacientesTurnos"];
            int idPaciente = Convert.ToInt32(dgvPacientesEncontrados.SelectedDataKey.Value);

            Paciente pacienteSeleccionado = lista.Find(x => x.Id == idPaciente);

            if (pacienteSeleccionado != null)
            {
                hfIdPaciente.Value = pacienteSeleccionado.Id.ToString();
                txtBuscarPaciente.Text = pacienteSeleccionado.Apellido + ", " + pacienteSeleccionado.Nombre;
                lblPacienteSeleccionado.Text = "Paciente seleccionado: " + pacienteSeleccionado.Apellido + ", " + pacienteSeleccionado.Nombre + " - DNI: " + pacienteSeleccionado.Dni;
                lblPacienteSeleccionado.Visible = true;
                dgvPacientesEncontrados.Visible = false;
            }
        }

        //buscar medicos y horarios segun especialidad
        protected void btnbuscarhorarios_Click(object sender, EventArgs e)
        {
            if (string.IsNullOrEmpty(hfIdPaciente.Value) || ddlEspecialidad.SelectedValue == "0")
            {
                return;
            }

            int idPaciente = int.Parse((hfIdPaciente.Value));
            int idEspecialidad = int.Parse((ddlEspecialidad.SelectedValue));

            MedicoNegocio medicoNegocio = new MedicoNegocio();
            TurnoDeTrabajoNegocio trabajoNegocio = new TurnoDeTrabajoNegocio();

            List<Medico> medicosActivos = medicoNegocio.listarMedicosActivos();
            List<Turno> listaTurnosDisponibles = new List<Turno>();


            foreach (Medico medico in medicosActivos)
            {
                //filtra los horarios para el medico
                List<TurnoDeTrabajo> horariosMedico = trabajoNegocio.listarPorMedico(medico.Id, "activos");

                //filtra horarios de la especialidad especifica para ese medico
                List<TurnoDeTrabajo> horariosFiltrados = horariosMedico.Where(a => a.Especialidad.Id == idEspecialidad).ToList();

                foreach (TurnoDeTrabajo agendaMedico in horariosFiltrados)
                {
                    //calcula los dias de diferencia entre hoy y la fecha elegida (+7 y %7 por si da negativo)
                    //estoy asumiendo que los turnos son a maximo 1 semana, sino hay que cambiarlo
                    int diasDiferencia = ((int)agendaMedico.DiaDeLaSemana - (int)DateTime.Today.DayOfWeek + 28) % 7;
                    //valida que el turno no sea pasado ni el mismo dia (si es o es hoy, asi que asigna el mismo dia de la siguiente semana)
                    DateTime fechaReal = DateTime.Today.AddDays(diasDiferencia == 0 ? 28 : diasDiferencia);

                    //bucle para manejar bloques de 1 hora y que no exceda el horario de fin de turno del medico
                    while (agendaMedico.HoraInicio < agendaMedico.HoraFin)
                    {
                        Turno turnoDisponible = new Turno();
                        turnoDisponible.Fecha = fechaReal;
                        turnoDisponible.HoraInicio = agendaMedico.HoraInicio;
                        turnoDisponible.Paciente = new Paciente();
                        turnoDisponible.Paciente.Id = idPaciente;
                        turnoDisponible.Medico = medico;
                        turnoDisponible.Especialidad = agendaMedico.Especialidad;
                        turnoDisponible.Observaciones = "Observaciones"; //aca deberia poder cargarse observaciones desde el front
                        turnoDisponible.Estado = "Nuevo";

                        listaTurnosDisponibles.Add(turnoDisponible);

                        //avanza a la siguiente hora
                        agendaMedico.HoraInicio = agendaMedico.HoraInicio.Add(new TimeSpan(1, 0, 0));
                    }
                }
            }

            //guardo la lista para usarla
            Session["listaHorariosDisponibles"] = listaTurnosDisponibles;

            //le da formato correcto para mostrar en la dgv (crea objetos temporales para cargar la lista)
            dgvHorariosDisponibles.DataSource = listaTurnosDisponibles.Select(t => new
            {
                Medico = t.Medico.Apellido + ", " + t.Medico.Nombre,
                Especialidad = t.Especialidad.Nombre,
                Fecha = t.Fecha.ToString("dd/MM/yyyy"),
                Horario = t.HoraInicio.ToString(@"hh\:mm")
            }).ToList();

            dgvHorariosDisponibles.DataBind();
        }

        //asignar el turno elegido al paciente seleccionado
        protected void dgvHorariosDisponibles_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (Session["listaHorariosDisponibles"] == null || string.IsNullOrEmpty(hfIdPaciente.Value))
                return;

            List<Turno> listaTurnos = (List<Turno>)Session["listaHorariosDisponibles"];

            // Para copiar el índice del turno desde la lista
            int seleccion = dgvHorariosDisponibles.SelectedIndex;
            Turno turnoSeleccionado = listaTurnos[seleccion];

            try
            {
                TurnoNegocio negocio = new TurnoNegocio();

                if (Session["IdTurno"] != null)
                {
                    int idTurnoReprogramado = (int)Session["IdTurno"];

                    //aca el nuevo metodo
                    negocio.reprogramarTurno(idTurnoReprogramado, turnoSeleccionado.Fecha, turnoSeleccionado.HoraInicio, txtObservaciones.Text);

                    EmailService email = new EmailService();
                    //plantilla modificada para reprogramacion
                    string rutaPlantilla = Server.MapPath("~/MailTurnoConfirmado.html");
                    turnoSeleccionado.Id = idTurnoReprogramado;
                    turnoSeleccionado.Estado = "Reprogramado";
                    email.armarMailConfirmacion(turnoSeleccionado, rutaPlantilla);
                    //email.enviarEmail();

                    //limpiamos para evitar conflicto
                    Session.Remove("IdTurnoReprogramar");
                    Session.Remove("listaHorariosDisponibles");
                    Response.Redirect("AgendaMedicos.aspx", false);
                }
                else
                {
                    int idPaciente = int.Parse((hfIdPaciente.Value));

                    if (Session["listaPacientesTurnos"] != null)
                    {//Recupero el paciento de la lista en session para cargarlo en el turno
                        List<Paciente> listaPacientes = (List<Paciente>)Session["listaPacientesTurnos"];
                        turnoSeleccionado.Paciente = listaPacientes.Find(x => x.Id == idPaciente) ?? turnoSeleccionado.Paciente;
                    }
                    if (!string.IsNullOrEmpty(txtObservaciones.Text.Trim()))
                    {
                        turnoSeleccionado.Observaciones = txtObservaciones.Text.Trim();
                    }
                    else
                    {
                        turnoSeleccionado.Observaciones = "";
                    }
                    negocio.agregar(turnoSeleccionado);

                    EmailService email = new EmailService();
                    string rutaPlantilla = Server.MapPath("~/MailTurnoConfirmado.html");
                    email.armarMailConfirmacion(turnoSeleccionado, rutaPlantilla);
                    //email.enviarEmail();
                    Session.Remove("listaHorariosDisponibles");
                    Response.Redirect("WebForm-Turnos.aspx", false);
                }
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                lblMensajeError.Text = ex.Message;
            }
        }
        protected void calTurnos_SelectionChanged(object sender, EventArgs e)
        {
            cargarTurnosDisp();
        }

        protected void btnBuscarTurnos_Click(object sender, EventArgs e)
        {
            lblMensajeError.Visible = false;
            try
            {
                if (string.IsNullOrEmpty(hfIdPaciente.Value) || hfIdPaciente.Value == "0" ||
                string.IsNullOrEmpty(ddlEspecialidad.SelectedValue) || ddlEspecialidad.SelectedValue == "0")
                {
                    lblMensajeError.Visible = true;
                    lblMensajeError.Text = "⚠️ Debe seleccionar un paciente y una especialidad";
                    dgvHorariosDisponibles.DataSource = null;
                    dgvHorariosDisponibles.DataBind();
                    return;
                }

                int idEspecialidad = int.Parse(ddlEspecialidad.SelectedValue);

                MedicoNegocio medicoNegocio = new MedicoNegocio();
                TurnoDeTrabajoNegocio trabajoNegocio = new TurnoDeTrabajoNegocio();

                //lista para usar en el calendario y hashset para evitar duplicardos
                //HashSet<DayOfWeek> diasDeAtencion = new HashSet<DayOfWeek>();
                List<DayOfWeek> diasDeAtencion = new List<DayOfWeek>();

                //lista para usar en el calendario
                List<TurnoDeTrabajo> listaDiasEspecialidades = new List<TurnoDeTrabajo>();
                //buscamos los medicos que tienen esa especialidad
                List<Medico> listaMedicos = medicoNegocio.listarMedicosPorEspecialidad(idEspecialidad);

                foreach (Medico medico in listaMedicos)
                {
                    //por cada medico de esa especialidad revisa sus turnos de trabajo 
                    List<TurnoDeTrabajo> listaAgendas = trabajoNegocio.listarPorMedico(medico.Id);
                    foreach (TurnoDeTrabajo disponible in listaAgendas)
                    {//si algun turno de trabajo es de la especialidad lo agrega a las listas
                        if (disponible.Especialidad.Id == idEspecialidad)
                        {
                            listaDiasEspecialidades.Add(disponible);
                            diasDeAtencion.Add(disponible.DiaDeLaSemana);
                        }
                    }
                }

                //todo en session para no ir tanto a la db
                Session["DiasDisponiblesEspecialidad"] = diasDeAtencion.ToList();
                Session["listaDiasEspecialidades"] = listaDiasEspecialidades;
                Session["listaMedicos"] = listaMedicos;
            }
            catch (Exception ex)
            {

                Session.Add("error", ex);
            }

        }

        private void cargarTurnosDisp()
        {
            //fecha actual por defecto
            try
            {
                //si no hay peciente ni especialidad seleccionada corta
                if (string.IsNullOrEmpty(hfIdPaciente.Value) || hfIdPaciente.Value == "0" ||
                    string.IsNullOrEmpty(ddlEspecialidad.SelectedValue) || ddlEspecialidad.SelectedValue == "0")
                {
                    lblMensajeError.Visible = true;
                    lblMensajeError.Text = "⚠️ Debe seleccionar un paciente y una especialidad";
                    dgvHorariosDisponibles.DataSource = null;
                    dgvHorariosDisponibles.DataBind();
                    return;
                }
                if (calTurnos.SelectedDate == DateTime.MinValue)
                {
                    calTurnos.SelectedDate = DateTime.Today;
                }

                //fecha y dia seleccionados
                DateTime fechaSeleccionada = calTurnos.SelectedDate;
                DayOfWeek diaSemanaSeleccionado = fechaSeleccionada.DayOfWeek;

                int idPaciente = int.Parse(hfIdPaciente.Value);
                List<Turno> listaTurnosDisponibles = new List<Turno>();

                //traemos las listas
                List<TurnoDeTrabajo> listaDiasEspecialidades = Session["listaDiasEspecialidades"] as List<TurnoDeTrabajo>;
                List<Medico> listaMedicos = Session["listaMedicos"] as List<Medico>;

                if (listaDiasEspecialidades != null && listaMedicos != null)
                {
                    TurnoNegocio turnoNegocio = new TurnoNegocio();

                    //busca la especialidad en el dia de la semana seleccionado con el where/toList (para no hacer un for each)
                    List<TurnoDeTrabajo> agendasDelDia = listaDiasEspecialidades.Where(a => a.DiaDeLaSemana == diaSemanaSeleccionado).ToList();

                    foreach (TurnoDeTrabajo horariosMedico in agendasDelDia)
                    {
                        //buscamos el medico para guardarlo con el turno
                        Medico medicoAux = new Medico();
                        foreach (Medico m in listaMedicos)
                        {
                            if (m.Id == horariosMedico.IdMedico)
                            {
                                medicoAux = m;
                                break; //una vez que encuentra el medico corta 
                            }
                        }
                        if (!(medicoAux == null))
                        {
                            TimeSpan horaInicio = horariosMedico.HoraInicio;
                            TimeSpan horaFin = horariosMedico.HoraFin;

                            while (horaInicio < horaFin)
                            {
                                //verifica si hay un turno asignado a esa hora para no mostrarlo
                                if (turnoNegocio.validarDisponibilidadMedico(medicoAux.Id, fechaSeleccionada, horaInicio))
                                {
                                    Turno turnoDisponible = new Turno();
                                    turnoDisponible.Fecha = fechaSeleccionada;
                                    turnoDisponible.HoraInicio = horaInicio;
                                    turnoDisponible.Paciente = new Paciente { Id = idPaciente };
                                    turnoDisponible.Medico = medicoAux;
                                    turnoDisponible.Especialidad = horariosMedico.Especialidad;
                                    turnoDisponible.Observaciones = "";
                                    turnoDisponible.Estado = "Nuevo";

                                    listaTurnosDisponibles.Add(turnoDisponible);
                                }

                                horaInicio = horaInicio.Add(new TimeSpan(1, 0, 0));
                            }
                        }

                    }
                }

                //la dgv se carga con el ToList();
                Session["listaHorariosDisponibles"] = listaTurnosDisponibles;
                dgvHorariosDisponibles.DataSource = listaTurnosDisponibles.Select(t => new
                {
                    Medico = t.Medico.Apellido + ", " + t.Medico.Nombre,
                    Especialidad = t.Especialidad.Nombre,
                    Fecha = t.Fecha.ToString("dd/MM/yyyy"),
                    Horario = t.HoraInicio.ToString(@"hh\:mm")
                }).ToList();

                dgvHorariosDisponibles.DataBind();
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
            }
        }
        //metodo del calendario para marcar los dias en el calendario
        protected void calTurnos_DayRender(object sender, DayRenderEventArgs e)
        {
            //deshabilita los días pasados
            if (e.Day.Date < DateTime.Today)
            {
                e.Day.IsSelectable = false;
                //le sumaeste estilo al dia para opacarlo
                e.Cell.CssClass += " text-muted opacity-50 bg-light-subtle";
                return;
            }

            //trae la lista de session
            List<DayOfWeek> diasDisponibles = Session["DiasDisponiblesEspecialidad"] as List<DayOfWeek>;

            if (diasDisponibles != null)
            {
                //busca la coincidencia con el dia del calendario
                if (diasDisponibles.Contains(e.Day.Date.DayOfWeek))
                {
                    //para contrastar con el dia que se esta viendo
                    if (!e.Day.IsSelected)
                    {
                        e.Cell.CssClass += " bg-primary-subtle text-primary-emphasis fw-bold border border-primary-subtle cursor-pointer";
                    }
                }
                else
                {
                    //inhabilita los dias donde no hay turnos
                    e.Day.IsSelectable = false;
                    e.Cell.CssClass += " text-black-50 opacity-25";
                }
            }
        }
        private void cargarTurnoReprogramar(int idTurno)
        {
            TurnoNegocio negocio = new TurnoNegocio();
            //usamos el find asi devuelve y corta a la primer coicidencia
            Turno turno = negocio.listar().Find(t => t.Id == idTurno);

            if (turno != null)
            {
                //traemos los datos pero bloqueamos cambiar el paciente y la especialidad
                hfIdPaciente.Value = turno.Paciente.Id.ToString();
                txtBuscarPaciente.Text = turno.Paciente.Apellido + ", " + turno.Paciente.Nombre;
                txtBuscarPaciente.Enabled = false;
                ddlEspecialidad.SelectedValue = turno.Especialidad.Id.ToString();
                ddlEspecialidad.Enabled = false;
                lblPacienteSeleccionado.Text = "Seleccione un nuevo día y horario para el paciente: " + turno.Paciente.Apellido + ", " + turno.Paciente.Nombre + " - DNI: " + turno.Paciente.Dni;
                lblPacienteSeleccionado.Visible = true;
                //permitimos cambiar las observaciones y la fecha/ hora obviamente
                txtObservaciones.Text = turno.Observaciones;
                //ya dejamos el calendario cargado con la disponibilidad
                //no me estaria funcionando...
                cargarTurnosDisp();
            }
        }
    }
}
