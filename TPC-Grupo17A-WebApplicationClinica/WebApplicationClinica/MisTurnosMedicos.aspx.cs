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
                //Misma expresion que para cargar los turnos disponibles para asignarlos
                dgvMisTurnos.DataSource = turnos.Select(t => new {
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
    }
}