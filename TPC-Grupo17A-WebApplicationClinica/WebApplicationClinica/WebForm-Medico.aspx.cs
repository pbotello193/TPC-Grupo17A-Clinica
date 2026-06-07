using negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplicationClinica
{
    public partial class WebForm_Medico : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            MedicoNegocio negocio = new MedicoNegocio();
            Session.Add("listaMedicos", negocio.listarMedicos());
            dgvMedicos.DataSource = Session["listaMedicos"];
            dgvMedicos.DataBind();
        }

        protected void dgvMedicos_SelectedIndexChanged(object sender, EventArgs e)
        {
            string id = dgvMedicos.SelectedDataKey.Value.ToString();
            Response.Redirect("FormularioMedico.aspx?id=" + id);
        }
    }
}