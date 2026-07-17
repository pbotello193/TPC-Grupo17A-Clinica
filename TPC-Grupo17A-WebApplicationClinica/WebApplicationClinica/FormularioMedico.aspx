<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="FormularioMedico.aspx.cs" Inherits="WebApplicationClinica.FormularioMedico" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            min-height: 100vh;
            background-image: linear-gradient(rgba(255, 255, 255, .50), rgba(255, 255, 255, .50)), url('Images/fondoInicio.png');
            background-size: cover;
            background-position: center;
            background-attachment: fixed;
        }

        .navbar {
            margin: 16px;
            border-radius: 14px;
            background: rgba(255, 255, 255, .72) !important;
            box-shadow: 0 12px 32px rgba(15, 23, 42, .12);
            backdrop-filter: blur(10px);
        }

        .navbar .nav-link,
        .navbar .navbar-brand {
            color: #172033;
            font-weight: 500;
        }

        .navbar .navbar-brand {
            color: #0d6efd;
            font-weight: 700;
        }

        .navbar .btn-outline-dark {
            background: rgba(255, 255, 255, .65);
            border-color: rgba(15, 23, 42, .12);
            box-shadow: 0 8px 20px rgba(15, 23, 42, .08);
        }

        .medico-form-panel {
            max-width: 980px;
            margin: 48px auto 72px;
            padding: 32px;
            border-radius: 18px;
            background: rgba(255, 255, 255, .88);
            box-shadow: 0 18px 45px rgba(15, 23, 42, .14);
            backdrop-filter: blur(8px);
        }

        .medico-form-header {
            display: flex;
            align-items: center;
            gap: 24px;
            padding-bottom: 24px;
            margin-bottom: 24px;
            border-bottom: 1px solid rgba(15, 23, 42, .12);
        }

        .medico-form-icon {
            width: 64px;
            height: 64px;
            border-radius: 14px;
            background: rgba(239, 246, 255, .95);
            color: #0d6efd;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 2rem;
            box-shadow: inset 0 0 0 1px rgba(255, 255, 255, .82);
            flex: 0 0 auto;
        }

        .medico-section-title {
            display: flex;
            align-items: center;
            gap: 16px;
            margin: 26px 0 22px;
            color: #172033;
            font-weight: 700;
        }

        .medico-section-title::after {
            content: "";
            height: 1px;
            flex: 1;
            background: rgba(15, 23, 42, .12);
        }

        .form-label {
            color: #172033;
            font-weight: 600;
        }

        .input-icon-group {
            display: flex;
            align-items: stretch;
        }

        .input-icon {
            width: 52px;
            min-height: 46px;
            border: 1px solid rgba(15, 23, 42, .12);
            border-right: 0;
            border-radius: .375rem 0 0 .375rem;
            background: rgba(239, 246, 255, .95);
            color: #0d6efd;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            font-size: 1.15rem;
        }

        .input-icon-group .form-control {
            min-height: 46px;
            border-radius: 0 .375rem .375rem 0;
            border-color: rgba(15, 23, 42, .12);
            box-shadow: 0 6px 16px rgba(15, 23, 42, .06);
        }

        .medico-access-panel {
            margin: 28px 0 8px;
            padding: 22px;
            border-radius: 14px;
            background: rgba(239, 246, 255, .72);
            border: 1px solid rgba(13, 110, 253, .16);
            box-shadow: inset 0 0 0 1px rgba(255, 255, 255, .62);
        }

        .medico-access-panel .medico-section-title {
            margin-top: 0;
        }

        .medico-form-actions {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
            margin-top: 24px;
        }

        .medico-form-actions .btn {
            min-height: 44px;
            padding-left: 22px;
            padding-right: 22px;
            font-weight: 600;
        }

        .medico-specialties-panel {
            margin-top: 28px;
        }

        .medico-specialties-help {
            color: #64748b;
            margin-bottom: 14px;
        }

        .especialidades-lista {
            display: block;
        }

        .specialty-option {
            display: flex;
            align-items: center;
            gap: 14px;
            min-height: 58px;
            padding: 14px 16px;
            margin-bottom: 12px;
            border: 1px solid rgba(15, 23, 42, .10);
            border-radius: 10px;
            background: rgba(255, 255, 255, .76);
            box-shadow: 0 6px 16px rgba(15, 23, 42, .04);
        }

        .specialty-option input[type="checkbox"] {
            flex: 0 0 auto;
            width: 16px;
            height: 16px;
        }

        .specialty-icon {
            width: 36px;
            height: 36px;
            border-radius: 8px;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            color: #0d6efd;
            background: rgba(239, 246, 255, .95);
            font-size: 1.1rem;
        }

        .specialty-icon.pediatria {
            color: #0ea5e9;
            background: rgba(224, 242, 254, .95);
        }

        .specialty-icon.cardiologia {
            color: #dc3545;
            background: rgba(255, 228, 230, .95);
        }

        .specialty-icon.traumatologia {
            color: #7c3aed;
            background: rgba(237, 233, 254, .95);
        }

        .specialty-icon.dermatologia {
            color: #f97316;
            background: rgba(255, 237, 213, .95);
        }

        .specialty-icon.ginecologia {
            color: #db2777;
            background: rgba(252, 231, 243, .95);
        }

        .specialty-icon.default {
            color: #0ea5e9;
            background: rgba(224, 242, 254, .95);
        }

        .specialty-option label {
            margin-bottom: 0;
            color: #334155;
            font-weight: 500;
        }

        .validacion {
            color: red;
            font-size: 13px;
            font-weight: bold;
        }
    </style>
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
