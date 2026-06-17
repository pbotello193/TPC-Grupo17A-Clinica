using negocio;
using System;

namespace WebApplicationClinica
{
    public partial class WebForm_Paciente : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            PacienteNegocio negocio = new PacienteNegocio();

            if (!IsPostBack)
            {
                Session.Add("listaPacientes", negocio.listarPacientes());
                dgvPacientes.DataSource = Session["listaPacientes"];
                dgvPacientes.DataBind();
            }
        }

        protected void dgvPacientes_SelectedIndexChanged(object sender, EventArgs e)
        {
            string id = dgvPacientes.SelectedDataKey.Value.ToString();
            Response.Redirect("FormularioPaciente.aspx?id=" + id);
        }
    }
}
