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
                Page.Validate();
                if (!Page.IsValid)
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
                nuevo.Nombre = txtNombre.Text;
                nuevo.Apellido = txtApellido.Text;
                nuevo.Matricula = txtMatricula.Text;
                if (medNegocio.validarMatricula(txtMatricula.Text, nuevo.Id))
                { //Aca es donde lanza el validador si la matricula ya existe
                    validadorMatricula.IsValid = false;
                    validadorMatricula.ErrorMessage = "Ya existe un médico con esa matrícula.";
                    return;
                }
                nuevo.Telefono = txtTelefono.Text;
                nuevo.Email = txtEmail.Text;
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
                throw ex; //manejar aca el mensaje de error de matricula duplicada
            }
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
                lblErrorUsuario.Text = "Ingrese la contraseña del médico.";
                lblErrorUsuario.Visible = true;
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