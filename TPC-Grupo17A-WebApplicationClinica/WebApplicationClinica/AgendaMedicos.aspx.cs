using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using dominio;
using negocio;

namespace WebApplicationClinica
{
    public partial class AgendaMedicos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Usuario usuario = Session["Usuario"] as Usuario;
                if (usuario == null)
                {
                    Response.Redirect("Login.aspx", false);
                    return;
                }

                if (!Seguridad.EsAdmin(usuario) && !Seguridad.EsRecepcionista(usuario))
                {
                    Response.Redirect(usuario.PaginaInicio, false);
                    return;
                }

                CargarFiltros();
                CargarAgenda();
            }
        }

        private void CargarFiltros()
        {
            CargarMedicos();
            CargarEspecialidades();
        }

        private void CargarMedicos()
        {
            MedicoNegocio medicoNegocio = new MedicoNegocio();
            List<Medico> medicos = medicoNegocio.listarMedicosActivos();

            ddlMedico.DataSource = medicos.Select(m => new
            {
                Id = m.Id,
                NombreCompleto = m.Apellido + ", " + m.Nombre
            }).ToList();
            ddlMedico.DataValueField = "Id";
            ddlMedico.DataTextField = "NombreCompleto";
            ddlMedico.DataBind();
            ddlMedico.Items.Insert(0, new ListItem("Todos", ""));
        }

        private void CargarEspecialidades()
        {
            EspecialidadNegocio especialidadNegocio = new EspecialidadNegocio();
            ddlEspecialidad.DataSource = especialidadNegocio.listarEspecialidadesActivas();
            ddlEspecialidad.DataValueField = "Id";
            ddlEspecialidad.DataTextField = "Nombre";
            ddlEspecialidad.DataBind();
            ddlEspecialidad.Items.Insert(0, new ListItem("Todas", ""));
        }

        private void CargarAgenda()
        {
            try
            {
                lblMensaje.Visible = false;
                TurnoNegocio turnoNegocio = new TurnoNegocio();
                List<Turno> turnos = AplicarFiltros(turnoNegocio.listar());

                dgvAgendaMedicos.DataSource = turnos.Select(t => new
                {
                    Id = t.Id,
                    Fecha = t.Fecha.ToString("dd/MM/yyyy"),
                    Hora = t.HoraInicio.ToString(@"hh\:mm"),
                    Paciente = t.Paciente.Nombre + " " + t.Paciente.Apellido,
                    Medico = t.Medico.Apellido + ", " + t.Medico.Nombre,
                    Especialidad = t.Especialidad.Nombre,
                    Estado = t.Estado,
                    Observaciones = t.Observaciones
                }).ToList();

                dgvAgendaMedicos.DataBind();
            }
            catch (Exception ex)
            {
                lblMensaje.Text = "Hubo un error al cargar la agenda de médicos.";
                lblMensaje.Visible = true;
                Session.Add("ErrorAgendaMedicos", ex);
            }
        }

        private List<Turno> AplicarFiltros(List<Turno> turnos)
        {
            IEnumerable<Turno> filtrados = turnos;

            if (int.TryParse(ddlMedico.SelectedValue, out int idMedico))
                filtrados = filtrados.Where(t => t.Medico != null && t.Medico.Id == idMedico);

            if (int.TryParse(ddlEspecialidad.SelectedValue, out int idEspecialidad))
                filtrados = filtrados.Where(t => t.Especialidad != null && t.Especialidad.Id == idEspecialidad);

            if (DateTime.TryParse(txtFecha.Text, out DateTime fecha))
                filtrados = filtrados.Where(t => t.Fecha.Date == fecha.Date);

            if (!string.IsNullOrWhiteSpace(ddlEstado.SelectedValue))
                filtrados = filtrados.Where(t => string.Equals(t.Estado, ddlEstado.SelectedValue, StringComparison.OrdinalIgnoreCase));

            return filtrados.ToList();
        }

        protected void btnFiltrar_Click(object sender, EventArgs e)
        {
            CargarAgenda();
        }

        protected void btnLimpiar_Click(object sender, EventArgs e)
        {
            ddlMedico.SelectedIndex = 0;
            ddlEspecialidad.SelectedIndex = 0;
            ddlEstado.SelectedIndex = 0;
            txtFecha.Text = string.Empty;
            CargarAgenda();
        }
    }
}
