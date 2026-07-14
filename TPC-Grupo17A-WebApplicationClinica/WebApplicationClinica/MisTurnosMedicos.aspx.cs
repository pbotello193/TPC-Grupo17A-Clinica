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
                List<Turno> turnos = negocio.listarAgendaMedico(idMedico);
                dgvMisTurnos.DataSource = turnos.Select(t => new {
                    Id = t.Id,
                    Fecha = t.Fecha.ToString("dd/MM/yyyy"),
                    Hora = t.HoraInicio.ToString(@"hh\:mm"),
                    Paciente = t.Paciente.Nombre + " " + t.Paciente.Apellido,
                    Especialidad = t.Especialidad.Nombre,
                    Estado = t.Estado,
                    Observaciones = string.IsNullOrEmpty(t.Observaciones) ? "Sin observaciones" : t.Observaciones
                }).ToList();

                dgvMisTurnos.DataBind();
            }
            catch (Exception ex)
            {
                Session.Add("Hubo un error al cargar la agenda", ex);
                lblMensajeError.Text = ex.Message;
                lblMensajeError.Visible = true;
            }
        }

        protected void dgvMisTurnos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "AbrirTurno")
            {
                string idTurno = e.CommandArgument.ToString();
                Response.Redirect("AtencionTurno.aspx?id=" + idTurno, false);
            }
        }

    }
}