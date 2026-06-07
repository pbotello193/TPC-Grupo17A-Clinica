using dominio;
using negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.WebSockets;

namespace WebApplicationClinica
{
    public partial class FormularioMedico : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnAceptar_Click(object sender, EventArgs e)
        {
            try
            {
                Medico nuevo = new Medico();
                MedicoNegocio negocio = new MedicoNegocio();

                nuevo.Nombre = txtNombre.Text;
                nuevo.Apellido = txtApellido.Text;
                nuevo.Matricula = txtMatricula.Text;
                nuevo.Telefono = txtTelefono.Text;
                nuevo.Email = txtEmail.Text;

                negocio.agregar(nuevo);
                Response.Redirect("WebForm-Medico.aspx", false);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}