using System;
using System.Collections.Generic;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using dominio;
using negocio;

namespace WebApplicationClinica
{
    public partial class FormularioUsuario : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                string id = Request.QueryString["id"] != null ? Request.QueryString["id"].ToString() : "";

                if (id != "" && !IsPostBack)
                {
                    pnlId.Visible = true;
                    UsuarioNegocio usuarioNegocio = new UsuarioNegocio();
                    Usuario usuario = usuarioNegocio.obtenerPersonalAdministrativoPorId(int.Parse(id));

                    if (usuario != null)
                    {
                        btnCambiarEstado.Visible = true;
                        btnCambiarEstado.Text = usuario.Activo ? "Dar de baja" : "Reactivar";
                        btnCambiarEstado.CssClass = usuario.Activo ? "btn btn-secondary" : "btn btn-success";

                        txtId.Text = usuario.Id.ToString();
                        ddlRol.SelectedValue = ((int)usuario.TipoUsuario).ToString();
                        txtApellido.Text = usuario.Apellido;
                        txtNombre.Text = usuario.Nombre;
                        txtDni.Text = usuario.DNI;
                        txtTelefono.Text = usuario.Telefono;
                        txtEmail.Text = usuario.Email;
                        txtUsuario.Text = usuario.User;
                        txtPassword.Text = usuario.Pass;
                    }
                }
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                lblErrorGeneral.Text = "No se pudo cargar el personal administrativo.";
                lblErrorGeneral.Visible = true;
            }
        }

        protected void btnAceptar_Click(object sender, EventArgs e)
        {
            try
            {
                if (!ValidarPersonalAdministrativo())
                    return;

                if (!ValidarUsuarioAdministrativo())
                    return;

                Usuario usuario = new Usuario();
                UsuarioNegocio usuarioNegocio = new UsuarioNegocio();

                if (Request.QueryString["id"] != null)
                    usuario.Id = int.Parse(Request.QueryString["id"].ToString());

                usuario.TipoUsuario = (TipoUsuario)int.Parse(ddlRol.SelectedValue);
                usuario.Apellido = txtApellido.Text.Trim();
                usuario.Nombre = txtNombre.Text.Trim();
                usuario.DNI = txtDni.Text.Trim();
                usuario.Telefono = txtTelefono.Text.Trim();
                usuario.Email = txtEmail.Text.Trim().ToLower();
                usuario.User = txtUsuario.Text.Trim();
                usuario.Pass = txtPassword.Text.Trim();

                if (Request.QueryString["id"] != null)
                    usuarioNegocio.modificarPersonalAdministrativo(usuario);
                else
                    usuarioNegocio.agregarPersonalAdministrativo(usuario);

                Response.Redirect("WebForm-Usuarios.aspx", false);
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                lblErrorGeneral.Text = "No se pudo guardar el personal administrativo. Revise los datos ingresados o intente nuevamente.";
                lblErrorGeneral.Visible = true;
            }
        }

        private bool ValidarPersonalAdministrativo()
        {
            LimpiarMensajesValidacionUsuario();

            if (ddlRol.SelectedValue == "" || txtNombre.Text.Trim() == "" || txtApellido.Text.Trim() == "" || txtDni.Text.Trim() == "" || txtTelefono.Text.Trim() == "" || txtEmail.Text.Trim() == "")
            {
                lblErrorGeneral.Text = "Complete todos los campos.";
                lblErrorGeneral.Visible = true;
                return false;
            }

            if (ddlRol.SelectedValue == "")
            {
                lblErrorRol.Text = "Seleccione un rol.";
                lblErrorRol.Visible = true;
                return false;
            }

            string apellido = txtApellido.Text.Trim();
            if (!Regex.IsMatch(apellido, @"^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ' ]{2,30}$"))
            {
                lblErrorApellido.Text = "El apellido debe tener entre 2 y 30 caracteres y solo puede contener letras y espacios.";
                lblErrorApellido.Visible = true;
                return false;
            }

            string nombre = txtNombre.Text.Trim();
            if (!Regex.IsMatch(nombre, @"^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ' ]{2,30}$"))
            {
                lblErrorNombre.Text = "El nombre debe tener entre 2 y 30 caracteres y solo puede contener letras y espacios.";
                lblErrorNombre.Visible = true;
                return false;
            }

            string dni = txtDni.Text.Trim();
            if (!Regex.IsMatch(dni, @"^[0-9]{7,8}$"))
            {
                lblErrorDni.Text = "El DNI debe contener entre 7 y 8 números, sin puntos ni espacios.";
                lblErrorDni.Visible = true;
                return false;
            }

            UsuarioNegocio usuarioNegocio = new UsuarioNegocio();
            if (usuarioNegocio.existeDniPersonalAdministrativo(dni, obtenerIdActual()))
            {
                lblErrorDni.Text = "Ya existe personal administrativo registrado con ese DNI.";
                lblErrorDni.Visible = true;
                return false;
            }

            string telefono = txtTelefono.Text.Trim();
            if (!Regex.IsMatch(telefono, @"^\+?[0-9]{10,13}$"))
            {
                lblErrorTelefono.Text = "El teléfono debe contener entre 10 y 13 números. Puede comenzar con el signo +.";
                lblErrorTelefono.Visible = true;
                return false;
            }

            string email = txtEmail.Text.Trim().ToLower();
            if (email.Length > 50 || !Regex.IsMatch(email, @"^[^@\s]+@[^@\s]+\.[^@\s]+$"))
            {
                lblErrorEmail.Text = "Ingrese un correo electrónico válido de hasta 50 caracteres.";
                lblErrorEmail.Visible = true;
                return false;
            }

            return true;
        }

        private bool ValidarUsuarioAdministrativo()
        {
            string usuario = txtUsuario.Text.Trim();
            string password = txtPassword.Text.Trim();

            if (string.IsNullOrWhiteSpace(usuario))
            {
                lblErrorUsuario.Text = "Ingrese el usuario.";
                lblErrorUsuario.Visible = true;
                return false;
            }

            if (string.IsNullOrWhiteSpace(password))
            {
                lblErrorPassword.Text = "Ingrese la contraseña.";
                lblErrorPassword.Visible = true;
                return false;
            }


            if (password.Length < 5 || password.Length > 10 || !Regex.IsMatch(password, @"[a-zA-Z]") || !Regex.IsMatch(password, @"\d"))
            {
                lblErrorPassword.Text = "La contraseña debe tener entre 5 y 10 caracteres e incluir letras y números.";
                lblErrorPassword.Visible = true;
                return false;
            }
            UsuarioNegocio usuarioNegocio = new UsuarioNegocio();
            if (usuarioNegocio.existeUsuario(usuario, obtenerIdActual()))
            {
                lblErrorUsuario.Text = "Ya existe un usuario con ese nombre.";
                lblErrorUsuario.Visible = true;
                return false;
            }

            return true;
        }


        private int obtenerIdActual()
        {
            if (Request.QueryString["id"] != null)
                return int.Parse(Request.QueryString["id"].ToString());

            return 0;
        }

        protected void btnCambiarEstado_Click(object sender, EventArgs e)
        {
            try
            {
                UsuarioNegocio usuarioNegocio = new UsuarioNegocio();
                usuarioNegocio.cambiarEstadoPersonalAdministrativo(int.Parse(txtId.Text));
                Response.Redirect("WebForm-Usuarios.aspx", false);
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                lblErrorGeneral.Text = "No se pudo cambiar el estado del personal administrativo.";
                lblErrorGeneral.Visible = true;
            }
        }
        private void LimpiarMensajesValidacionUsuario()
        {
            lblErrorGeneral.Visible = false;
            lblErrorRol.Visible = false;
            lblErrorNombre.Visible = false;
            lblErrorApellido.Visible = false;
            lblErrorDni.Visible = false;
            lblErrorTelefono.Visible = false;
            lblErrorEmail.Visible = false;
            lblErrorUsuario.Visible = false;
            lblErrorPassword.Visible = false;
        }
    }
}

