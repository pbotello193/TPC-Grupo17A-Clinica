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
    public partial class HistorialDeTurnos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["idPaciente"] != null)
                {
                    int idPaciente = int.Parse(Request.QueryString["idPaciente"]);

                    cargarDatosPaciente(idPaciente);
                    cargarHistorial(idPaciente);
                }
                else
                {
                    //por si se llega sin el id que vuelva a pacientes
                    Response.Redirect("WebForm-Paciente.aspx", false);
                }
            }
        }

        private void cargarDatosPaciente(int idPaciente)
        {
            PacienteNegocio negocio = new PacienteNegocio();
            Paciente paciente = negocio.obtenerPorId(idPaciente);

            if (paciente == null)
            {
                Response.Redirect("WebForm-Paciente.aspx", false);
                return;
            }

            lblNombrePaciente.Text = paciente.Apellido + ", " + paciente.Nombre;
            lblDniPaciente.Text = paciente.Dni;
        }

        private void cargarHistorial(int idPaciente)
        {
            TurnoNegocio negocio = new TurnoNegocio();
            List<Turno> lista = negocio.listarPorPaciente(idPaciente);

            Session["listaTurnosPaciente"] = lista;

            dgvTurnos.DataSource = lista;
            dgvTurnos.DataBind();
        }

        protected void dgvTurnos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "VerDetalle")
            {
                //crear el metodo que va a invocar aca, deberia llevar el id de turno
            }
        }
    }

}
