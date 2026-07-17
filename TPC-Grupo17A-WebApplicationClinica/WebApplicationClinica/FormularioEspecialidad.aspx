<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="FormularioEspecialidad.aspx.cs" Inherits="WebApplicationClinica.FormularioEspecialidad" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

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

