using negocio;
using dominio;
using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplicationClinica
{
    public partial class ListaEspecialidades : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                cargarEspecialidades();
            }
        }

        private void cargarEspecialidades()
        {
            EspecialidadNegocio negocio = new EspecialidadNegocio();

            if (ddlEstadoEspecialidades.SelectedValue == "activos")
            {
                Session["listaEspecialidades"] = negocio.listarEspecialidadesActivas();
            }
            else if (ddlEstadoEspecialidades.SelectedValue == "inactivos")
            {
                Session["listaEspecialidades"] = negocio.listarEspecialidadesInactivas();
            }
            else
            {
                Session["listaEspecialidades"] = negocio.listarTodasEspecialidades();
            }

            dgvEspecialidades.DataSource = Session["listaEspecialidades"];
            dgvEspecialidades.DataBind();
        }

        protected void ddlEstadoEspecialidades_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtBuscar.Text = string.Empty;
            cargarEspecialidades();
        }

        protected void txtBuscar_TextChanged(object sender, EventArgs e)
        {
            if (Session["listaEspecialidades"] != null)
            {
                List<Especialidad> lista = (List<Especialidad>)Session["listaEspecialidades"];
                string filtro = txtBuscar.Text.Trim().ToUpper();
                List<Especialidad> listaFiltrada = lista.FindAll(x =>
                    x.Nombre.ToUpper().Contains(filtro) ||
                    (x.Descripcion != null && x.Descripcion.ToUpper().Contains(filtro))
                );

                dgvEspecialidades.DataSource = listaFiltrada;
                dgvEspecialidades.DataBind();
            }
        }

        protected void dgvEspecialidades_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (dgvEspecialidades.SelectedDataKey != null)
            {
                string id = dgvEspecialidades.SelectedDataKey.Value.ToString();
                Response.Redirect("FormularioEspecialidad.aspx?id=" + id, false);
            }
        }
    }
}