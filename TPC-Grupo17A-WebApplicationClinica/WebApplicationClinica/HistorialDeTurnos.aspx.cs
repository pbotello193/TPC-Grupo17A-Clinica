using dominio;
using negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplicationClinica
{
    public partial class HistorialDeTurnos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Request.QueryString["idPaciente"] != null)
                {
                    int idPaciente = int.Parse(Request.QueryString["idPaciente"]);

                    cargarDatosPaciente(idPaciente);
                    cargarHistorial(idPaciente);
                }
                else
                {
                    //por si se llega sin el id que vuelva a pacientes
                    Response.Redirect("WebForm-Paciente.aspx", false);
                }
            }
        }

        private void cargarDatosPaciente(int idPaciente)
        {
            PacienteNegocio negocio = new PacienteNegocio();
            Paciente paciente = negocio.obtenerPorId(idPaciente);

            if (paciente == null)
            {
                Response.Redirect("WebForm-Paciente.aspx", false);
                return;
            }

            lblNombrePaciente.Text = paciente.Apellido + ", " + paciente.Nombre;
            lblDniPaciente.Text = paciente.Dni;
        }

        private void cargarHistorial(int idPaciente)
        {
            TurnoNegocio negocio = new TurnoNegocio();
            List<Turno> lista = negocio.listarPorPaciente(idPaciente);

            Session["listaTurnosPaciente"] = lista;

            dgvTurnos.DataSource = lista;
            dgvTurnos.DataBind();
        }

        protected void dgvTurnos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "VerDetalle")
            {
                int idTurno = int.Parse(e.CommandArgument.ToString());
                //aca le pone eso en la clase asi achica la dgv y el panel se muestra al costado
                divDgvTurnos.Attributes["class"] = "col-7"; //divDgvTurnos es el id que le puse en el front con el runnat="server"
                mostrarDetalleTurno(idTurno);
            }
        }

        private void mostrarDetalleTurno(int idTurno)
        {
            //usamos la lista en session para buscar el turno
            List<Turno> lista = Session["listaTurnosPaciente"] as List<Turno>;
            if (lista == null) return;//Por si caducó la session

            Turno turno = lista.Find(t => t.Id == idTurno);
            if (turno == null) return;

            lblDetalleFecha.Text = turno.Fecha.ToString("dd/MM/yyyy");
            lblDetalleHorario.Text = turno.HoraInicio.ToString(@"hh\:mm") + " - " + turno.HoraFin.ToString(@"hh\:mm");
            lblDetalleMedico.Text = turno.Medico.Apellido + ", " + turno.Medico.Nombre + " - Matricula: " + turno.Medico.Matricula;
            lblDetalleEspecialidad.Text = turno.Especialidad.Nombre;
            lblDetalleEstado.Text = turno.Estado;
            lblDetalleEstado.CssClass = badgeEstado(turno.Estado) + "";
            lblDetalleObservaciones.Text = string.IsNullOrEmpty(turno.Observaciones) ? "" : turno.Observaciones;
            lblDetalleDiagnostico.Text = string.IsNullOrEmpty(turno.Diagnostico) ? "" : turno.Diagnostico;
            lblDetalleAsignado.Text = turno.UsuarioAsignacion != null ? turno.UsuarioAsignacion.User : "";
            lblDetalleFechaAsignacion.Text = turno.FechaAsignacion.ToString("dd/MM/yyyy HH:mm");

            pnlDetalleTurno.Visible = true; //Aca ponemos el panel en true para mostrar los detalles
        }

        protected void btnCerrarDetalle_Click(object sender, EventArgs e)
        {
            pnlDetalleTurno.Visible = false; //lo pone en false para cerrarlo
            divDgvTurnos.Attributes["class"] = "col-12"; //vuelve a la grilla de tamaño completa
        }
        // metodo para la clase del badge segun el estado (color)
        protected string badgeEstado(string estado)
        {
            switch (estado)
            {
                case "Asignado": return "badge bg-info text-bg-info";
                case "Asistió": return "badge bg-primary text-bg-info";
                case "Reprogramado": return "badge bg-warning text-bg-info";
                case "Cancelado": return "badge bg-danger text-bg-info";
                case "No asistió": return "badge bg-black";
                default: return "badge bg-secondary-subtle text-bg-info";
            }
        }

    }

}
