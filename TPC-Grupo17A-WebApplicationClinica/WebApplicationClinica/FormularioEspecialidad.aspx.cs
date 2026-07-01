using dominio;
using negocio;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services.Description;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace WebApplicationClinica
{
    public partial class FormularioEspecialidad : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            txtId.Enabled = false;
            try
            {
                string id = Request.QueryString["id"] != null ? Request.QueryString["id"].ToString() : "";
                if (id != "" && !IsPostBack)
                {
                    txtId.Text = id;

                    List<Especialidad> listaEspecialidades = (List<Especialidad>)Session["listaEspecialidades"];
                    Especialidad aux = listaEspecialidades.Find(x => x.Id == int.Parse(id));

                    txtId.Text = aux.Id.ToString();
                    txtNombre.Text = aux.Nombre;
                    txtDescripcion.Text = aux.Descripcion;
                    if (aux.Activo)
                    {
                        rdbActivo.Checked = true;
                    }
                    else
                    {
                        rdbInactivo.Checked = true;
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
                if (string.IsNullOrWhiteSpace(txtNombre.Text) || string.IsNullOrWhiteSpace(txtDescripcion.Text))
                {
                    lblMensaje.Text = "Complete todos los datos antes de guardar";
                    return; //para evitar ir a la db
                }

                EspecialidadNegocio espNegocio = new EspecialidadNegocio();
                Especialidad nuevo = new Especialidad();

                nuevo.Nombre = txtNombre.Text;
                nuevo.Descripcion = txtDescripcion.Text;
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
                    //verifica si existe esp. con el mismo nombre y distinto id
                    if (espNegocio.existeEspecialidad(nuevo.Nombre, nuevo.Id))
                    {
                        lblMensaje.Text = "Ya existe una especialidad con ese nombre";
                        return;
                    }
                    espNegocio.modificar(nuevo);
                }
                else
                {
                    //verifica si existe esp. con el mismo nombre
                    if (espNegocio.existeEspecialidad(nuevo.Nombre, nuevo.Id))
                    {
                        lblMensaje.Text = "Ya existe una especialidad con ese nombre.";
                        return;
                    }
                    espNegocio.agregar(nuevo);
                }

                Response.Redirect("ListaEspecialidades.aspx", false);
            }
            catch (System.Data.SqlClient.SqlException ex)
            {
                //excepciones con la db
                Session.Add("error", ex);
                lblMensaje.Text = "Hubo un problema con la base de datos. Intente nuevamente mas tarde.";
                lblMensaje.Visible = true;
            }
            catch (Exception ex)
            {
                //excepciones generales
                Session.Add("error", ex);
                lblMensaje.Text = ex.Message;
                lblMensaje.Visible = true;
            }
        }

       
    }
}