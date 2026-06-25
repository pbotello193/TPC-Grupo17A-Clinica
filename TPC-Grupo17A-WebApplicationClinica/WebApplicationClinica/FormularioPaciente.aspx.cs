using dominio;
using negocio;
using System;
using System.Text.RegularExpressions;

namespace WebApplicationClinica
{
    public partial class FormularioPaciente : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            txtId.Enabled = false;

            try
            {
                string id = Request.QueryString["id"] != null ? Request.QueryString["id"].ToString() : "";

                if (id != "" && !IsPostBack)
                {
                    pnlId.Visible = true;
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
                lblErrorGeneral.Visible = false;
                lblErrorNombre.Visible = false;
                lblErrorApellido.Visible = false;
                lblErrorDni.Visible = false;

                if (txtNombre.Text == "" || txtApellido.Text == "" || txtDni.Text == "" || txtFechaNacimiento.Text == "" || txtTelefono.Text == "" || txtEmail.Text == "" || txtDireccion.Text == "")
                {
                    lblErrorGeneral.Text = "Complete todos los campos.";
                    lblErrorGeneral.Visible = true;
                    return;
                }

                string nombre = txtNombre.Text.Trim();

                if (!Regex.IsMatch(nombre, @"^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ' ]{2,30}$"))
                {
                    lblErrorNombre.Text = "El nombre debe tener entre 2 y 30 caracteres y solo puede contener letras y espacios.";
                    lblErrorNombre.Visible = true;
                    return;
                }

                string apellido = txtApellido.Text.Trim();

                if (!Regex.IsMatch(apellido, @"^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ' ]{2,30}$"))
                {
                    lblErrorApellido.Text = "El apellido debe tener entre 2 y 30 caracteres y solo puede contener letras y espacios.";
                    lblErrorApellido.Visible = true;
                    return;
                }

                string dni = txtDni.Text.Trim();

                if (!Regex.IsMatch(dni, @"^[0-9]{7,8}$"))
                {
                    lblErrorDni.Text = "El DNI debe contener entre 7 y 8 números, sin puntos ni espacios.";
                    lblErrorDni.Visible = true;
                    return;
                }

                Paciente paciente = new Paciente();
                PacienteNegocio pacienteNegocio = new PacienteNegocio();

                // existe DNI
                int idPaciente = 0;
                if (Request.QueryString["id"] != null)
                    idPaciente = int.Parse(txtId.Text);

                if (pacienteNegocio.existeDni(txtDni.Text, idPaciente))
                {
                    lblErrorDni.Text = "Ya existe un paciente registrado con ese DNI.";
                    lblErrorDni.Visible = true;
                    return;
                }

                paciente.Nombre = nombre;
                paciente.Apellido = apellido;
                paciente.Dni = dni;
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

    }
}
