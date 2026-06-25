<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="FormularioPaciente.aspx.cs" Inherits="WebApplicationClinica.FormularioPaciente" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container">
        <div class="row">
            <div class="col-6">
                                <%-- Errores generales del formulario --%>
                <div class="mb-3">
                    <asp:Label ID="lblErrorGeneral" runat="server" CssClass="alert alert-danger d-block" Visible="false" />
                </div>
                <div class="mb-3">
                    <label for="txtId" class="form-label">Id</label>
                    <asp:TextBox runat="server" ID="txtId" CssClass="form-control" />
                </div>
                <%--Nombre --%>
                <div class="mb-3">
                    <label for="txtNombre" class="form-label">Nombre</label>
                    <asp:TextBox runat="server" ID="txtNombre" CssClass="form-control" />
                    <asp:Label ID="lblErrorNombre" runat="server" CssClass="alert alert-danger d-block mt-2" Visible="false" />
                </div>
                <%--Apellido --%>
                <div class="mb-3">
                    <label for="txtApellido" class="form-label">Apellido</label>
                    <asp:TextBox runat="server" ID="txtApellido" CssClass="form-control" />
                    <asp:Label ID="lblErrorApellido" runat="server" CssClass="alert alert-danger d-block mt-2" Visible="false" />
                </div>
                <%--DNI --%>
                <div class="mb-3">
                    <label for="txtDni" class="form-label">DNI</label>
                    <asp:TextBox runat="server" ID="txtDni" CssClass="form-control" />
                    <asp:Label ID="lblErrorDni" runat="server" CssClass="alert alert-danger d-block mt-2" Visible="false" />
                </div>
                <div class="mb-3">
                    <label for="txtFechaNacimiento" class="form-label">Fecha de nacimiento</label>
                    <asp:TextBox runat="server" ID="txtFechaNacimiento" CssClass="form-control" TextMode="Date" />
                </div>
                <div class="mb-3">
                    <label for="txtTelefono" class="form-label">Telefono</label>
                    <asp:TextBox runat="server" ID="txtTelefono" CssClass="form-control" />
                </div>
                <div class="mb-3">
                    <label for="txtEmail" class="form-label">Email</label>
                    <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control" />
                </div>
                <div class="mb-3">
                    <label for="txtDireccion" class="form-label">Direccion</label>
                    <asp:TextBox runat="server" ID="txtDireccion" CssClass="form-control" />
                </div>

                <div class="mb-3">
                    <asp:Button ID="btnAceptar" class="btn btn-primary" runat="server" Text="Aceptar" OnClick="btnAceptar_Click" />
                    <a href="WebForm-Paciente.aspx" class="btn btn-danger">Cancelar</a>
                </div>
                <div class="mb-3">
                    <asp:Button ID="btnEliminarFisico" class="btn btn-secondary" runat="server" Text="Eliminar" OnClick="btnEliminarFisico_Click" />
                </div>
            </div>
        </div>
    </div>
</asp:Content>
