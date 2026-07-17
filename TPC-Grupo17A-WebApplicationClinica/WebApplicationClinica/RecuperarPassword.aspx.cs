using System;

namespace WebApplicationClinica
{
    public partial class RecuperarPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnEnviar_Click(object sender, EventArgs e)
        {
            lblErrorUsuarioOMail.Visible = false;
            lblMensaje.Visible = false;

            if (string.IsNullOrWhiteSpace(txtUsuarioOMail.Text))
            {
                lblErrorUsuarioOMail.Text = "Ingrese su usuario o mail.";
                lblErrorUsuarioOMail.Visible = true;
                return;
            }
        }
    }
}