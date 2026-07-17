using dominio;
using negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplicationClinica
{
    public partial class AtencionTurno : System.Web.UI.Page
    {
        private int idTurnoSeleccionado;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["Usuario"] == null)
            {
                Response.Redirect("Login.aspx", false);
                return;
            }
            Usuario usuario = Session["Usuario"] as Usuario;
            if (usuario.TipoUsuario != TipoUsuario.Medico || !usuario.IdMedico.HasValue)
            {
                Response.Redirect("Default.aspx", false);
                return;
            }
            if (Request.QueryString["id"] != null)
            {
                idTurnoSeleccionado = int.Parse((Request.QueryString["id"]));
                if (!IsPostBack)
                {
                    cargarDatosTurno(usuario.IdMedico.Value);
                }
            }
            else
            {
                Response.Redirect("MisTurnosMedicos.aspx", false);
            }
        }
        private void cargarDatosTurno(int idMedico)
        {
            TurnoNegocio negocio = new TurnoNegocio();
            try
            {
                List<Turno> turnos = negocio.listarPorMedico(idMedico);
                Turno seleccionado = turnos.Find(t => t.Id == idTurnoSeleccionado);
                if (seleccionado != null)
                {
                    lblNombrePaciente.Text = seleccionado.Paciente.Apellido + ", " + seleccionado.Paciente.Nombre;
                    lblEdad.Text = seleccionado.Paciente.Edad.ToString() + " años";
                    // Cargar resto de los datos personales
                    lblDniPaciente.Text = seleccionado.Paciente.Dni;
                    lblTelefonoPaciente.Text = seleccionado.Paciente.Telefono;
                    lblEmailPaciente.Text = seleccionado.Paciente.Email;
                    lblFecha.Text = seleccionado.Fecha.ToString("dd/MM/yyyy");
                    lblHora.Text = seleccionado.HoraInicio.ToString(@"hh\:mm");
                    lblEspecialidad.Text = seleccionado.Especialidad.Nombre;
                    lblObservaciones.Text = string.IsNullOrEmpty(seleccionado.Observaciones) ? "" : seleccionado.Observaciones;

                    txtDiagnostico.Text = seleccionado.Diagnostico ?? "";
                    txtIndicaciones.Text = seleccionado.Indicaciones ?? "";
                    txtReceta.Text = seleccionado.Receta ?? "";
                    txtEstudios.Text = seleccionado.EstudiosSolicitados ?? "";
                    txtSignosVitales.Text = seleccionado.SignosVitales ?? "";
                    // Bloqueo si el turno no es del día de hoy
                    if (seleccionado.Fecha.Date != DateTime.Today)
                    {
                        btnGuardarAsistio.Enabled = false;
                        btnRegistrarInasistencia.Enabled = false;
                    }
                    // Cargar el historial clínico del paciente
                    cargarHistorialClinico(seleccionado.Paciente.Id, seleccionado.Id);
                }
                else
                {
                    Response.Redirect("MisTurnosMedicos.aspx", false);
                }
            }
            catch (Exception ex)
            {
                Session.Add("Ocurrio un error al abrir el turno", ex);
                Response.Redirect("MisTurnosMedicos.aspx", false);
            }
        }
        private void cargarHistorialClinico(int idPaciente, int idTurnoActual)
        {
            TurnoNegocio negocio = new TurnoNegocio();
            try
            {
                List<Turno> historial = negocio.listarPorPaciente(idPaciente);

                var atencionesAnteriores = historial
                    .Where(t => t.Id != idTurnoActual && t.Estado == "Asistió")
                    .OrderByDescending(t => t.Fecha)
                    .ThenByDescending(t => t.HoraInicio)
                    .ToList();
                if (atencionesAnteriores.Count > 0)
                {
                    rptHistorialClinico.DataSource = atencionesAnteriores;
                    rptHistorialClinico.DataBind();
                    rptHistorialClinico.Visible = true;
                    lblSinHistorial.Visible = false;
                }
                else
                {
                    rptHistorialClinico.Visible = false;
                    lblSinHistorial.Visible = true;
                }
            }
            catch (Exception ex)
            {
                Session.Add("Error al cargar historial", ex);
                lblMensajeError.Text = "No se pudo cargar el historial clínico: " + ex.Message;
                lblMensajeError.Visible = true;
            }
        }
        protected void btnGuardarAsistio_Click(object sender, EventArgs e)
        {
            TurnoNegocio negocio = new TurnoNegocio();
            try
            {
                string diagnostico = txtDiagnostico.Text;
                string indicaciones = txtIndicaciones.Text;
                string receta = txtReceta.Text;
                string estudios = txtEstudios.Text;
                string signosVitales = txtSignosVitales.Text;
                negocio.registrarAtencion(idTurnoSeleccionado, diagnostico, indicaciones, receta, estudios, signosVitales);
                Response.Redirect("MisTurnosMedicos.aspx", false);
            }
            catch (Exception ex)
            {
                Session.Add("Error al registrar la atencion", ex);
                lblMensajeError.Text = ex.Message;
                lblMensajeError.Visible = true;
                return;
            }
        }
        protected void btnRegistrarInasistencia_Click(object sender, EventArgs e)
        {
            TurnoNegocio negocio = new TurnoNegocio();
            try
            {
                negocio.cambiarEstado(idTurnoSeleccionado, "No asistió", "");
                Response.Redirect("MisTurnosMedicos.aspx", false);
            }
            catch (Exception ex)
            {
                Session.Add("Error al registrar la atencion", ex);
                lblMensajeError.Text = ex.Message;
                lblMensajeError.Visible = true;
                return;
            }
        }
    }
}