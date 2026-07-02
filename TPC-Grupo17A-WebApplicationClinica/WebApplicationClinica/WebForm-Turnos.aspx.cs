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
                lblPacienteSeleccionado.Text = "Paciente seleccionado: " + pacienteSeleccionado.Apellido + ", " + pacienteSeleccionado.Nombre + " - DNI " + pacienteSeleccionado.Dni;
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
                TurnoNegocio negocio = new TurnoNegocio();
                negocio.agregar(turnoSeleccionado);

                EmailService email = new EmailService();
                string rutaPlantilla = Server.MapPath("~/MailTurnoConfirmado.html");
                email.armarMailConfirmacion(turnoSeleccionado, rutaPlantilla);
                email.enviarEmail();
                Session.Remove("listaHorariosDisponibles");
                Response.Redirect("WebForm-Turnos.aspx", false);
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
        private void cargarTurnosDisp()
        {
            //Metodo para buscar los turnos por fecha
        }

        
    }
}
