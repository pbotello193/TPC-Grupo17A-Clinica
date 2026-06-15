using negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplicationClinica
{
    public partial class ListaEspecialidades : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            EspecialidadNegocio negocio = new EspecialidadNegocio();
            if (!IsPostBack)
            {
                Session.Add("listaEspecialidades", negocio.listarEspecialidades());
                dgvEspecialidades.DataSource = Session["listaEspecialidades"];
                dgvEspecialidades.DataBind();
            }

        }

        protected void dgvEspecialidades_SelectedIndexChanged(object sender, EventArgs e)
        {
            string id = dgvEspecialidades.SelectedDataKey.Value.ToString();
            Response.Redirect("FormularioEspecialidad.aspx?id=" + id);
        }
    }
}