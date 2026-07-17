using System;
using dominio;
using negocio;

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
            lblErrorPasswordConfirmacion.Visible = false;
            lblMensaje.Visible = false;
            lnkVolverInicio.Visible = false;
            btnGuardar.Visible = true;

            string passwordActual = txtPasswordActual.Text.Trim();
            string passwordNueva = txtPasswordNueva.Text.Trim();
            string passwordConfirmacion = txtPasswordConfirmacion.Text.Trim();

            if (string.IsNullOrWhiteSpace(passwordActual))
            {
                lblErrorPasswordActual.Text = "Ingrese la contraseña actual.";
                lblErrorPasswordActual.Visible = true;
                return;
            }

            if (string.IsNullOrWhiteSpace(passwordNueva))
            {
                lblErrorPasswordNueva.Text = "Ingrese la nueva contraseña.";
                lblErrorPasswordNueva.Visible = true;
                return;
            }

            if (string.IsNullOrWhiteSpace(passwordConfirmacion))
            {
                lblErrorPasswordConfirmacion.Text = "Confirme la nueva contraseña.";
                lblErrorPasswordConfirmacion.Visible = true;
                return;
            }

            if (passwordNueva != passwordConfirmacion)
            {
                lblErrorPasswordConfirmacion.Text = "Las contraseñas nuevas deben coincidir.";
                lblErrorPasswordConfirmacion.Visible = true;
                return;
            }

            try
            {
                Usuario usuario = Session["Usuario"] as Usuario;
                if (usuario == null)
                {
                    Response.Redirect("Login.aspx", false);
                    return;
                }

                UsuarioNegocio negocio = new UsuarioNegocio();
                bool passwordModificada = negocio.cambiarPassword(usuario.Id, passwordActual, passwordNueva);

                if (!passwordModificada)
                {
                    lblErrorPasswordActual.Text = "La contraseña actual no es correcta.";
                    lblErrorPasswordActual.Visible = true;
                    return;
                }

                usuario.Pass = passwordNueva;
                Session["Usuario"] = usuario;

                txtPasswordActual.Text = string.Empty;
                txtPasswordNueva.Text = string.Empty;
                txtPasswordConfirmacion.Text = string.Empty;
                lblMensaje.CssClass = "alert alert-success d-block";
                lblMensaje.Text = "La contraseña se modificó correctamente.";
                lblMensaje.Visible = true;
                lnkVolverInicio.NavigateUrl = usuario.PaginaInicio;
                lnkVolverInicio.Visible = true;
                btnGuardar.Visible = false;
            }
            catch (Exception)
            {
                lblMensaje.CssClass = "alert alert-danger d-block";
                lblMensaje.Text = "No se pudo modificar la contraseña. Intente nuevamente.";
                lblMensaje.Visible = true;
            }
        }
    }
}