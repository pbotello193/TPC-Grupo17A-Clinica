using dominio;
using negocio;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.WebSockets;
using System.Text.RegularExpressions;

namespace WebApplicationClinica
{
    public partial class FormularioMedico : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            txtId.Enabled = false;
            pnlUsuarioMedico.Visible = Request.QueryString["id"] == null;
            try
            {
                if (!IsPostBack)
                {
                    EspecialidadNegocio negocio = new EspecialidadNegocio();
                    cblEspecialidades.DataSource = negocio.listarTodasEspecialidades();
                    cblEspecialidades.DataBind();
                }
                string id = Request.QueryString["id"] != null ? Request.QueryString["id"].ToString() : "";
                if (id != "" && !IsPostBack)
                {
                    List<Medico> listaMedicos = (List<Medico>)Session["listaMedicos"];
                    Medico aux = listaMedicos.Find(x => x.Id == int.Parse(id));

                    txtId.Text = aux.Id.ToString();
                    txtNombre.Text = aux.Nombre;
                    txtApellido.Text = aux.Apellido;
                    txtMatricula.Text = aux.Matricula;
                    txtTelefono.Text = aux.Telefono;
                    txtEmail.Text = aux.Email;

                    if (aux.Activo) //lo trae siempre en false!!!
                    {
                        rdbActivo.Checked = true;
                    }
                    else
                    {
                        rdbInactivo.Checked = true;
                    }
                    if (aux.Especialidades != null)
                    {
                        foreach (ListItem item in cblEspecialidades.Items)
                        {
                            if (aux.Especialidades.Any(x => x.Id == int.Parse(item.Value)))
                            {
                                item.Selected = true;
                            }
                        }
                    }

                }
            }
            catch (Exception ex)
            {

                Session.Add("error", ex);
            }

        }

        protected void btnAceptar_Click(object sender, EventArgs e)
        {
            try
            {
                if (!ValidarDatosMedico())
                    return;

                if (Request.QueryString["id"] == null && !ValidarUsuarioMedico())
                    return;

                Medico nuevo = new Medico();
                MedicoNegocio medNegocio = new MedicoNegocio();
                EspecialidadNegocio espNegocio = new EspecialidadNegocio();
                UsuarioNegocio usuarioNegocio = new UsuarioNegocio();

                // Si es una modificación asigno el id antes de validar sino siempre va con 0
                if (Request.QueryString["id"] != null)
                {
                    nuevo.Id = int.Parse(txtId.Text);
                }
                nuevo.Nombre = txtNombre.Text.Trim();
                nuevo.Apellido = txtApellido.Text.Trim();
                nuevo.Matricula = txtMatricula.Text.Trim();
                if (medNegocio.validarMatricula(txtMatricula.Text, nuevo.Id))
                {
                    lblErrorMatricula.Text = "Ya existe un médico con esa matrícula.";
                    lblErrorMatricula.Visible = true;
                    return;
                }
                nuevo.Telefono = txtTelefono.Text.Trim();
                nuevo.Email = txtEmail.Text.Trim().ToLower();
                if (rdbActivo.Checked)
                {
                    nuevo.Activo = true;
                }
                else
                {
                    nuevo.Activo = false;
                }

                if (Request.QueryString["id"] != null)
                {
                    nuevo.Id = int.Parse(txtId.Text);
                    medNegocio.modificar(nuevo);
                    espNegocio.resetearEspecialidades(nuevo.Id);

                    foreach (ListItem item in cblEspecialidades.Items)
                    {
                        if (item.Selected)
                        {
                            espNegocio.asignarEspecialidad(nuevo.Id, int.Parse(item.Value));
                        }
                    }
                }
                else
                {
                    int idMedicoAgregado = medNegocio.agregar(nuevo);
                    Usuario usuarioMedico = new Usuario();
                    usuarioMedico.User = txtUsuario.Text.Trim();
                    usuarioMedico.Pass = txtPassword.Text.Trim();
                    usuarioMedico.IdMedico = idMedicoAgregado;
                    usuarioNegocio.agregarUsuarioMedico(usuarioMedico);

                    foreach (ListItem item in cblEspecialidades.Items)
                    {
                        if (item.Selected)
                        {
                            espNegocio.asignarEspecialidad(idMedicoAgregado, int.Parse(item.Value));
                        }
                    }
                }
                Response.Redirect("WebForm-Medico.aspx", false);
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
                lblErrorGeneral.Text = ex.Message;
                lblErrorGeneral.Visible = true;
            }
        }

        private bool ValidarDatosMedico()
        {
            LimpiarMensajesValidacionMedico();

            if (txtNombre.Text.Trim() == "" || txtApellido.Text.Trim() == "" || txtMatricula.Text.Trim() == "" || txtTelefono.Text.Trim() == "" || txtEmail.Text.Trim() == "")
            {
                lblErrorGeneral.Text = "Complete todos los campos del médico.";
                lblErrorGeneral.Visible = true;
                return false;
            }

            string nombre = txtNombre.Text.Trim();
            if (!Regex.IsMatch(nombre, @"^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ' ]{2,30}$"))
            {
                lblErrorNombre.Text = "El nombre debe tener entre 2 y 30 caracteres y solo puede contener letras y espacios.";
                lblErrorNombre.Visible = true;
                return false;
            }

            string apellido = txtApellido.Text.Trim();
            if (!Regex.IsMatch(apellido, @"^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ' ]{2,30}$"))
            {
                lblErrorApellido.Text = "El apellido debe tener entre 2 y 30 caracteres y solo puede contener letras y espacios.";
                lblErrorApellido.Visible = true;
                return false;
            }

            string matricula = txtMatricula.Text.Trim();
            if (!Regex.IsMatch(matricula, @"^[a-zA-Z0-9-]{3,10}$"))
            {
                lblErrorMatricula.Text = "La matrícula debe tener entre 3 y 10 caracteres y solo puede contener letras, números y guiones.";
                lblErrorMatricula.Visible = true;
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

            if (!cblEspecialidades.Items.Cast<ListItem>().Any(item => item.Selected))
            {
                lblErrorEspecialidades.Text = "Seleccione al menos una especialidad.";
                lblErrorEspecialidades.Visible = true;
                return false;
            }

            if (!rdbActivo.Checked && !rdbInactivo.Checked)
            {
                lblErrorEstado.Text = "Seleccione el estado del médico.";
                lblErrorEstado.Visible = true;
                return false;
            }

            return true;
        }

        private void LimpiarMensajesValidacionMedico()
        {
            lblErrorGeneral.Visible = false;
            lblErrorNombre.Visible = false;
            lblErrorApellido.Visible = false;
            lblErrorMatricula.Visible = false;
            lblErrorTelefono.Visible = false;
            lblErrorEmail.Visible = false;
            lblErrorEspecialidades.Visible = false;
            lblErrorEstado.Visible = false;
            lblErrorUsuario.Visible = false;
            lblErrorPassword.Visible = false;
        }

        private bool ValidarUsuarioMedico()
        {
            lblErrorUsuario.Visible = false;
            string usuario = txtUsuario.Text.Trim();
            string password = txtPassword.Text.Trim();

            if (string.IsNullOrWhiteSpace(usuario))
            {
                lblErrorUsuario.Text = "Ingrese el usuario del médico.";
                lblErrorUsuario.Visible = true;
                return false;
            }

            if (string.IsNullOrWhiteSpace(password))
            {
                lblErrorPassword.Text = "Ingrese la contraseña del médico.";
                lblErrorPassword.Visible = true;
                return false;
            }

            UsuarioNegocio usuarioNegocio = new UsuarioNegocio();
            if (usuarioNegocio.existeUsuario(usuario))
            {
                lblErrorUsuario.Text = "Ya existe un usuario con ese nombre.";
                lblErrorUsuario.Visible = true;
                return false;
            }

            return true;
        }


        protected void btnEliminarLogico_Click(object sender, EventArgs e)
        {
            try
            {
                MedicoNegocio medNegocio = new MedicoNegocio();

                int idMedico = int.Parse(txtId.Text);
                medNegocio.eliminarLogico(idMedico);
                Response.Redirect("WebForm-Medico.aspx", false);

            }
            catch (Exception ex)
            {

                Session.Add("error", ex);
            }
        }
    }
}
