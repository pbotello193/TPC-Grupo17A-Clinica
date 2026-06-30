using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplicationClinica
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
                ActualizarLoginNavbar();
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
