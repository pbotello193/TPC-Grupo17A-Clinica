using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplicationClinica
{
    public partial class WebForm_Turno : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        //buscar pacientes por DNI, nombre o apellido
        protected void txtBuscarPaciente_TextChanged(object sender, EventArgs e)
        {
          
        }

        //guardar el paciente seleccionado y ocultar la lista
        protected void dgvPacientesEncontrados_SelectedIndexChanged(object sender, EventArgs e)
        {
            
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