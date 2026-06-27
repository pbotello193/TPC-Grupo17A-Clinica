using negocio;
using dominio;
using System;
using System.Collections.Generic;
using System.Web.UI;

namespace WebApplicationClinica
{
    public partial class WebForm_Medico : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                cargarMedicos();
            }
        }

        private void cargarMedicos()
        {
            MedicoNegocio negocio = new MedicoNegocio();

            if (ddlEstadoMedicos.SelectedValue == "inactivos")
            {
                //Hacer mejor un metodo para filtrar inactivos
                Session["listaMedicos"] = negocio.listarMedicosCompleto().FindAll(x => !x.Activo);
            }
            else if (ddlEstadoMedicos.SelectedValue == "todos")
            {
                Session["listaMedicos"] = negocio.listarMedicosCompleto();
            }
            else
            {
                Session["listaMedicos"] = negocio.listarMedicosActivos();
            }

            dgvMedicos.DataSource = Session["listaMedicos"];
            dgvMedicos.DataBind();
        }

        protected void ddlEstadoMedicos_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtBuscar.Text = string.Empty; //Para limpiar el buscador
            cargarMedicos();
        }

        protected void txtBuscar_TextChanged(object sender, EventArgs e)
        {//Metodo para generar la lista filtrada
            List<Medico> lista = (List<Medico>)Session["listaMedicos"];
            string filtro = txtBuscar.Text.Trim().ToUpper();

            List<Medico> listaFiltrada = lista.FindAll(x =>
                x.Apellido.ToUpper().Contains(filtro) ||
                x.Nombre.ToUpper().Contains(filtro) ||
                x.Matricula.ToUpper().Contains(filtro)
            );

            dgvMedicos.DataSource = listaFiltrada;
            dgvMedicos.DataBind();
        }

        protected void dgvMedicos_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (dgvMedicos.SelectedDataKey != null)
            {
                string id = dgvMedicos.SelectedDataKey.Value.ToString();
                Response.Redirect("FormularioMedico.aspx?id=" + id, false);
            }
        }
    }
}