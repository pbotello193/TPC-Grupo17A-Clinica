<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="FormularioMedico.aspx.cs" Inherits="WebApplicationClinica.FormularioMedico" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="medico-form-panel">
        <div class="medico-form-header">
            <div class="medico-form-icon">
                <i class="bi bi-person-plus"></i>
            </div>
            <div>
                <h1 class="h2 fw-bold mb-2">Nuevo Médico</h1>
                <p class="text-muted fs-6 mb-0">Complete los datos del médico para registrarlo en el sistema.</p>
            </div>
        </div>

        <asp:Label ID="lblErrorGeneral" runat="server" CssClass="alert alert-danger d-block" Visible="false" />

        <asp:Panel ID="pnlId" runat="server" Visible="false">
            <div class="mb-3">
                <label for="txtId" class="form-label">Id</label>
                <div class="input-icon-group">
                    <span class="input-icon"><i class="bi bi-hash"></i></span>
                    <asp:TextBox runat="server" ID="txtId" CssClass="form-control" />
                </div>
            </div>
        </asp:Panel>

        <h2 class="h5 medico-section-title">Datos personales</h2>

        <div class="mb-3">
            <label for="txtNombre" class="form-label">Nombre</label>
            <div class="input-icon-group">
                <span class="input-icon"><i class="bi bi-person"></i></span>
                <asp:TextBox runat="server" ID="txtNombre" CssClass="form-control" placeholder="Ingrese el nombre" />
            </div>
            <asp:Label ID="lblErrorNombre" runat="server" CssClass="alert alert-danger d-block mt-2" Visible="false" />
        </div>

        <div class="mb-3">
            <label for="txtApellido" class="form-label">Apellido</label>
            <div class="input-icon-group">
                <span class="input-icon"><i class="bi bi-person"></i></span>
                <asp:TextBox runat="server" ID="txtApellido" CssClass="form-control" placeholder="Ingrese el apellido" />
            </div>
            <asp:Label ID="lblErrorApellido" runat="server" CssClass="alert alert-danger d-block mt-2" Visible="false" />
        </div>

        <div class="mb-3">
            <label for="txtMatricula" class="form-label">Matrícula</label>
            <div class="input-icon-group">
                <span class="input-icon"><i class="bi bi-card-text"></i></span>
                <asp:TextBox runat="server" ID="txtMatricula" CssClass="form-control" placeholder="Ingrese la matrícula profesional" />
            </div>
            <asp:Label ID="lblErrorMatricula" runat="server" CssClass="alert alert-danger d-block mt-2" Visible="false" />
        </div>

        <div class="mb-3">
            <label for="txtTelefono" class="form-label">Teléfono</label>
            <div class="input-icon-group">
                <span class="input-icon"><i class="bi bi-telephone"></i></span>
                <asp:TextBox runat="server" ID="txtTelefono" CssClass="form-control" placeholder="Ingrese el teléfono" />
            </div>
            <asp:Label ID="lblErrorTelefono" runat="server" CssClass="alert alert-danger d-block mt-2" Visible="false" />
        </div>

        <div class="mb-3">
            <label for="txtEmail" class="form-label">Email</label>
            <div class="input-icon-group">
                <span class="input-icon"><i class="bi bi-envelope"></i></span>
                <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control" placeholder="Ingrese el email" />
            </div>
            <asp:Label ID="lblErrorEmail" runat="server" CssClass="alert alert-danger d-block mt-2" Visible="false" />
        </div>

        <div class="medico-specialties-panel">
            <asp:Label ID="lblMensaje" runat="server" CssClass="alert alert-danger d-block" Visible="false"></asp:Label>

            <h2 class="h5 medico-section-title">Especialidades</h2>
            <p class="medico-specialties-help">Seleccione una o más especialidades del médico.</p>
            <asp:CheckBoxList ID="cblEspecialidades" runat="server"
                CssClass="especialidades-lista"
                RepeatLayout="Flow"
                RepeatDirection="Vertical"
                DataTextField="Nombre"
                DataValueField="Id"></asp:CheckBoxList>
            <asp:Label ID="lblErrorEspecialidades" runat="server" CssClass="alert alert-danger d-block mt-2" Visible="false" />
        </div>

        <asp:Panel ID="pnlUsuarioMedico" runat="server" CssClass="medico-access-panel">
            <h2 class="h5 medico-section-title">Usuario de acceso</h2>

            <div class="mb-3">
                <label for="txtUsuario" class="form-label">Usuario</label>
                <div class="input-icon-group">
                    <span class="input-icon"><i class="bi bi-person"></i></span>
                    <asp:TextBox runat="server" ID="txtUsuario" CssClass="form-control" placeholder="Nombre de usuario para iniciar sesión" />
                </div>
                <asp:Label ID="lblErrorUsuario" runat="server" CssClass="alert alert-danger d-block mt-2" Visible="false" />
            </div>

            <div class="mb-3">
                <label for="txtPassword" class="form-label">Contraseña</label>
                <div class="input-icon-group">
                    <span class="input-icon"><i class="bi bi-lock"></i></span>
                    <asp:TextBox runat="server" ID="txtPassword" CssClass="form-control" TextMode="Password" placeholder="Ingrese una contraseña segura" />
                </div>
                <asp:Label ID="lblErrorPassword" runat="server" CssClass="alert alert-danger d-block mt-2" Visible="false" />
            </div>
        </asp:Panel>

        <div class="medico-form-actions">
            <asp:Button Text="Aceptar" runat="server" ID="btnAceptar" class="btn btn-primary" OnClick="btnAceptar_Click" />
            <a href="WebForm-Medico.aspx" class="btn btn-outline-danger">Cancelar</a>
            <asp:Button ID="btnCambiarEstado" runat="server" CssClass="btn btn-secondary" Visible="false" OnClick="btnCambiarEstado_Click" />
        </div>
    </div>

    <script>
        function normalizarEspecialidad(texto) {
            return texto
                .toLowerCase()
                .normalize("NFD")
                .replace(/[\u0300-\u036f]/g, "");
        }

        function obtenerIconoEspecialidad(nombre) {
            const normalizado = normalizarEspecialidad(nombre);

            if (normalizado.includes("pediatria")) return { icono: "bi-people", clase: "pediatria" };
            if (normalizado.includes("cardiologia")) return { icono: "bi-heart-pulse", clase: "cardiologia" };
            if (normalizado.includes("traumatologia")) return { icono: "bi-bandaid", clase: "traumatologia" };
            if (normalizado.includes("dermatologia")) return { icono: "bi-droplet", clase: "dermatologia" };
            if (normalizado.includes("ginecologia")) return { icono: "bi-gender-female", clase: "ginecologia" };

            return { icono: "bi-stethoscope", clase: "default" };
        }

        function decorarEspecialidades() {
            const contenedor = document.getElementById("<%= cblEspecialidades.ClientID %>");
            if (!contenedor || contenedor.dataset.decorado === "true") return;

            const inputs = Array.from(contenedor.querySelectorAll("input[type='checkbox']"));

            inputs.forEach(input => {
                const label = contenedor.querySelector("label[for='" + input.id + "']");
                if (!label) return;

                const nombre = label.textContent.trim();
                const datosIcono = obtenerIconoEspecialidad(nombre);

                const opcion = document.createElement("div");
                opcion.className = "specialty-option";

                const icono = document.createElement("span");
                icono.className = "specialty-icon " + datosIcono.clase;
                icono.innerHTML = "<i class='bi " + datosIcono.icono + "'></i>";

                input.parentNode.insertBefore(opcion, input);
                opcion.appendChild(input);
                opcion.appendChild(icono);
                opcion.appendChild(label);
            });

            contenedor.querySelectorAll("br").forEach(br => br.remove());
            contenedor.dataset.decorado = "true";
        }

        document.addEventListener("DOMContentLoaded", decorarEspecialidades);
    </script>
</asp:Content>
