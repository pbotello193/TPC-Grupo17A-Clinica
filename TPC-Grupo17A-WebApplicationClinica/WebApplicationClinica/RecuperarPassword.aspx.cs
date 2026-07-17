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
            lblErrorUsuario.Visible = false;
            lblErrorEmail.Visible = false;
            lblMensaje.Visible = false;

            if (string.IsNullOrWhiteSpace(txtUsuario.Text))
            {
                lblErrorUsuario.Text = "Ingrese su usuario.";
                lblErrorUsuario.Visible = true;
                return;
            }

            if (string.IsNullOrWhiteSpace(txtEmail.Text))
            {
                lblErrorEmail.Text = "Ingrese su mail.";
                lblErrorEmail.Visible = true;
                return;
            }
        }
    }
}