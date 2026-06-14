using dominio;
using negocio;
using System;
using System.Collections.Generic;
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
            try
            {
                if (!IsPostBack)
                {
                    EspecialidadNegocio negocio = new EspecialidadNegocio();
                    cblEspecialidades.DataSource = negocio.listarEspecialidades();
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
                Medico nuevo = new Medico();
                MedicoNegocio medNegocio = new MedicoNegocio();
                EspecialidadNegocio espNegocio = new EspecialidadNegocio();

                nuevo.Nombre = txtNombre.Text;
                nuevo.Apellido = txtApellido.Text;
                nuevo.Matricula = txtMatricula.Text;
                nuevo.Telefono = txtTelefono.Text;
                nuevo.Email = txtEmail.Text;

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
                throw ex;
            }
        }
    }
}