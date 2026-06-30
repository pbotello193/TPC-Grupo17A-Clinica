using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using dominio;

namespace WebApplicationClinica
{
    public partial class InicioMedico : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Usuario usuario = Session["Usuario"] as Usuario;

            if (usuario != null && !string.IsNullOrWhiteSpace(usuario.NombreMostrar))
                litTitulo.Text = "Dr/a. " + usuario.NombreMostrar;
            else
                litTitulo.Text = "Médico";
        }
    }
}