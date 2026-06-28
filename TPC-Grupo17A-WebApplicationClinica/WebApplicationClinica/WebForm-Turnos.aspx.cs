using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using negocio;
using dominio;

namespace WebApplicationClinica
{
    public partial class WebForm_Turno : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                cargarEspecialidades();
                cargarPacientesActivos();
            }
        }

        private void cargarEspecialidades()
        {
            EspecialidadNegocio negocio = new EspecialidadNegocio();

            ddlEspecialidad.DataSource = negocio.listarEspecialidades();
            ddlEspecialidad.DataTextField = "Nombre";
            ddlEspecialidad.DataValueField = "Id";
            ddlEspecialidad.DataBind();

            ListItem opcionInicial = new ListItem("Seleccione una especialidad", "0");
            opcionInicial.Attributes.Add("disabled", "disabled");
            opcionInicial.Attributes.Add("style", "display:none");
            ddlEspecialidad.Items.Insert(0, opcionInicial);
            ddlEspecialidad.SelectedIndex = 0;
        }

        private void cargarPacientesActivos()
        {
            PacienteNegocio negocio = new PacienteNegocio();
            Session["listaPacientesTurnos"] = negocio.listarPacientes();
        }

        //buscar pacientes por DNI, nombre o apellido
        protected void txtBuscarPaciente_TextChanged(object sender, EventArgs e)
        {
            List<Paciente> lista = (List<Paciente>)Session["listaPacientesTurnos"];
            string filtro = txtBuscarPaciente.Text.Trim().ToUpper();

            hfIdPaciente.Value = string.Empty;
            lblPacienteSeleccionado.Visible = false;

            if (string.IsNullOrEmpty(filtro))
            {
                dgvPacientesEncontrados.Visible = false;
                return;
            }

            List<Paciente> listaFiltrada = lista.FindAll(x =>
                x.Apellido.ToUpper().Contains(filtro) ||
                x.Nombre.ToUpper().Contains(filtro) ||
                x.Dni.Contains(filtro)
            );

            dgvPacientesEncontrados.DataSource = listaFiltrada;
            dgvPacientesEncontrados.DataBind();
            dgvPacientesEncontrados.Visible = true;
        }

        //guardar el paciente seleccionado y ocultar la lista
        protected void dgvPacientesEncontrados_SelectedIndexChanged(object sender, EventArgs e)
        {
            List<Paciente> lista = (List<Paciente>)Session["listaPacientesTurnos"];
            int idPaciente = Convert.ToInt32(dgvPacientesEncontrados.SelectedDataKey.Value);

            Paciente pacienteSeleccionado = lista.Find(x => x.Id == idPaciente);

            if (pacienteSeleccionado != null)
            {
                hfIdPaciente.Value = pacienteSeleccionado.Id.ToString();
                txtBuscarPaciente.Text = pacienteSeleccionado.Apellido + ", " + pacienteSeleccionado.Nombre;
                lblPacienteSeleccionado.Text = "Paciente seleccionado: " + pacienteSeleccionado.Apellido + ", " + pacienteSeleccionado.Nombre + " - DNI " + pacienteSeleccionado.Dni;
                lblPacienteSeleccionado.Visible = true;
                dgvPacientesEncontrados.Visible = false;
            }
        }

        //buscar medicos y horarios segun especialidad
        protected void btnBuscarHorarios_Click(object sender, EventArgs e)
        {
            
        }

        //asignar el turno elegido al paciente seleccionado
        protected void dgvHorariosDisponibles_SelectedIndexChanged(object sender, EventArgs e)
        {
            
        }
    }
}