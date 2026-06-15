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
    public partial class FormularioEspecialidad : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            txtId.Enabled = false;
            btnEliminarFisico.Visible = false;
            try
            {
                string id = Request.QueryString["id"] != null ? Request.QueryString["id"].ToString() : "";
                if (id != "" && !IsPostBack)
                {
                    btnEliminarFisico.Visible = true;
                    txtId.Text = id;

                    List<Especialidad> listaEspecialidades = (List<Especialidad>)Session["listaEspecialidades"];
                    Especialidad aux = listaEspecialidades.Find(x => x.Id == int.Parse(id));

                    txtId.Text = aux.Id.ToString();
                    txtNombre.Text = aux.Nombre;
                    txtDescripcion.Text = aux.Descripcion;



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
                EspecialidadNegocio espNegocio = new EspecialidadNegocio();
                Especialidad nuevo = new Especialidad();

                nuevo.Nombre = txtNombre.Text;
                nuevo.Descripcion = txtDescripcion.Text;

                if (Request.QueryString["id"] != null)
                {
                    nuevo.Id = int.Parse(txtId.Text);
                    espNegocio.modificar(nuevo);
                }
                else
                {
                    espNegocio.agregar(nuevo);
                }

                Response.Redirect("ListaEspecialidades.aspx", false);
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
            }
        }



        protected void btnEliminarFisico_Click(object sender, EventArgs e)
        {
            //Validar que no este asociada a ningun medico antes de borrar!!
            try
            {
                EspecialidadNegocio espNegocio = new EspecialidadNegocio();

                int idEspecialidad = int.Parse(txtId.Text);
                espNegocio.eliminarFisico(idEspecialidad);
                Response.Redirect("ListaEspecialidades.aspx", false);
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
            }
        }
    }
}