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
    public partial class FormularioTurnoDeTrabajo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            if (!IsPostBack)
            {
                MedicoNegocio medicoNegocio = new MedicoNegocio();
                ddlMedico.DataSource = medicoNegocio.listarMedicosActivos();
                ddlMedico.DataValueField = "Id";
                ddlMedico.DataTextField = "Apellido";
                ddlMedico.DataBind();
                ddlMedico.Items.Insert(0, new ListItem("-- Seleccione un Médico --", "0"));
            }
            btnEliminarFisico.Visible = !string.IsNullOrEmpty(txtId.Text);
        }
        protected void ddlMedico_SelectedIndexChanged(object sender, EventArgs e)
        {
            cargarGrilla();
            limpiarCampos();
        }
        private void cargarGrilla()
        {
            int idMedico = int.Parse(ddlMedico.SelectedValue);
            if (idMedico == 0)
            {
                dgvTurnos.DataSource = null;
                dgvTurnos.DataBind();
                return;
            }
            TurnoDeTrabajoNegocio negocio = new TurnoDeTrabajoNegocio();
            List<TurnoDeTrabajo> lista = negocio.listarPorMedico(idMedico);
            var displayList = lista.Select(t => new {
                t.Id,
                DiaNombre = obtenerNombreDia(t.DiaDeLaSemana),
                HoraInicio = t.HoraInicio.ToString(@"hh\:mm"),
                HoraFin = t.HoraFin.ToString(@"hh\:mm")
            }).ToList();
            dgvTurnos.DataSource = displayList;
            dgvTurnos.DataBind();
        }
        private string obtenerNombreDia(DayOfWeek dia)
        {
            switch (dia)
            {
                case DayOfWeek.Monday: return "Lunes";
                case DayOfWeek.Tuesday: return "Martes";
                case DayOfWeek.Wednesday: return "Miércoles";
                case DayOfWeek.Thursday: return "Jueves";
                case DayOfWeek.Friday: return "Viernes";
                case DayOfWeek.Saturday: return "Sábado";
                case DayOfWeek.Sunday: return "Domingo";
                default: return dia.ToString();
            }
        }
        protected void dgvTurnos_SelectedIndexChanged(object sender, EventArgs e)
        {
            string idSelected = dgvTurnos.SelectedDataKey.Value.ToString();
            txtId.Text = idSelected;
            btnEliminarFisico.Visible = true;
            int idMedico = int.Parse(ddlMedico.SelectedValue);
            TurnoDeTrabajoNegocio negocio = new TurnoDeTrabajoNegocio();
            List<TurnoDeTrabajo> lista = negocio.listarPorMedico(idMedico);
            TurnoDeTrabajo seleccionado = lista.Find(x => x.Id == int.Parse(idSelected));
            if (seleccionado != null)
            {
                ddlDia.SelectedValue = ((int)seleccionado.DiaDeLaSemana).ToString();
                txtHoraInicio.Text = seleccionado.HoraInicio.ToString(@"hh\:mm");
                txtHoraFin.Text = seleccionado.HoraFin.ToString(@"hh\:mm");
            }
        }
        protected void btnAceptar_Click(object sender, EventArgs e)
        {
            try
            {
                int idMedico = int.Parse(ddlMedico.SelectedValue);
                if (idMedico == 0) return;
                TurnoDeTrabajoNegocio negocio = new TurnoDeTrabajoNegocio();
                TurnoDeTrabajo nuevo = new TurnoDeTrabajo();
                nuevo.IdMedico = idMedico;
                nuevo.DiaDeLaSemana = (DayOfWeek)int.Parse(ddlDia.SelectedValue);
                nuevo.HoraInicio = TimeSpan.Parse(txtHoraInicio.Text);
                nuevo.HoraFin = TimeSpan.Parse(txtHoraFin.Text);
                if (txtId.Text != "")
                {
                    nuevo.Id = int.Parse(txtId.Text);
                    negocio.modificar(nuevo);
                }
                else
                {
                    negocio.agregar(nuevo);
                }
                cargarGrilla();
                limpiarCampos();
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
            }
        }
        protected void btnEliminarFisico_Click(object sender, EventArgs e)
        {
            try
            {
                TurnoDeTrabajoNegocio negocio = new TurnoDeTrabajoNegocio();
                int id = int.Parse(txtId.Text);
                negocio.eliminar(id);
                cargarGrilla();
                limpiarCampos();
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
            }
        }
        private void limpiarCampos()
        {
            txtId.Text = "";
            ddlDia.SelectedIndex = 0;
            txtHoraInicio.Text = "";
            txtHoraFin.Text = "";
            btnEliminarFisico.Visible = false;
        }
    }
}