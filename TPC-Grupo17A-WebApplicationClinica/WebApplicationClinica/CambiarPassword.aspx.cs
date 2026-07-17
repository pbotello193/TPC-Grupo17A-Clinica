using System;

namespace WebApplicationClinica
{
    public partial class CambiarPassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            lblErrorPasswordActual.Visible = false;
            lblErrorPasswordNueva.Visible = false;
            lblMensaje.Visible = false;

            if (string.IsNullOrWhiteSpace(txtPasswordActual.Text))
            {
                lblErrorPasswordActual.Text = "Ingrese la contraseña actual.";
                lblErrorPasswordActual.Visible = true;
                return;
            }

            if (string.IsNullOrWhiteSpace(txtPasswordNueva.Text))
            {
                lblErrorPasswordNueva.Text = "Ingrese la nueva contraseña.";
                lblErrorPasswordNueva.Visible = true;
                return;
            }
        }
    }
}
