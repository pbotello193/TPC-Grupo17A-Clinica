using negocio;
using System;

namespace WebApplicationClinica
{
    public partial class WebForm_Paciente : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                cargarPacientes();
            }
        }

        //carga segun seleccion
        private void cargarPacientes()
        {
            PacienteNegocio negocio = new PacienteNegocio();

            if (ddlEstadoPacientes.SelectedValue == "inactivos")
                Session["listaPacientes"] = negocio.listarPacientesInactivos();
            else if (ddlEstadoPacientes.SelectedValue == "todos")
                Session["listaPacientes"] = negocio.listarPacientesCompleto();
            else
                Session["listaPacientes"] = negocio.listarPacientes();

            dgvPacientes.DataSource = Session["listaPacientes"];
            dgvPacientes.DataBind();
        }

        protected void ddlEstadoPacientes_SelectedIndexChanged(object sender, EventArgs e)
        {
            cargarPacientes();
        }

        protected void dgvPacientes_SelectedIndexChanged(object sender, EventArgs e)
        {
            string id = dgvPacientes.SelectedDataKey.Value.ToString();
            Response.Redirect("FormularioPaciente.aspx?id=" + id);
        }
    }
}
