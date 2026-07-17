<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="FormularioPaciente.aspx.cs" Inherits="WebApplicationClinica.FormularioPaciente" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="paciente-form-panel">
        <div class="paciente-form-header">
            <div class="paciente-form-icon">
                <i class="bi bi-person-plus"></i>
            </div>
            <div>
                <h1 class="h2 fw-bold mb-2">Nuevo Paciente</h1>
                <p class="text-muted fs-6 mb-0">Complete los datos del paciente para registrarlo en el sistema.</p>
            </div>
        </div>

        <asp:Label ID="lblErrorGeneral" runat="server" CssClass="alert alert-danger d-block" Visible="false" />

        <asp:Panel ID="pnlId" runat="server" Visible="false">
            <div class="mb-3">
                <label for="txtId" class="form-label">Id</label>
                <div class="input-icon-group">
                    <span class="input-icon"><i class="bi bi-hash"></i></span>
                    <asp:TextBox runat="server" ID="txtId" CssClass="form-control" Enabled="false" />
                </div>
            </div>
        </asp:Panel>

        <div class="mb-3">
            <label for="txtApellido" class="form-label">Apellido</label>
            <div class="input-icon-group">
                <span class="input-icon"><i class="bi bi-person"></i></span>
                <asp:TextBox runat="server" ID="txtApellido" CssClass="form-control" placeholder="Ingrese el apellido" />
            </div>
            <asp:Label ID="lblErrorApellido" runat="server" CssClass="alert alert-danger d-block mt-2" Visible="false" />
        </div>

        <div class="mb-3">
            <label for="txtNombre" class="form-label">Nombre</label>
            <div class="input-icon-group">
                <span class="input-icon"><i class="bi bi-person"></i></span>
                <asp:TextBox runat="server" ID="txtNombre" CssClass="form-control" placeholder="Ingrese el nombre" />
            </div>
            <asp:Label ID="lblErrorNombre" runat="server" CssClass="alert alert-danger d-block mt-2" Visible="false" />
        </div>

        <div class="mb-3">
            <label for="txtDni" class="form-label">DNI</label>
            <div class="input-icon-group">
                <span class="input-icon"><i class="bi bi-card-text"></i></span>
                <asp:TextBox runat="server" ID="txtDni" CssClass="form-control" placeholder="Ingrese el DNI" />
            </div>
            <asp:Label ID="lblErrorDni" runat="server" CssClass="alert alert-danger d-block mt-2" Visible="false" />
        </div>

        <div class="mb-3">
            <label for="txtFechaNacimiento" class="form-label">Fecha de nacimiento</label>
            <div class="input-icon-group">
                <span class="input-icon"><i class="bi bi-calendar-date"></i></span>
                <asp:TextBox runat="server" ID="txtFechaNacimiento" CssClass="form-control" TextMode="Date" />
            </div>
            <asp:Label ID="lblErrorFechaNacimiento" runat="server" CssClass="alert alert-danger d-block mt-2" Visible="false" />
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

        <div class="mb-3">
            <label for="txtDireccion" class="form-label">Dirección</label>
            <div class="input-icon-group">
                <span class="input-icon"><i class="bi bi-geo-alt"></i></span>
                <asp:TextBox runat="server" ID="txtDireccion" CssClass="form-control" placeholder="Ingrese la dirección" />
            </div>
            <asp:Label ID="lblErrorDireccion" runat="server" CssClass="alert alert-danger d-block mt-2" Visible="false" />
        </div>

        <div class="paciente-form-actions">
            <asp:Button ID="btnAceptar" class="btn btn-primary" runat="server" Text="Aceptar" OnClick="btnAceptar_Click" />
            <a href="WebForm-Paciente.aspx" class="btn btn-outline-danger">Cancelar</a>
            <asp:Button ID="btnCambiarEstado" runat="server" CssClass="btn btn-secondary" Visible="false" OnClick="btnCambiarEstado_Click" />
        </div>
    </div>
</asp:Content>
