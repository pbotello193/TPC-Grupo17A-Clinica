using negocio;
using System;
using dominio;
using System.Collections.Generic;

namespace WebApplicationClinica
{
    public partial class WebForm_Paciente : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                cargarPacientes();
            }
        }

        //carga segun seleccion
        private void cargarPacientes()
        {
            PacienteNegocio negocio = new PacienteNegocio();

            if (ddlEstadoPacientes.SelectedValue == "inactivos")
                Session["listaPacientes"] = negocio.listarPacientesInactivos();
            else if (ddlEstadoPacientes.SelectedValue == "todos")
                Session["listaPacientes"] = negocio.listarPacientesCompleto();
            else
                Session["listaPacientes"] = negocio.listarPacientes();

            dgvPacientes.DataSource = Session["listaPacientes"];
            dgvPacientes.DataBind();
        }

        protected void ddlEstadoPacientes_SelectedIndexChanged(object sender, EventArgs e)
        {
            txtBuscar.Text = string.Empty;
            cargarPacientes();
        }

        protected void txtBuscar_TextChanged(object sender, EventArgs e)
        {
            List<Paciente> lista = (List<Paciente>)Session["listaPacientes"];
            string filtro = txtBuscar.Text.Trim().ToUpper();

            List<Paciente> listaFiltrada = lista.FindAll(x =>
                x.Apellido.ToUpper().Contains(filtro) ||
                x.Nombre.ToUpper().Contains(filtro) ||
                x.Dni.Contains(filtro)
            );

            dgvPacientes.DataSource = listaFiltrada;
            dgvPacientes.DataBind();
        }

        protected void dgvPacientes_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            if (e.CommandName == "VerHistorial")
            {
                string id = e.CommandArgument.ToString();
                Response.Redirect("HistorialDeTurnos.aspx?idPaciente=" + id, false);
            }
            else if (e.CommandName == "Editar")
            {
                string id = e.CommandArgument.ToString();
                Response.Redirect("FormularioPaciente.aspx?id=" + id); 
            }
        }

    }
}
