<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="FormularioEspecialidad.aspx.cs" Inherits="WebApplicationClinica.FormularioEspecialidad" %>

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

        .especialidad-form-panel {
            max-width: 920px;
            margin: 48px 0 72px 64px;
            padding: 32px;
            border-radius: 18px;
            background: rgba(255, 255, 255, .88);
            box-shadow: 0 18px 45px rgba(15, 23, 42, .14);
            backdrop-filter: blur(8px);
        }

        .especialidad-form-header {
            display: flex;
            align-items: center;
            gap: 24px;
            padding-bottom: 24px;
            margin-bottom: 24px;
            border-bottom: 1px solid rgba(15, 23, 42, .12);
        }

        .especialidad-form-icon {
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

        .input-icon-group textarea.form-control {
            min-height: 120px;
            resize: vertical;
        }

        .especialidad-form-actions {
            display: flex;
            gap: 18px;
            flex-wrap: wrap;
            margin-top: 24px;
            padding-top: 20px;
            border-top: 1px solid rgba(15, 23, 42, .12);
        }

        .especialidad-form-actions .btn {
            min-height: 44px;
            padding-left: 22px;
            padding-right: 22px;
            font-weight: 600;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="especialidad-form-panel">
        <div class="especialidad-form-header">
            <div class="especialidad-form-icon">
                <i class="bi bi-tags"></i>
            </div>
            <div>
                <h1 class="h2 fw-bold mb-2">Nueva Especialidad</h1>
                <p class="text-muted fs-6 mb-0">Complete los datos para registrar una nueva especialidad.</p>
            </div>
        </div>

        <div class="d-none">
            <label for="txtId" class="form-label">Id</label>
            <asp:TextBox runat="server" ID="txtId" CssClass="form-control" />
        </div>

        <div class="mb-4">
            <label for="txtNombre" class="form-label">Nombre</label>
            <div class="input-icon-group">
                <span class="input-icon"><i class="bi bi-tag"></i></span>
                <asp:TextBox runat="server" ID="txtNombre" CssClass="form-control" placeholder="Ingrese el nombre de la especialidad" />
            </div>
        </div>

        <div class="mb-4">
            <label for="txtDescripcion" class="form-label">Descripción</label>
            <div class="input-icon-group">
                <span class="input-icon"><i class="bi bi-chat-left"></i></span>
                <asp:TextBox runat="server" ID="txtDescripcion" CssClass="form-control" TextMode="MultiLine" Rows="4" placeholder="Ingrese una descripción detallada" />
            </div>
        </div>

        <div class="d-none">
            <asp:Label ID="lblEstado" Text="Estado:" runat="server" Font-Bold="true" />
            <asp:RadioButton ID="rdbActivo" Text="Activo" runat="server" GroupName="Estado" Checked="true" />
            <asp:RadioButton ID="rdbInactivo" Text="Inactivo" runat="server" GroupName="Estado" />
        </div>

        <asp:Label ID="lblMensaje" runat="server" CssClass="alert alert-danger d-block" Visible="false"></asp:Label>

        <div class="especialidad-form-actions">
            <asp:Button ID="btnAceptar" CssClass="btn btn-primary" runat="server" Text="Guardar" OnClick="btnAceptar_Click" />
            <a href="ListaEspecialidades.aspx" class="btn btn-outline-danger">Cancelar</a>
            <asp:Button ID="btnCambiarEstado" runat="server" CssClass="btn btn-secondary" Visible="false" OnClick="btnCambiarEstado_Click" />
        </div>
    </div>
</asp:Content>

