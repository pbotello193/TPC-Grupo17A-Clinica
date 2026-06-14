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
            if (!IsPostBack)
            {
                Session.Add("listaMedicos", negocio.listarMedicosActivos());
                dgvMedicos.DataSource = Session["listaMedicos"];
                dgvMedicos.DataBind();
            }

        }

        protected void dgvMedicos_SelectedIndexChanged(object sender, EventArgs e)
        {
            string id = dgvMedicos.SelectedDataKey.Value.ToString();
            Response.Redirect("FormularioMedico.aspx?id=" + id);
        }


        protected void cbxMostrarTodos_CheckedChanged(object sender, EventArgs e)
        {
            MedicoNegocio negocio = new MedicoNegocio();
            if (cbxMostrarTodos.Checked)
            {
                Session.Add("listaMedicos", negocio.listarMedicosCompleto());
                dgvMedicos.DataSource = Session["listaMedicos"];
                dgvMedicos.DataBind();
            }
            else
            {
                Session.Add("listaMedicos", negocio.listarMedicosActivos());
                dgvMedicos.DataSource = Session["listaMedicos"];
                dgvMedicos.DataBind();
            }
        }
    }
}