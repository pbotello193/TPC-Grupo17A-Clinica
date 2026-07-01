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
    public partial class MisTurnosMedicos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["Usuario"] != null)
                {
                    Usuario usuario = Session["Usuario"] as Usuario;

                    if (usuario.TipoUsuario == TipoUsuario.Medico && usuario.IdMedico.HasValue)
                    {
                        cargarTurnos(usuario.IdMedico.Value);
                    }
                    else
                    {
                        Response.Redirect("Default.aspx", false);
                    }
                }
                else
                {
                    Response.Redirect("Login.aspx", false);
                }
            }
        }

        private void cargarTurnos(int idMedico)
        {
            TurnoNegocio negocio = new TurnoNegocio();

            try
            {
                List<Turno> turnos = negocio.listarPorMedico(idMedico);
                dgvMisTurnos.DataSource = turnos.Select(t => new {
                    Id = t.Id, // para poder identificar el turno
                    Fecha = t.Fecha.ToString("dd/MM/yyyy"),
                    Hora = t.HoraInicio.ToString(@"hh\:mm"),
                    Paciente = t.Paciente.Nombre + " " + t.Paciente.Apellido,
                    Especialidad = t.Especialidad.Nombre,
                    Estado = t.Estado,
                    Observaciones = t.Observaciones,
                    Diagnostico = string.IsNullOrEmpty(t.Diagnostico) ? "" : t.Diagnostico
                }).ToList();

                dgvMisTurnos.DataBind();
            }
            catch (Exception ex)
            {
                Session.Add("Hubo un error al cargar la agenda", ex);
            }
        }

        protected void dgvMisTurnos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "CargarDiag" || e.CommandName == "NoAsistio")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = dgvMisTurnos.Rows[index];
                int idTurno = Convert.ToInt32(dgvMisTurnos.DataKeys[index].Value);

                TurnoNegocio negocio = new TurnoNegocio();

                if (e.CommandName == "CargarDiag")
                {
                    TextBox txtDiag = (TextBox)row.FindControl("txtDiagnostico");
                    string diagnostico = txtDiag.Text.Trim();

                    if (string.IsNullOrWhiteSpace(diagnostico))
                    {
                        ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Por favor, ingrese un diagnóstico antes de marcar la asistencia del paciente.');", true);
                        return;
                    }

                    negocio.cambiarEstado(idTurno, "Asistió", diagnostico);
                }
                else if (e.CommandName == "NoAsistio")
                {
                    negocio.cambiarEstado(idTurno, "No Asistió");
                }

                // Recargar la grilla para refrescar los estados y deshabilitar controles
                Usuario usuario = Session["Usuario"] as Usuario;
                if (usuario != null && usuario.IdMedico.HasValue)
                {
                    cargarTurnos(usuario.IdMedico.Value);
                }
            }
        }
    }
}