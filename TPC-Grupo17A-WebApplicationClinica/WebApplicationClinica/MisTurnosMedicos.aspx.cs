using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplicationClinica
{
    public partial class MisTurnosMedicos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                cargarGrillaVacia();
            }
        }

        private void cargarGrillaVacia()
        {
            DataTable tabla = new DataTable();
            tabla.Columns.Add("Fecha");
            tabla.Columns.Add("Hora");
            tabla.Columns.Add("Paciente");
            tabla.Columns.Add("Especialidad");
            tabla.Columns.Add("Estado");
            tabla.Columns.Add("Observaciones");
            tabla.Columns.Add("Diagnostico");

            dgvMisTurnos.DataSource = tabla;
            dgvMisTurnos.DataBind();
        }
    }
}