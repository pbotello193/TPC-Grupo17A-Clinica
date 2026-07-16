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
            List<Usuario> lista = negocio.listarPersonalAdministrativo();

            if (ddlEstadoUsuarios.SelectedValue == "activos")
                lista = lista.FindAll(x => x.Activo);
            else if (ddlEstadoUsuarios.SelectedValue == "inactivos")
                lista = lista.FindAll(x => !x.Activo);

            if (ddlRolUsuarios.SelectedValue == "admin")
                lista = lista.FindAll(x => x.TipoUsuario == TipoUsuario.Administrador);
            else if (ddlRolUsuarios.SelectedValue == "recepcion")
                lista = lista.FindAll(x => x.TipoUsuario == TipoUsuario.Recepcionista);

            Session["listaPersonalAdministrativo"] = lista;
            dgvUsuarios.DataSource = lista;
            dgvUsuarios.DataBind();
        }

        protected void ddlEstadoUsuarios_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtBuscar.Text = string.Empty;
            cargarPersonalAdministrativo();
        }

        protected void ddlRolUsuarios_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtBuscar.Text = string.Empty;
            cargarPersonalAdministrativo();
        }

        protected void txtBuscar_TextChanged(object sender, EventArgs e)
        {
            List<Usuario> lista = (List<Usuario>)Session["listaPersonalAdministrativo"];
            string filtro = txtBuscar.Text.Trim().ToUpper();

            List<Usuario> listaFiltrada = lista.FindAll(x =>
                x.Apellido.ToUpper().Contains(filtro) ||
                x.Nombre.ToUpper().Contains(filtro) ||
                x.DNI.Contains(filtro)
            );

            dgvUsuarios.DataSource = listaFiltrada;
            dgvUsuarios.DataBind();
        }

        protected void dgvUsuarios_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Editar")
            {
                string id = e.CommandArgument.ToString();
                Response.Redirect("FormularioUsuario.aspx?id=" + id, false);
            }
        }
    }
}