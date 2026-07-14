using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using negocio;

namespace WebApplicationClinica
{
    public partial class WebForm_Usuarios : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                cargarPersonalAdministrativo();
        }
        private void cargarPersonalAdministrativo()
        {
            UsuarioNegocio negocio = new UsuarioNegocio();
            dgvUsuarios.DataSource = negocio.listarPersonalAdministrativo();
            dgvUsuarios.DataBind();
        }
    }
}