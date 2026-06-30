using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using dominio;
using negocio;

namespace WebApplicationClinica
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            lblErrorUsuario.Visible = false;
            lblErrorPassword.Visible = false;

            if (string.IsNullOrWhiteSpace(txtUsuario.Text))
            {
                lblErrorUsuario.Text = "Ingrese el usuario.";
                lblErrorUsuario.Visible = true;
                return;
            }

            if (string.IsNullOrWhiteSpace(txtPassword.Text))
            {
                lblErrorPassword.Text = "Ingrese la contraseña.";
                lblErrorPassword.Visible = true;
                return;
            }

            Usuario usuario = new Usuario();
            usuario.User = txtUsuario.Text.Trim();
            usuario.Pass = txtPassword.Text.Trim();

            UsuarioNegocio usuarioNegocio = new UsuarioNegocio();

            if (!usuarioNegocio.Loguear(usuario))
            {
                lblErrorPassword.Text = "Usuario o contraseña incorrectos.";
                lblErrorPassword.Visible = true;
                return;
            }

            Session["Usuario"] = usuario;
            Response.Redirect("Default.aspx", false);
        }
    }
}