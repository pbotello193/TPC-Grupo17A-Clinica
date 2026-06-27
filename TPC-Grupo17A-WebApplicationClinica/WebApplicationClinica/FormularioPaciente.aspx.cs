using System;
using System.Linq;
using System.Text.RegularExpressions;
using dominio;
using negocio;

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

                    btnCambiarEstado.Visible = true;
                    btnCambiarEstado.Text = aux.Activo ? "Dar de baja" : "Reactivar";
                    btnCambiarEstado.CssClass = aux.Activo ? "btn btn-secondary" : "btn btn-success";

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
                lblErrorFechaNacimiento.Visible = false;
                lblErrorTelefono.Visible = false;
                lblErrorEmail.Visible = false;
                lblErrorDireccion.Visible = false;

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

                //Fechas
                DateTime fechaNacimiento = DateTime.Parse(txtFechaNacimiento.Text);

                if (fechaNacimiento > DateTime.Today)
                {
                    lblErrorFechaNacimiento.Text = "La fecha de nacimiento no puede ser posterior al día de hoy.";
                    lblErrorFechaNacimiento.Visible = true;
                    return;
                }

                if (fechaNacimiento < DateTime.Today.AddYears(-130))
                {
                    lblErrorFechaNacimiento.Text = "La fecha de nacimiento no puede superar los 130 años.";
                    lblErrorFechaNacimiento.Visible = true;
                    return;
                }

                string telefono = txtTelefono.Text.Trim();

                if (!Regex.IsMatch(telefono, @"^\+?[0-9]{10,13}$"))
                {
                    lblErrorTelefono.Text = "El teléfono debe contener entre 10 y 13 números. Puede comenzar con el signo +.";
                    lblErrorTelefono.Visible = true;
                    return;
                }

                string email = txtEmail.Text.Trim().ToLower();

                if (email.Length > 50 || !Regex.IsMatch(email, @"^[^@\s]+@[^@\s]+\.[^@\s]+$"))
                {
                    lblErrorEmail.Text = "Ingrese un correo electrónico válido de hasta 50 caracteres.";
                    lblErrorEmail.Visible = true;
                    return;
                }

                string direccion = txtDireccion.Text.Trim();

                if (direccion.Length < 5 || direccion.Length > 100 ||
                    !direccion.Any(char.IsLetter) ||
                    !Regex.IsMatch(direccion, @"^[a-zA-ZáéíóúÁÉÍÓÚñÑüÜ0-9\s.,°º#/-]+$"))
                {
                    lblErrorDireccion.Text = "La dirección debe tener entre 5 y 100 caracteres y contener al menos una letra.";
                    lblErrorDireccion.Visible = true;
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
                paciente.FechaNacimiento = fechaNacimiento;
                paciente.Telefono = telefono;
                paciente.Email = email;
                paciente.Direccion = direccion;

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

        protected void btnCambiarEstado_Click(object sender, EventArgs e)
        {
            try
            {
                int idPaciente = int.Parse(txtId.Text);
                PacienteNegocio pacienteNegocio = new PacienteNegocio();
                Paciente paciente = pacienteNegocio.obtenerPorId(idPaciente);

                if (paciente.Activo)
                    pacienteNegocio.desactivar(idPaciente);
                else
                    pacienteNegocio.reactivar(idPaciente);

                Response.Redirect("WebForm-Paciente.aspx", false);
            }
            catch (Exception ex)
            {
                Session.Add("error", ex);
            }
        }
    }
}
