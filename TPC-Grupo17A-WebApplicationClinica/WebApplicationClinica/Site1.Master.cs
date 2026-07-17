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
            string paginaActual = System.IO.Path.GetFileName(Request.Url.AbsolutePath);

            if (Page is Login || paginaActual == "RecuperarPassword.aspx")
                return;

            if (!Seguridad.SesionActiva(Session["Usuario"]))
                Response.Redirect("Login.aspx", false);
        }

        private void ValidarPermisosPorPagina()
        {
            string paginaActual = System.IO.Path.GetFileName(Request.Url.AbsolutePath);

            if (Page is Login || paginaActual == "RecuperarPassword.aspx")
                return;

            Usuario usuario = Session["Usuario"] as Usuario;
            if (usuario == null || Seguridad.EsAdmin(usuario))
                return;

            if (paginaActual == "CambiarPassword.aspx")
                return;

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
                    || paginaActual == "MisTurnosMedicos.aspx"
                    || paginaActual == "AtencionTurno.aspx";

            return false;
        }

        private void ActualizarLoginNavbar()
        {
            Usuario usuario = Session["Usuario"] as Usuario;

            OcultarLinksPrivados();

            if (usuario == null)
            {
                divUsuarioNavbar.Visible = false;
                lnkLogin.Visible = false;
                lnkLogin.Text = "Login";
                lnkInicio.InnerText = "Iniciar sesión";
                lnkInicio.HRef = "Login.aspx";
                return;
            }

            divUsuarioNavbar.Visible = true;
            btnUsuarioNavbar.InnerHtml = ObtenerTextoUsuarioNavbar(usuario);
            lnkLogin.Visible = true;
            lnkLogin.Text = "Cerrar sesión";
            lnkLogin.CssClass = "dropdown-item";
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
                lnkUsuarios.Visible = true;
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


        private string ObtenerTextoUsuarioNavbar(Usuario usuario)
        {
            string rol = "Usuario";

            if (Seguridad.EsAdmin(usuario))
                rol = "Administrador";
            else if (Seguridad.EsRecepcionista(usuario))
                rol = "Recepcionista";
            else if (Seguridad.EsMedico(usuario))
                rol = "Médico";

            string nombreMostrar = HttpUtility.HtmlEncode(usuario.NombreMostrar);
            return "<span class=\"fw-bold\">" + rol + ":</span> " + nombreMostrar;
        }
        private void OcultarLinksPrivados()
        {
            lnkTurnos.Visible = false;
            lnkPacientes.Visible = false;
            lnkMedicos.Visible = false;
            lnkEspecialidades.Visible = false;
            lnkHorariosMedicos.Visible = false;
            lnkMisTurnos.Visible = false;
            lnkUsuarios.Visible = false;
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


