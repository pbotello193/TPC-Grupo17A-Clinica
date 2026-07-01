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
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ValidarSesion();
            ValidarPermisosPorPagina();

            if (!IsPostBack)
                ActualizarLoginNavbar();
        }

        private void ValidarSesion()
        {
            if (Page is Login)
                return;

            if (!Seguridad.SesionActiva(Session["Usuario"]))
                Response.Redirect("Login.aspx", false);
        }

        private void ValidarPermisosPorPagina()
        {
            if (Page is Login)
                return;

            Usuario usuario = Session["Usuario"] as Usuario;
            if (usuario == null || Seguridad.EsAdmin(usuario))
                return;

            string paginaActual = System.IO.Path.GetFileName(Request.Url.AbsolutePath);

            if (!TienePermisoParaPagina(usuario, paginaActual))
                Response.Redirect(usuario.PaginaInicio, false);
        }

        private bool TienePermisoParaPagina(Usuario usuario, string paginaActual)
        {
            if (Seguridad.EsRecepcionista(usuario))
                return paginaActual == "InicioRecepcionista.aspx"
                    || paginaActual == "AgendaMedicos.aspx"
                    || paginaActual == "WebForm-Turnos.aspx"
                    || paginaActual == "WebForm-Paciente.aspx"
                    || paginaActual == "FormularioPaciente.aspx"
                    || paginaActual == "WebForm-Medico.aspx";

            if (Seguridad.EsMedico(usuario))
                return paginaActual == "InicioMedico.aspx"
                    || paginaActual == "MisTurnosMedicos.aspx";

            return false;
        }

        private void ActualizarLoginNavbar()
        {
            Usuario usuario = Session["Usuario"] as Usuario;

            OcultarLinksPrivados();

            if (usuario == null)
            {
                lnkLogin.Visible = false;
                lnkLogin.Text = "Login";
                lnkInicio.InnerText = "Iniciar sesión";
                lnkInicio.HRef = "Login.aspx";
                return;
            }

            lnkLogin.Visible = true;
            lnkLogin.Text = "Cerrar sesión";
            lnkLogin.CssClass = "btn btn-dark ms-lg-auto";
            lnkInicio.InnerText = "Inicio";
            lnkInicio.HRef = usuario.PaginaInicio;

            if (Seguridad.EsAdmin(usuario))
            {
                lnkTurnos.Visible = true;
                lnkPacientes.Visible = true;
                lnkMedicos.Visible = true;
                lnkEspecialidades.Visible = true;
                lnkHorariosMedicos.Visible = true;
                lnkHorariosMedicos.InnerText = "Horarios Médicos";
                lnkHorariosMedicos.HRef = "FormularioTurnoDeTrabajo.aspx";
                lnkMisTurnos.Visible = true;
                lnkMisTurnos.InnerText = "Agenda Médicos";
                lnkMisTurnos.HRef = "AgendaMedicos.aspx";
            }
            else if (Seguridad.EsRecepcionista(usuario))
            {
                lnkTurnos.Visible = true;
                lnkPacientes.Visible = true;
                lnkMedicos.Visible = true;
                lnkHorariosMedicos.Visible = true;
                lnkHorariosMedicos.InnerText = "Agenda Médicos";
                lnkHorariosMedicos.HRef = "AgendaMedicos.aspx";
            }
            else if (Seguridad.EsMedico(usuario))
            {
                lnkMisTurnos.Visible = true;
                lnkMisTurnos.InnerText = "Mis Turnos";
                lnkMisTurnos.HRef = "MisTurnosMedicos.aspx";
            }
        }

        private void OcultarLinksPrivados()
        {
            lnkTurnos.Visible = false;
            lnkPacientes.Visible = false;
            lnkMedicos.Visible = false;
            lnkEspecialidades.Visible = false;
            lnkHorariosMedicos.Visible = false;
            lnkMisTurnos.Visible = false;
        }

        protected void lnkLogin_Click(object sender, EventArgs e)
        {
            if (Session["Usuario"] == null)
            {
                Response.Redirect("Login.aspx", false);
                return;
            }

            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx", false);
        }
    }
}
