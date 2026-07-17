<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="FormularioUsuario.aspx.cs" Inherits="WebApplicationClinica.FormularioUsuario" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        body {
            min-height: 100vh;
            background-image: linear-gradient(rgba(255, 255, 255, .58), rgba(255, 255, 255, .58)), url('Images/fondoInicio.png');
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

        .usuario-form-panel {
            max-width: 920px;
            margin: 48px 0 72px 64px;
            padding: 32px;
            border-radius: 18px;
            background: rgba(255, 255, 255, .88);
            box-shadow: 0 18px 45px rgba(15, 23, 42, .14);
            backdrop-filter: blur(8px);
        }

        .usuario-form-header {
            display: flex;
            align-items: center;
            gap: 24px;
            padding-bottom: 24px;
            margin-bottom: 24px;
            border-bottom: 1px solid rgba(15, 23, 42, .12);
        }

        .usuario-form-icon {
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

        .usuario-section-title {
            display: flex;
            align-items: center;
            gap: 16px;
            margin: 28px 0 22px;
            color: #172033;
            font-weight: 700;
        }

        .usuario-section-title::after {
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

        .input-icon-group .form-control,
        .input-icon-group .form-select {
            min-height: 46px;
            border-radius: 0 .375rem .375rem 0;
            border-color: rgba(15, 23, 42, .12);
            box-shadow: 0 6px 16px rgba(15, 23, 42, .06);
        }

        .usuario-access-panel {
            margin: 28px 0 8px;
            padding: 22px;
            border-radius: 14px;
            background: rgba(239, 246, 255, .72);
            border: 1px solid rgba(13, 110, 253, .16);
            box-shadow: inset 0 0 0 1px rgba(255, 255, 255, .62);
        }

        .usuario-access-panel .usuario-section-title {
            margin-top: 0;
        }

        .usuario-form-actions {
            display: flex;
            gap: 12px;
            flex-wrap: wrap;
            margin-top: 24px;
            padding-top: 20px;
            border-top: 1px solid rgba(15, 23, 42, .12);
        }

        .usuario-form-actions .btn {
            min-height: 44px;
            padding-left: 22px;
            padding-right: 22px;
            font-weight: 600;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="usuario-form-panel">
        <div class="usuario-form-header">
            <div class="usuario-form-icon">
                <i class="bi bi-person-gear"></i>
            </div>
            <div>
                <h1 class="h2 fw-bold mb-2">Personal Administrativo</h1>
                <p class="text-muted fs-6 mb-0">Complete los datos para registrar administradores y recepcionistas.</p>
            </div>
        </div>

        <asp:Label ID="lblErrorGeneral" runat="server" CssClass="alert alert-danger d-block" Visible="false" />

        <asp:Panel ID="pnlId" runat="server" Visible="false">
            <div class="mb-4">
                <label for="txtId" class="form-label">Id</label>
                <div class="input-icon-group">
                    <span class="input-icon"><i class="bi bi-hash"></i></span>
                    <asp:TextBox runat="server" ID="txtId" CssClass="form-control" Enabled="false" />
                </div>
            </div>
        </asp:Panel>

        <h2 class="h5 usuario-section-title">Datos personales</h2>

        <div class="mb-4">
            <label for="ddlRol" class="form-label">Rol</label>
            <div class="input-icon-group">
                <span class="input-icon"><i class="bi bi-person-badge"></i></span>
                <asp:DropDownList ID="ddlRol" runat="server" CssClass="form-select">
                    <asp:ListItem Text="Seleccione un rol" Value="" />
                    <asp:ListItem Text="Administrador" Value="1" />
                    <asp:ListItem Text="Recepcionista" Value="2" />
                </asp:DropDownList>
            </div>
            <asp:Label ID="lblErrorRol" runat="server" CssClass="alert alert-danger d-block mt-2" Visible="false" />
        </div>

        <div class="mb-4">
            <label for="txtApellido" class="form-label">Apellido</label>
            <div class="input-icon-group">
                <span class="input-icon"><i class="bi bi-person"></i></span>
                <asp:TextBox runat="server" ID="txtApellido" CssClass="form-control" placeholder="Ingrese el apellido" />
            </div>
            <asp:Label ID="lblErrorApellido" runat="server" CssClass="alert alert-danger d-block mt-2" Visible="false" />
        </div>

        <div class="mb-4">
            <label for="txtNombre" class="form-label">Nombre</label>
            <div class="input-icon-group">
                <span class="input-icon"><i class="bi bi-person"></i></span>
                <asp:TextBox runat="server" ID="txtNombre" CssClass="form-control" placeholder="Ingrese el nombre" />
            </div>
            <asp:Label ID="lblErrorNombre" runat="server" CssClass="alert alert-danger d-block mt-2" Visible="false" />
        </div>

        <div class="mb-4">
            <label for="txtDni" class="form-label">DNI</label>
            <div class="input-icon-group">
                <span class="input-icon"><i class="bi bi-card-text"></i></span>
                <asp:TextBox runat="server" ID="txtDni" CssClass="form-control" placeholder="Ingrese el DNI" />
            </div>
            <asp:Label ID="lblErrorDni" runat="server" CssClass="alert alert-danger d-block mt-2" Visible="false" />
        </div>

        <div class="mb-4">
            <label for="txtTelefono" class="form-label">Teléfono</label>
            <div class="input-icon-group">
                <span class="input-icon"><i class="bi bi-telephone"></i></span>
                <asp:TextBox runat="server" ID="txtTelefono" CssClass="form-control" placeholder="Ingrese el teléfono" />
            </div>
            <asp:Label ID="lblErrorTelefono" runat="server" CssClass="alert alert-danger d-block mt-2" Visible="false" />
        </div>

        <div class="mb-4">
            <label for="txtEmail" class="form-label">Email</label>
            <div class="input-icon-group">
                <span class="input-icon"><i class="bi bi-envelope"></i></span>
                <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control" placeholder="Ingrese el email" />
            </div>
            <asp:Label ID="lblErrorEmail" runat="server" CssClass="alert alert-danger d-block mt-2" Visible="false" />
        </div>

        <div class="usuario-access-panel">
            <h2 class="h5 usuario-section-title">Usuario de acceso</h2>

            <div class="mb-4">
                <label for="txtUsuario" class="form-label">Usuario</label>
                <div class="input-icon-group">
                    <span class="input-icon"><i class="bi bi-person"></i></span>
                    <asp:TextBox runat="server" ID="txtUsuario" CssClass="form-control" placeholder="Nombre de usuario para iniciar sesión" />
                </div>
                <asp:Label ID="lblErrorUsuario" runat="server" CssClass="alert alert-danger d-block mt-2" Visible="false" />
            </div>

            <div class="mb-0">
                <label for="txtPassword" class="form-label">Contraseña</label>
                <div class="input-icon-group">
                    <span class="input-icon"><i class="bi bi-lock"></i></span>
                    <asp:TextBox runat="server" ID="txtPassword" CssClass="form-control" TextMode="Password" placeholder="Ingrese una contraseña segura" />
                </div>
                <asp:Label ID="lblErrorPassword" runat="server" CssClass="alert alert-danger d-block mt-2" Visible="false" />
            </div>
        </div>

        <div class="usuario-form-actions">
            <asp:Button Text="Guardar" runat="server" ID="btnAceptar" CssClass="btn btn-primary" OnClick="btnAceptar_Click" />
            <a href="WebForm-Usuarios.aspx" class="btn btn-outline-danger">Cancelar</a>
            <asp:Button ID="btnCambiarEstado" runat="server" CssClass="btn btn-secondary" Visible="false" OnClick="btnCambiarEstado_Click" />
        </div>
    </div>
</asp:Content>
