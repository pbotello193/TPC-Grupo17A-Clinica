using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using negocio;

namespace WebApplicationClinica
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ValidarSesion();

            if (!IsPostBack)
                ActualizarLoginNavbar();
        }

        private void ValidarSesion()
        {
            if (Page is Login)
                return;

            if (!Seguridad.SesionActiva(Session["Usuario"]))
                Response.Redirect("Login.aspx", false);
        }

        private void ActualizarLoginNavbar()
        {
            if (Session["Usuario"] == null)
                lnkLogin.Text = "Login";
            else
                lnkLogin.Text = "Cerrar sesión";
        }

        protected void lnkLogin_Click(object sender, EventArgs e)
        {
            if (Session["Usuario"] == null)
            {
                Response.Redirect("Login.aspx", false);
                return;
            }

            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx", false);
        }
    }
}
