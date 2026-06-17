using dominio;
using negocio;
using System;

namespace WebApplicationClinica
{
    public partial class FormularioPaciente : System.Web.UI.Page
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
                    PacienteNegocio pacienteNegocio = new PacienteNegocio();
                    Paciente aux = pacienteNegocio.obtenerPorId(int.Parse(id));

                    txtId.Text = aux.Id.ToString();
                    txtNombre.Text = aux.Nombre;
                    txtApellido.Text = aux.Apellido;
                    txtDni.Text = aux.Dni;
                    txtFechaNacimiento.Text = aux.FechaNacimiento.ToString("yyyy-MM-dd");
                    txtTelefono.Text = aux.Telefono;
                    txtEmail.Text = aux.Email;
                    txtDireccion.Text = aux.Direccion;
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
                lblError.Visible = false;

                if (txtNombre.Text == "" || txtApellido.Text == "" || txtDni.Text == "" || txtFechaNacimiento.Text == "" || txtTelefono.Text == "" || txtEmail.Text == "" || txtDireccion.Text == "")
                {
                    lblError.Text = "Complete todos los campos.";
                    lblError.Visible = true;
                    return;
                }

                long dni;
                if (!long.TryParse(txtDni.Text, out dni))
                {
                    lblError.Text = "El DNI solo puede contener numeros.";
                    lblError.Visible = true;
                    return;
                }

                Paciente paciente = new Paciente();
                PacienteNegocio pacienteNegocio = new PacienteNegocio();

                paciente.Nombre = txtNombre.Text;
                paciente.Apellido = txtApellido.Text;
                paciente.Dni = txtDni.Text;
                paciente.FechaNacimiento = DateTime.Parse(txtFechaNacimiento.Text);
                paciente.Telefono = txtTelefono.Text;
                paciente.Email = txtEmail.Text;
                paciente.Direccion = txtDireccion.Text;

                if (Request.QueryString["id"] != null)
                {
                    paciente.Id = int.Parse(txtId.Text);
                    pacienteNegocio.modificar(paciente);
                }
                else
                {
                    pacienteNegocio.agregar(paciente);
                }

                Response.Redirect("WebForm-Paciente.aspx", false);
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
            }
        }

        protected void btnEliminarFisico_Click(object sender, EventArgs e)
        {
            try
            {
                PacienteNegocio pacienteNegocio = new PacienteNegocio();

                int idPaciente = int.Parse(txtId.Text);
                pacienteNegocio.eliminarFisico(idPaciente);
                Response.Redirect("WebForm-Paciente.aspx", false);
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
            }
        }
    }
}
