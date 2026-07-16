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
                    cargarDatosTurno(usuario.IdMedico.Value);//lo trae con el id del usuario en session
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
                    lblFecha.Text = seleccionado.Fecha.ToString("dd/MM/yyyy");
                    lblHora.Text = seleccionado.HoraInicio.ToString(@"hh\:mm");
                    lblEspecialidad.Text = seleccionado.Especialidad.Nombre;
                    lblObservaciones.Text = string.IsNullOrEmpty(seleccionado.Observaciones) ? "" : seleccionado.Observaciones;
                    txtDiagnostico.Text = seleccionado.Diagnostico ?? "";

                    //Aca evitamos que pueda registrar diagnostico y asistencia/inasistencia si no es un turno del dia
                    if (seleccionado.Fecha.Date != DateTime.Today)
                    {
                        btnGuardarAsistio.Enabled = false;
                        btnRegistrarInasistencia.Enabled = false;
                    }
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

        protected void btnGuardarAsistio_Click(object sender, EventArgs e)
        {
            TurnoNegocio negocio = new TurnoNegocio();
            try
            {
                string diagnostico = txtDiagnostico.Text;
                negocio.cambiarEstado(idTurnoSeleccionado, "Asistió", diagnostico);
                Response.Redirect("MisTurnosMedicos.aspx", false);
            }
            catch (Exception ex)
            {
                Session.Add("Error al registrar la atencion", ex);
                lblMensajeError.Text = ex.Message;
                lblMensajeError.Visible = true;
                return; //para no abandonar de una la pagina
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
                return; //para no abandonar de una la pagina
            }
        }

    }
}